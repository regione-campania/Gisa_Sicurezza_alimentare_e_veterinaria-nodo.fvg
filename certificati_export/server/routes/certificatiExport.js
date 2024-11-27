/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
//rotta per notifiche
const PizZip = require("pizzip");
const Docxtemplater = require("docxtemplater");
var express = require('express');
var router = express.Router();
var conn = require('../db/connection');
var auth = require('../utils/auth');
var path = require('path');
var fs = require('fs');
var PDFLib = require('pdf-lib');
const libre = require('libreoffice-convert');
const base64url = require('base64url');
const PDFWatermark = require('pdf-watermark');
const mail = require("../email/email");

libre.convertAsync = require('util').promisify(libre.convert);

function angularParser(tag) {
    tag = tag
        .replace(/^\.$/, "this")
        .replace(/(’|‘)/g, "'")
        .replace(/(“|”)/g, '"');

    const expr = expressions.compile(tag);
    return {
        get: function (scope, context) {
            let obj = {};
            const scopeList = context.scopeList;
            const num = context.num;
            for (let i = 0, len = num + 1; i < len; i++) {
                obj = assign(obj, scopeList[i]);
            }
            return expr(scope, obj);
        },
    };
}




router.get("/getListaCertificati", auth.authenticateToken, function (req, res) {
    console.log("\n\n-----getListaCertificati-----\n\n");
    const idUtente = req.authData.id_access;
    const idStabilimento = req.authData.id_stabilimento;
    const idAsl = req.authData.id_asl;


    let value = [];
    let where = '';

    var andWhere = ' and ';
    if (req.authData.permission.some(p => p.descr_permission == 'CAN_SEE_ALL_CERTIFICATE_STABS') || req.authData.superuser) {
        where += `${andWhere} (vglc.id_stabilimento = ${idStabilimento})`;
    } else if (req.authData.permission.some(p => p.descr_permission == 'CAN_SEE_OWN_CERTIFICATE') && !req.authData.superuser) {
        where += `${andWhere} (vglc.id_access = ${idUtente} and vglc.id_stabilimento = ${idStabilimento})`;
    } else if (req.authData.permission.some(p => p.descr_permission == 'CAN_SEE_CERTIFICATE_ASL')) {
        where += `${andWhere} (vglc.id_stabilimento in (select id from vw_get_stabilimenti where asl_rif = ${idAsl}) and scc.is_bozza is false)`;
    }
    

    let query = {
        text: `
            select vglc.*, scc.modificabile
            from public.vw_get_lista_certificati vglc
            join types.stati_certificato_compilato scc on scc.id = vglc.id_stato_certificato_compilato
            where 1 = 1 
            ${where}
            order by vglc.id_certificato_compilato desc
        `,
        values: value
    };

    console.log(query);

    conn.clientCE.query(query, (err, result) => {
        if (err) {
            console.log(err.stack);
            res.writeHead(500).end();
        } else {
            //console.log(result.rows);
            res.json(result.rows).end();
        }
    })
})

router.get("/getTipiCertificato", auth.authenticateToken, function (req, res) {
    console.log("\n\n-----getTipiCertificato-----\n\n");
    const query = `select * from public.certificati`;

    console.log(query);
    conn.clientCE.query(query, (err, result) => {
        if (err) {
            console.log(err.stack);
            res.writeHead(500).end();
        } else {
            res.json(result.rows).end();
        }
    })
})


router.get("/getStatiCertificatoProssimo", auth.authenticateToken, function (req, res) {
    console.log("\n\n-----getStatiCertificatoProssimo-----\n\n");

    const idCertificatoCompilato = req.query.idCertificatoCompilato;

    var q = {};
    if (idCertificatoCompilato == null || idCertificatoCompilato == 'null' || idCertificatoCompilato == 'undefined'){
        q = {
            text: `select * from "types".vw_stato_certificato_compilato_prossimo where iniziale_stato_attuale is true`,
            valus: []
        }
    }else{
        q = {
            text: `select * from "types".vw_stato_certificato_compilato_prossimo 
            where id_stato_attuale = (select id_stato_certificato_compilato from public.certificati_compilati cc where id = $1)`,
            values: [idCertificatoCompilato]
        }
    }

    conn.clientCE.query(q, (err, result) => {
        if (err) {
            console.log(err.stack);
            res.writeHead(500).end();
        } else {
            res.json(result.rows).end();
        }
    })
})


