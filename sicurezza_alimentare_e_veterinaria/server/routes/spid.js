/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
var express = require("express");
var router = express.Router();
var conf = require("../config/config");
var soap = require('soap');
var utils = require('../utils/utils');
var MD5 = require("crypto-js/md5");


router.post("/login", async function (req, res) {

    try {
    
        console.log(req.body);

        let samlResponse = req.body['SAMLRESPONSE'];

        soap.createClient(conf.loginfvgEndpoint, function (err, client) {
            if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
            }
            console.log(client);

            client['verifySAMLRespose']({resp: samlResponse}, function (err, result, rawResponse, soapHeader, rawRequest) {
                if (err) {
                    console.log(err.stack);
                    res.writeHead(500).end();
                    return;
                }
                console.log(result.verifySAMLResposeReturn);
                userData = {};
                userData.fiscalCode = utils.getXmlValueByTagName(result.verifySAMLResposeReturn, 'CODICE_FISCALE');
                userData.crypt = MD5('GISA-'+utils.getXmlValueByTagName(result.verifySAMLResposeReturn, 'CODICE_FISCALE')).toString();
                userData.lastName = utils.getXmlValueByTagName(result.verifySAMLResposeReturn, 'COGNOME');
                userData.firstName = utils.getXmlValueByTagName(result.verifySAMLResposeReturn, 'NOME');
                console.log(userData);
                res.render('postSpid.ejs', {userData: userData})
            });
        });



    } catch (e) {
        console.log(e.stack);
        res.writeHead(500).end();
    }
});

router.post("/logout", async function (req, res) {
    res.render('postSpid.ejs', {userData: null})
});

module.exports = router;
