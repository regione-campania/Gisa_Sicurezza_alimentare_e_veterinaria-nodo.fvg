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

            text: ` call cu_srv.get_dati($1, $2, $3, '{}')`,

            values: [funzione, args, idUtente]

        }



        console.log(query);

        console.log(`\n\ncall cu_srv.get_dati('%s', '%s', %s, '{}')\n\n`, funzione, args.replace(/'/g, "''"), idUtente);



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

            text: ` call cu_srv.upd_dati($1, $2, $3, '{}')`,

            values: [funzione, args, idUtente]

        }

        console.log(`\n\ncall cu_srv.upd_dati('%s', '%s', %s, '{}')\n\n`, funzione, args.replace(/'/g, "''"), idUtente);



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



router.post("/AllegaPDF", auth.authenticateToken, async function (req, res) {



    try {

        console.log("\n\n-----AllegaPDF-----\n\n");

        const file = req.files.file;

        const id_modulo = req.query.id_modulo;

        const descr_modulo = req.query.descr_modulo;



        //Funzione che va a scrivere nel file specificando il path tramite la funzione path.join



        fs.writeFileSync(path.join('static', 'tmp', file.name), file.data);

        console.log("nome file: ", file.name);







        const insertQuery = {

            text: `insert into documenti.pdf(id_modulo,descr_modulo,filename,data) values ($1,$2,$3,$4)

            on conflict (id_modulo,descr_modulo,filename) 

            do update

            set data = $4, validita = tsrange(lower(documenti.pdf.validita)::timestamp,null)

            `,

            values: [parseInt(id_modulo), descr_modulo, file.name, file.data]

        };



        await conn.client.query(insertQuery);



        res.json({ esito: true, name: file.name }).end();

    } catch (err) {

        console.log(err);

        res.writeHead(500);

        res.json({ esito: false }).end();

    }

})





router.post("/getPdfAllegati", auth.authenticateToken, async function (req, res) {



    try {

        console.log("\n\n-----getPdfAllegati-----\n\n");

        const id_modulo = req.query.id_modulo;

        const descr_modulo = req.query.descr_modulo;



        //Funzione che va a scrivere nel file specificando il path tramite la funzione path.join



        const selectQuery = {

            text: `select id,filename, lower(validita) as dt from documenti.pdf where id_modulo = $1 and descr_modulo = $2 and upper_inf(validita)`,

            values: [parseInt(id_modulo), descr_modulo]

        };



        let result = await conn.client.query(selectQuery);



        res.json({ esito: true, files: result.rows }).end();

    } catch (err) {

        console.log(err);

        res.writeHead(500);

        res.json({ esito: false }).end();

    }

})



router.post("/EliminaPDF", auth.authenticateToken, async function (req, res) {



    try {

        console.log("\n\n-----EliminaPDF-----\n\n");

        const id = req.query.id;



        const insertQuery = {

            text: `update documenti.pdf set validita = tsrange(lower(validita)::timestamp, CURRENT_TIMESTAMP::timestamp) where id = $1`,

            values: [parseInt(id)]

        };



        await conn.client.query(insertQuery);



        res.json({ esito: true }).end();

    } catch (err) {

        console.log(err);

        res.writeHead(500);

        res.json({ esito: false }).end();

    }

})



router.post("/DownloadPDF", auth.authenticateToken, async function (req, res) {



    try {

        console.log("\n\n-----DownloadPDF-----\n\n");

        const id = req.query.id;

        res.set({ "Access-Control-Expose-Headers": 'Content-Disposition' });

        const selectQuery = {

            text: `select data,filename from documenti.pdf where id = $1`,

            values: [parseInt(id)]

        };



        let result = await conn.client.query(selectQuery);

        let pathname = path.join('static', 'tmp');

        let filename = result.rows[0].filename;



        const dati = result.rows[0].data;

        fs.writeFileSync(path.join(pathname, filename), dati);

        res.download(path.join(pathname, filename), filename, function (err) {

            if (err) {

                console.log(err);

                res.status(500).send(err).end();

                return;

            }

            fs.unlinkSync(path.join(pathname, filename));

        })

    } catch (err) {

        console.log(err);

        res.writeHead(500);

        res.json({ esito: false }).end();

    }

})

module.exports = router;