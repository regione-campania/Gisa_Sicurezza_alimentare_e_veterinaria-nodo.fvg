/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
const https = require('https');
const conf = require('../config/config');
const formData = require('form-data');
const fs = require('fs');
const zlib = require('zlib');
const conn = require('../db/connection');
const funzioni = require('./funzioni');
const utils = require('../utils/utils');
var MD5 = require("crypto-js/md5");

var TOKEN = null
var JSESSION = null;
var processing = false;

async function inviaPromise(options, body){


    return new Promise((resolve, reject) => {

        if(options.method == 'POST'){
            const req = https.request(options, function (res) {
                var data = '';
                res.on('data', function (chunk) {
                    data += chunk;
                });
                res.on('end', function () {
                    if (res.statusCode === 200) {
                        try {
                            resolve(data);
                        } catch (e) {
                            console.log("data", e.stack, options);
                        }
                    } else {
                        console.log('Status:', res.statusCode, options);
                        resolve(data);
                    }
                });
            }).on('error', function (err) {
                console.log('Error:', err);
                reject(err);
            });
            if(options.headers['Content-Type'].startsWith('multipart/form-data'))
                body.pipe(req);
            else{
                req.write(body.toString());
                req.end();
            }
           
        }else{ // GET
            https.get(options, function (res) {
                var data = '';
                res.on('data', function (chunk) {
                    data += chunk;
                });
                res.on('end', function () {
                    if (res.statusCode === 200) {
                        try {
                            resolve(data);
                        } catch (e) {
                            console.log(e.stack);
                        }
                    } else {
                        console.log('Status:', res.statusCode);
                        resolve(data);
                    }
                });
            }).on('error', function (err) {
                console.log('Error:', err);
                reject(err);
            });
        }
    })
}

async function invia(options, data) {
    try {
        let promise = inviaPromise(options, data);
        return(await promise);
    }
    catch(error) {
        // Promise rejected
        console.log(error);
    }
}


async function getToken(){

    let form = new formData();
    form.append('grant_type', 'password');
    form.append('username', conf.bdnDwl.username);
    form.append('password', conf.bdnDwl.password);
  
    let credentials  = Buffer.from(conf.bdnDwl.clientId + ':' + conf.bdnDwl.clientSecret).toString('base64');
    // An object of options to indicate where to post to
    var post_options = {
        host: conf.bdnDwl.host,
        port: '443',
        path: conf.bdnDwl.autUrl+'/oauth/token',
        method: 'POST',
        headers: {
            'Authorization' : `Basic ${credentials}`,
            'Content-Type': form.getHeaders()['content-type'],
            'Content-Length': form.getLengthSync()
        }
    };
  
    let res = await invia(post_options, form);
    try{
        return JSON.parse(res).access_token;
    }catch(err){
        console.log(err.stack);
    }

}

async function aggiornaTipologie() {
    let options = {
        host: conf.bdnDwl.host,
        port: '443',
        path: conf.bdnDwl.baseUrl + '/api/dwl/v1/tipologiadownload?from=1&limit=9999',
        method: 'GET',
        headers: {
            'Authorization' : `Bearer ${TOKEN}`
        }
    }
    let res = JSON.parse(await invia(options));
    console.log("tipolgie", res);
    for(t of res){
        let query = {
            text: `
            INSERT INTO BDN_DWL.tipologie (dwltipdowid, codice, nome, descrizione, vista, dtinserimentobdn,
                tipoestrazionecodice, tipoestrazionedescrizione, ambitoapplicativocodice, ambitoapplicativodescrizione,
                flagvisibilitacompetenza)
            values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
            on conflict (dwltipdowid) do update
                set codice = $2, nome = $3, descrizione = $4, vista = $5, dtinserimentobdn = $6, 
                    tipoestrazionecodice = $7, tipoestrazionedescrizione = $8, ambitoapplicativocodice = $9, ambitoapplicativodescrizione = $10, 
                    flagvisibilitacompetenza = $11
            `,
            values: [t.dwltipdowId, t.codice, t.nome, t.descrizione, t.vista, t.dtInserimentoBdn,
                t.tipoEstrazioneCodice, t.tipoEstrazioneDescrizione, t.ambitoApplicativoCodice, t.ambitoApplicativoDescrizione, 
                t.flagVisibilitaCompetenza]
        }
        await conn.clientBDN.query(query)
    }

}

