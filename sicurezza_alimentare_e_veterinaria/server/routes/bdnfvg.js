/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
//rotta per notifiche
var express = require('express');
var router = express.Router();
var conn = require('../db/connection');
const mapUtilts = require("../utils/mapUtils");
var utils = require("../utils/utils");
var auth = require('../utils/auth');
var path = require('path');
var JsBarcode = require('jsbarcode');
// var { createCanvas } = require("canvas");
var fs = require('fs');
var soap = require('soap');
const pdfkit = require('pdfkit');
const pdfkitTable = require('pdfkit-table');
const conf = require('../config/config');
const funzioni = require('../bdn_dwl/funzioni');
const bwipjs = require('bwip-js');

router.get("/getDati", auth.authenticateToken, function (req, res) {
  // const idUtente = req.authData.idUtente;
  const idUtente = req.authData.id_utente_struttura_ruolo;
  const funzione = req.query.function;
  const args = req.query.args;

  console.log("idUtente:", idUtente);
  console.log("funzione:", funzione);
  console.log("args:", args);

  const showQuery = `call bdn_srv.get_dati('${funzione}','${args.replace(/'/g, "''")}', ${idUtente},'{}')`;
  console.log(`\n\n\t\t\tQUERY\n${showQuery}\n\n`);

  const query = {
    text: 'call bdn_srv.get_dati($1, $2, $3, $4)',
    values: [funzione, args, idUtente, '{}']
  }
  console.log(query);
  conn.clientBDN.query(query, (err, result) => {
    if (err) {
      console.log(err.stack);
      res.writeHead(500).end();
    } else {
      res.json(result.rows[0].joutput).end();
    }
  })
})

router.post("/updDati", auth.authenticateToken, function (req, res) {
  // const idUtente = req.authData.idUtente;
  const idUtente = req.authData.id_utente_struttura_ruolo;
  const funzione = req.body.function;
  const args = req.body.args;

  console.log("idUtente:", idUtente);
  console.log("funzione:", funzione);
  console.log("args:", args);

  // Execute query
  const showQuery = `call bdn.upd_dati('${funzione}', '${args.replace(/'/g, "''")}', '${idUtente}', '{}')`;
  console.log(`\n\n\t\t\tQUERY\n${showQuery}\n\n`);

  const query = {
    text: 'call bdn.upd_dati($1, $2, $3, $4)',
    values: [funzione, args, idUtente, '{}']
  }
  console.log(query);
  conn.clientBDN.query(query, (err, result) => {
    if (err) {
      console.log(err.stack);
      res.writeHead(500).end();
    } else {
      res.json(result.rows[0].joutput).end();
    }
  })
})

router.get("/soapRequest", function (req, res) {
  console.log("req.query:", req.query);
  if (req.query['WS_BDN_METHOD']?.startsWith('getMovimentazioniCapo')) {
    funzioni.getMovimentazioniCapo(req.query.p_capo_codice, req.query['WS_BDN_METHOD'], res);
  } else
    funzioni.jobAllienaCapiWS(req.query.p_allev_id, res);
  //            res.json(risultati).end();
  return;
})

router.post("/insertInfoSanitarie", function (req, res) {
  console.log("req.body:", req.body);
  funzioni.insertInfoSanitarie(req.body, res);
})

router.get("/invioSanan", function (req, res) {
  console.log("req.body:", req.body);
  funzioni.invioSanan(res, req.query.id_intervento);
})

