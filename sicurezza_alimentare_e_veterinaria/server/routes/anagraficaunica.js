/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
//rotta per notifiche
var express = require('express');
var router = express.Router();
var soap = require('soap');
const conf = require('../config/config');
const base64 = require('base64url');
var utils = require('../utils/utils')
const xml2js = require('xml2js');
var conn = require('../db/connection');

router.get("/ricerca", (req, res) => {

  const url = conf.anagrafeUnica.host;
  const wsdl = conf.anagrafeUnica.wsdl;
  const username = conf.anagrafeUnica.username;
  const password = conf.anagrafeUnica.password;
  const options = {
    wsdl_headers: {
      'Authorization': 'Basic ' + base64.encode(username + ':' + password)
    }
  }
  var args = "";
  if (req.query.cf != null) {
    args = { 'AutenticazioneParent': [{ 'Ticket': '---' }], 'RicercaAnagrafica': [{ 'CodiceFiscale': req.query.cf }] };

  } else {
    if (req.query.cognome != null && req.query.nome != null) {
      args = { 'AutenticazioneParent': [{ 'Ticket': '---' }], 'RicercaAnagrafica': [{ 'Nominativo': { 'Cognome': req.query.cognome, 'Nome': req.query.nome } }] };
    }
  }
  soap.createClient(wsdl, options, async (err, client) => {
    console.log("args: ", args);
    if (err) {
      console.error(err);
      res.json({ esito: false, msg: err.message }).end();
      return;
    } else {
      // var args={'AutenticazioneParent':[{'Ticket':'---'}],'RicercaAnagrafica':[{'CodiceFiscale':req.query.cf}]} ;

      try {
        client.setSecurity(new soap.BasicAuthSecurity(username, password));
        client.setEndpoint(url);
        let result = await client.ricercaBaseAsync(args, { timeout: 10000 });

        var profile = JSON.parse(JSON.stringify(result[0]));
        if (profile.CodiceRitorno == 0) {
          delete profile["attributes"];

          if (profile.Anagrafica == null) {
            // console.log("utente non esistente: "); 
            profile["CodiceRitorno"] = -1;
          }

          console.log(result[1]);
          let persone = result[1].split('<ns2:IdentificativoPersona>');
          let i = 0;
          persone.shift();
          for (let p of persone) {
            console.log(p);
            let dateNascita = utils.getXmlValueByTagName(p, 'NascitaData');
            console.log(dateNascita);
            profile.Anagrafica[i].Anagrafica.NascitaData = dateNascita?.split('+')?.[0] ?? null;
            i++;
          }


          res.json(profile);
        }
      } catch (err) {
        console.log(err);
        res.writeHead(500).end();
      }
    }
  });

  return;
})

router.get("/parixDettaglioCompletoImpresa", async (req, res) => {
  const wsdl = conf.parix.wsdl
  const username = conf.parix.username
  const password = conf.parix.password

  let piva = req.query.piva
  let n_rea
  let cciaa

  let params = {
    codice_fiscale: piva, //'01610130930', 
    user: username,
    password: password
  }

  try {
    let client = await soap.createClientAsync(wsdl, { wsdl_options: { timeout: 1000 } });
    let result = await client['RicercaImpresePerCodiceFiscale' + 'Async'](params);
    result = result[0].RicercaImpresePerCodiceFiscaleReturn["$value"]
    n_rea = utils.getXmlValueByTagName(result, 'NREA')
    cciaa = utils.getXmlValueByTagName(result, 'CCIAA')

  } catch (err) {
    console.log(err);
    res.writeHead(500).end();
    return
  }

  if (n_rea == null || cciaa == null) {
    res.writeHead(200, 'Impresa non trovata').end()
    return
  }

  params = {
    sgl_prv_sede: cciaa,
    n_rea_sede: n_rea,
    switch_control: '',
    abilitaSoci: '',
    user: username,
    password: password
  }

  try {
    let client = await soap.createClientAsync(wsdl, { wsdl_options: { timeout: 1000 } });
    let result = await client['DettaglioCompletoImpresa' + 'Async'](params);
    result = result[0].DettaglioCompletoImpresaReturn["$value"];
    xml = result;
    xml2js.parseString(xml, function (err, res) {
      result = res;
    })
    Object.assign(result, { 'RISPOSTA_RAW': xml })

    res.json(result)

  } catch (err) {
    console.log(err);
    res.writeHead(500).end();
    return
  }

})

