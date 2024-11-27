/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
//rotta per notifiche
var express = require('express');
var router = express.Router();
const conf = require('../config/config');
const axios = require('axios');

router.get("/geolocalizzaIndirizzo", (req, res) => {
    const params = req.query.toponimo + ' ' + req.query.indirizzo + ' ' + req.query.civico + ', ' + req.query.cap + ' ' + req.query.comune + ', ' + 'Italia';
    axios.get(`${conf.eagleEndpoint}/geofinderwrapperservice/rest/v1/geofinderwrapper/location-by-query?query=${params}&maxResult=1&onlyFvg=false`)
    .then( (response) => {
        // console.log("url:",url);
        console.log("risposta",response);
        //ricavo delle coordinate del primo risultato preso
        res.json({esito: true, data: response.data.resourceSets[0].resources[0].geocodePoints[0].coordinates});
    })
    .catch((error) => {
        console.log("errore:",error)
        res.json({esito: false, msg: error})
    })
})



module.exports = router;