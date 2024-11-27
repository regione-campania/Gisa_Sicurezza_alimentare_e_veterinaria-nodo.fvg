/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
//rotta per notifiche
var express = require('express');
var router = express.Router();
var conn = require('../db/connection');
var auth = require('../utils/auth');

router.get("/getDati", auth.authenticateToken, function (req, res) {
    try {
        //const idUtente = req.authData.idUtente;
        const idUtente = req.authData.id_utente_struttura_ruolo;
        var funzione = req.query.function;
        var args = req.query.args;

        if(!args || !funzione){
            res.writeHead(200).end();
            return;
        };

        console.log("idUtente:", idUtente);
        console.log("funzione:", funzione);
        console.log("args:", args);

        const query = {
            text: ` call rbac.get_dati($1, $2, $3, '{}')`,
            values: [funzione, args, idUtente]
        }

        console.log(query);
        console.log(`\n\ncall rbac.get_dati('%s', '%s', %s, '{}')\n\n`, funzione, args.replace(/'/g, "''"), idUtente);

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

        if(!args || !funzione){
            res.writeHead(200).end();
            return;
        };

        console.log("idUtente:", idUtente);
        console.log("funzione:", funzione);

        // Execute query
        const query = {
            text: ` call rbac.upd_dati($1, $2, $3, '{}')`,
            values: [funzione, args, idUtente]
        }
        console.log(`\n\ncall rbac.upd_dati('%s', '%s', %s, '{}')\n\n`, funzione, args.replace(/'/g, "''"), idUtente);

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
module.exports = router;