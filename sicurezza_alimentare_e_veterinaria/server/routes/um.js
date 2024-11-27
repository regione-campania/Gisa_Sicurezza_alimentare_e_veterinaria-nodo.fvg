/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
//rotta per UserManagement
var express = require("express");
var router = express.Router();
var conn = require("../db/connection");
var auth = require("../utils/auth");
var config = require("../config/config");

/*router.get('/fakeLogin', function(req, res) { 
    res.render('fakeLogin.ejs', {env: process.argv[2]})
});*/

router.get("/getAmbiente", function (req, res) {
    res.json({ applicativi: config.applicativi }).end();
});

router.post("/login", async function (req, res) {
    var username = null//req.body.username;
    var password = null//req.body.password;
    const cf = req.body.codice_fiscale;
    var cfCriptato = req.body.crypt;
    if (!cfCriptato) {
        username = req.body.username;
        password = req.body.password;
        cfCriptato = null;
    }

    try {
        // console.log(`select * from public.get_utente_info_from_gisa(${username}, ${password}, ${cfCriptato})`);
        // const queryAccess = `select * from public.get_utente_info_from_gisa($1::text, $2::text, $3::text)`;

        //console.log(`select * from public.get_utente_info_3(``${username}``, ``${password}``, ``${cfCriptato})```);
        const queryAccess = `select * from public.get_utente_info_3($1::text, $2::text, $3::text)`;
        var result = await conn.client.query(queryAccess, [username, password, cfCriptato]);
        console.log("result.rows queryAccess:", result.rows);
        var utenti = [];
        for (let i = 0; i < result.rows.length; i++) {
            var user = {};

            user.id_utente_struttura_ruolo = result.rows[i].id_utente_struttura_ruolo;
            user.id = result.rows[i].id;
            user.id_utente_struttura = result.rows[i].id_utente_struttura;
            user.id_ruolo = result.rows[i].id_ruolo;
            user.ruolo_sigla = result.rows[i].ruolo_sigla;
            user.ruolo_descr = result.rows[i].ruolo_descr;
            user.idUtente = result.rows[i].id_utente;
            user.id_utente = result.rows[i].id_utente;
            user.nome = result.rows[i].nome;
            user.cognome = result.rows[i].cognome;
            user.cf = result.rows[i].cf;
            user.id_asl = result.rows[i].id_asl;
            user.descrizione_breve = result.rows[i].descrizione_breve;
            user.id_struttura = result.rows[i].id_struttura;
            user.id_qualifica = result.rows[i].id_qualifica;
            user.sigla_qualifica = result.rows[i].sigla_qualifica;
            user.descr_qualifica = result.rows[i].descr_qualifica;
            user.responsabile = result.rows[i].responsabile;
            user.livello = result.rows[i].livello;

            user.hideProfilassi = result.rows[i].hideProfilassi;

            // user.nome = result.rows[i].nome;
            // user.ruolo = result.rows[i].ruolo;
            // user.idRuolo = result.rows[i].id_ruolo;
            // user.idUtente = result.rows[i].id_utente;
            // user.id_utente = result.rows[i].id_utente;
            // //user.username = result.rows[i].username;
            // user.idAsl = result.rows[i].id_asl;
            // user.idStrutturaRoot = result.rows[i].id_struttura_root;
            // user.codice_interno_struttura = result.rows[i].codice_interno_struttura;
            // user.livello = result.rows[i].livello;
            // user.responsabile = result.rows[i].responsabile;
            // user.idNominativoStruttura = result.rows[i].id_nominativo_struttura;
            // user.idStrutturaSemplice = null;
            // user.StrutturaSemplice = null;
            // user.idStrutturaComplessa = null;
            // user.StrutturaComplessa = null;
            // user.combUOCUOS = null;

            // user.hideProfilassi = result.rows[i].hideProfilassi;

            // if (result.rows[i].codice_interno_struttura) {
            //     const queryUO = `
            //         select p.p_id as id_uoc, p.p_descrizione as uoc, a.id as id_uos, a.descrizione as uos
            //         from matrix.struttura_asl a
            //         join matrix.vw_tree_nodes_asl_descr p on p.id = a.id
            //         where a.codice_interno_fk = ${result.rows[i].codice_interno_struttura} and p.anno::text = (
            //             select value
            //             from "Analisi_dev".config
            //             where descr = 'ANNO CORRENTE'
            //         )
            //     `;

            //     console.log("queryUO:\n", queryUO);

            //     let resUO = await conn.client.query(queryUO);
            //     console.log("resUO.rows:", resUO.rows);
            //     if (resUO.rows.length > 0) {
            //         user.idStrutturaSemplice = resUO.rows[0].id_uos;
            //         user.StrutturaSemplice = resUO.rows[0].uos;
            //         user.idStrutturaComplessa = resUO.rows[0].id_uoc;
            //         user.StrutturaComplessa = resUO.rows[0].uoc;
            //         // user.combUOCUOS = resUO.rows[0].uoc + resUO.rows[0].uos;
            //         user.combUOCUOS = `${resUO.rows[0].uoc} ${resUO.rows[0].uos}`;
            //     }
            // }

            // if (result.rows[i].id_struttura_root) {
            //     const queryUO = {
            //         text:`select * from matrix.struttura_asl sa where id = $1 and sa.anno::text = (
            //             select value
            //             from "Analisi_dev".config
            //             where descr = 'ANNO CORRENTE'
            //         )`,
            //         values: [result.rows[i].id_struttura_root]
            //     };

            //     let resUO = await conn.client.query(queryUO);
            //     console.log("resUO.rows:", resUO.rows);
            //     if (resUO.rows.length > 0) {
            //         user.descr_struttura_root = resUO.rows[0].descrizione_breve;
            //     }
            // }

            const token = auth.generateAccessToken(user);
            user.token = token;

            console.log("user:", user);

            // Aggiungi utente
            utenti.push(user);
        }

        console.log("utenti:", utenti);

        res.json(utenti).end();
    } catch (e) {
        console.log(e.stack);
        res.writeHead(500).end();
    }
});

router.get("/getUser", function (req, res) {
    auth.getUser(req, res);
});

router.get("/logout", function (req, res) {
    req.session.idNotificante = null;
    /*res.writeHead(307, {
          Location: `/login`
      }).end();*/
});

module.exports = router;
