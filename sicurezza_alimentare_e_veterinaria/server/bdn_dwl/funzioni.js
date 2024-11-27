/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
const https = require('https');
const http = require('http');
const request = require('request');
const conf = require('../config/config.js');
const conn = require('../db/connection.js');
var MD5 = require("crypto-js/md5");
var soap = require('soap');
var fs = require('fs')
var axios = require('axios');
const utils = require('../utils/utils');

function getGisaJSession(options) {
    return new Promise((resolve, reject) => {
        request.post(
            options
            , (error, response, body) => {
                if (error)
                    reject(error);
                else {
                    //'JSESSIONID=5D1A5137262EE5356BAA97732A7A6B1D; Path=/gisa_nt; HttpOnly'
                    let jsession = response.headers['set-cookie'][0]//.split('JSESSIONID=')[1].split(';')[0];
                    if (response.statusCode = 200)
                        resolve(jsession)
                    else
                        reject(response.statusCode);
                }
            })
    })
}


function upsertAllevamentiDaAllineare(d) {
    var data = d.data;
    var dtRiferimento = d.dtRiferimento;
    if (!data)
        return;
    try {
        data = JSON.parse(data);
        //console.log(Object.values(data)[0]);
        if (Object.values(data)[0]['ELEMENTI'] == '')
            return
        if (!Array.isArray(Object.values(data)[0]['ELEMENTI'])) //a volte è un oggetto singolo
            Object.values(data)[0]['ELEMENTI'] = [Object.values(data)[0]['ELEMENTI']]

        Object.values(data)[0]['ELEMENTI'].forEach(async element => {
            if (element['AZIENDA_CODICE']) {
                await conn.clientBDN.query({
                    text: `INSERT INTO BDN_DWL.DATI_DA_ELAB (VALORE, DATA_RIFERIMENTO_BDN, ID_FUNZIONE)
                        VALUES ($1, $2, (SELECT ID FROM BDN_DWL.FUNZIONI WHERE FUNCTION_NAME = 'allineaAllevamenti'))
                        ON CONFLICT (VALORE, ID_FUNZIONE) DO UPDATE SET DATA_RIFERIMENTO_BDN = $2`,
                    values: [element['AZIENDA_CODICE'], dtRiferimento]
                })
            }
        })

    } catch (err) {
        console.log('upsertAllevamentiDaAllineare', err.stack, data, dtRiferimento)
    }
}

async function allineaAllevamenti(updateMgm) {

    if(updateMgm === undefined)
        updateMgm = true;

    let JSESSION = await this.getGisaJSession({
        url: conf.bdnDwl.gisaProtocol + '://' + conf.bdnDwl.gisaUrl + ':' + conf.bdnDwl.gisaPort + `/gisa_nt/Login.do?command=LoginLDAP`,
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        form: {
            crypt: MD5('GISA-' + conf.bdnDwl.gisaUserCf).toString(),
            cfSpid: conf.bdnDwl.gisaUserCf
        }
    });
    console.log(JSESSION);

    conn.clientBDN.query({
        text: `SELECT VALORE FROM BDN_DWL.DATI_DA_ELAB 
        WHERE ID_FUNZIONE = (SELECT ID FROM BDN_DWL.FUNZIONI WHERE FUNCTION_NAME = 'allineaAllevamenti')
        AND DATA_ELABORAZIONE_GISA IS NULL OR DATA_ELABORAZIONE_GISA <= DATA_RIFERIMENTO_BDN`
    }, async (err, res) => {
        if (err) {
            console.error(err);
            return;
        }
        if (res.rowCount == 0)
            return;
        var i = 0;
        let interval = setInterval(() => {
            try {
                let valore = res.rows[i].valore;

                let options = {
                    host: conf.bdnDwl.gisaUrl,
                    port: conf.bdnDwl.gisaPort,
                    path: `/gisa_nt/AllineamentoBdn?codiceAzienda=${valore}`,
                    method: 'GET',
                    headers: { 'Cookie': JSESSION }
                }
                console.log('allineo:', valore)
                let req = http.get(options, (res) => {
                    var data = '';
                    res.on('data', function (chunk) {
                        data += chunk;
                    });
                    res.on('end', () => {
                        console.log('Response ended: ' + data);
                        conn.clientBDN.query({
                            text: `UPDATE BDN_DWL.DATI_DA_ELAB 
                            SET DATA_ELABORAZIONE_GISA = CURRENT_DATE 
                            WHERE VALORE = $1 AND ID_FUNZIONE = (SELECT ID FROM BDN_DWL.FUNZIONI WHERE FUNCTION_NAME = 'allineaAllevamenti')`,
                            values: [valore]
                        }, (err, result) => {
                            if(err){
                                console.log(err);
                                return;
                            }
                            if(updateMgm){
                               // this.jobAllienaCapiWS(null, null, valore);
                                try{
                                    conn.client.query({
                                        text: 'select * from cu_anag.ins_upd_azienda($1, 1)',
                                        values: [JSON.stringify({codice_azienda: valore})]
                                    }, (err, data) => {
                                        console.log(`select * from cu_anag.ins_upd_azienda('${JSON.stringify({codice_azienda: valore})}', 1)`, err, data.rows[0]?.info)
                                    })
                                }catch(err2){
                                    console.log('Errore cu_anag.ins_upd_azienda ' + valore, err2);
                                }
                            }
                            //infine ottengo i capi per l'allevamento appena aggiunto
                        })
                    });
                }).on('error', err => {
                    console.log('Error: ', err.message, valore);
                });
                //console.log(req);
            } catch (err) {
                console.log('allineaAllevamenti', err.stack, valore);
            } finally {
                i++;
                if (i == res.rows.length)
                    clearInterval(interval);
            }
        }, 3000);
    })

}