router.get("/getCampiByModulo", auth.authenticateToken, async function (req, res) {
    console.log("\n\n-----getCampiByModulo-----\n\n");
    const idModulo = req.query.idModulo
    const idModuliAllegati = req.query.idModuliAllegati.split(',');
    const idStabilimento = req.authData.id_stabilimento;

    var idModuli = [idModulo];
    if (idModuliAllegati != '')
        idModuli = [idModulo].concat(idModuliAllegati)
    try {

        let campi = [];
        for (let i = 0; i < idModuli.length; i++) {
            let idModulo = idModuli[i];
            let refToFind = [];
            do {

                let query = `select mc.*, tc.descr, q.query, q.params as query_params, q.calcolo_a_posteriori, 
                l.descr as anagrafica, mc.id_campo_traduzione, l.rif_tipo_prodotto as dipende_tipo_certificato, mc.label, mc.font_size,
                c.descr as descr_modulo
                from 
                public.modulo_campi mc 
                join types.tipo_campo tc on tc.id = mc.id_tipo_campo 
                left join public.query q on q.id = mc.id_query
                left join anagrafica.lista l on l.id = mc.id_anagrafica_lista 
                join certificati c on c.id_modulo_corrente = mc.id_modulo
                where mc.id_modulo = $1
                and id_modulo_campo_ref is null
                ORDER BY mc.ord`;

                let _values = [idModulo];

                if (refToFind.length) {
                    query = `select mc.*, tc.descr, q.query, q.params as query_params, q.calcolo_a_posteriori, l.descr as anagrafica, mc.id_campo_traduzione, mc.dipende_tipo_certificato
                    from 
                    public.modulo_campi mc 
                    join types.tipo_campo tc on tc.id = mc.id_tipo_campo 
                    left join public.query q on q.id = mc.id_query
                    left join anagrafica.lista l on l.id = mc.id_anagrafica_lista 
                    where mc.id_modulo = $1 and id_modulo_campo_ref = any($2::bigint[])
                    and id_modulo_campo_ref is null
                    ORDER BY mc.ord`;
                    _values = [idModulo, refToFind]
                }



                let result = await conn.clientCE.query({
                    text: query,
                    values: _values
                });

                // PRIMA VOLTA
                // Recupera tutti i campi senza figli
                if (!refToFind.length || !refToFind[0]) {
                    campi.push(result.rows);

                    // Salva gli id per recuperare i figli
                    refToFind = result.rows.map(c => { return c.id });
                }
                // SECONDA VOLTA IN POI
                // Recupera i figli
                else {
                    refToFind = [];

                    const iterate = async (_obj, row) => {
                        console.log("_obj", _obj);
                        await _obj.forEach(async obj => {
                            //       console.log(`key: ${key}, value: ${obj[key]}`)
                            if (obj.children) {
                                iterate(obj.children, row);
                            }

                            // Assegna il figlio al padre
                            if (obj.id == row.id_modulo_campo_ref) {
                                if (!obj.children)
                                    obj.children = [];
                                obj.children.push(row);
                            }
                        })
                    }

                    console.log("rows ", result.rows)
                    await result.rows.forEach(row => {
                        iterate(campi, row);
                        refToFind.push(row.id);
                    })
                }

            } while (refToFind.length)
        }

        for (let campiModuli of campi) {
            let campi = campiModuli;
            for (let i = 0; i < campi.length; i++) {
                if (campi[i].query && !campi[i].calcolo_a_posteriori) {
                    let q = campi[i].query;
                    if (campi[i].query_params) {
                        let params = campi[i].query_params.split(',');
                        for (let j = 0; j < params.length; j++) {
                            let p = params[j].trim();
                            console.log(q, req.authData[p]);
                            q = q.replace('$' + (j + 1), req.authData[p])
                        }

                    }
                    if (q) {
                        let valore = await conn.clientCE.query(q);
                        campi[i].valore = valore.rows[0].valore;
                    }
                }
                if (campi[i].id_anagrafica_lista) {
                    campi[i].autofiller = {
                        lista: null,
                        valori: []
                    };
                    /*
                    select * from anagrafica.vw_liste_valori 
                        where ((id_stabilimento = $1 and not abilitatoimport) or abilitatoimport) 
                        and ((rif_tipo_prodotto and id_node_denominazione_prodotto = $2) or not rif_tipo_prodotto)
                        and id_lista = $3
                    */
                    let valori = await conn.clientCE.query({
                        text: `
                        select * from anagrafica.vw_liste_valori 
                        where ((id_stabilimento = $1 and not abilitatoimport) or abilitatoimport) 
                        and id_lista = $2`,
                        values: [idStabilimento, campi[i].id_anagrafica_lista]
                    });
                    if (valori.rowCount) {
                        campi[i].autofiller.lista = { idLista: valori.rows[0].id_lista, descr: valori.rows[0].descr };
                        for (let j = 0; j < valori.rowCount; j++) {
                            campi[i].autofiller.valori.push({ id: valori.rows[j].id, descr: valori.rows[j].valore, traduzione: valori.rows[j].traduzione, id_tipo_prodotto: valori.rows[j].id_node_denominazione_prodotto });
                        }
                    }
                }
                delete campi[i].query;
                delete campi[i].query_params;
            }
        }

        res.json(campi).end();

    } catch (err) {
        console.log(err.stack);
        res.writeHead(500).end();
    }
})