router.post("/parixBonificaSoggettiFisici", async (req, res) => {
  const wsdl = conf.parix.wsdl
  const username = conf.parix.username //da configuare come per bdn
  const password = conf.parix.password

  let cf = req.body.cf
  let cfc = req.body.cfc
  let n_rea
  let cciaa
  let risp;
  let parsingData;
  let datiPersona;

  let params = {
    codice_fiscale: null, //'01610130930', 
    codice_carica: cfc,
    user: username,
    password: password
  }
  for (let elem of cf) {
    params.codice_fiscale = elem;
    // params.codice_fiscale = cf;
    console.log("codice fiscale:", elem);
    await new Promise(r => setTimeout(r, 2000));
    try {
      let client = await soap.createClientAsync(wsdl, { wsdl_options: { timeout: 10000 } });
      let result = await client['RicercaPersonePerCodiceFiscale' + 'Async'](params);
      result = result[0].RicercaPersonePerCodiceFiscaleReturn["$value"]
      n_rea = utils.getXmlValueByTagName(result, 'NREA')
      cciaa = utils.getXmlValueByTagName(result, 'CCIAA')
      xml = result;
      xml2js.parseString(xml, function (err, resjson) {
        result = resjson;
      })
      console.log(result.RISPOSTA.DATI[0]);
      // console.log("Dati persona:",result.RISPOSTA.DATI[0].LISTA_PERSONE[0].SCHEDA_PERSONA[0].PERSONA[0].PERSONA_FISICA[0]);
      risp = result;
      if (!result.RISPOSTA.DATI[0].ERRORE?.length) {
        console.log("entrato");
        datiPersona = result.RISPOSTA.DATI[0].LISTA_PERSONE[0].SCHEDA_PERSONA[0].PERSONA[0].PERSONA_FISICA[0];
        if (('ESTREMI_NASCITA' in datiPersona)) {
          parsingData = datiPersona.ESTREMI_NASCITA[0].DATA[0].substring(0, 4) + '-' + datiPersona.ESTREMI_NASCITA[0].DATA[0].substring(4, 6) + '-' + datiPersona.ESTREMI_NASCITA[0].DATA[0].substring(6, 8);
          // console.log("Data persona:",result.RISPOSTA.DATI[0].LISTA_PERSONE[0].SCHEDA_PERSONA[0].PERSONA[0].PERSONA_FISICA[0].ESTREMI_NASCITA[0].DATA[0]);
          console.log(parsingData);
        }
        if ((!('INDIRIZZO' in datiPersona) || datiPersona.INDIRIZZO[0] == '') && (!('ESTREMI_NASCITA' in datiPersona))) {
          console.log("entrato senza indirizzo e data di nascita")
          const query = {
            text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,fonte)
              values ($1,$2,$3,$4)`,
            values: [datiPersona.CODICE_FISCALE[0], datiPersona.COGNOME[0], datiPersona.NOME[0], 'PARIX']
          };
          conn.client.query(query, (err, result) => {
            if (err) {
              console.log(err.stack);
              res.writeHead(500).end();
            }
          })
        }
        else if (!('INDIRIZZO' in datiPersona) || datiPersona.INDIRIZZO[0] == '') {
          console.log("entrato senza indirizzo")
          const query = {
            text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,data_nascita,fonte)
              values ($1,$2,$3,$4,$5)`,
            values: [datiPersona.CODICE_FISCALE[0], datiPersona.COGNOME[0], datiPersona.NOME[0], parsingData, 'PARIX']
          };
          conn.client.query(query, (err, result) => {
            if (err) {
              console.log(err.stack);
              res.writeHead(500).end();
            }
          })
        }
        else {
          if (!('TOPONIMO' in datiPersona.INDIRIZZO[0]) && !('N_CIVICO' in datiPersona.INDIRIZZO[0]) && !('VIA' in datiPersona.INDIRIZZO[0])) {
            console.log("entrato in indirizzo senza toponimo, civico e via PARIX")
            const query = {
              text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,data_nascita,cap,comune,fonte)
              values ($1,$2,$3,$4,$5,$6,$7)`,
              values: [datiPersona.CODICE_FISCALE[0], datiPersona.COGNOME[0], datiPersona.NOME[0], parsingData, datiPersona.INDIRIZZO[0].CAP[0], datiPersona.INDIRIZZO[0].COMUNE[0], 'PARIX']
            };
            conn.client.query(query, (err, result) => {
              if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
              }
            })
          }
          else if (!('TOPONIMO' in datiPersona.INDIRIZZO[0]) && !('N_CIVICO' in datiPersona.INDIRIZZO[0])) {
            console.log("entrato in indirizzo senza toponimo e civico PARIX")
            const query = {
              text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,data_nascita,indirizzo,cap,comune,fonte)
              values ($1,$2,$3,$4,$5,$6,$7,$8)`,
              values: [datiPersona.CODICE_FISCALE[0], datiPersona.COGNOME[0], datiPersona.NOME[0], parsingData, datiPersona.INDIRIZZO[0].VIA[0], datiPersona.INDIRIZZO[0].CAP[0], datiPersona.INDIRIZZO[0].COMUNE[0], 'PARIX']
            };
            conn.client.query(query, (err, result) => {
              if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
              }
            })
          }
          else if (!('TOPONIMO' in datiPersona.INDIRIZZO[0]) && !('CAP' in datiPersona.INDIRIZZO[0])) {
            console.log("entrato in indirizzo senza toponimo e cap PARIX")
            const query = {
              text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,data_nascita,civico,indirizzo,comune,fonte)
              values ($1,$2,$3,$4,$5,$6,$7,$8)`,
              values: [datiPersona.CODICE_FISCALE[0], datiPersona.COGNOME[0], datiPersona.NOME[0], parsingData, datiPersona.INDIRIZZO[0].N_CIVICO[0], datiPersona.INDIRIZZO[0].VIA[0], datiPersona.INDIRIZZO[0].COMUNE[0], 'PARIX']
            };
            conn.client.query(query, (err, result) => {
              if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
              }
            })
          }
          else if (!('TOPONIMO' in datiPersona.INDIRIZZO[0]) && !('VIA' in datiPersona.INDIRIZZO[0])) {
            console.log("entrato in indirizzo senza toponimo e via PARIX")
            const query = {
              text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,data_nascita,civico,cap,comune,fonte)
              values ($1,$2,$3,$4,$5,$6,$7,$8)`,
              values: [datiPersona.CODICE_FISCALE[0], datiPersona.COGNOME[0], datiPersona.NOME[0], parsingData, datiPersona.INDIRIZZO[0].N_CIVICO[0], datiPersona.INDIRIZZO[0].CAP[0], datiPersona.INDIRIZZO[0].COMUNE[0], 'PARIX']
            };
            conn.client.query(query, (err, result) => {
              if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
              }
            })
          }
          else if (!('TOPONIMO' in datiPersona.INDIRIZZO[0])) {
            console.log("entrato in indirizzo senza toponimo PARIX")
            const query = {
              text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,data_nascita,civico,indirizzo,cap,comune,fonte)
              values ($1,$2,$3,$4,$5,$6,$7,$8,$9)`,
              values: [datiPersona.CODICE_FISCALE[0], datiPersona.COGNOME[0], datiPersona.NOME[0], parsingData, datiPersona.INDIRIZZO[0].N_CIVICO[0], datiPersona.INDIRIZZO[0].VIA[0], datiPersona.INDIRIZZO[0].CAP[0], datiPersona.INDIRIZZO[0].COMUNE[0], 'PARIX']
            };
            conn.client.query(query, (err, result) => {
              if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
              }
            })
          }
          else if (!('N_CIVICO' in datiPersona.INDIRIZZO[0])) {
            console.log("entrato in indirizzo senza civico PARIX")
            const query = {
              text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,data_nascita,toponimo,indirizzo,cap,comune,fonte)
              values ($1,$2,$3,$4,$5,$6,$7,$8,$9)`,
              values: [datiPersona.CODICE_FISCALE[0], datiPersona.COGNOME[0], datiPersona.NOME[0], parsingData, datiPersona.INDIRIZZO[0].TOPONIMO[0], datiPersona.INDIRIZZO[0].VIA[0], datiPersona.INDIRIZZO[0].CAP[0], datiPersona.INDIRIZZO[0].COMUNE[0], 'PARIX']
            };
            conn.client.query(query, (err, result) => {
              if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
              }
            })
          }
          else if (!('CAP' in datiPersona.INDIRIZZO[0])) {
            console.log("entrato in indirizzo senza cap PARIX")
            const query = {
              text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,data_nascita,toponimo,civico,indirizzo,comune,fonte)
              values ($1,$2,$3,$4,$5,$6,$7,$8,$9)`,
              values: [datiPersona.CODICE_FISCALE[0], datiPersona.COGNOME[0], datiPersona.NOME[0], parsingData, datiPersona.INDIRIZZO[0].TOPONIMO[0], datiPersona.INDIRIZZO[0].N_CIVICO[0], datiPersona.INDIRIZZO[0].VIA[0], datiPersona.INDIRIZZO[0].COMUNE[0], 'PARIX']
            };
            conn.client.query(query, (err, result) => {
              if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
              }
            })
          }
          else {
            console.log("entrato in indirizzo PARIX")
            const query = {
              text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,data_nascita,toponimo,civico,indirizzo,cap,comune,fonte)
              values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)`,
              values: [datiPersona.CODICE_FISCALE[0], datiPersona.COGNOME[0], datiPersona.NOME[0], parsingData, datiPersona.INDIRIZZO[0].TOPONIMO[0], datiPersona.INDIRIZZO[0].N_CIVICO[0], datiPersona.INDIRIZZO[0].VIA[0], datiPersona.INDIRIZZO[0].CAP[0], datiPersona.INDIRIZZO[0].COMUNE[0], 'PARIX']
            };
            conn.client.query(query, (err, result) => {
              if (err) {
                console.log(err.stack);
                res.writeHead(500).end();
              }
            })
          }
        }
      }

    } catch (err) {
      console.log(err);
      return
    }
  }
  res.json(risp);

})
router.post("/bonificaAssistitiFVG", (req, res) => {

  const url = conf.anagrafeUnica.host;
  const wsdl = conf.anagrafeUnica.wsdl;
  const username = conf.anagrafeUnica.username;
  const password = conf.anagrafeUnica.password;
  const options = {
    wsdl_headers: {
      'Authorization': 'Basic ' + base64.encode(username + ':' + password)
    }
  }
  var args = "";
  let cfPresi = req.body;
  let cfRestituiti = { CodiceRitorno: -1, cf: [] };
  soap.createClient(wsdl, options, async (err, client) => {
    console.log("args: ", args);
    if (err) {
      console.error(err);
      res.json({ esito: false, msg: err.message }).end();
      return;
    } else {
      try {
        for (elem of cfPresi) {
          var args = { 'AutenticazioneParent': [{ 'Ticket': '---' }], 'RicercaAnagrafica': [{ 'CodiceFiscale': elem }] };


          client.setSecurity(new soap.BasicAuthSecurity(username, password));
          client.setEndpoint(url);
          let result = await client.ricercaBaseAsync(args, { timeout: 10000 });

          var profile = JSON.parse(JSON.stringify(result[0]));
          if (profile.CodiceRitorno == 0) {
            delete profile["attributes"];

            // console.log(profile);

            // console.log("Residenza:", profile.Anagrafica[0].Residenza);
            // console.log("Anagrafica:", profile.Anagrafica[0].Anagrafica);

            if (profile.Anagrafica == null) {
              // console.log("utente non esistente: "); 
              profile["CodiceRitorno"] = -1;
              cfRestituiti.cf.push(elem);
            }
            console.log("profile:", profile);
            console.log(result[1]);
            let persone = result[1].split('<ns2:IdentificativoPersona>');
            let i = 0;
            persone.shift();
            for (let p of persone) {
              console.log(p);
              let dateNascita = utils.getXmlValueByTagName(p, 'NascitaData');
              console.log(dateNascita);
              profile.Anagrafica[i].Anagrafica.NascitaData = dateNascita?.split('+')?.[0] ?? null;
              i++;
            }

            if (profile.Anagrafica != null) {
              if (profile.Anagrafica[0].Residenza) {
                if ('ResidenzaItalia' in profile.Anagrafica[0].Residenza) {
                  if ('LuogoItaliaNote' in profile.Anagrafica[0].Residenza.ResidenzaItalia) {
                    console.log("entrato senza indirizzo");
                    const query = {
                      text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,comune_nascita,data_nascita,cap,comune,fonte)
                      values ($1,$2,$3,$4,$5,$6,$7,$8)`,
                      values: [profile.Anagrafica[0].Anagrafica.CodiceFiscale, profile.Anagrafica[0].Anagrafica.Cognome, profile.Anagrafica[0].Anagrafica.Nome,
                      profile.Anagrafica[0].Anagrafica.NascitaLuogo.Descrizione, profile.Anagrafica[0].Anagrafica.NascitaData,
                      profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaCAP, profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaComune.Descrizione, 'Anagrafica-Assistiti']
                    };
                    conn.client.query(query, (err, result) => {
                      if (err) {
                        console.log(err.stack);
                        res.writeHead(500).end();
                      }
                    })
                  }
                  else if ('LuogoItaliaIndirizzo' in profile.Anagrafica[0].Residenza.ResidenzaItalia) {
                    if ('NascitaLuogo' in profile.Anagrafica[0].Anagrafica) {
                      console.log("entrato con indirizzo");
                      const query = {
                        text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,comune_nascita,data_nascita,toponimo,civico,indirizzo,cap,comune,fonte)
                        values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)`,
                        values: [profile.Anagrafica[0].Anagrafica.CodiceFiscale, profile.Anagrafica[0].Anagrafica.Cognome, profile.Anagrafica[0].Anagrafica.Nome,
                        profile.Anagrafica[0].Anagrafica.NascitaLuogo.Descrizione, profile.Anagrafica[0].Anagrafica.NascitaData, profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaIndirizzo.IndirizzoToponimo,
                        profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaIndirizzo.IndirizzoNumeroCivico, profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaIndirizzo.IndirizzoDescrizione,
                        profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaCAP, profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaComune.Descrizione, 'Anagrafica-Assistiti']
                      };
                      conn.client.query(query, (err, result) => {
                        if (err) {
                          console.log(err.stack);
                          res.writeHead(500).end();
                        }
                      })
                    }
                    else {
                      console.log("entrato con indirizzo senza luogo di nascita");
                      const query = {
                        text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,data_nascita,toponimo,civico,indirizzo,cap,comune,fonte)
                        values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)`,
                        values: [profile.Anagrafica[0].Anagrafica.CodiceFiscale, profile.Anagrafica[0].Anagrafica.Cognome, profile.Anagrafica[0].Anagrafica.Nome,
                        profile.Anagrafica[0].Anagrafica.NascitaData, profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaIndirizzo.IndirizzoToponimo,
                        profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaIndirizzo.IndirizzoNumeroCivico, profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaIndirizzo.IndirizzoDescrizione,
                        profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaCAP, profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaComune.Descrizione, 'Anagrafica-Assistiti']
                      };
                      conn.client.query(query, (err, result) => {
                        if (err) {
                          console.log(err.stack);
                          res.writeHead(500).end();
                        }
                      })
                    }
                  }
                  else {
                    console.log("entrato senza residenza italia");
                    const query = {
                      text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,comune_nascita,data_nascita,cap,comune,fonte)
                      values ($1,$2,$3,$4,$5,$6,$7,$8)`,
                      values: [profile.Anagrafica[0].Anagrafica.CodiceFiscale, profile.Anagrafica[0].Anagrafica.Cognome, profile.Anagrafica[0].Anagrafica.Nome,
                      profile.Anagrafica[0].Anagrafica.NascitaLuogo.Descrizione, profile.Anagrafica[0].Anagrafica.NascitaData,
                      profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaCAP, profile.Anagrafica[0].Residenza.ResidenzaItalia.LuogoItaliaComune.Descrizione, 'Anagrafica-Assistiti']
                    };
                    conn.client.query(query, (err, result) => {
                      if (err) {
                        console.log(err.stack);
                        res.writeHead(500).end();
                      }
                    })
                  }
                }
                else if ('ResidenzaEstero' in profile.Anagrafica[0].Residenza) {
                  console.log("entrato con indirizzo estero senza residenza");
                  const query = {
                    text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,comune_nascita,data_nascita,nazione,comune,codice_at,fonte)
                    values ($1,$2,$3,$4,$5,$6,$7,$8,$9)`,
                    values: [profile.Anagrafica[0].Anagrafica.CodiceFiscale, profile.Anagrafica[0].Anagrafica.Cognome, profile.Anagrafica[0].Anagrafica.Nome,
                    profile.Anagrafica[0].Anagrafica.NascitaLuogo.Descrizione, profile.Anagrafica[0].Anagrafica.NascitaData,
                    profile.Anagrafica[0].Residenza.ResidenzaEstero.LuogoEsteroStato.Descrizione, profile.Anagrafica[0].Residenza.ResidenzaEstero.LuogoEsteroComune,
                    profile.Anagrafica[0].Residenza.ResidenzaEstero.LuogoEsteroStato.Codice, 'Anagrafica-Assistiti']
                  };
                  conn.client.query(query, (err, result) => {
                    if (err) {
                      console.log(err.stack);
                      res.writeHead(500).end();
                    }
                  })
                }
              }
              else {
                console.log("entrato senza residenza");
                const query = {
                  text: `insert into conf_ext.bonifica_soggetti_fisici (codice_fiscale,cognome,nome,comune_nascita,data_nascita,fonte)
                  values ($1,$2,$3,$4,$5,$6)`,
                  values: [profile.Anagrafica[0].Anagrafica.CodiceFiscale, profile.Anagrafica[0].Anagrafica.Cognome, profile.Anagrafica[0].Anagrafica.Nome,
                  profile.Anagrafica[0].Anagrafica.NascitaLuogo.Descrizione, profile.Anagrafica[0].Anagrafica.NascitaData,
                    'Anagrafica-Assistiti']
                };
                conn.client.query(query, (err, result) => {
                  if (err) {
                    console.log(err.stack);
                    res.writeHead(500).end();
                  }
                })
              }
            }
          }


        }

        res.json(cfRestituiti);
      } catch (err) {
        console.log(err);
        res.writeHead(500).end();
      }

    }
  });




  return;
})


module.exports = router;