let processing = false
function jobAllienaCapiWS(idAllevamentoBdn, httpRes, numAzienda) {

   // if (processing)
     //   return;
    console.log('jobAllienaCapiWS');
    // Recupera i dati dalla configurazione
    const WSDLURL = conf.bdnSOAP.wsdlurl;
    const username = conf.bdnSOAP.username;
    const password = conf.bdnSOAP.password;

    let HeaderArgs = {
        'tns:SOAPAutenticazione': {
            "tns:username": username,
            "tns:password": password,
            'tns:ruolo_codice': '',
            'tns:valore_ruolo_codice': '',
            'tns:token': ''
        }
    };

    conn.clientBDN.query(`select * from bdn_conf.ws_query`, async (errWs, wsConfigAll) => {
        if (errWs) {
            console.log(errWs);
            return;
        }

        conn.clientBDN.query({
                text: `select 
                    id_allevamento,
                    cod_gruppo_specie,
                    account_number as p_azienda_codice,
                    cf_proprietario as p_allev_idfiscale,
                    specie_allev as p_spe_codice,
                    id_allevamento_bdn AS p_allev_id,
                    '' as p_dt_ingresso,
                    '' as p_dt_uscita,
                    '' as p_ordinamento,
                    '' as p_tipo
                    from 
                    bdn.vw_allevamenti where specie_allev in (
                        select lpad(codice::text, 4, '0') from bdn_types.specie where id_gruppo_specie in (
                            select id from bdn_types.gruppispecie where codice in (
                                select cod_grp_specie from bdn_conf.ws_query
                            )
                        )
                    ) and ($1 = 'null' or id_allevamento_bdn = $1) and ($2 = 'null' or account_number = $2)`,
                values: [!idAllevamentoBdn ? 'null' : idAllevamentoBdn, !numAzienda ? 'null' : numAzienda]
            }, async (err, result) => {
            if (err) {
                console.log(err);
                return;
            }
            processing = true;
            //result.rows.forEach((allev) => {
            for (let i = 0; i < result.rows.length; i++) {
                let allev = result.rows[i];
                console.log(`Recupero capi in stalla per azienda ${allev.p_azienda_codice} / specie ${allev.p_spe_codice}`)
                let wsConfig = wsConfigAll.rows.filter((ws) => { return ws.cod_grp_specie == allev.cod_gruppo_specie })[0];
                if (!wsConfig)
                    continue;
                let methods = wsConfig.ws.split(';')
                for (let j = 0; j < methods.length; j++) { //in ws ho i vari metodi da richiamare per la specie
                    try {
                        let method = methods[j];
                        let wsdl = WSDLURL + wsConfig.wsdl.split(';')[j]; //recupero wsdl corrispondente per il metodo
                        let client = await soap.createClientAsync(wsdl, {wsdl_options: {timeout: 60000}});
                        client.addSoapHeader(HeaderArgs);
                        let res = await client[method + 'Async'](allev);
                        //client[method](allev, (err, res, rawResponse, addSoapHeaderoapHeader, rawRequest) => {
                        res = res[0];
                        //ES: Capi_In_StallaResult.root.dati?. dsREGISTRO_STALLA.REGISTRO_DI_STALLA;
                        let dati = res[Object.keys(res)[0]].root.dati?.
                        [Object.keys(res[Object.keys(res)[0]].root.dati)[0]]
                        [Object.keys(res[Object.keys(res)[0]].root.dati[Object.keys(res[Object.keys(res)[0]].root.dati)[0]])[0]];
                        //console.log(dati)
                        if (!dati)
                            continue;
                        if (!Array.isArray(dati))
                            dati = [dati];
                        if (allev.cod_gruppo_specie == '0122') {//suini
                            for (let k = 0; k < dati.length; k++) {
                                if (method == 'FindSuiCensimenti') {//CENSIMENTO
                                    dati[k]["NUM_SUINI_INGR"] = dati[k]['CAPI_TOTALI']
                                    dati[k]["NUM_SUINI_USC"] = null;
                                    dati[k]["DESCR_MOTIVO_INGR_USC"] = 'CENSIMENTO DEL ' + dati[k]['ANNO_RIFERIMENTO'].split('T')[0]
                                    dati[k]["DT_INGRESSO_USCITA"] = dati[k]['ANNO_RIFERIMENTO'].split('T')[0];
                                } else if (method == 'FindRegistriUscitePartitaSuini') { //partita uscita
                                    dati[k]["NUM_SUINI_INGR"] = null;
                                    dati[k]["NUM_SUINI_USC"] = dati[k]['NUM_SUINI'];
                                    dati[k]["DESCR_MOTIVO_INGR_USC"] = dati[k]['DESCR_MOTIVO_USC']
                                    dati[k]["DT_INGRESSO_USCITA"] = dati[k]['DT_USCITA'];
                                } else if (method == 'FindRegistriStallaPartitaSuini') { //partita ingresso
                                    dati[k]["NUM_SUINI_INGR"] = dati[k]['NUM_SUINI'];
                                    dati[k]["NUM_SUINI_USC"] = null;
                                    dati[k]["DESCR_MOTIVO_INGR_USC"] = dati[k]['DESCR_MOTIVO_INGR']
                                    dati[k]["DT_INGRESSO_USCITA"] = dati[k]['DT_INGRESSO'];
                                }
                            }
                        }
                        let queryUpdCapi = {
                            text: 'call bdn_srv.upd_dati($1, $2, 9999, null)',
                            values: [`upd_${method}`, JSON.stringify({ id_allevamento: parseInt(allev.id_allevamento), REGISTRO_DI_STALLA: dati })]
                        }
                        console.log(i, j, queryUpdCapi);
                        let resCapi = await conn.clientBDN.query(queryUpdCapi)
                        if(httpRes)
                            httpRes.json(resCapi.rows[0].joutput);
                    } catch (errfor) {
                        console.log(errfor);
                        if(httpRes)
                            httpRes.json({esito: false, info: errfor.message});
                    }

                }
            }
            processing = false;
        })

    });
}