router.get("/getInfoCertificato", auth.authenticateToken, async function (req, res) {
    console.log("\n\n-----getInfoCertificato-----\n\n");
    try {
        const idCertificatoCompilato = req.query.idCertificatoCompilato;
        const idStabilimento = req.authData.id_stabilimento;
        const superuser = req.authData.superuser

        const query = {
            text: `select * from public.vw_get_certificato_compilato_valori where id_certificato_compilato = $1`,
            values: [idCertificatoCompilato]
        }

        console.log(`
            select *
            from public.vw_get_certificato_compilato_valori
            where id_certificato_compilato = %s
            ORDER BY ID
        `, idCertificatoCompilato);

        var result = await conn.clientCE.query(query)
        console.log("result.rows:", result.rows);

        if(idStabilimento && result?.rows[0]?.id_stabilimento != idStabilimento){
            res.writeHead(401).end();
            return;
        }
        if(idStabilimento && (!superuser && !req.authData.permission.some(p => p.descr_permission == 'CAN_SEE_ALL_CERTIFICATE_STABS')) && result?.rows[0]?.id_access != req.authData.id_access){
            res.writeHead(401).end();
            return;
        }

        /**
         * Bisogna costruire l'oggetto dei campi così come viene costruito
         * quando viene creato un nuovo certificato.
         */

        for (let i = 0; i < result.rows.length; i++) {

            if (result.rows[i].id_anagrafica_lista && idStabilimento) {
                result.rows[i].autofiller = {
                    lista: null,
                    valori: []
                };
                let valori = await conn.clientCE.query(`
                select * from anagrafica.vw_liste_valori 
                where ((id_stabilimento = ${idStabilimento} and not abilitatoimport) or abilitatoimport) 
                and id_lista = ${result.rows[i].id_anagrafica_lista}`);
                result.rows[i].autofiller.lista = { idLista: valori.rows[0]?.id_lista, descr: valori.rows[0]?.descr };
                for (let j = 0; j < valori.rowCount; j++) {
                    result.rows[i].autofiller.valori.push({ id: valori.rows[j].id, descr: valori.rows[j].valore, traduzione: valori.rows[j].traduzione, id_tipo_prodotto: valori.rows[j].id_node_denominazione_prodotto });
                }
            }
        }
        // Aggiunge il campo children per i campi di tipo select
        const optionsResult = result.rows.filter(({ descr }) => descr === 'select');
        optionsResult.forEach(opzione => {
            let childrenOption = result.rows.filter(({ id_modulo_campo_ref, descr }) => (id_modulo_campo_ref === opzione.id && descr === 'option'));
            opzione.children = childrenOption;
        });

        // Aggiunge il campo children per i campi di tipo object
        const objectsResult = result.rows.filter(({ descr }) => descr == 'object');
        objectsResult.forEach(oggetto => {
            let objectChildren = result.rows.filter(({ id_modulo_campo_ref }) => id_modulo_campo_ref === oggetto.id);
            oggetto.children = objectChildren;
        });

        // Costruisce l'oggetto con i campi select e le opzioni
        result.rows.forEach((elem, i) => {
            if (elem.descr == 'option') {
                result.rows.forEach((innerElem) => {
                    if (innerElem.descr == 'select' && innerElem.id == elem.id_modulo_campo_ref) {
                        if (!innerElem.children)
                            innerElem.children = [];
                        console.log("elem:", elem);
                        innerElem.children.push(elem);
                    }
                })
                delete result.rows[i];
            }
        });

        // const fieldsRows = result.rows.filter(elem => {return elem != null});
        //result.rows = result.rows.sort((a, b) => { return a.index - b.index });
        const fieldsRows = result.rows.filter(({ descr }) => descr != 'option');
        console.log("fieldsRows:", fieldsRows);

        const fileQuery = {
            text: `
                select c.*, c2.descr as descr_modulo, m.filename_template as filename_template, s.descr as descr_stato_certificato_compilato,
                t.descr as tipo_denominazione_prodotto,
                stab.ragione_sociale, stab.comune, stab.provincia_stab, stab.indirizzo
                from public.certificati_compilati c
                join public.moduli m on c.id_modulo  = m.id
                join public.certificati c2 on c2.id = m.id_certificato 
                join types.stati_certificato_compilato s on s.id = c.id_stato_certificato_compilato
                left join vw_tree_nodes_up_denominazione_prodotti t on t.id_node = c.id_node_denominazione_prodotto
                left join vw_get_stabilimenti stab on stab.id = c.id_stabilimento
                where c.id = $1
            `,
            values: [idCertificatoCompilato]
        };
        var resFile = await conn.clientCE.query(fileQuery);
        console.log("resFile.rows[0]:", resFile.rows[0]);
        console.log("resFile.rows[0].file:", resFile.rows[0].file);
        const pathFile = path.join('certificatiExportTemplates', 'tmp', req.authData.id + '_' + resFile.rows[0].filename_template.replace('.docx', '.pdf'));
        fs.writeFileSync(path.join('static', pathFile), base64url.toBuffer(resFile.rows[0].file));
        delete resFile.rows[0].file;
        delete resFile.rows[0].codice_sblocco;

        /*const statiQuery = {
            text: `select * from "types".vw_stato_certificato_compilato_prossimo
                where id_stato_attuale = (select id_stato_certificato_compilato from public.certificati_compilati cc where id = $1)`,
            values: [idCertificatoCompilato]
        };
        var resStati = await conn.clientCE.query(statiQuery);*/

        let fieldsArray = [];
        let oldModulo = null;
        currentArray = [];
        for(let field of fieldsRows){
            if(oldModulo && field.descr_modulo != oldModulo){
                fieldsArray.push(currentArray);
                currentArray = [];
            }
            currentArray.push(field);
            oldModulo = field.descr_modulo;
        }
        fieldsArray.push(currentArray);

        const returnData = {
            info: resFile.rows[0],
            fields: fieldsArray,
            //statiSuccessivi: resStati.rows,
            pathname: pathFile
        };

        let descr_permissions = Object.values(req.authData.permission.map((el) => el.descr_permission));
        console.log("descr_permissions:", descr_permissions);

        /** NON PIU NECESSARIO IN QUANTO ORA C'è SILENZIO ASSENSO */
        /*if (resFile.rows[0].presa_in_carico == false && descr_permissions.includes('CAN_ACCEPT_CERTIFICATE')) {
            try {
                mail.sendEmail('COLLAUDO FVG CERTIFICATI EXPORT: Presa in carico certificato', `Il certificato ${idCertificatoCompilato} è preso in carico`, null, null);
                await conn.clientCE.query({
                    text: 'update public.certificati_compilati set presa_in_carico = true where id = $1',
                    values: [idCertificatoCompilato]
                });
            } catch (e) {
                console.log(e);
            }
        }*/

        res.json(returnData).end();
    } catch (err) {
        console.log(err.stack);
        res.writeHead(500).end();
    }

})