async function aggiornaTipologie() {
    let options = {
        host: conf.bdnDwl.host,
        port: '443',
        path: conf.bdnDwl.baseUrl + '/api/dwl/v1/tipologiadownload?from=1&limit=9999',
        method: 'GET',
        headers: {
            'Authorization' : `Bearer ${TOKEN}`
        }
    }
    let res = JSON.parse(await invia(options));
    //console.log(res);
    for(t of res){
        let query = {
            text: `
            INSERT INTO BDN_DWL.tipologie (dwltipdowid, codice, nome, descrizione, vista, dtinserimentobdn,
                tipoestrazionecodice, tipoestrazionedescrizione, ambitoapplicativocodice, ambitoapplicativodescrizione,
                flagvisibilitacompetenza)
            values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
            on conflict (dwltipdowid) do update
                set codice = $2, nome = $3, descrizione = $4, vista = $5, dtinserimentobdn = $6, 
                    tipoestrazionecodice = $7, tipoestrazionedescrizione = $8, ambitoapplicativocodice = $9, ambitoapplicativodescrizione = $10, 
                    flagvisibilitacompetenza = $11
            `,
            values: [t.dwltipdowId, t.codice, t.nome, t.descrizione, t.vista, t.dtInserimentoBdn,
                t.tipoEstrazioneCodice, t.tipoEstrazioneDescrizione, t.ambitoApplicativoCodice, t.ambitoApplicativoDescrizione, 
                t.flagVisibilitaCompetenza]
        }
        await conn.clientBDN.query(query)
    }

}

async function aggiornaSottostrizioni() {
    let options = {
        host: conf.bdnDwl.host,
        port: '443',
        path: conf.bdnDwl.baseUrl + '/api/dwl/v1/sottoscrizione?from=1&limit=9999',
        method: 'GET',
        headers: {
            'Authorization' : `Bearer ${TOKEN}`
        }
    }
    let res = JSON.parse(await invia(options));
    console.log("sottoscrizioni", res);
    for(t of res){
        //aggiorno dati sottoscrizioni
        let query = {
            text: `
            INSERT INTO BDN_DWL.sottoscrizioni (dwlsotid, dwltipdowid, formato, dtriferimento, dtregistrazione, statosottoscrizione,
                dtultimamodifica, numelaborazionisuccesso, numelaborazionierrore, enabled)
            values ($1, $2, $3, $4, $5, $6, $7, $8, $9, true)
            on conflict (dwlsotid) do update
                set dwltipdowid = $2, formato = $3, dtriferimento = $4, dtregistrazione = $5, statosottoscrizione = $6, 
                dtultimamodifica = $7, numelaborazionisuccesso = $8, numelaborazionierrore = $9
            `,
            values: [t.dwlsotId, t.tipologiaDownload.dwltipdowId, t.formato, t.dtRiferimento, t.dtRegistrazione, t.statoSottoscrizione,
                t.dtUltimaModifica, t.numElaborazioniSuccesso, t.numElaborazioniErrore]
        }
        await conn.clientBDN.query(query)
        
    }

    return res;

}