async function insertInfoSanitarie(data, httpRes) {


        console.log('insertInfoSanitarie');
        // Recupera i dati dalla configurazione
        const WSDLURL = conf.qualificheSOAP.wsdl;
        const username = conf.qualificheSOAP.username;
        const password = conf.qualificheSOAP.password;

        let xml = fs.readFileSync('static/bdn/InsertInfoSanitarie.xml', 'utf8');

        data['username'] = username;
        data['password'] = password;

        xml = generaXml(xml, data);
    
        try{
            let soapRes = await axios.post(
                WSDLURL, 
                xml, 
                {
                    headers: {'Content-Type': 'text/xml'}
                }
                );
            console.log(soapRes);
            let INFOSAN_ID = utils.getXmlValueByTagName(soapRes.data, 'INFOSAN_ID');
            if(INFOSAN_ID){
                await conn.clientBDN.query({
                    text: 'insert into bdn_prof.intervento_qualifiche (id_intervento, id_qualifica, id_piano, infosan_id_bdn, xml_bdn, dt_invio) values ($1, $2, $3, $4, $5, current_timestamp)',
                    values: [data.id_intervento, data.id_qualifica, data.p_id_piano, INFOSAN_ID, xml]
                })
                httpRes.json({esito: true, info: {INFOSAN_ID: INFOSAN_ID}}).end();
            }else{
                let error = utils.getXmlValueByTagName(soapRes.data, 'des');
                await conn.clientBDN.query({
                    text: 'insert into bdn_prof.intervento_qualifiche (id_intervento, id_qualifica, id_piano, error_bdn, xml_bdn, dt_invio) values ($1, $2, $3, $4, $5, current_timestamp)',
                    values: [data.id_intervento, data.id_qualifica, data.p_id_piano, error, xml]
                })
                httpRes.json({esito: false, info: {error: error}}).end();
            }
        }catch(err){
            console.log(err);
            let error = utils.getXmlValueByTagName(err.response.data, 'des');
            await conn.clientBDN.query({
                text: 'insert into bdn_prof.intervento_qualifiche (id_intervento, id_qualifica, id_piano, error_bdn, xml_bdn, dt_invio) values ($1, $2, $3, $4, $5, current_timestamp)',
                values: [data.id_intervento, data.id_qualifica, data.p_id_piano, error, xml]
            })
            httpRes.json({esito: false, info: {error: error}}).end();
        }
       
    
                    
}