// Stampa PDF resoconto giornaliero
router.post('/PDF_Giornaliero', function (req, res) {
  console.log("\n\nreq.body:", req.body);

  const tablejson = req.body.tablejson;
  console.log("\n\ntablejson:", tablejson);

  const previous_data = req.body.previous_data;
  console.log("\n\nprevious_data:", previous_data);

  const filename = previous_data.filename;
  const title = previous_data.title;
  const other_text = previous_data.other_text;

  console.log("\nfilename:", filename);
  console.log("\ntitle:", title);
  console.log("\nother_text:", other_text);

  try {
    const pathname = path.join('static', 'pdfFiles', filename);
    const doc = new PDFDocument({ margin: 50 });
    const _tmpFile = { f: pathname };
    doc.pipe(fs.createWriteStream(_tmpFile[Object.keys(_tmpFile)[0]]));
    doc.pipe(res);

    // Title
    doc.fontSize(title.dim).text(title.text);
    doc.moveDown(0.5);

    // Other text
    if (other_text.length > 0) {
      for (let i = 0; i < other_text.length; i++) {
        doc.fontSize(other_text[i].dim).text(other_text[i].text);
        doc.moveDown(0.5);
      }
    }

    // Table
    doc.table(tablejson);
    doc.end();
  } catch (error) {
    console.log(error.stack());
    res.status(500).send(error).end();
  }
});

// Genera PDF
router.post('/generatePDF', function (req, res) {
  console.log("req.body:", req.body);
  const selectedCapi = req.body.selectedCapi;

  try {
    const filename = 'Barcodes.pdf';
    const pathname = path.join('static/pdfFiles', filename);
    let images = [];
    let buffer;
    // let canvas = createCanvas();

    // Genera le immagini dei codici a barre per ogni capo
    selectedCapi?.forEach(marchio => {
      JsBarcode(canvas, marchio);
      images.push(marchio);
      buffer = canvas.toBuffer('image/png');
      fs.writeFileSync(path.join('static/images', marchio + '.png'), buffer);
    });

    // Genera il PDF
    const doc = new PDFDocument();
    doc.pipe(fs.createWriteStream(pathname));
    doc.pipe(res);

    let yString = doc.page.margins.top;
    let yImage = doc.page.margins.top + 10;

    let xString = doc.page.margins.left + 5;
    let xImage = doc.page.margins.left;

    // Aggiunge i codici a barre al PDF
    selectedCapi?.forEach((marchio) => {
      doc.image(path.join('static/images', marchio + '.png'), xImage, yImage, { scale: 0.5 }).text(marchio, xString, yString);
      yString += 100;
      yImage += 100;
      if (doc.currentLineHeight(true) + yImage > doc.page.maxY()) {
        doc.addPage();
        yString = doc.page.margins.top;
        yImage = doc.page.margins.top + 10;
        xString = doc.page.margins.left + 5;
        xImage = doc.page.margins.left;
      }
    });

    doc.end();
  } catch (error) {
    console.log("Error from catch: " + error);
    res.status(500).send(error).end();
  }
});

