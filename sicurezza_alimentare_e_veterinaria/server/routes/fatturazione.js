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
var axios = require('axios');
var confSicer = require('../config/config')['sicerFatturazione']

router.get("/inviaPrestazioniSicer", function (req, res) {
    try {
        inviaPrestazioniSicerJob(req.query.idPrestazione, res);
    } catch (err) {
        console.log(err.stack);
        res.writeHead(500).end();
    }
})

inviaPrestazioniSicerJob = function (idPrestazione, res){

    try{
        axios.get(`${confSicer.host}/rest_api/authentication?username=${confSicer.username}&password=${confSicer.password}`)
        .then(async (response) => {
            console.log(response.data);
            let ticket = response.data.ticket;
            
            //console.log("idPrestazione: ", idPrestazione);
            let result = null
            let risultatoAttDatiDaInviare = null;
            if(!idPrestazione)
                result = await conn.client.query(`select * from  trf.trf_att_inviate`);
            else{
                //Se è un array faccio la split altrimenti prendo come se fosse un solo elemento
                let elem = idPrestazione.split(',')
                if(!Array.isArray(elem)) elem = [elem];
                for(let i = 0; i < elem.length; i ++){
                    elem[i] = parseInt(elem[i]);
                }
                //Dichiarazione dell'oggetto in modo tale da metterla nella query facendo lo stringify
                let obj = { id_trf_att_inviate: elem}
               // console.log("oggetto: ",obj)
                result = await conn.client.query({
                    text: `select * from trf.get_att_dati_da_inviare($1,-1)`,
                    values: [JSON.stringify(obj)]
                });
               // console.log("risultato query: ", result.rows);
               // Parse del risultato della query
                risultatoAttDatiDaInviare = JSON.parse(result.rows[0].info);
                //console.log("Parse del risultato: ", risultatoAttDatiDaInviare);
               // console.log("risulato att da inviare", risultatoAttDatiDaInviare[0].id_trf_attivita);
            }

            responses = [];
            for(let i = 0; i < result.rowCount; i++){
                var strJ = '';
                var risultato = '';
                try{

                    //La funzione lato DB restituisce già un JSON, quindi si dovrà fare lo stringify del JSON restituito
                    risultato = JSON.stringify(risultatoAttDatiDaInviare[i].str_j);
                    //console.log(JSON.stringify(risultatoAttDatiDaInviare[i].str_j.Prestazioni))
                    var url = `${confSicer.host}/rest_api/InvioPrestazioni?ticket=${ticket}&prestazioni=${encodeURIComponent(risultato)}`;
                    console.log(url)
                    let responsePost = await axios({
                        method: 'get',
                        url: url,
                    })
                   // console.log("Risposta: ", responsePost.data);
                    responses.push({id: risultatoAttDatiDaInviare[i].id, esito: 'ok', data: risultato, result: responsePost.data})
                    //La risposta la andrò a mettere nella upd che andrò a passare l'id_att_inviata e la risposta la metterò nel ret
                   // console.log("result: ", responses[i].id);
                   // Dichiarazione dell'oggetto per poi utilizzarla nella query facendo lo stringify
                    let obj = { id_att_inviata: risultatoAttDatiDaInviare[i].id,
                                ret: JSON.stringify(responses)}
                  //  console.log("oggetto: ",obj)
                    resultAttDaInviare = await conn.client.query({
                        text: `select * from trf.upd_att_inviata_sicer($1,-1)`,
                        values: [JSON.stringify(obj)]
                    });
                }catch(err){
                    console.log(err);
                    responses.push({id: risultatoAttDatiDaInviare[i].id, esito: 'ko', data: risultato, result: err})
                    let obj = { id_att_inviata: risultatoAttDatiDaInviare[i].id,
                        ret: JSON.stringify(responses)}
                    resultAttDaInviare = await conn.client.query({
                        text: `select * from trf.upd_att_inviata_sicer($1,-1)`,
                        values: [JSON.stringify(obj)]
                    });
                }
            }
            if(res)
                res.json(responses).end();
        })
        .catch((error) => {
            res.json({esito: false, info: 'Errore SICER:' + error.message}).end();
        });
    }catch(err){
        console.log(err.stack);
        if(res)
            res.writeHead(500).end();
    }
    
}

module.exports = router;