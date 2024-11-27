/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
var express = require('express');
var router = express.Router();
var conn = require('../db/connection');
var utils = require("../utils/utils");
var auth = require('../utils/auth');
const jwt = require('jsonwebtoken');
const conf = require('../config/config.js');

router.post("/getUser", auth.authenticateToken, function (req, res) {
    auth.getUser(req, res);
});

router.post("/login", function (req, res) {
    const usr = req.body.username;
    const pswd = req.body.password;
    var cf = req.body.fiscalCode;
    
    var nome = req.body.firstName;
    var cognome = req.body.lastName;
    var cfCrypt = req.body.crypt;
    
    /*cfCrypt= '11fc15cda0957c59a84c76979cfeb141';
    nome = 'BARBARA'
    cognome = 'LUGOBONI'
    cf = 'LGBBBR79T60L781H'*/
    

    console.log("userdata:", req.body);

    try {
        const query = {
            text: `
                select u.*, a.responsabile_asl, u.id as id_user
                from um.get_user u
                join um.access a on u.id = a.id
                left join um.access_stabilimenti as2 on a.id = as2.id_access
                where ((
                        a.username = $1
                        and a.password = $2
                    )
                    or md5('GISA-' || u.codice_fiscale) = $3
                )
                and (
                    as2.id_access is null
                    or (
                        as2.id_access is not null
                        and (as2.validato_data is not null or id_responsabile is not null)
                        and (as2.validato_da is not null or id_responsabile is not null)
                    )
                )
                and (nullif(as2.validita, '(,)') is null or as2.validita::tsrange @> current_timestamp::timestamp)
            `,
            values: [usr, pswd, cfCrypt]
        };

        conn.clientCE.query(query, async (err, result) => {
            if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
            } else {
                if (result.rows.length > 0) {
                    const queryPermission = {
                        text: `select * from um.vw_role_permission where id_role = $1`,
                        values: [result.rows[0].id_role]
                    };
                    const resultPermission = await conn.clientCE.query(queryPermission);
                    result.rows[0].permission = resultPermission.rows;
                    result.rows[0].token = auth.generateAccessToken(result.rows[0]);
                }
                res.json(result.rows[0]).end();
            }
        })
    } catch (err) {
        console.log(err.stack);
        res.writeHead(500).end();
    }
})

router.get("/getStabilimenti", auth.authenticateToken, function (req, res) {

    const idAccess = req.authData.id;

    console.log("idAccess:", idAccess);

    try {
        conn.clientCE.query({
            text: `select * from um.vw_user_stabilimenti where id_access = $1`,
            values: [idAccess]
            }, async (err, result) => {
                if (err) {
                    console.log(err.stack);
                    res.writeHead(500).end();
                } else {
                    for (let i = 0; i < result.rows.length; i++) {
                        const queryPermission = `select * from um.vw_role_permission where id_role = $1`;
                        try {
                            const resultPermission = await conn.clientCE.query({
                                text: queryPermission,
                                values: [result.rows[i].id_role]
                            });
                            result.rows[i].permission = resultPermission.rows;
                        } catch (err) {
                            console.log(err.stack)
                        }
                        result.rows[i].token = auth.generateAccessToken(result.rows[i]);
                    }
                    res.json(result.rows).end();
                }
            })
    } catch (err) {
        console.log(err.stack);
        res.writeHead(500).end();
    }
})

module.exports = router;
