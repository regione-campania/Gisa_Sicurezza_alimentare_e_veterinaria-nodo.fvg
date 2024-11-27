/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
const path = require('path');
const izsve = require('./izsve');
const utils = require('./utils');
const fs = require('fs');
const conn = require('../db/connection');

generaXml = function (xml, data) {
    for (const [key, value] of Object.entries(data)) {
        xml = xml.replaceAll(`$${key}$`, value);
    }
    return xml//.replace(/[\r\n\t]/g, "");
}

getRdpFirmato = async function (rdpCod, httpRes) {

    let sid = null;
    sid = utils.getXmlValueByTagName(await izsve.login(), 'sid');
    if (sid) {
        let ret = await izsve.RefertoPDF(rdpCod, sid, httpRes);
        return ret;
    }

}

creaPreaccettazione = async function (idIntervento) {

    try {

        await conn.clientBDN.query('BEGIN');

        //creo record preacc, avrà il codice di invio
        await conn.clientBDN.query({
            text: `delete from bdn_pa.pre_acc where id_intervento = $1`,
            values: [idIntervento]
        });
        let pa = await conn.clientBDN.query({
            text: `INSERT INTO bdn_pa.pre_acc (id_intervento, dt_invio, cod_ext) 
                values ($1, current_timestamp, null) returning id`,
            values: [idIntervento]
        });

        let idPreacc = pa.rows[0].id;

        await conn.clientBDN.query({
            text: `INSERT INTO bdn_pa.pre_acc_stati (id_pre_acc, id_pa_stato, ts) 
                values ($1, (select id from bdn_types.bdn_pa_stati where cod = 'generata'), current_timestamp)`,
            values: [idPreacc]
        });

        await conn.clientBDN.query({
            text: `INSERT INTO bdn_prof.intervento_stati (id_intervento, id_tipo_stato, dt) 
                values ($1, (select id from bdn_types.tipi_stato where cod = 'send'), current_timestamp)`,
            values: [idIntervento]
        });

        let allevamenti = (await conn.clientBDN.query({
            text: `select distinct id_allevamento from bdn_prof.giornate where id_intervento = $1`,
            values: [idIntervento]
        })).rows;


        let allevamentiXml = '';
        let allevamentoXML = fs.readFileSync(path.join('static', 'izsve', 'allevamento.xml'), 'utf8');
        let campioneXML = fs.readFileSync(path.join('static', 'izsve', 'campione.xml'), 'utf8');
        for (let allev of allevamenti) {
            let dati = {};
            dati['id_giornata'] = allev.id_allevamento;

            //recupero info se a pagamento
            let dlResult = await conn.clientBDN.query({
                text: `select case when min = 'true' then 'S' else 'N' end 
                    from (
                        select min(coalesce(dl32, false)::text), i.id from
                        bdn_prof.interventi i
                        join bdn_prof.intervento_piani ip on ip.id_intervento = i.id 
                        join bdn_prof.piani p on p.id = ip.id_piano 
                        where i.id = $1
                        group by 2
                    )a`,
                values: [idIntervento]
            });
            dati['a_pagamento'] = dlResult.rows[0].case;

            //recupero info allevamento
            let resDatiXml = await conn.clientBDN.query({
                text: `
                    select distinct
                    coalesce(a.cod_azienda, '') as cod_azienda,
                    coalesce(a.cod_azienda, '') as nome_azienda,
                    coalesce(a.indirizzo_azienda, '') as indirizzo_azienda,
                    coalesce(a.cap_azienda, '') as cap_azienda,
                    coalesce(a.localita, '') as comune,
                    case when length(trim(a.id_fiscale_prop)) = 16 then a.id_fiscale_prop else '' end as cod_fiscale,
                    case when length(trim(a.id_fiscale_prop)) != 16 then a.id_fiscale_prop else '' end partita_iva,
                    trim(n.codice_fiscale) as cf_veterinario,
                    n.nominativo as nome_veterinario,
                    s.cod_esterno as cod_asl,
                    s.nome as nome_asl,
                    s.indirizzo as indirizzo_asl,
                    s.istat_comune as comune_asl,
                    s.cap as cap_asl,
                    s.piva as piva_asl,
                    va.id_allevamento,
                    replace(va.name, '&', 'e') as nome_allevamento, 
                    trim(va.partita_iva) as partita_iva_allevamento,
                    trim(va.cf_proprietario) as cod_fiscale_allevamento,
                    pa.dt_invio::date,
                    iv.id
                    from
                    bdn_prof.interventi i
                    join bdn_pa.pre_acc pa on pa.id_intervento = i.id
                    join bdn_prof.giornate g on g.id_intervento = i.id
                    join bdn.vw_allevamenti va on va.id = g.id_allevamento 
                    join bdn.vw_aziende a on va.account_number::text = a.cod_azienda
                    join bdn_prof.interventi_veterinari iv on iv.id_intervento = i.id
                    join bdn.vw_nominativi n on n.id = iv.id_veterinario
                    join bdn_conf.asl_sedi s on s.id_asl = n.id_asl 
                    where i.id = $1 and g.id_allevamento = $2
                    order by iv.id`,
                values: [idIntervento, allev.id_allevamento]
            })

            //merge dati con dati allevamento
            dati = { ...dati, ...resDatiXml.rows[0] };

            //recupero info campioni
            let resCampioni = await conn.clientBDN.query({
                text: `
                SELECT  ic.id AS id_pre_acc_capo,
                    ic.id_ic,
                    pa.id as id_pre_acc,
                    pa.id,
                    pa.id_intervento,
                    pa.dt_invio::date AS dt_invio,
                    ic.id AS cod_izs,
                    ic.id_capo,
                    ic.marchio,
                    ic.sesso,
                    COALESCE(ic.dt_nascita::text, '') dt_nascita,
                    ic.n_sample,
                    ic.cod_gruppo_specie,
                    vr.cod_izsv,
                    g.id_matrice,
                    ic.id_piani,
                    m.codicecampione_izsv,
                    string_agg(distinct '<esame tipoesito="A" subacc="'||subacc||'" motacc="'||motacc||'" metodo="'||metodo_izsve||'" codice="'||codice_izsve||'"/>
                        ', '') as esami
                FROM 
                    bdn_pa.vw_pre_acc pa 
                    JOIN bdn_prof.vw_intervento_capi ic ON ic.id_intervento  = pa.id_intervento 
                    CROSS JOIN LATERAL unnest(ic.id_piani) piani(id_piano)
                    LEFT JOIN bdn.capi c ON c.id = ic.id_capo
                    JOIN bdn_prof.giornate g ON g.id_intervento = ic.id_intervento AND ic.id_giornata = g.id
                    join bdn.vw_allevamenti va on va.id_allevamento = g.id_allevamento 
                    JOIN bdn_types.vw_specie vr ON vr.spe_id = va.spe_id
                    JOIN bdn_conf.matrici m ON m.id = g.id_matrice
                    JOIN bdn_conf.piano_materiale_metodo pmm ON pmm.id_piano = piani.id_piano AND pmm.id_matrice = g.id_matrice AND pmm.id_specie = vr.id_specie
                    where pa.id_intervento = $1 and g.id_allevamento = $2 and pmm.codice_izsve is not null
                    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
                    
                    
                    union 
                    
                    SELECT  ic.pool AS id_pre_acc_capo,
                    ic.pool,
                    pa.id as id_pre_acc,
                    pa.id,
                    pa.id_intervento,
                    pa.dt_invio::date AS dt_invio,
                    ic.pool AS cod_izs,
                    ic.pool,
                    '',
                    '',
                    '',
                    ic.n_sample,
                    vr.codice::text,
                    vr.cod_izsv,
                    g.id_matrice,
                    ic.id_piani,
                    m.codicecampione_izsv,
                    string_agg(distinct '<esame tipoesito="A" subacc="'||subacc||'" motacc="'||motacc||'" metodo="'||metodo_izsve||'" codice="'||codice_izsve||'"/>
                        ', '') as esami
                FROM 
                    bdn_pa.pre_acc pa 
                    JOIN bdn_prof.intervento_pool pc ON pc.id_intervento  = pa.id_intervento 
                    JOIN bdn_prof.giornate g ON g.id_intervento = pc.id_intervento 
                    join bdn_prof.vw_pool_giornata ic on 
                        ic.id_giornata = g.id 
                    cross JOIN LATERAL unnest(ic.id_piani) piani(id_piano) 
                    join bdn.vw_allevamenti va on va.id_allevamento = g.id_allevamento 
                    JOIN bdn_types.vw_specie vr ON vr.spe_id = va.spe_id
                JOIN bdn_conf.matrici m ON m.id = g.id_matrice
                    JOIN bdn_conf.piano_materiale_metodo pmm ON pmm.id_piano = piani.id_piano 
                        AND pmm.id_matrice = g.id_matrice AND pmm.id_specie = vr.spe_id
                    where pa.id_intervento = $1 and g.id_allevamento = $2 and pmm.codice_izsve is not null
                    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
                    
                    
                    order by n_sample
                `,
                values: [idIntervento, allev.id_allevamento]
            })

            //creo xml campioni
            if (resCampioni.rowCount) {
                let campioniXml = '';
                for (let campione of resCampioni.rows) {
                    campioniXml += generaXml(campioneXML, campione);
                }

                //inserisco record preacc per ogni allevamento (ognuno avraà il suo rdp)
                await conn.clientBDN.query({
                    text: `INSERT INTO bdn_pa.pre_acc_allevamenti (id_allevamento, id_preacc) 
                        values ($1, $2)`,
                    values: [allev.id_allevamento, idPreacc]
                });


                //aggiungi i dati dei campioni a e genero l xml per il sigolo allevamento
                dati['campioni'] = campioniXml;
                allevamentiXml += generaXml(allevamentoXML, dati);
            } else {
                await conn.clientBDN.query('ROLLBACK');
                return { esito: false, msg: 'Nessun capo da inviare all\'IZSVe' };
            }

        }

        let importaAccettazioneXML = fs.readFileSync(path.join('static', 'izsve', 'importaAccettazione.xml'), 'utf8');
        importaAccettazioneXML = generaXml(importaAccettazioneXML, { allevamenti: allevamentiXml });

        let codice = null;
        let sid = null;
        sid = utils.getXmlValueByTagName(await izsve.login(), 'sid');
        if (sid) {
            let retImporta = await izsve.importaAccettazione(importaAccettazioneXML, sid);
            if (retImporta) {
                codice = utils.getXmlValueByTagName(retImporta, 'codice');
            }
        }

        await izsve.logout(sid);
        if (codice) {
            await conn.clientBDN.query({
                text: `update bdn_pa.pre_acc set cod_ext = $1, xml = $3 where id_intervento = $2`,
                values: [codice, idIntervento, importaAccettazioneXML]
            })
            await conn.clientBDN.query({
                text: `INSERT INTO bdn_pa.pre_acc_stati (id_pre_acc, id_pa_stato, ts) 
                    values ($1, (select id from bdn_types.bdn_pa_stati where cod = 'inviata'), current_timestamp)`,
                values: [idPreacc]
            });
            await conn.clientBDN.query('COMMIT');
            return { esito: true, codice: codice, xml: importaAccettazioneXML }
        } else {
            await conn.clientBDN.query('ROLLBACK');
            return { esito: false, msg: 'Errore durante la preaccettazione' };
        }
    } catch (err) {
        console.log(err);
        await conn.clientBDN.query('ROLLBACK');
        return { esito: false, error: err }
    }

}