// Genera il PDF di riepilogo prima di inviare i dati all'IZVSE
router.post('/riepilogoPDF', auth.authenticateToken, async function (req, res) {
  const idUtente = 42619;
  console.log("req.body:", req.body);
  const id_intervento = req.body.id_intervento;
  //const filename = req.body.filename;
  const filename = `scheda_accompagnamento_campioni_${id_intervento}.pdf`;
  const vetIntervento = req.body.vet_intervento;
  const vetRaccolte = req.body.vet_raccolte;
  const note = req.body.note;


  console.log("\nvetIntervento:", vetIntervento);
  console.log("\nvetRaccolte:", vetRaccolte);
  console.log("\nnote:", note);


  const showQuery = `call bdn_srv.get_dati('get_info_pdf','{"id_intervento":${id_intervento}}', ${idUtente},'{}');`;
  console.log(`\n\nQUERY:\n\n${showQuery}\n`);

  const query = {
    text: `call bdn_srv.get_dati('get_info_pdf', $1, $2,'{}');`,
    values: [{ id_intervento: parseInt(id_intervento) }, idUtente]
  };
  console.log("Query:", query);

  console.time('Execution Time');
  try {
    //Reso sicrono per fare in modo tale che riesca a fare la insert dei dati del file nel DB
    var result = await conn.clientBDN.query(query);
    console.timeEnd('Execution Time');
    console.log(result.rows[0].joutput);

    const info = JSON.parse(result.rows[0].joutput.info);
    // console.log("info:", info);

    let info_intervento = info.info_intervento;
    console.log("info_intervento:", info_intervento);

    if (info_intervento[0].id_preacc === null) {
      // throw new Error('Codice Accettazione non pervenuto');
      console.log("Codice Accettazione non pervenuto");
    }

    var info_capi = info.info_capi;
    console.log("info_capi:", info_capi);

    // Distinct lato angular
    let allevamenti = [] // [...new Set((info_capi).map((item) => { return { allevamento_name: item.name_allevamento, identificativo_fiscale: item.identificativo_fiscale, specie: item.specie, id_allevamento: item.id_allevamento } }))]
    let allevIds = [];
    for (let item of info_capi) {
      if (allevIds.indexOf(item.id_allevamento) < 0) {
        allevIds.push(item.id_allevamento);
        allevamenti.push({
          allevamento_name: item.name_allevamento, identificativo_fiscale: item.identificativo_fiscale,
          specie: item.specie, id_allevamento: item.id_allevamento
        })
      }
    }

    const marchi = info_capi?.map(ic => ic.marchio);
    let filenames = await generateBarcodes(marchi);
    console.log("\nfilenames:", filenames);

    let regione = info_intervento[0].regione;
    let izs = info_intervento[0].izs;
    let asl = info_intervento[0].asl;
    const asl_descr_breve = info_intervento[0].asl_descr_breve;
    let cod_azienda = info_intervento[0].cod_azienda;
    let indirizzo_azienda = info_intervento[0].indirizzo_azienda;
    // let specie = info_intervento[0].specie;
    // let allevamento_name = info_intervento[0].allevamento;
    let comune = info_intervento[0].comune;
    // let identificativo_fiscale = info_intervento[0].identificativo_fiscale;
    let data_intervento = info_intervento[0].dt;

    // Recupera l'immagine dell'ASL
    const imgPathname = path.join('static', 'images', asl_descr_breve.replace(' ', '_').trim() + '.jpg');
    console.log("\nimgPathname:", imgPathname);

    let options = { day: '2-digit', month: '2-digit', year: 'numeric' };

    // Crea il PDF
    const _margin = 50;
    const _tmpFile = { f: filename };
    const pathname = path.join('static', 'pdfFiles', _tmpFile[Object.keys(_tmpFile)[0]]);
    console.log("\npathname:", pathname);
    const doc = new pdfkitTable({ size: 'A4', margin: 50 });
    var ws = fs.createWriteStream(pathname);
    doc.pipe(ws);
    //doc.pipe(res);

    // Logo ASL
    doc.image(imgPathname, 430, 15, { fit: [100, 100], align: 'right', valign: 'top' })

    // Rettangolo informazioni principali
    doc.moveDown(1);
    doc.font('Courier').text('Regione: ' + regione, { align: 'left' });

    doc.moveDown(0.5);
    doc.text('ASL: ' + asl, { align: 'left' });

    doc.moveDown(0.5);
    doc.text('Indirizzo: Via Fogliatti, 34', { align: 'left' });

    // Title
    doc.fontSize(16);
    doc.moveDown(1);
    doc.font('Courier-Bold').text('SCHEDA ACCOMPAGNAMENTO CAMPIONI', { align: 'center' });

    // Altr info
    doc.fontSize(10);
    doc.moveDown(0.5);
    doc.text('IZS: ' + izs, {
      align: 'center',
      bold: true
    });

    doc.moveDown(0.5);
    doc.text('Codice Accettazione: ' + info_intervento[0].id_preacc, {
      align: 'left',
      bold: true
    });

    doc.moveDown(0.5);
    doc.moveTo(50, doc.y).lineTo(doc.page.width - _margin, doc.y)
      .dash(5, { space: 10 }).stroke();

    doc.moveDown(0.5);
    doc.text('Azienda: ' + cod_azienda, {
      align: 'left',
      bold: true
    });

    doc.moveDown(0.5);
    doc.font('Courier').text('Indirizzo: ' + indirizzo_azienda, { align: 'left' });

    doc.moveDown(0.5);
    doc.text('Comune: ' + comune, { align: 'left' });

    /*
    doc.moveDown(1);
    doc.font('Courier-Bold').text('Piano 2023 - REGIONE FVG - PIANO PROFILASSI BOVINA', {
      align: 'left',
      bold: true
    });
 
    doc.moveDown(0.5);
    doc.text('Motivo Controllo Attività programmata', {
      align: 'left',
      bold: true
    });
    */



    let pianiHeader = [];
    let idPianiHeader = [];
    //Per ogni allevamento mi vado ad estrapolare i capi e i pool per ogni singolo allevamento
    for (let all of allevamenti) {
      //Qui vado ad estrapolare i capi per ogni allevamento

      doc.moveDown(1);
      doc.font('Courier-Bold').text(all.specie + ': ' + all.allevamento_name, {
        align: 'left',
        bold: true
      });

      doc.moveDown(0.5);
      doc.text('Identificativo Fiscale: ' + all.identificativo_fiscale, {
        align: 'left',
        bold: true
      });

      let prov = info.info_prov.filter((p) => p.id_allevamento == all.id_allevamento);
      for (let p of prov) {
        doc.moveDown(0.5);
        doc.font('Courier').text(`Provette di ${p.descr} per malattia ${p.malattia}: ${p.count}`, {
          align: 'left',
        });

        if (idPianiHeader.indexOf(p.id_piano) < 0) {
          pianiHeader.push(p.codice_malattia)
          idPianiHeader.push(p.id_piano)
        }

      }

    }



    // Info relativi alla data e risultati
    doc.moveDown(2);
    doc.text(`Data Sopralluogo: ${new Date(data_intervento).toLocaleString('it-IT', options)}`, { align: 'left' });


    doc.moveDown(2)
    doc.text('Veterinari:', { align: 'left' });
    for (const vi of vetIntervento) {
      doc.moveDown(0.5);
      doc.text(vi, { align: 'left' });
    }

    doc.moveDown(0.7);
    doc.text('Totale Provette:', { align: 'left' });
    doc.moveDown(0.7);
    doc.text(info_capi.length, { align: 'left' });

    doc.moveDown(1);
    doc.text(`Note da comunicare all'Istituto:`, { align: 'left' });

    doc.moveDown(1)
    doc.text(note, { align: 'left' });
    for (let i = 0; i < 3; i++) {
      doc.moveTo(50, doc.y).lineTo(doc.page.width - _margin, doc.y).dash([]).stroke();
      doc.moveDown(2);
    }

    doc.addPage();
    doc.font('Courier-Bold').text('Azienda: ' + cod_azienda, { align: 'left' });

    doc.moveDown(0.5);

    let headers = [
      { label: 'Prov.', property: 'prov', width: 30, align: 'center', valign: 'center' },
      { label: 'Codice a barre', property: 'codice', width: 160, align: 'center', valign: 'center' },
      { label: 'Id. fiscale', property: 'identificativo_fiscale', width: 80, align: 'center', valign: 'center' },
      { label: 'Nascita', property: 'nascita', width: 70, align: 'center', valign: 'center' },
      { label: 'Sesso', property: 'sesso', width: 30, align: 'center', valign: 'center' },
    ];

    headers = headers.concat(pianiHeader?.map(p => {
      return {
        label: p,
        property: p?.toLowerCase(),
        width: 30,
        align: 'center',
        valign: 'center'
      }
    }));
    console.log("headers:", headers);

    let rows = [];
    //info_capi?.forEach(ic => {
    for (let ic of info_capi) {
      app = [];
      app.push(ic.n_sample ?? "");
      app.push("");
      app.push(ic.identificativo_fiscale.trim() ?? "");
      app.push(ic.dt_nascita ? new Date(ic.dt_nascita).toLocaleString('it-IT', options) : "");
      app.push(ic.sesso ?? "");
      for (const p of idPianiHeader) {
        ic.id_piani.includes(p) ? app.push('X') : app.push('');
      }
      rows.push(app);
    }
    //});

    const tab = {
      headers: headers,
      rows: rows,
    };

    doc.table(tab, {
      width: doc.page.width - _margin * 2,
      minRowHeight: 30,
      prepareRow: (row, indexColumn, indexRow, rectRow, rectCell) => {
        doc.font("Courier").fontSize(7);
        if (indexColumn === 1) {
          doc.image(path.join('static', 'tmp', info_capi[indexRow]?.marchio + '.png'), rectCell.x, rectCell.y + 5, { fit: [150, 30], align: 'center' });
        }
      }
    });

    console.log("tab:", tab);

    doc.end();

    //Per sincronizzare la fine della scrittura del file e iniziare poi la lettura e poi la scrittura sul DB
    const { finished } = require('node:stream/promises');
    //Aspetta che finice la scrittura del file
    await finished(ws);
    // ws.on('finish', () => {
    const content = fs.readFileSync(path.resolve(pathname), { encoding: 'base64' });

    // console.log("path del file: ",pathname);
    // console.log("contenuto file: ", content);

    const insertQuery = {
      text: `insert into bdn_pa.pdf_accettazione(id_intervento,file) values ($1,$2)`,
      values: [parseInt(id_intervento), content]
    };
    console.log("Query inserimento:", insertQuery);
    await conn.clientBDN.query(insertQuery);

    //Risposta del servizio
    res.end();
    // });
  } catch (error) {
    // console.log("Error from catch:", error);
    console.error('PDF non generato', error);
    res.status(500).send({ error: error.toString() }).end();
  }
})