async function getMovimentazioniCapo(p_capo_codice, method, httpRes) {

    console.log('getMovimentazioniCapo');
    // Recupera i dati dalla configurazione
    const WSDLURL = conf.bdnSOAP.wsdlurl + 'wsregistrostallaqry.asmx?WSDL';
    const username = conf.bdnSOAP.username;
    const password = conf.bdnSOAP.password;

    let HeaderArgs = {
        'tns:SOAPAutenticazione': {
            "tns:username": username,
            "tns:password": password,
            'tns:ruolo_codice': '',
            'tns:valore_ruolo_codice': '',
            'tns:token': ''
        }
    };

    try{
        let client = await soap.createClientAsync(WSDLURL, {wsdl_options: {timeout: 60000}});
        client.addSoapHeader(HeaderArgs);
        let res = await client[method + 'Async']({p_capo_codice: p_capo_codice});
        //client[method](allev, (err, res, rawResponse, addSoapHeaderoapHeader, rawRequest) => {
        res = res[0];
        
        if(httpRes)
            httpRes.json(res).end();
    }catch(err){
        if(httpRes)
            httpRes.json({esito: false, info: err.message}).end();
    }
                    
}


async function invioSanan(httpRes, id_intervento) {

    // Recupera i dati dalla configurazione
    const WSDLURL = conf.sananSOAP.host;
    const username = conf.sananSOAP.username;
    const password = conf.sananSOAP.password;

    let rdpId = '';
    let countCampioni = 0;

    let xmlTot = '';

    let infoStab = (await conn.clientBDN.query({
        text: `
        select distinct
        a.cod_gruppo_specie,
        a.cod_gruppo_specie as cod_gruppo_specie_due,
        l.codice as cod_laboratorio,
        extract('year' from i.dt) as anno,
        to_char(i.dt, 'YYYY-MM-DD') as data_prelievo,
        a.cf_proprietario as azienda_id_fiscale, 
        a.account_number as cod_azienda,
        to_char(coalesce(p.dt_invio, i.dt) , 'YYYY-MM-DD') as data_accettazone,
        to_char(coalesce(p.dt_invio, i.dt) , 'YYYY-MM-DD') as data_esito,
        m.codicecampione as cod_campione,
        g.id_allevamento,
        m.id as id_matrice,
        coalesce(paa.rdp_cod::text, i.id::text) as rdp_cod
        from 
        bdn_prof.interventi i
        join bdn_prof.giornate g on g.id_intervento = i.id 
        join bdn.vw_allevamenti a on a.id_allevamento = g.id_allevamento 
        join bdn_prof.intervento_matrici_laboratorio_sanan s on s.id_intervento = i.id 
        join bdn_conf.laboratorio l on l.id = s.id_laboratorio
        left join bdn_pa.pre_acc p on p.id_intervento = i.id
        join bdn_conf.matrici m on m.id = g.id_matrice
        left join bdn_pa.pre_acc_allevamenti paa on paa.id_allevamento = g.id_allevamento and p.id = paa.id_preacc 
        where case when m.risultato_intervento_collegato = true then i.id = (SELECT id_intervento_collegato
            FROM bdn_prof.interventi
           WHERE id = $1) else i.id = $1 end`,
        values: [id_intervento]
    })).rows //query

    for(let row of infoStab){

        let resCampioni = await conn.clientBDN.query({text: `
            select pmm.id_prova_sanan as id_prova, 
            case when valore_r = 'KO' then 'S' when valore_r = 'OK' then 'F' else valore_r end as esito,
            tag as matricola, 
            coalesce(esito_analitico, '') as descr_risultato 
            from bdn_prof.intervento_capi ic 
            join bdn_prof.giornate g on ic.id_giornata = g.id
            join bdn.vw_capi c on c.id = ic.id_capo 
                JOIN LATERAL unnest(ic.id_piani)  WITH ORDINALITY piano(valore_p, ordine) ON true
                JOIN LATERAL unnest(ic.risultati_array)  WITH ORDINALITY risultato(valore_r, ordine) ON piano.ordine = risultato.ordine
                join bdn_conf.piano_materiale_metodo pmm on pmm.id_piano = piano.valore_p and pmm.id_matrice = ic.id_matrice and pmm.id_specie = c.id_specie 
            join bdn_conf.matrici m on m.id = g.id_matrice
                where  case when m.risultato_intervento_collegato = true then ic.id_intervento = (SELECT id_intervento_collegato
                    FROM bdn_prof.interventi
                   WHERE id = $1) else ic.id_intervento = $1 end and 
            g.id_allevamento = $2 and g.id_matrice = $3 and pmm.id_prova_sanan is not null
            and n_sample is not null and valore_r is not null
            `,
            values: [id_intervento, row.id_allevamento, row.id_matrice]})

            row['username'] = username;
            row['password'] = password;
            row['num_campioni'] = resCampioni.rowCount;

        if(resCampioni?.rowCount){
            //httpRes.json({esito: false, info: {error: 'Nessun capo/malattia inviabile a SANAN'}}).end();
            countCampioni += resCampioni.rowCount
            let xml = fs.readFileSync('static/sanan/rapportiIzs.xml', 'utf8');
            xml = generaXml(xml, row);

            let campioni = '';

            var xmlCampioni = fs.readFileSync('static/sanan/campione.xml', 'utf8');
            for(let d of resCampioni.rows){
                campioni += `
                `+generaXml(xmlCampioni, d);
            }
            console.log(campioni)
            xml = generaXml(xml, { campioni: campioni });
            xmlTot += xml;

            try{
                let soapRes = await axios.post(
                    WSDLURL, 
                    xml, 
                    {
                        headers: {'Content-Type': 'text/xml'}
                    }
                    );
                console.log(soapRes);
                rdpId += utils.getXmlValueByTagName(soapRes.data, 'rdpId') +', ';
                
            }catch(err){
                console.log(err);
                let error = utils.getXmlValueByTagName(err.response.data, 'faultstring');
                await conn.clientBDN.query({
                    text: `
                        update bdn_prof.intervento_matrici_laboratorio_sanan 
                        set xml_invio_sanan = coalesce(xml_invio_sanan, '') || $1, dt_invio_sanan= current_timestamp, error_sanan = coalesce(error_sanan, '') || $2
                        where id_intervento = $3
                    `,
                    values: [xmlTot ,error, id_intervento]
                })
                httpRes.json({esito: false, info: {error: error}}).end();
                return;
            }     
        }
    }

    if(countCampioni == 0){
        httpRes.json({esito: false, info: {error: 'Nessun capo/malattia inviabile a SANAN'}}).end();
    }else{
        httpRes.json({esito: true, info: {rdpId: rdpId}}).end();
        await conn.clientBDN.query({
            text: `
                update bdn_prof.intervento_matrici_laboratorio_sanan 
                set xml_invio_sanan = coalesce(xml_invio_sanan, '') || $1, dt_invio_sanan= current_timestamp, rdp_id_sanan = $2
                where id_intervento = $3
            `,
            values: [xmlTot ,rdpId, id_intervento]
        })
    }
}




module.exports = {
    upsertAllevamentiDaAllineare: upsertAllevamentiDaAllineare,
    allineaAllevamenti: allineaAllevamenti,
    getGisaJSession: getGisaJSession,
    jobAllienaCapiWS: jobAllienaCapiWS,
    getMovimentazioniCapo : getMovimentazioniCapo,
    insertInfoSanitarie: insertInfoSanitarie,
    invioSanan: invioSanan
}