router.post("/compilaCertificato", auth.authenticateToken, async function (req, res) {
    console.log("\n\n-----compilaCertificato-----\n\n");
    var idModulo = req.query.idModulo;
    const idModuliAllegati = req.query.idModuliAllegati.split(',');
    var valori = req.body.valori;
    const idStabilimento = req.authData.id_stabilimento;
    const idCertificatoCompilato = req.query.idCertificatoCompilato;
    const calcoloAPosteriori = req.query.calcoloAPosteriori;

    console.log("valori:", valori);

    var idModuloArray = [idModulo]
    if (idModuliAllegati != '')
        idModuloArray = [idModulo].concat(idModuliAllegati);

    resultsArray = [];
    for (id of idModuloArray) {
        let query = {
            text: `
                select filename_template, tm.descr as tipo_modulo
                from public.moduli m
                join types.tipo_modulo tm on tm.id = m.id_tipo_modulo
                where m.id = $1
            `,
            values: [id]
        }

        resultsArray.push(await conn.clientCE.query(query));
    }

    let i = 0;
    try {
        var pdfBytesArray = [];
        var pathFile = '';
        var pathRes = '';
        const PDFDocument = PDFLib.PDFDocument;
        for (result of resultsArray) {

            const staticDir = 'static';
            const imagesDir = 'images';
            var certificatiDir = "certificatiExportTemplates";
            // certificatiDir = "stamp";
            const tmpDir = 'tmp';
            const tipoModulo = result.rows[0].tipo_modulo;
            const filenameTemplate = result.rows[0].filename_template;
            // path per recuperare il file
            const pathCertificati = path.join(staticDir, certificatiDir);
            // path per scrivere il file
            pathRes = path.join(staticDir, certificatiDir, tmpDir, req.authData.id + '_' + filenameTemplate);
            // path residenza del file (senza static)
            pathFile = path.join(certificatiDir, tmpDir, req.authData.id + '_' + filenameTemplate);

            if (tipoModulo.startsWith('statico')) {
                const pdfDoc = await PDFDocument.load(fs.readFileSync(path.join(pathCertificati, filenameTemplate)))
                const form = pdfDoc.getForm();

                for(let v of valori[i]){

                    if (!v.valore && calcoloAPosteriori == 'true') {

                        try {
                            await conn.clientCE.query({
                                text: 'update certificati_compilati set data_accettazione = current_timestamp where id = $1',
                                values: [idCertificatoCompilato]
                            })

                            let isQueryResult = await conn.clientCE.query({
                                text: 'select query, params, numero_certificato from modulo_campi mc join query q on q.id = mc.id_query where mc.id = $1 and calcolo_a_posteriori',
                                values: [v.id]
                            })
                            if (isQueryResult.rowCount) {
                                let idParam = isQueryResult.rows[0].params == 'id_stabilimento' ? idStabilimento : idCertificatoCompilato;
                                let q = isQueryResult.rows[0].query.replace('$1', idParam)
                                await conn.clientCE.query({
                                    text: `prepare prstmt as ${q}`,
                                })
                                let valoreQuery = await conn.clientCE.query({
                                    text: `execute prstmt`,
                                })
                                if (valoreQuery.rowCount) {
                                    v.valore = valoreQuery.rows[0].valore;
                                }
                                if(isQueryResult.rows[0].numero_certificato){
                                    await conn.clientCE.query({
                                        text: `update certificati_compilati set num_certificato = $1 where id = $2`,
                                        values: [v.valore, idCertificatoCompilato]
                                    })
                                }
                            }
                        } catch (error) {
                            console.log(error.stack);
                        }

                    }
                    if(v.tipo_prodotto_descr){
                        v.valore = v.tipo_prodotto_descr + ' ' + v.valore;
                    }
                };

                let fields = form.getFields();
                console.log(fields.length);
                let oldDa = null;
                for(let f of form.getFields()){
                    f.enableReadOnly();
                    f.setMaxLength(undefined)
                    console.log('CAMPO', f.getName(), 'type', f.constructor.name)
                    let v = valori[i].filter((val) => {return val.nome == f.getName()})[0].valore;
                    console.log('CAMPO', f.getName(), 'Valore', v)
                    let fontSize = valori[i].filter((val) => {return val.nome == f.getName()})[0].font_size;

                    if(v?.trim() != '')
                        f.setText(v.trim());
                    else 
                        f.setText('//');
                   try{
                        const da = f.acroField.getDefaultAppearance() ?? '';
                        if(!da && oldDa){
                            console.log('no da', f.getName(), 'setting', oldDa)
                            const newDa = da + '\n' + PDFLib.setFontAndSize('Courier', fontSize).toString(); //setFontAndSize() method came to resuce
                            f.acroField.setDefaultAppearance(oldDa);
                            //f.setFontSize(fontSize);
                        }else{
                            f.setFontSize(fontSize);
                            oldDa = f.acroField.getDefaultAppearance()
                            //f.enableMultiline();
                        }
                    }catch(err){
                        console.log(err);
                    }
                }

                // Serialize the PDFDocument to bytes (a Uint8Array)
                const pdfBytes = await pdfDoc.save();
                //fs.writeFileSync(pathRes, pdfBytes);
                pdfBytesArray.push(pdfBytes);
            } else if (tipoModulo == 'dinamico') {
                const content = fs.readFileSync(path.join(pathCertificati, filenameTemplate));
                const doc = new Docxtemplater(
                    new PizZip(content),
                    {
                        paragraphLoop: true,
                        linebreaks: true,
                        nullGetter() { return ''; },
                    }
                )

                function buildDocxJson(data, idRef) {

                    function getMaxIndexByRef(data, idRef) {
                        let max = -999999;
                        data.forEach(d => {
                            Object.keys(d).forEach(k => {
                                if (d[k].id_modulo_campo_ref == idRef && d[k].index > max)
                                    max = d[k].index;
                            })
                        })
                        return max;
                    }

                    function getCampiByRef(data, idRef) {
                        let campi = [];
                        data.forEach(d => {
                            Object.keys(d).forEach(k => {
                                if (d[k].id_modulo_campo_ref == idRef) {
                                    if (campi.indexOf(k) < 0)
                                        campi.push(k);
                                }
                            })
                        })
                        return campi;
                    }

                    function getObjectByCampiIndex(campi, index) {
                        let ret = {};
                        campi.forEach(c => {
                            data.forEach(d => {
                                Object.keys(d).forEach(k => {
                                    if (k == c && d[k].index == index)
                                        ret[c] = d[k].valore;
                                })
                            })
                        })
                        return ret
                    }

                    let valoriToSend = {};
                    data.forEach((v) => {
                        console.log("v", v);
                        Object.keys(v).forEach(k => {
                            console.log("k", k);
                            if (v[k].type != 'object' && v[k].id_modulo_campo_ref == idRef)
                                valoriToSend[k] = v[k].valore;
                            else if (v[k].type == 'object') {
                                if (valoriToSend[k] == null)
                                    valoriToSend[k] = [];
                                let maxIndex = getMaxIndexByRef(data, v[k].id);
                                let campiOggetto = getCampiByRef(data, v[k].id);
                                for (let i = 0; i <= maxIndex; i++) {
                                    valoriToSend[k].push(getObjectByCampiIndex(campiOggetto, i))
                                }
                            }
                        })
                    })
                    return valoriToSend;
                }

                let valoriNew = buildDocxJson(valori, null);

                console.log("valoriToSend", valoriNew);
                doc.render(valoriNew);

                const buf = doc.getZip().generate({
                    type: "nodebuffer",
                    compression: "DEFLATE",
                });
                let data = await libre.convertAsync(buf, `.pdf`, undefined);
                fs.writeFileSync(pathRes.replace('.docx', '.pdf'), data);
            }

            i++;
        }
        const mergedPdf = await PDFDocument.create();
        for (const pdfBytes of pdfBytesArray) {
            const pdf = await PDFDocument.load(pdfBytes);
            const copiedPages = await mergedPdf.copyPages(pdf, pdf.getPageIndices());
            copiedPages.forEach((page) => {
                mergedPdf.addPage(page);
            });
        }


        const buf = await mergedPdf.save();
        fs.writeFileSync(pathRes, buf);

        // Aggiunge il watermark al pdf
        if(!calcoloAPosteriori || calcoloAPosteriori == 'false'){
            await PDFWatermark({
                pdf_path: path.join(pathRes),
                text: "Anteprima",
                output_dir: path.join(pathRes), // remove to override file
                textOption: {
                    diagonally: true,
                    size: 70,
                    opacity: 0.3
                }
            });
        }

        res.json({ path: pathFile.replace('.docx', '.pdf') }).end();
    } catch (e) {
        console.log(e);
        res.writeHead(500).end();
    }
})

