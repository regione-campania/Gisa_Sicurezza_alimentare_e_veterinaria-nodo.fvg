/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
//rotta per notifiche
var express = require('express');
var router = express.Router();
var conn = require('../db/connection');
const mapUtilts = require("../utils/mapUtils");
var utils = require("../utils/utils");
var auth = require('../utils/auth');
var path = require('path');
var fs = require('fs');
var soap = require('soap');
var xml2js = require('xml2js');

router.get("/getDati", auth.authenticateToken, function (req, res) {
    try {
        //const idUtente = req.authData.idUtente;
        const idUtente = req.authData.id_utente_struttura_ruolo;
        var funzione = req.query.function;
        var args = req.query.args;

        if (!args || !funzione) {
            res.writeHead(200).end();
            return;
        };

        console.log("idUtente:", idUtente);
        console.log("funzione:", funzione);
        console.log("args:", args);

        const query = {
            text: ` call ag_srv.get_dati($1, $2, $3, '{}')`,
            values: [funzione, args, idUtente]
        }

        console.log(query);
        console.log(`\n\ncall ag_srv.get_dati('%s', '%s', %s, '{}')\n\n`, funzione, args.replace(/'/g, "''"), idUtente);

        conn.client.query(query, (err, result) => {
            if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
            } else {
                res.json(result.rows[0].joutput).end();
            }
        })



    } catch (err) {
        console.log(err.stack);
        res.writeHead(500).end();
    }

})

router.post("/updDati", auth.authenticateToken, function (req, res) {
    // get Data
    try {
        // const idUtente = req.authData.idUtente;
        const idUtente = req.authData.id_utente_struttura_ruolo;
        var funzione = req.body.function;
        var args = req.body.args;

        if (!args || !funzione) {
            res.writeHead(200).end();
            return;
        };

        console.log("idUtente:", idUtente);
        console.log("funzione:", funzione);

        // Execute query
        const query = {
            text: ` call ag_srv.upd_dati($1, $2, $3, '{}')`,
            values: [funzione, args, idUtente]
        }
        console.log(`\n\ncall ag_srv.upd_dati('%s', '%s', %s, '{}')\n\n`, funzione, args.replace(/'/g, "''"), idUtente);

        args = JSON.parse(args);
        args.bytearray = '';
        console.log("args:", args);

        console.log(query);


        conn.client.query(query, (err, result) => {
            if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
            } else {
                res.json(result.rows[0].joutput).end();
            }
        })
    } catch (err) {
        console.log(err.stack);
        res.writeHead(500).end();
    }

})

router.get("/getStrutturaPiani", auth.authenticateToken, function (req, res) {

    const idElabCalendario = req.query.idElab;
    let joinElabCalendario = '';
    let selectElabCalendario = '';
    let whereIdStrutturaRoot = `where  
    p.id in (select id_node_ref from matrix.vw_tree_nodes_down_piani d 
    where d.id_node in (select distinct id_piano  from agenda.asl_piani where id_struttura in (
        select id_node from matrix.vw_tree_nodes_down_asl vtnda where id_node_ref = ${req.authData.idStrutturaRoot}
    )))`;
    if (idElabCalendario && idElabCalendario != 'undefined') {
        selectElabCalendario = `, case when ecp.id is null then false else true end as preselected`;
        joinElabCalendario = ` left join agenda.elab_cal_params ecp on ecp.id_elab_cal = ${idElabCalendario} and ecp.type_param = 'PIANO' and ecp.value = p.id`;
    }

    try {
        const query = String.raw`
            select regexp_replace(coalesce(p.alias,'')||' '||public.unaccent(p.descrizione_breve), '[\r\n]', '', 'g') as name,
            p.id as id_piano, p.livello as livello, p.color as color,
            f_uba.fattore_fin as fattore_uba_reale,
            f_ups.fattore_fin as fattore_ups_reale, p.id_formula_ups,
            p.id_formula_uba,
            null as target, null as valore, null as ups_target,
            null as uba_target, null as ups_impegnati,
            null as uba_impegnati, null as path, null as case
            ${selectElabCalendario}
            from matrix.vw_tree_nodes_up_piani p
            join matrix.struttura_piani pp on pp.id = p.id and (pp.data_scadenza > current_timestamp or pp.data_scadenza is null)
            left join matrix.formule f_ups on p.id_formula_ups = f_ups.id 
            left join matrix.formule f_uba on p.id_formula_uba = f_uba.id 
            ${joinElabCalendario}
            ${whereIdStrutturaRoot}
            order by p.path_ord
    `;

        conn.client.query(query, (err, result) => {
            try {
                if (err) {
                    console.log(err.stack)
                    res.writeHead(500).end();
                } else {
                    const response = utils.getJSONFromRows(result.rows);

                    // console.log(response);
                    res.json(response).end();
                }
            } catch (err) {
                console.log(err.stack);
                res.writeHead(500).end();
            }
        });

    } catch (err) {
        console.log(err.stack);
        res.writeHead(500).end();
    }
})

router.get("/getStrutturaAsl", auth.authenticateToken, function (req, res) {
    console.log(req.query)

    const idElabCalendario = req.query.idElab;
    /*let joinElabCalendario = '';
    let selectElabCalendario = '';*/
    let query = {
        text: `select a.id as id_struttura, id_asl, descrizione as name, descrizione_breve, n_livello as livello
            from matrix.vw_tree_nodes_up_asl a
            where a.id_node in (select id_node from matrix.vw_tree_nodes_down_asl where id_node_ref = $1)
            order by path`,
        values: [req.authData.idStrutturaRoot]
    };

    if (idElabCalendario) {
        query = {
            text: `select a.id as id_struttura, id_asl, descrizione as name, descrizione_breve, n_livello as livello
                , case when ecp.id is null then false else true end as preselected
                from matrix.vw_tree_nodes_up_asl a
                left join agenda.elab_cal_params ecp on ecp.id_elab_cal = $1 and ecp.type_param = 'ASL' and ecp.value = a.id_node
                where a.id_node in (select id_node from matrix.vw_tree_nodes_down_asl where id_node_ref = $2)
                order by path`,
            values: [idElabCalendario, req.authData.idStrutturaRoot]
        };
    }

    try {

        conn.client.query(query, (err, result) => {
            if (err) {
                console.log(err.stack)
                res.writeHead(500).end();
            } else {
                const response = utils.getJSONFromRows(result.rows);

                // console.log(response);
                res.json(response).end();
            }
        });
    } catch (e) {
        console.log(e.stack);
        res.writeHead(500).end();
    }
})

router.post("/soapRequest", function (req, res) {
    console.log("\nreq.body:", req.body);
    const callXML = req.body.xml;

    const wsdlurl = 'https://test-smarterp-ws.sanita.fvg.it/ADInterface/services/ModelADService?wsdl';

    fetch(wsdlurl, {
        method: 'POST',
        body: callXML
    })
        .then((response) => response.text()
            .then(result => {
                console.log("result:", result);

                xml2js.parseString(result, function (parseErr, parseResult) {
                    let data = JSON.stringify(parseResult);
                    console.log("data:", data);
                    res.json({
                        _jsonRes: data,
                        _xmlRes: result
                    }).end();
                });

            })
            .catch((innErr) => {
                console.log("innErr:", innErr);
            })
        )
        .catch((err) => {
            console.log(err.stack);
            res.writeHead(500).end();
        });
})

module.exports = router;