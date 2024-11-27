/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
//rotta per anagrafiche
var express = require('express');
var router = express.Router();
var conn = require('../db/connection');
var auth = require('../utils/auth');

router.post("/updateEvento", auth.authenticateToken, function(req, res) {

    try{
        // const jsonRequest = JSON.parse(req.body);
        const jsonRequest = JSON.stringify(req.body);
        console.log("jsonRequest:", jsonRequest);

        const query = {
            text: `call ag_srv.upd_dati('upd_evento', $1, 1, null)`,
            values: [jsonRequest.replace(/'/g, "''")]
        }

        console.log("query:", query);

        conn.client.query(query, (err, response) => {
            if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
            } else {
                res.json(response.rows).end();
            }
        })
    }catch(err){
        console.log(err.stack);
        res.writeHead(500).end();
    }
    
})

router.get("/getCalendario", auth.authenticateToken, function(req, res) {

    try{
        console.log("req.authData:", req.authData);
        const id = req.query.id;
        console.log("id per calendario:", id);
        // const id = req.authData.idUtente;
       /* query = `
            call ag_srv.get_dati('get_eventi', '{\"id\":${id}}', ${id}, null)
        `;*/

        const query = {
            text: ` call ag_srv.get_dati('get_eventi', $1, $2, null)`,
            values: [`{"id":${id}}`, id]
        }
    
        console.log("query:", query);
    
        console.log("id:", id);
    
        conn.client.query(query, (err, response) => {
            if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
            } else {
                console.log("response.rows[0].joutput:", response.rows[0].joutput);
                res.json(response.rows[0].joutput).end();
            }
        })
    }catch(err){
        console.log(err.stack);
        res.writeHead(500).end();
    }
    
})

router.get("/getCalendari", auth.authenticateToken, function(req, res) {
    try{
        console.log("req.authData:", req.authData);
        // const id = req.query.id;
        const id = req.authData.idUtente;

        const query = {
            text: ` call ag_srv.get_dati('get_agende', $1, $2, null)`,
            values: [`{"id":${id}}`, id]
        }
    
        console.log("query:", query);
    
        conn.client.query(query, (err, response) => {
            if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
            } else {
                console.log("response.rows[0].joutput:", response.rows[0].joutput);
                res.json(response.rows[0].joutput).end();
            }
        })
    }catch(err){
        console.log(err.stack);
        res.writeHead(500).end();
    }
    
})


module.exports = router;