router.post("/salvaCertificato", auth.authenticateToken, async function (req, res) {
    console.log("\n\n-----salvaCertificato-----\n\n");
    let idCertificatoCompilato = req.body.id_certificato_compilato;
    const idModulo = req.body.idModulo;
    const pdfName = req.body.pdfPath;
    const idUtente = req.authData.id_access;
    const idStabilimento = req.authData.id_stabilimento;
    const certificato = req.body.certificato;
    const idDenominazioneProdotto = req.body.id_denominazione_prodotto;

    console.log("\n\nidModulo:", idModulo);
    console.log("pdfName:", pdfName);
    console.log("idUtente:", idUtente);
    console.log("idStabilimento:", idStabilimento);
    console.log("certificato:", certificato);
    console.log("codiceSblocco:", certificato.codiceSblocco);
    console.log("idDenominazioneProdotto:", idDenominazioneProdotto);
    console.log("\n\n");

    //check if sblocco
    if (certificato.codiceSblocco) {
        /*let resultSblocco = await conn.clientCE.query(
            {
                text: 'select codice_sblocco from public.certificati_compilati where id = $1',
                values: [idCertificatoCompilato]
            }
        )
        if (resultSblocco.rows[0].codice_sblocco.toString() != certificato.codiceSblocco.toString()) {
            res.json({ info: false, msg: 'Codice di sblocco errato!' }).end();
            return;
        } else {*/
        //AGGIUNGI WATERMARK

        // Aggiunge il watermark al pdf
        await PDFWatermark({
            pdf_path: path.join('static', pdfName),
            text: "Copia Conforme",
            output_dir: path.join('static', pdfName), // remove to override file
            textOption: {
                diagonally: true,
                size: 70
            }
        });

        
        // Salva il pdf con il watermark su DB
        const _tmpFile = {f: pdfName};
        const pdfBytes = fs.readFileSync(path.join('static', _tmpFile[Object.keys(_tmpFile)[0]]), { encoding: 'base64' });

        console.log(`
                update public.certificati_compilati set file = ${pdfBytes} where id = ${idCertificatoCompilato}
            `);

        const queryUpdateFile = {
            text: `update public.certificati_compilati set file = $1 where id = $2`,
            values: [pdfBytes, idCertificatoCompilato]
        };

        const resUpdateFile = await conn.clientCE.query(queryUpdateFile);
        console.log("resUpdateFile.rows:", resUpdateFile.rows);
        // }

    }

    try {
        await conn.clientCE.query('BEGIN');
        const _tmpFile = {f: pdfName};
        var pdfBytes = fs.readFileSync('static/' + _tmpFile[Object.keys(_tmpFile)[0]], { encoding: 'base64' });

        if (!idCertificatoCompilato) {
            // Query per i certificati
            let queryCertificati = {
                text: `
                    insert into public.certificati_compilati (id_access, id_modulo, id_stabilimento, id_node_denominazione_prodotto)
                    values ($1, $2, $3, $4)
                    returning id
                    `,
                values: [idUtente, idModulo, idStabilimento, idDenominazioneProdotto]
            };

            const resQueryCertificati = await conn.clientCE.query(queryCertificati);
            idCertificatoCompilato = resQueryCertificati.rows[0].id;
        }
        console.log("idCertificatoCompilato:", idCertificatoCompilato);

        if ((await conn.clientCE.query({
            text: `select finale from types.stati_certificato_compilato 
                where id = $1`,
            values: [certificato.id_stato_certificato_compilato]
        }
        )).rows[0].finale) {
            // Query per i certificati
            let queryCertificati = {
                text: `
                    update public.certificati_compilati set
                        id_stato_certificato_compilato = $1,
                        data_proposta = $2,
                        data_controllo = $3,
                        descr = $4,
                        motivo_integrazione = $6,
                        orario_proposto = tsrange($7, $8, '[)'),
                        orario_controllo = tsrange($9, $10, '[)'),
                        id_access_sblocco = $11,
                        motivo_annullamento = $12
                    where id = $5
                    `,
                values: [
                    certificato.id_stato_certificato_compilato, certificato.data_proposta,
                    certificato.data_controllo, certificato.descr,
                    idCertificatoCompilato,
                    certificato.motivo_integrazione, 
                    certificato.orario_proposto_da == '' ? null : certificato.orario_proposto_da, 
                    certificato.orario_proposto_a == '' ? null : certificato.orario_proposto_a, 
                    certificato.orario_controllo_da == '' ? null : certificato.orario_controllo_da, 
                    certificato.orario_controllo_a == '' ? null : certificato.orario_controllo_a,
                    certificato.id_access_sblocco, certificato.motivo_annullamento
                ]
            };
            const resQueryCertificati = await conn.clientCE.query(queryCertificati);
        } else {
            // Query per i certificati
            let queryCertificati = {
                text: `
                    update public.certificati_compilati set
                        file = $1,
                        id_stato_certificato_compilato = $2,
                        data_proposta = $3,
                        data_controllo = $4,
                        descr = $5,
                        motivo_integrazione = $7,
                        orario_proposto = tsrange($8, $9, '[)'),
                        orario_controllo = tsrange($10, $11, '[)'),
                        id_access_sblocco = $12,
                        id_country_generico = $13,
                        data_accettazione = $14
                    where id = $6
                    `,
                values: [
                    pdfBytes, certificato.id_stato_certificato_compilato,
                    certificato.data_proposta, certificato.data_controllo,
                    certificato.descr,
                    idCertificatoCompilato, certificato.motivo_integrazione,
                    certificato.orario_proposto_da == '' ? null : certificato.orario_proposto_da, 
                    certificato.orario_proposto_a == '' ? null : certificato.orario_proposto_a, 
                    certificato.orario_controllo_da == '' ? null : certificato.orario_controllo_da, 
                    certificato.orario_controllo_a == '' ? null : certificato.orario_controllo_a, 
                    certificato.id_access_sblocco,
                    certificato.id_country_generico, certificato.codiceSblocco ? new Date().toISOString().split('T')[0] : null
                ]
            };
            const resQueryCertificati = await conn.clientCE.query(queryCertificati);
        }



        // Elimina i campi per un determinato idCC
        let deleteQuery = {
            text: 'delete from public.campo_valori where id_certificato_compilato = $1',
            values: [idCertificatoCompilato]
        };

        const resDelete = await conn.clientCE.query(deleteQuery);
        console.log("resDelete.rows:", resDelete.rows);

        // Recupera i dati sui campi della form
        var fieldsArray = req.body.fields;
        console.log("fieldsArray:", fieldsArray);

        let moduloIndex = -1;
        const gettingFields = ['id', 'valore', 'id_modulo_campo_ref', 'id_tipo_prodotto', 'riporta_tipo_prodotto', 'valore_statistico'];
        const numValues = gettingFields.length + 1;
        for (fields of fieldsArray) {
            moduloIndex++;
            // Aggiunge un value per ogni elemento in fields
            let stringValues = [];
            let num = 1;
            for (let i = 0; i < fields.length; i++) {

                let appString = `(${idCertificatoCompilato}`;
                while (num <= numValues * (i + 1)) {
                    appString = appString.concat(`, $${num}`);
                    num++;
                }
                appString = appString.concat(')');

                console.log("appString:", appString);
                stringValues.push(appString);

                /*if (fields[i]?.idLista && fields[i]?.valore) {

                    //controllo se la li sta che sto inserendo è di tipo OSA (NON ABILITATA ALL IMPORT) e mi prendo se rif e tipo prodotto
                    let tipoListaResult = await conn.clientCE.query({
                        text: `select * from anagrafica.vw_liste where id = $1 and not abilitatoimport`,
                        values: [fields[i].idLista]
                    });
                    if (tipoListaResult.rowCount) {
                        let rifTipoProdotto = tipoListaResult.rows[0].rif_tipo_prodotto;
                        if (rifTipoProdotto) {
                            await conn.clientCE.query({
                                text: `        
                            insert into anagrafica.lista_valori (id_lista, valore, id_stabilimento, id_node_denominazione_prodotto) 
                            select 
                            $1, $2::varchar, $3, $4
                            where not exists
                            (select id_lista, valore, id_stabilimento, id_node_denominazione_prodotto from anagrafica.lista_valori 
                            where id_stabilimento = $3
                            and id_lista= $1 and upper(valore)::varchar = upper($2)::varchar and id_node_denominazione_prodotto = $4)
                            `,
                                values: [fields[i].idLista, fields[i].valore.trim(), idStabilimento, fields[i].id_tipo_prodotto]
                            });
                        } else {
                            await conn.clientCE.query({
                                text: `        
                            insert into anagrafica.lista_valori (id_lista, valore, id_stabilimento) 
                            select 
                            $1, $2::varchar, $3
                            where not exists
                            (select id_lista, valore, id_stabilimento, id_node_denominazione_prodotto from anagrafica.lista_valori 
                            where id_stabilimento = $3
                            and id_lista= $1 and upper(valore)::varchar = ($2)::varchar and id_node_denominazione_prodotto is null)
                            `,
                                values: [fields[i].idLista, fields[i].valore.trim(), idStabilimento]
                            });
                        }
                    }

                }*/

            }

            console.log("stringValues:", stringValues);

            // Crea il testo della query
            let queryText = `insert into public.campo_valori (id_certificato_compilato, id_campo, valore, id_campo_ref, id_tipo_prodotto, riporta_tipo_prodotto, valore_statistico, index) values `;
            await stringValues.forEach((value, index) => {
                queryText = queryText.concat(value);

                index != stringValues.length - 1 ? queryText = queryText.concat(", ") : queryText = queryText.concat(";");
            })

            console.log("queryText:", queryText);

            // Crea il vettore di elementi da inserire sul DB
            let valuesVect = [];
            for(Obj of fields){
                console.log("Obj:", Obj);
                for(getField of gettingFields){
                    valuesVect = valuesVect.concat(Obj[getField]);
                }
                valuesVect = valuesVect.concat(moduloIndex);
            }


            console.log("valuesVect:", valuesVect);

            // Query per i campi
            let queryFields = {
                text: queryText,
                values: valuesVect
            }

            await conn.clientCE.query(queryFields);
        }

            let result2 = await conn.clientCE.query(
                {
                    text: 'select * from types.stati_certificato_compilato where id = $1',
                    values: [certificato.id_stato_certificato_compilato]
                }
            )

            if (result2.rows[0].ask_data_controllo == true || result2.rows[0].ask_data_controllo == 't') {
                mail.sendEmail('GISA FVG CERTIFICATI EXPORT: Certificato calendarizzato', `Il certificato ${idCertificatoCompilato} è calendarizzato`, null, null);
            }
            if (result2.rows[0].ask_data_proposta == true || result2.rows[0].ask_data_proposta == 't') {
                let result3 = await conn.clientCE.query(
                    {
                        text: 'select * from ui.vw_email_info where id_certificato_compilato = $1',
                        values: [idCertificatoCompilato]
                    }
                )
                let v = result3.rows[0];
                let allegato = {
                    filename: 'certificato.pdf',
                    content: base64url.toBuffer(v.file)
                }

                mail.sendEmail('GISA FVG - CERTIFICATI EXPORT: Richiesta nuovo certificato', `
                Nuova richiesta certificato <br>
                Stabilimento ${v.ragione_sociale}, ${v.indirizzo}, ${v.comune}, ${v.provincia_stab} <br>
                Data e fascia oraria proposta ${v.orario_proposto}, <br>
                Prodotti: ${v.prodotti}, <br>
                Tracciabilità / Paese di esportazione: ${v.paese} 
                `, v.email, allegato);


                if(certificato.flags?.insEvento){
                    let result = await conn.clientCE.query({
                        text: `select * from srv_functions.ins_evento_agenda($1)`,
                        values: [{
                            inizio: certificato.orario_proposto_da, 
                            fine: certificato.orario_proposto_a, 
                            id_stabilimento: idStabilimento
                        }]
                    })
                    console.log(result);

                    let idEvento = result.rows[0].info;

                    await conn.clientCE.query({
                        text: `update certificati_compilati set id_evento_calendario = $1 where id = $2`,
                        values: [idEvento, idCertificatoCompilato]
                    });
                }else if(certificato.flags?.ricalendarizza){

                    let idEvento = (await conn.clientCE.query({
                        text: `select id_evento_calendario from certificati_compilati where id = $1`,
                        values: [idCertificatoCompilato]
                    })).rows[0].id_evento_calendario;

                    let result = await conn.clientCE.query({
                        text: `select * from srv_functions.upd_evento_agenda($1)`,
                        values: [{
                            inizio: certificato.orario_controllo_da, 
                            fine: certificato.orario_controllo_a, 
                            id: idEvento 
                        }]
                    })
                }
            }
            if(certificato.flags?.eliminaAttivita){

                await conn.clientCE.query({
                    text: `select * from srv_functions.close_evento_agenda($1, $2)`,
                    values: [
                        idCertificatoCompilato, 
                        false 
                    ]
                })
            }
        
        res.json({ info: true }).end();
        await conn.clientCE.query('COMMIT');
    }catch (err) {
        await conn.clientCE.query('ROLLBACK');
        console.log(err.stack);
        res.writeHead(500);
        res.json({ info: false }).end();
    }    

})

