/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
const express = require('express');
var router = express.Router();
const conf = require('../config/config');
const preaccettazione = require('../utils/preaccettazioneFunctions');

router.get("/inviaPreaccettazioni", async function (req, res) {
    try {
        res.send(await preaccettazione.jobGetCodiciDaInviareProfilassiBdn()).end();
    } catch (err) {
        console.log(err);
        res.send(err).end();
    }
})

router.get("/creaPreaccettazione", async function (req, res) {
    try {
        res.send(await preaccettazione.creaPreaccettazione(req.query.idIntervento)).end();
    } catch (err) {
        console.log(err);
        res.send(err).end();
    }
})

router.get("/getRdpFirmato", async function (req, res) {
    try {
        await preaccettazione.getRdpFirmato(req.query.rdpcod, res);
    } catch (err) {
        console.log(err);
        res.send(err).end();
    }
})

router.get("/esitiDaRecuperare", async function (req, res) {
    try {
        res.send(await preaccettazione.jobGetEsitiDaRecuperare()).end();
    } catch (error) {
        console.log("error:", error);
        res.send(error).end();
    }
})

router.get("/izsveJob", async function (req, res) {
    try {
        res.send(await preaccettazione.jobIZSVE()).end();
    } catch (error) {
        console.log("error:", error);
        res.send(error).end();
    }
})

router.get("/inviaEsitiSanan", async function (req, res) {
    try {
        res.send(await sanan.inviaEsiti()).end();
    } catch (error) {
        console.log("error:", error);
        res.send(error).end();
    }
})

module.exports = router;