recuperaPreaccettazioni = async function () {

    conn.clientBDN.query(`SELECT 
                        p.id as id_preacc,
                        p.cod_ext, 
                        p.id_intervento,
                        p.dt_invio::date,
                        current_date as dt_ricerca,
                        a.id_allevamento,
                        a.id as id_preacc_all
                        FROM bdn_pa.pre_acc p
                        join bdn_pa.pre_acc_allevamenti a on p.id = a.id_preacc
                        where a.rdp_cod is null and p.xml is not null` , async (err, data) => {
        if (err) {
            console.log(err);
            return { esito: false, msg: err };
        }

        let i = 0;
        for (let d of data?.rows) {
            i++;
            let codInvio = d.cod_ext;
            let sid = utils.getXmlValueByTagName(await izsve.login(), 'sid');
            if (sid) {
                let listaRDPXML = await izsve.ListaRdpFirmati(d.dt_invio.split('-').reverse().join('/'), d.dt_ricerca.split('-').reverse().join('/'), sid)

                let listaRDP = listaRDPXML.split('<row');
                listaRDP.shift(); //rimuovo primo elemento perchè non mi interessa
                for (let rdp of listaRDP) {
                    if (utils.getAttributeFromXmlTag(rdp, 'PRACODINVIO') == codInvio && utils.getAttributeFromXmlTag(rdp, 'ACCNUMVERBALE') == d.id_allevamento) {
                        let rdpCod = utils.getAttributeFromXmlTag(rdp, 'RDPCOD');
                        await conn.clientBDN.query(
                            {
                                text: `update bdn_pa.pre_acc_allevamenti set rdp_cod = $1 where id = $2`,
                                values: [rdpCod, d.id_preacc_all]
                            })

                        await conn.clientBDN.query({
                            text: `INSERT INTO bdn_pa.pre_acc_stati (id_pre_acc, id_pa_stato, ts) 
                                values ($1, (select id from bdn_types.bdn_pa_stati where cod = 'ricevuta'), current_timestamp)`,
                            values: [d.id_preacc]
                        });

                        let accettazioniXML = await izsve.esportaAccettazione(codInvio, sid);
                        let listaAccettazioni = accettazioniXML.split('<allevamento>');
                        listaAccettazioni.shift();
                        for (let acc of listaAccettazioni) {

                            await conn.clientBDN.query({
                                text: `INSERT INTO bdn_pa.pre_acc_stati (id_pre_acc, id_pa_stato, ts) 
                                    values ($1, (select id from bdn_types.bdn_pa_stati where cod = 'inlettura'), current_timestamp)`,
                                values: [d.id_preacc]
                            });

                            if (utils.getXmlValueByTagName(acc, 'num_verbale') == d.id_allevamento) {
                                let capi = acc.split('<campione>');
                                capi.shift();
                                for (let capo of capi) {
                                    let idIntCapo = utils.getXmlValueByTagName(capo, 'codice');
                                    let marca = utils.getXmlValueByTagName(capo, 'marca');
                                    let codMatrice = utils.getXmlValueByTagName(capo, 'materiale');
                                    let codSpecie = utils.getXmlValueByTagName(capo, 'specie');
                                    let provetta = utils.getXmlValueByTagName(capo, 'num_provetta');
                                    let esami = capo.split('<esame');
                                    esami.shift();
                                    for (esame of esami) {

                                        try{

                                            let codiceMalattia = utils.getAttributeFromXmlTag(esame, 'codice');
                                            let metodoAnalisi = utils.getAttributeFromXmlTag(esame, 'metodo');
                                            let motivoAccertamento = utils.getAttributeFromXmlTag(esame, 'motacc');
                                            let subAccertamento = utils.getAttributeFromXmlTag(esame, 'subacc');
                                            let esitoSintetico = utils.getAttributeFromXmlTag(esame, 'esito_sint');
                                            let esitoAnalitico = utils.getAttributeFromXmlTag(esame, 'esito_anal');

                                            if (marca) {//capo

                                                let qq = `select id_piano from bdn_conf.piano_materiale_metodo pmm 
                                                where codice_izsve = $2 and metodo_izsve = $3
                                                and id_matrice = (select id_matrice from bdn_prof.intervento_capi where id = $1)
                                                and id_specie = (select id from  bdn_types.specie  where cod_izsv = $4 )
                                                and motacc = $5 and subacc = $6 `;

                                                let vv = [idIntCapo, codiceMalattia, metodoAnalisi, codSpecie, motivoAccertamento, subAccertamento];

                                                console.log(qq, vv);

                                                let idPianoResult = await conn.clientBDN.query({
                                                    text: qq,
                                                    values: vv
                                                });

                                                if (idPianoResult.rowCount) {

                                                    let idPiano = idPianoResult.rows[0].id_piano;

                                                    let q = `update bdn_prof.intervento_capi  set
                                                            risultati_array[array_position(id_piani, $2)] = case when $3 ='N' then 'OK' when $3 ='P' then 'KO' else $3 end,
                                                            esito_analitico_array[array_position(id_piani, $2)] = $4
                                                        where id = $1`;
                                                    let v = [idIntCapo, idPiano, esitoSintetico, esitoAnalitico];

                                                    console.log(q, v);

                                                    await conn.clientBDN.query({
                                                        text: q,
                                                        values: v
                                                    })
                                                }
                                            } else { //pool

                                                let qq = `select id_piano from bdn_conf.piano_materiale_metodo pmm 
                                                    where codice_izsve = $2 and metodo_izsve = $3
                                                    and id_matrice = (select id_matrice from bdn_prof.vw_pool_giornata where pool = $1)
                                                    and id_specie = (select id from  bdn_types.specie  where cod_izsv = $4 )
                                                    and motacc = $5 and subacc = $6 `;

                                                let vv = [idIntCapo, codiceMalattia, metodoAnalisi, codSpecie, motivoAccertamento, subAccertamento];

                                                console.log(qq, vv);

                                                let idPianoResult = await conn.clientBDN.query({
                                                    text: qq,
                                                    values: vv
                                                });

                                                if (idPianoResult.rowCount) {

                                                    let idPiano = idPianoResult.rows[0].id_piano;

                                                    let q = `update bdn_prof.pool_giornata  set
                                                    risultati_array[array_position(id_piani, $2)] = case when $3 ='N' then 'OK' when $3 ='P' then 'KO' else $3 end,
                                                    esito_analitico_array[array_position(id_piani, $2)] = $4
                                                    where pool = $1`;

                                                    let v = [idIntCapo, idPiano, esitoSintetico, esitoAnalitico];

                                                    console.log(q, v);

                                                    await conn.clientBDN.query({
                                                        text: q,
                                                        values: v
                                                    })
                                                }
                                            }
                                        }catch(errEsami){
                                            console.log(errEsami);
                                        }
                                    }
                                }
                            }
                        }
                        await conn.clientBDN.query({
                            text: `INSERT INTO bdn_prof.intervento_stati (id_intervento, id_tipo_stato, dt) 
                                values ($1, (select id from bdn_types.tipi_stato where cod = 'closed'), current_timestamp)`,
                            values: [d.id_intervento]
                        });
                    }
                }
            }


            if (i == data.rowCount) {
                await conn.clientBDN.query({
                    text: `INSERT INTO bdn_pa.pre_acc_stati (id_pre_acc, id_pa_stato, ts) 
                    values ($1, (select id from bdn_types.bdn_pa_stati where cod = 'finale'), current_timestamp)`,
                    values: [d.id_preacc]
                });
            }
        }
    })

}


module.exports = {
    getRdpFirmato: getRdpFirmato,
    creaPreaccettazione: creaPreaccettazione,
    recuperaPreaccettazioni: recuperaPreaccettazioni
}