router.get("/chiudiAttivita", auth.authenticateToken, async function (req, res) {

    try {
        const idCertificatoCompilato = req.query.idCertificatoCompilato;
        
        let result = await conn.clientCE.query({
            text: `select * from srv_functions.close_evento_agenda($1)`,
            values: [
                idCertificatoCompilato
            ]
        })

        let idAttivita = JSON.parse(result.rows[0].info)?.id_trf_attivita;
        if(!idAttivita){
            let result = await conn.clientCE.query({
                text: `select id_trf_attivita from certificati_compilati where id = $1`,
                values: [
                    idCertificatoCompilato
                ]
            })
            idAttivita = result.rows[0].id_trf_attivita;
        }

        if(idAttivita)
            await conn.clientCE.query({
                text: `update certificati_compilati set id_trf_attivita = $1 where id = $2`,
                values: [idAttivita, idCertificatoCompilato]
            });

        let vociResult = await conn.clientCE.query({
            text: `select * from vw_get_voci_tariffa where id_attivita = $1`,
            values: [idAttivita]
        })

        res.json({esito: true, id_attivita: idAttivita, voci: vociResult.rows}).end();
    }catch(err){
        console.log(err);
        res.json({esito: false}).end();
    }
});


router.post("/inviaDatiTariffazione", auth.authenticateToken, async function (req, res) {

    try{
        const dati = req.body;
        console.log(dati);

        let result = await conn.clientCE.query({
            text: `select * from srv_functions.close_attivita_tariffazione($1)`,
            values: [
                dati
            ]
        })

        res.json({esito: result.rows[0].esito}).end();
    }catch(err){
        console.log(err);
        res.json({esito: false}).end();
    }

});