// Scarica il PDF generato in precedenza
router.post('/getPDF', auth.authenticateToken, async function (req, res) {
  const filename = req.body.filename;
  try {
    const pathname = path.join('static/pdfFiles', filename);
    console.log("\nPathname:", pathname);
    downloadPDF(res, filename, pathname);
  } catch (error) {
    console.log("Error from catch: " + error);
    res.status(500).send(error).end();
  }
})

router.post('/getPDFFromDB', async function (req, res) {
  //const filename = req.body.filename;
  const id_intervento = req.body.id_intervento;
  const filename = `scheda_accompagnamento_campioni_${id_intervento}.pdf`;
  try {
    const pathname = path.join('static', 'pdfFiles');
    console.log("\nPathname:", pathname);
    downloadPDFFromDB(res, filename, pathname, id_intervento);
  } catch (error) {
    console.log("Error from catch: " + error);
    res.status(500).send(error).end();
  }
})

// Importa le movimentazioni
router.post('/importaMovimentazioni', function (req, res) {
  let fileString = req.body.fileString;

  try {
    console.log("fileString:", fileString);
    // Effettua il parser del file
    const query = {
      text: `
        select *
        from bdn_mov.operazioni o
        order by o.id`,
      values: []
    };

    let movimentazioni = [];

    conn.clientBDN.query(query, (err, result) => {
      if (err) {
        console.log(err.stack);
        res.writeHead(500).end();
      } else {
        const operazioni = result.rows;
        // console.log("operazioni:", operazioni);

        // Distingui le operazioni con codice null e quelle con codice
        const op_mov = operazioni?.filter(o => o.codice === null);
        const op_mov_val = operazioni?.filter(o => o.codice !== null);
        // console.log("op_mov:", op_mov);
        // console.log("op_mov_val:", op_mov_val);

        const lines = fileString.split(/\r?\n/);
        // console.log("lines:", lines);

        lines?.forEach(l => {
          movimentazioni = [];
          let mov_dett = {
            datarange_movimentazione: null,
            datarange_id: null,
            cod_azienda: null,
            cf_piva: null,
            id_asl: null,
            descr_specie: null,
            //descr_specie: null,
            ragione_sociale: null,
            tipo_utente_inserimento: null,
            dt_utente_inserimento: null
          };

          op_mov?.forEach(o => {
            const value_mov = (l.substring(o.char_inizio - 1, o.char_fine - 1)).trim();
            movimentazioni.push(value_mov);

            if (o.descrizione === 'datarange_movimentazione') {
              mov_dett.init_range = value_mov.substring(0, 4) + '-' + value_mov.substring(4, 6) + '-' + value_mov.substring(6, 8);
              mov_dett.end_range = value_mov.substring(8, 12) + '-' + value_mov.substring(12, 14) + '-' + value_mov.substring(14, 16);
              mov_dett.datarange_movimentazione = `[${mov_dett.init_range}, ${mov_dett.end_range}]`;
              console.log("init_range:", mov_dett.init_range);
              console.log("end_range:", mov_dett.end_range);
              mov_dett.datarange_id = value_mov.substring(16, value_mov.length - 1);
              console.log("datarange_id:", mov_dett.datarange_id);
            } else if (o.descrizione === 'codice_azienda_piva_cf') {
              mov_dett.cod_azienda = '';
              mov_dett.cf_piva = '';
              if (value_mov.length === 21 || value_mov.length === 25) {
                mov_dett.id_asl = value_mov.substring(0, 2);
                mov_dett.cod_azienda = value_mov.substring(2, 10);
                mov_dett.cf_piva = value_mov.substring(10, value_mov.length - 1);
                console.log("id_asl:", mov_dett.id_asl);
              } else {
                mov_dett.cod_azienda = value_mov.substring(0, 8);
                mov_dett.cf_piva = value_mov.substring(8, value_mov.length - 1);
              }
              console.log("cod_azienda:", mov_dett.cod_azienda);
              console.log("cf_piva:", mov_dett.cf_piva);
            } else if (o.descrizione === 'utente_inserimento') {
              mov_dett.tipo_utente_inserimento = value_mov.substring(0, 3);
              mov_dett.dt_utente_inserimento = value_mov.substring(3, 7) + '-' + value_mov.substring(7, 9) + '-' + value_mov.substring(9, 11);
              console.log("tipo_utente_inserimento:", mov_dett.tipo_utente_inserimento);
              console.log("dt_utente_inserimento:", mov_dett.dt_utente_inserimento);
            } else {
              mov_dett[o.descrizione] = value_mov;
            }
          });
          // console.log("movimentazioni:", movimentazioni);
          console.log("mov_dett:", mov_dett);

          /*
          const ii_mov_dettagli = {
            text: 'insert into bdn_mov.movimentazioni_dettagli (datarange_movimentazione, datarange_id, cod_azienda, cf_piva, descr_specie, ragione_sociale, tipo_utente_inserimento, dt_utente_inserimento) values ($1, $2, $3, $4, $5, $6, $7, $8);',
            values: [
              mov_dett.datarange_movimentazione,
              mov_dett.datarange_id,
              mov_dett.cod_azienda,
              mov_dett.cf_piva,
              mov_dett.descr_specie,
              mov_dett.descr_specie,
              mov_dett.ragione_sociale,
              mov_dett.tipo_utente_inserimento,
              mov_dett.dt_utente_inserimento
            ]
          };

          // insert into bdn_mov.movimentazioni_dettagli (datarange_movimentazione, datarange_id, cod_azienda, cf_piva, descr_specie, ragione_sociale, tipo_utente_inserimento, dt_utente_inserimento) values ('[2023-01-01, 2023-02-20]', '729985', '004UD009', '00517450300', 'BOVINI', 'PERSELLO ANITA', 'DET', '1998-03-17');

          const ii_movimentazioni = {
            text: `insert into bdn_mov.movimentazioni (datarange_movimentazione, codice_azienda_piva_cf, descr_specie, ragione_sociale, utente_inserimento) values ($1, $2, $3, $4, $5) returning id;`,
            values: movimentazioni
          };

          conn.clientBDN.query(ii_movimentazioni, (err, result) => {
            if (err) {
              console.log(err.stack);
              res.writeHead(500).end();
            } else {
              console.log("result.rows:", result.rows);
              op_mov_val?.forEach(o => {
                const value_mov_op = (l.substring(o.char_inizio - 1, o.char_fine - 1)).trim();

                const ii_mov_valori = {
                  text: 'insert into bdn_mov.movimentazioni_valori (id_operazione, valore, id_movimentazione) values ($1, $2, $3);',
                  values: [o.id, value_mov_op, parseInt(result.rows[0].id)]
                }

                conn.clientBDN.query(ii_mov_valori, (err, result) => {
                  if (err) {
                    console.log(err.stack);
                    res.writeHead(500).end();
                  }
                });
              });
            }
          })
          */
        });

        res.json({ 'status': 'OK' }).end();
      }
    })

  } catch (error) {
    console.log("Error from catch: " + error);
    res.status(500).send(error).end();
  }
});