async function getElaborazioni() {
    //if(processing)
      //  return;
    processing = true;
    console.log("start bdn_dlw");
    TOKEN = await getToken();

    await aggiornaTipologie();
    let sottoscrizioni = await aggiornaSottostrizioni();

    let options = {
        host: conf.bdnDwl.host,
        port: '443',
        path: conf.bdnDwl.baseUrl + '/api/dwl/v1/elaborazione?limit=99999999&q='+encodeURIComponent(`{"lo":"AND","cr":[{"f":"dtRiferimento","op":"GTE","v1":"1900-01-01"}]}`),
        method: 'GET',
        headers: {
            'Authorization' : `Bearer ${TOKEN}`
        }
    }

    let elabsTotali = JSON.parse(await invia(options));

    //filtro tenendo solo le sottoscrizioni che voglio elaborare
    let resSott = await conn.clientBDN.query('SELECT dwlsotid FROM BDN_DWL.SOTTOSCRIZIONI WHERE ENABLED');
    sottoscrizioni = sottoscrizioni.filter((sott) => {
        for(row of resSott.rows){
            if(row.dwlsotid == sott.dwlsotId)
                return true;
        }
        return false;
    })

    sottoscrizioni = sottoscrizioni.sort((a, b) => {
        return new Date(utils.italianStringDateToIsoDate(a.dtRiferimento)) - new Date(utils.italianStringDateToIsoDate(b.dtRiferimento))
    })

    const promises = await sottoscrizioni.map(async sott => {

        //recupero data da cui recuperare le elebarazioni
        let query = {
            text: `
            select to_char(coalesce(data_ultima_elaborazione_processata, dtRiferimento), 'YYYY-MM-DD') as data_ultima_elaborazione_processata 
            from BDN_DWL.sottoscrizioni where dwlsotid = $1 and enabled
            `,
            values: [sott.dwlsotId]
        }
        let ret = await conn.clientBDN.query(query);
        let data_ultima_elaborazione_processata = new Date(ret.rows[0].data_ultima_elaborazione_processata);

        let elabs = elabsTotali?.filter((e) => {
            return (e.sottoscrizione.dwlsotId == sott.dwlsotId && new Date(utils.italianStringDateToIsoDate(e.dtRiferimento)) >= data_ultima_elaborazione_processata)
        })
        elabs = elabs.sort((a, b) => {
            return new Date(utils.italianStringDateToIsoDate(a.dtRiferimento)) - new Date(utils.italianStringDateToIsoDate(b.dtRiferimento))
        })

        console.log("elab da processare:", elabs.length, elabs[0].sottoscrizione.tipologiaDownload.codice)
        for(elab of elabs){
            
            try{
                let idElab = elab['dwlelaId'];
                let options = {
                    host: conf.bdnDwl.host,
                    port: '443',
                    path: conf.bdnDwl.baseUrl + '/api/dwl/v1/elaborazione/'+idElab,
                    method: 'GET',
                    headers: {
                        'Authorization' : `Bearer ${TOKEN}`
                    }
                }
        
                var idTipologia = elab.sottoscrizione.tipologiaDownload.dwltipdowId
        
                let queryElab = {
                    text: `
                    INSERT INTO BDN_DWL.elaborazioni (dwlelaid, dwlsotid, dtultimamodifica, dtriferimento, esito)
                    values ($1, $2, $3, $4, $5)
                    on conflict (dwlelaid) do update
                        set dwlsotid = $2, dtultimamodifica = $3, dtriferimento = $4, esito = $5
                    `,
                    values: [idElab, elab.sottoscrizione.dwlsotId, elab.dtUltimaModifica, elab.dtRiferimento, elab.esito]
                }
                await conn.clientBDN.query(queryElab)
        
                TOKEN = await getToken();
                elab = JSON.parse(await invia(options));

                let queryFile = null;
                try{
                    for(file of elab.files){
                        queryFile = null;
                        let idFile = file.dwlfilId;
                        let options = {
                            host: conf.bdnDwl.host,
                            port: '443',
                            path: conf.bdnDwl.baseUrl + '/api/dwl/v1/file/'+idFile,
                            method: 'GET',
                            headers: {
                                'Authorization' : `Bearer ${TOKEN}`
                            }
                        };
                        TOKEN = await getToken();
                        file = JSON.parse(await invia(options));

                        file.fileTextBytea = 'null';
                        if(file.file){//non sempre ricevo il file
                            file.fileText = zlib.gunzipSync(Buffer.from(file.file, 'base64')).toString('utf8');
                            file.fileTextBytea = " '" + file.fileText.replace(/'/g, "''").replace(/\\/g, "") + "'"; //faccio l'escape della stringa per inserirla nel bytea
                        }
                        
                        queryFile = {
                            text: `
                            INSERT INTO BDN_DWL.files (dwlfilid, dwlelaid, nome_file, dtultimamodifica, file)
                                values ($1, $2, $3, $4, ${file.fileTextBytea})
                            on conflict (dwlfilid) do update
                                set dwlelaid = $2, nome_file = $3, dtultimamodifica = $4, file = ${file.fileTextBytea}
                            `,
                            values: [file.dwlfilId, idElab, file.nomeFile, file.dtUltimaModifica]
                        }
                        await conn.clientBDN.query(queryFile);

                        if(file.fileText){
                
                            let queryFun = {
                                text: `SELECT * FROM BDN_DWL.FUNZIONI WHERE dwltipdowId = $1 and tipo = 'singolo' order by ord`,
                                values: [idTipologia]
                            };
                            result = await conn.clientBDN.query(queryFun);
                
                            for(fun of result.rows){
                                if(fun.server == 'node'){
                                    funzioni[fun.function_name]({
                                        data: file.fileText, dtRiferimento: elab.dtRiferimento
                                    });
                                }
                            }
                        }
                    }
                    //a termine di tutti i file flaggo l'elaborazione processata alla data attuale
                    let querySott = {
                        text: `UPDATE BDN_DWL.SOTTOSCRIZIONI SET DATA_ULTIMA_ELABORAZIONE_PROCESSATA = $2 WHERE dwlsotid = $1`,
                        values: [elab.sottoscrizione.dwlsotId, elab.dtRiferimento]
                    };
                    result = await conn.clientBDN.query(querySott);
                }catch(err){
                    console.log("file:", err.stack, queryFile);
                }
            }catch(err){
                console.log("elab:", err.stack);
            }
    
        }
        return;
    })    

    await Promise.all(promises);
    console.log("end promises")
    let queryFunFin = {
        text: `SELECT * FROM BDN_DWL.FUNZIONI WHERE tipo = 'finale' order by ord`,
    };
    result = await conn.clientBDN.query(queryFunFin);

    for(fun of result.rows){
        if(fun.server == 'node'){
            funzioni[fun.function_name]();
        }else if(fun.server == 'postgres'){
            await conn.clientBDN.query(`select * from ${fun.function_name}`);
        }
    }


}

module.exports = {
    getElaborazioni: getElaborazioni
};