router.post("/rilasciaCertificato", auth.authenticateToken, async function (req, res) {

    try{
        console.log("\n\n-----rilasciaCertificato-----\n\n");
        const certificato = JSON.parse(req.body.certificato);
        const file = req.files.file;

        console.log("certificato:", certificato);
        console.log("file:", file);

        let fileObj = {};
        fileObj['name'] = file.name;
        fileObj['data'] = file.data;

        // Scrive il file caricato nella cartella temporanea
        fs.writeFileSync(path.join('static', 'certificatiExportTemplates', 'tmp', file.name), file.data);

        // Aggiunge il watermark al pdf
        await PDFWatermark({
            pdf_path: path.join('static', 'certificatiExportTemplates', 'tmp', file.name),
            text: "Copia Conforme",
            output_dir: path.join('static', 'certificatiExportTemplates', 'tmp', file.name), // remove to override file
            textOption: {
                diagonally: true,
                size: 70
            }
        });

        // Salva il pdf con il watermark su DB
        const pdfBytes = fs.readFileSync(path.join('static', 'certificatiExportTemplates', 'tmp', file.name), { encoding: 'base64' });

        console.log(`
            update public.certificati_compilati set file = ${pdfBytes} where id = ${certificato.idCertificato}
        `);

        const queryUpdateFile = {
            text: `update public.certificati_compilati set file = $1 where id = $2`,
            values: [pdfBytes, certificato.idCertificato]
        };

        const resUpdateFile = await conn.clientCE.query(queryUpdateFile);
        console.log("resUpdateFile.rows:", resUpdateFile.rows);

        res.json({ info: true }).end();
    }catch(err){
        res.writeHead(500).end();
    }
})

/**************************** REGISTRAZIONE UTENTE ****************************/
router.post('/get_vw_stabilimenti', async function (req, res) {

    const args = req.body;

    let check = (await conn.clientCE.query({
        text: `select $1 = md5($2) as check`,
        values: [args.crypt, 'GISA-'+args.fiscalCode]
    }))?.rows?.[0]?.check;

    if(!check){
        res.sendStatus(401).end();
        return;
    }

    const query = { text: 'select id, id as id_stabilimento, indirizzo, provincia_stab, comune, ragione_sociale from public.vw_get_stabilimenti vgs' };

    conn.clientCE.query(query, (err, result) => {
        if (err) {
            console.log(err.stack);
            res.writeHead(500).end();
        } else {
            console.log("result.rows:", result.rows);
            res.json(result.rows).end();
        }
    })
})

router.post("/insRegistrazione", async function (req, res) {
    const funzione = 'ins_access_stabilimento';
    const args = req.body.args;

    console.log("funzione:", funzione);
    console.log("args:", args);

    let check = (await conn.clientCE.query({
        text: `select $1 = md5($2) as check`,
        values: [JSON.parse(args).check, 'GISA-'+JSON.parse(args).codice_fiscale]
    }))?.rows?.[0]?.check;

    if(!check){
        res.json({esito: false}).end();
        return;
    }

    const showQuery = `call srv.upd_dati('${funzione}','${args.replace(/'/g, "''")}', null,'{}')`;
    console.log(`\n\n\t\t\tQUERY\n${showQuery}\n\n`);

    const query = {
        text: 'call srv.upd_dati($1, $2, $3, $4)',
        values: [funzione, args, 0, '{}']
    };
    console.log(query);
    conn.clientCE.query(query, (err, result) => {
        if (err) {
            console.log(err.stack);
            res.writeHead(500).end();
        } else {
            console.log("result.rows:", result.rows);
            res.json(result.rows[0].joutput).end();
        }
    });
});
/******************************************************************************/

/****************************** STANDARD METHODS ******************************/
router.get("/getDati", auth.authenticateToken, function (req, res) {
    console.log("req.authData:", req.authData);
    const idUtente = req.authData.id;
    const funzione = req.query.function;
    var args = req.query.args;

    console.log("idUtente:", idUtente);
    console.log("funzione:", funzione);
    console.log("args:", args);

    if (!args)
        args = '{}';

    const showQuery = `call srv.get_dati('${funzione}','${args.replace(/'/g, "''")}', ${idUtente},'{}')`;
    console.log(`\n\n\t\t\tQUERY\n${showQuery}\n\n`);

    const query = {
        text: 'call srv.get_dati($1, $2, $3, $4)',
        values: [funzione, args, idUtente, '{}']
    };
    console.log(query);
    conn.clientCE.query(query, (err, result) => {
        if (err) {
            console.log(err.stack);
            res.writeHead(500).end();
        } else {
            console.log("result.rows:", result.rows);
            res.json(result.rows[0].joutput).end();
        }
    })
});

