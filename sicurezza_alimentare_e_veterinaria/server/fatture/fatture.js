/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
var conf = require('../config/config');
const https = require('https');
var conn = require('../db/connection');
var utils = require('../utils/utils');
var auth = require('../utils/auth');
var soap = require('soap');

var fattureUtils = {
    jobFatture: async function (id_trf_fattura) {
        // Idle per recuperare gli id delle fatture

        // Fin quando ne trovo uno, allora esegui la pipeline

        // PIPELINE
        // get_ws_call (Richiama l'XML per il WS)
        const query_get = {
            text: 'call agenda.get_dati($1, $2, $3, $4)',
            values: ['get_ws_call', { id_trf_fattura: id_trf_fattura }, , '{}']
        };

        res_get = await conn.client.query(query_get);
        console.log("res_get:", res_get);

        // ws call per l'aggiornamento


        // upd_ws_call (Aggiorna i dati)
        const query_upd = {
            text: 'call agenda.upd_dati($1, $2, $3, $4)',
            values: ['upd_ws_call', {}, , '{}']
        };

        res_upd = await conn.client.query(query_upd);
        console.log("res_upd:", res_upd);
    }
}

module.exports = fattureUtils;