async function downloadPDF(res, filename, pathname) {
  try {
    res.set({ "Access-Control-Expose-Headers": 'Content-Disposition' });
    res.download(pathname, filename, function (err) {
      if (err) {
        console.log(err);
        res.status(500).send(err).end();
      }
      fs.unlinkSync(pathname);
    });
  } catch (e) {
    console.log(e.stack);
    res.end();
  }
}

async function downloadPDFFromDB(res, filename, pathname, id_intervento) {
  console.log(id_intervento)
  try {
    res.set({ "Access-Control-Expose-Headers": 'Content-Disposition' });
    const querySelect = {
      text: `select pa.file from bdn_pa.pdf_accettazione pa where pa.id_intervento = $1 order by id desc limit 1`,
      values: [parseInt(id_intervento)]
    };
    console.log("Query pdf", querySelect);
    conn.clientBDN.query(querySelect, async (err, result) => {
      if (err) {
        console.log(err.stack);
        res.writeHead(500).end();
      } else {
        const dati = result.rows[0].file;
        console.log("dati presi dalla query", dati.toString('base64'));
        fs.writeFileSync(path.join(pathname, filename), Buffer.from(dati.toString(), 'base64'));
        res.download(path.join(pathname, filename), filename, function (err) {
          if (err) {
            console.log(err);
            res.status(500).send(err).end();
          }

        });
      }
    })


  } catch (e) {
    console.log(e.stack);
    res.end();
  }
}

/**
 * La funzione prende in input un array di stringhe e le converte in immagini di 
 * codici a barre.
 * @param {string[]} strings Array di strighe da convertire in barcodes
 * @returns 
 */
function generateBarcodes(strings) {
  return Promise.all(strings?.map(function (string, index) {
    return new Promise(function (resolve, reject) {
      bwipjs.toBuffer({
        bcid: 'code128',       // Barcode type
        text: string,          // Text to encode
        scale: 3,              // 3x scaling factor
        height: 10,            // Bar height, in millimeters
        includetext: true,     // Show human-readable text
        textxalign: 'center',  // Always good to set this
      }, function (err, png) {
        if (err) {
          reject(err);
        } else {
          const imgPathname = path.join('static', 'tmp', `${string}.png`);
          fs.writeFile(imgPathname, png, function (err) {
            if (err) {
              reject(err);
            } else {
              resolve(imgPathname);
            }
          });
        }
      });
    });
  }));
}

module.exports = router;