router.post("/updDati", auth.authenticateToken, function (req, res) {
    const idUtente = req.authData.id;
    const funzione = req.body.function;
    const args = req.body.args;

    console.log("idUtente:", idUtente);
    console.log("funzione:", funzione);
    console.log("args:", args);

    const showQuery = `call srv.upd_dati('${funzione}','${args.replace(/'/g, "''")}', ${idUtente},'{}')`;
    console.log(`\n\n\t\t\tQUERY\n${showQuery}\n\n`);

    const query = {
        text: 'call srv.upd_dati($1, $2, $3, $4)',
        values: [funzione, args, idUtente, '{}']
    };
    console.log(query);
    conn.clientCE.query(query, (err, result) => {
        if (err) {
            console.log(err.stack);
            res.writeHead(500).end();
        } else {
            console.log("result.rows:", result.rows);
            res.json(result.rows[0].joutput).end();
        }
    });
});

router.get("/sendEmailUtenteValidato", auth.authenticateToken, function (req, res) {
    console.log("req.query:", req.query);
    const email_da_validare = JSON.parse(req.query.emailDaValidare);

    for (let i = 0; i < email_da_validare.length; i++) {
        console.log("email_da_validare[i]:", email_da_validare[i]);
        mail.sendEmail('COLLAUDO FVG CERTIFICATI EXPORT: Validazione Utente', 'Il suo account è stato validato correttamente.', email_da_validare[i], null);
    }

    res.json({ info: true, esito: true }).end();
})

router.get("/sendEmailUrgenza", auth.authenticateToken, async function (req, res) {
    const idCertificato = req.query.idCertificato

    let result3 = await conn.clientCE.query(
        {
            text: 'select * from ui.vw_email_info where id_certificato_compilato = $1',
            values: [idCertificato]
        }
    )
    let v = result3.rows[0];
    let allegato = {
        filename: 'certificato.pdf',
        content: base64url.toBuffer(v.file)
    }

    mail.sendEmail('GISA FVG CERTIFICATI EXPORT: Urgenza certificato!', `
    La richiesta di certificato è urgente! <br>
    Stabilimento ${v.ragione_sociale}, ${v.indirizzo}, ${v.comune}, ${v.provincia_stab} <br>
    Data e fascia oraria proposta ${v.orario_proposto}, <br>
    Prodotti: ${v.prodotti}, <br>
    Tracciabilità / Paese di esportazione: ${v.paese} 
    `, v.email, allegato);


    res.json({ info: true }).end();
})

router.post("/sendEmailRegistrazione", async function (req, res) {
    const data = JSON.parse(req.body.args);

    let check = (await conn.clientCE.query({
        text: `select $1 = md5($2) as check`,
        values: [data.check, 'GISA-'+data.codice_fiscale]
    }))?.rows?.[0]?.check;

    if(!check){
        res.json({esito: false}).end();
        return;
    }

    let result3 = await conn.clientCE.query(
        {
            text: `select * from public.vw_get_stabilimenti s
            join um.get_user u on u.codice_fiscale = s.sd_vet_cf 
            where s.id = $1`,
            values: [data.id_stabilimento]
        }
    )
    let v = result3.rows[0];

    mail.sendEmail('GISA FVG CERTIFICATI EXPORT: Richiesta registrazione!', `
    Richiesta di registrazione inoltrata! <br>
    Stabilimento ${data.ragione_sociale} <br>
    Dati responsabile richiedente ${data.cognome} ${data.nome}, ${data.codice_fiscale} <br>
    `, [data.email, v.email].join('; '));


    res.json({ info: true }).end();
})


router.get("/sendEmailEliminazione", auth.authenticateToken, async function (req, res) {
    const idCertificato = req.query.idCertificato

    let result3 = await conn.clientCE.query(
        {
            text: 'select * from ui.vw_email_info where id_certificato_compilato = $1',
            values: [idCertificato]
        }
    )
    let v = result3.rows[0];
    let allegato = {
        filename: 'certificato.pdf',
        content: base64url.toBuffer(v.file)
    }

    mail.sendEmail('GISA FVG CERTIFICATI EXPORT: Eliminazione richiesta certificato!', `
    La richiesta di certificato è stata eliminata! <br>
    Stabilimento ${v.ragione_sociale}, ${v.indirizzo}, ${v.comune}, ${v.provincia_stab} <br>
    Data e fascia oraria proposta ${v.orario_proposto}, <br>
    Prodotti: ${v.prodotti}, <br>
    Tracciabilità / Paese di esportazione: ${v.paese} 
    `, v.email, allegato);


    res.json({ info: true }).end();
})


router.post("/caricaPdfDaConfigurare", auth.authenticateToken, async function (req, res) {

    try {
        console.log("\n\n-----caricaPdfDaConfigurare-----\n\n");
        const file = req.files.file;

        const PDFDocument = PDFLib.PDFDocument;
        const pdfDoc = await PDFDocument.load(file.data);
        const form = pdfDoc.getForm();

        fs.writeFileSync(path.join('static', 'certificatiExportTemplates', 'tmp', file.name + '_config'), file.data);

        let fields = form.getFields()
        ret = [];
        fields.forEach((f) => {
            //console.log(f.getName(), f.isRequired());
            ret.push({ nome_campo: f.getName(), obbligatorio: f.isRequired() });
        })

        ret = Array.from(new Set(ret.map(a => JSON.stringify(a))))
        .map(b => JSON.parse(b));
        console.log(ret);
        res.json(ret).end();
    } catch (err) {
        console.log(err);
        res.writeHead(500);
        res.json({ esito: false }).end();   
    }
})

router.post("/memorizzaPdfConfigurato", auth.authenticateToken, async function (req, res) {

    const filename = req.body.filename;
    try {
        console.log("\n\n-----memorizzaPdfConfigurato-----\n\n");

        const _tmpFile = {f: filename};
        fs.renameSync(
            path.join('static', 'certificatiExportTemplates', 'tmp', _tmpFile[Object.keys(_tmpFile)[0]] + '_config'),
            path.join('static', 'certificatiExportTemplates', _tmpFile[Object.keys(_tmpFile)[0]])
        );

        res.json({ esito: true }).end();
    } catch (err) {
        console.log(err);
        res.json({ esito: false }).end();
    }

})





module.exports = router;
