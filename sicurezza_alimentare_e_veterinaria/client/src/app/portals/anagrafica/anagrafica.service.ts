/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { BackendCommunicationService, BackendResponse } from "@us/utils";
import { Observable, map } from "rxjs";
import { baseUri } from "src/environments/environment";

@Injectable()
export class AnagraficaService {
  constructor(
    private http: HttpClient,
    private be: BackendCommunicationService) { }

  getCu() {
    return this.be.getDati('get_cu');
  }

  getCuSingolo(idCu: string | number) {
    return this.be.getDati('get_cu_singolo', { "id_cu": +idCu });
  }

  getCuInfo(idCu: string | number) {
    return this.be.getDati('get_cu_info', { "id_cu": idCu });
  }

  getCuInfoPerVerbale(idCu: string | number) {
    return this.be.getDati('get_cu_info_per_verbale', { "id_cu": +idCu });
  }

  getCuOggettiAssoc(idCu: string | number) {
    return this.be.getDati('get_cu_oggetti', { "id_cu": idCu })
  }

  getTipiProvvedimenti(idNorma: string | number) {
    return this.be.getDati('get_cu_tipi_provv', { "id_norma": idNorma })
  }

  getProvvedimenti(idEv: string | number) {
    return this.be.getDati('get_cu_provv', { "id_evidenza": idEv })
  }

  addProvvedimento(provvedimento: any) {
    return this.be.updDati('upd_cu_add_provv', provvedimento)
  }

  updProvvedimento(provvedimento: any) {
    return this.be.updDati('upd_cu_upd_provv', provvedimento)
  }

  delProvvedimento(idProvv: any[]) {
    return this.be.updDati('upd_cu_del_provv', { "id_provv": idProvv })
  }

  getMenu(menu: string) {
    return this.be.getDati('get_menu', { menu: menu });
  }

  getTipoOggettiValidi() {
    return this.be.getDati('get_cu_tipo_oggetti_validi')
  }

  addTipoOggettiValidi(oggetto: any) {
    return this.be.updDati('upd_cu_add_tipo_oggetto', oggetto)
  }

  delTipoOggettiValidi(idOgg: any[]) {
    return this.be.updDati('upd_cu_del_tipo_oggetto', { "id_tipo_oggetto": idOgg })
  }

  updTipoOggettiValidi(oggetto: any) {
    return this.be.updDati('upd_cu_upd_tipo_oggetto', oggetto)
  }

  getTipoOggettiRequisitiValidi() {
    return this.be.getDati('get_cu_tipo_oggetti_requisiti_validi')
  }

  addTipoOggettiRequisitiValidi(requisito: any) {
    return this.be.updDati('upd_cu_add_requisiti', requisito)
  }

  delTipoOggettiRequisitiValidi(idReq: any[]) {
    return this.be.updDati('upd_cu_del_requisiti', { "id_requisito": idReq })
  }

  updTipoOggettiRequisitiValidi(requisito: any) {
    return this.be.updDati('upd_cu_upd_requisiti', requisito)
  }

  getTipiIspettori(idCu: string | number) {
    return this.be.getDati('get_cu_tipi_isp', { "id_cu": +idCu })
  }

  getTipiPersonale() {
    return this.be.getDati('get_cu_tipi_per')
  }

  getDichiarazioniPersonaleCu(idCuNucleo: number) {
    return this.be.getDati('get_cu_dichiarazione', { "id_cu_nucleo": +idCuNucleo })
  }

  addDichiarazioniPersonaleCu(dichiarazione: any) {
    return this.be.updDati('upd_cu_add_dichiarazione', dichiarazione)
  }

  getNuoviStatiOggetto(idOggetto: any) {
    return this.be.getDati('get_cu_stati_oggetto', { "id_cu_oggetto": +idOggetto })
  }

  updCuInfo(info: any) {
    return this.be.updDati('upd_cu_info_generali', info)
  }

  getNormeViolate(idCu: string | number) {
    return this.be.getDati('get_cu_norme_violate', { "id_cu": +idCu })
  }

  getEvidenzeByNorma(idCu: string | number, idNorma: string | number) {
    return this.be.getDati('get_cu_evidenze_by_norma', { "id_cu": +idCu, "id_norma_violata": +idNorma })
  }

  checkNucleiCU(idCu: string | number) {
    return this.be.getDati('cu_check_nuclei', { "id_cu": +idCu })
  }
  checkOggettiCU(idCu: string | number) {
    return this.be.getDati('cu_check_oggetti', { "id_cu": +idCu })
  }
  checkProvvedimentiCU(idCu: string | number) {
    return this.be.getDati('cu_check_provvedimenti', { "id_cu": +idCu })
  }
  checkProvvedimentiFU(idCu: string | number) {
    return this.be.getDati('cu_check_provvedimenti_fu', { "id_cu": +idCu })
  }

  checkStabilimentoCU(idCu: string | number) {
    return this.be.getDati('cu_check_stabilimento', { "id_cu": +idCu })
  }
  chiudiCU(params: any) {
    return this.be.updDati('upd_cu_chiudi_cu', params)
  }

  updNoteGenerali(params: any) {
    return this.be.updDati('upd_cu_note_generali', params)
  }

  updNoteVerbale(params: any) {
    return this.be.updDati('upd_cu_note_verbale', params)
  }

  getProvvFU(idCu: string | number) {
    return this.be.getDati('get_cu_provv_fu', { "id_cu": +idCu })
  }

  getEvidenzeFU(idProvvFu: string | number) {
    return this.be.getDati('get_cu_evidenze_linee_fu', { "id_provv_fu": +idProvvFu })
  }

  getStatiCU() {
    return this.be.getDati('get_cu_stati_cu')
  }

  getNucleoCU(idCu: string | number) {
    return this.be.getDati('get_cu_ni', { "id_cu": +idCu });
  }

  getPersonaleCU(idCu: string | number) {
    return this.be.getDati('get_cu_personale', { "id_cu": +idCu });
  }

  getEsterniCU(idCu: string | number) {
    return this.be.getDati('get_cu_esterni', { "id_cu": +idCu });
  }
  //Anche se non passo nulla devo comunque passare l'args passandogli l'oggetto vuoto
  getComuni(): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_comuni', args: '{}' }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_comuni') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getComuniAssociati(): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_comuni_associati', args: '{}' }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_comuni_associati') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getCodiciNascita(): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_codici_nascita', args: '{}' }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_codici_nascita') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getNazioni(): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_nazioni', args: '{}' }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_nazioni') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getToponimi(): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_toponimi', args: '{}' }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_toponimi') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getIndirizziPerComune(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_indirizzi_per_comune', args: JSON.stringify(args) }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_indirizzi_per_comune') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getCategRischio() {
    return this.be.getDati('get_categ_rischio')
  }

  getImpreseBySel(params: any) {
    return this.be.getDati('get_cu_imprese_by_sel', params)
  }

  getStabilimentiBySel(params: any) {
    return this.be.getDati('get_cu_stabilimenti_by_sel', params)
  }

  getSoggettiBySel(params: any) {
    return this.be.getDati('get_cu_soggetti_fisici_by_sel', params)
  }

  getPraticheBySel(params: any) {
    return this.be.getDati('get_cu_pratiche_by_sel', params)
  }

  getTipiPratiche() {
    return this.be.getDati('get_tipi_pratiche')
  }

  getImpresaSingolo(id_impresa: any) {
    return this.be.getDati('get_cu_impresa_singolo', { "id_impresa": +id_impresa })
  }

  getStabilimentoSingolo(id_stabilimento: any) {
    return this.be.getDati('get_cu_stabilimento_singolo', { "id_stabilimento": +id_stabilimento })
  }

  getPraticaSingolo(id_pratica: any) {
    return this.be.getDati('get_cu_pratica_singolo', { "id_pratica": +id_pratica })
  }

  getPraticaStorico(id_pratica: any) {
    return this.be.getDati('get_cu_pratica_storico', { "id_pratica": +id_pratica })
  }

  getSoggettoSingolo(id_soggetto_fisico: any) {
    return this.be.getDati('get_soggetto_fisico_singolo', { "id_soggetto_fisico": +id_soggetto_fisico })
  }

  updImpresa(params: any) {
    return this.be.updDati('upd_cu_imprese', params)
  }

  addImpresa(params: any) {
    return this.be.updDati('upd_cu_add_impresa', params)
  }

  addPratica(params: any) {
    return this.be.updDati('upd_cu_add_pratica', params)
  }

  updPratica(params: any) {
    return this.be.updDati('upd_cu_upd_pratica', params)
  }

  updStatoPratica(params: any) {
    return this.be.updDati('upd_cu_stato_pratica', params)
  }

  getImpresaStabilimenti(id_impresa: any) {
    return this.be.getDati('get_cu_stabilimenti', { "id_impresa": +id_impresa })
  }

  getStabilimentiFigureByImpresa(id_impresa: any) {
    return this.be.getDati('get_cu_stabilimenti_figure_by_impresa', { "id_impresa": +id_impresa })
  }

  addStabilimento(params: any) {
    return this.be.updDati('upd_cu_add_stabilimento', params)
  }

  updStabilimento(params: any) {
    return this.be.updDati('upd_cu_stabilimenti', params)
  }

  getCuEffettuatiByStabilimento(id_stabilimento: any) {
    return this.be.getDati('get_cu_effettuati', { "id_stabilimento": +id_stabilimento })
  }

  getCuProgrammatiByStabilimento(id_stabilimento: any) {
    return this.be.getDati('get_cu_programmati', { "id_stabilimento": +id_stabilimento })
  }

  getProvvedimentiInCorsoByStabilimento(id_stabilimento: any) {
    return this.be.getDati('get_cu_provv_in_corso', { "id_stabilimento": +id_stabilimento })
  }

  getStabilimentiSedi(id_stabilimento: any) {
    return this.be.getDati('get_cu_stabilimenti_sedi', { "id_stabilimento": +id_stabilimento })
  }

  getStabilimentiFigure(id_stabilimento: any) {
    return this.be.getDati('get_cu_stabilimenti_figure', { "id_stabilimento": +id_stabilimento })
  }

  getStabilimentiLinee(id_stabilimento: any) {
    return this.be.getDati('get_cu_linee_stabilimenti', { "id_stabilimento": +id_stabilimento })
  }

  getTipiSedi() {
    return this.be.getDati('get_cu_tipi_sede');
  }

  getTipiFigure() {
    return this.be.getDati('get_cu_tipi_figure');
  }

  getTipiLinee(id_stabilimento: any) {
    return this.be.getDati('get_cu_tipo_linee', { "id_stabilimento": +id_stabilimento });
  }

  getTipiImprese() {
    return this.be.getDati('get_cu_tipo_imprese');
  }

  getStabilimentiSediSingolo(id_sede: any) {
    return this.be.getDati('get_cu_stabilimenti_sede_singolo', { "id_sede": +id_sede })
  }

  getStabilimentiFigureSingolo(id_figura: any) {
    return this.be.getDati('get_cu_stabilimenti_figura_singolo', { "id_figura": +id_figura })
  }

  getStabilimentiLineeSingolo(id_linea: any) {
    return this.be.getDati('get_cu_stabilimenti_linea_singolo', { "id_linea": +id_linea })
  }

  getTipologiaStruttura() {
    return this.be.getDati('get_tipologie_struttura');
  }

  getTipologiaStrutturaAll() {
    return this.be.getDati('get_tipologie_struttura_all');
  }

  addSede(params: any) {
    return this.be.updDati('upd_cu_add_stabilimenti_sedi', params)
  }

  updSede(params: any) {
    return this.be.updDati('upd_cu_upd_stabilimenti_sedi', params)
  }

  addFigura(params: any) {
    return this.be.updDati('upd_cu_add_stabilimenti_figure', params)
  }

  updFigura(params: any) {
    return this.be.updDati('upd_cu_upd_stabilimenti_figure', params)
  }

  updStabilimentiLineaPrincipale(params: any) {
    return this.be.updDati('upd_cu_stabilimenti_linea_principale', params)
  }

  addLinea(params: any) {
    return this.be.updDati('upd_cu_add_linea_stabilimenti', params)
  }

  stabilimentoSubingresso(params: any) {
    return this.be.updDati('upd_cu_stabilimento_subingresso', params)
  }

  updLinea(params: any) {
    return this.be.updDati('upd_cu_linea_stabilimenti', params)
  }

  ricercaAnagrafica(params: any = {}): Observable<BackendResponse> {
    //Trasformazione dell'oggetto in una query string per la chiamata http
    let queryString = Object.keys(params).map(key => key + '=' + params[key]).join('&');
    //Chiamata http al server con url + query string
    return this.http
      .get(baseUri + 'anagraficaunica/ricerca?' + queryString)
      .pipe(
        map((res: any) => {
          //Costruzione del JSON per la creazione della tabella lato client
          res.info = {
            ui: {
              colonne: [{
                campo: "Nome",
                editabile: false,
                intestazione: "Nome",
                tipo: "text",
              },
              {
                campo: "Cognome",
                editabile: false,
                intestazione: "Cognome",
                tipo: "text",
              },
              {
                campo: "CodiceFiscale",
                editabile: false,
                intestazione: "Codice Fiscale",
                tipo: "text",
              }]
            },
            dati: res.Anagrafica
          };
          return res;
        })
      );
  }

  bonificaAnagraficaAssistiti(cf: any): Observable<BackendResponse> {
    return this.http.request<any>('POST', baseUri + `anagraficaunica/bonificaAssistitiFVG`,
      { body: cf })
      .pipe(
        map((res: any) => {
          return res;
        })
      );
  }

  geolocalizzaIndirizzo(params: any = {}): Observable<BackendResponse> {
    let queryString = Object.keys(params).map(key => key + '=' + params[key]).join('&');
    return this.http.get(baseUri + 'geolocalizzazioneIndirizzo/geolocalizzaIndirizzo?' + queryString)
      .pipe(
        map((res: any) => {
          return res;
        }))
  }

  getImpreseSediSingolo(id_sede: any) {
    return this.be.getDati('get_cu_imprese_sede_singolo', { "id_sede": +id_sede })
  }

  getImpreseSedi(id_impresa: any) {
    return this.be.getDati('get_cu_imprese_sedi', { "id_impresa": +id_impresa })
  }

  getImpreseFigure(id_impresa: any) {
    return this.be.getDati('get_cu_imprese_figure', { "id_impresa": +id_impresa })
  }

  getImpreseFigureSingolo(id_figura: any) {
    return this.be.getDati('get_cu_imprese_figura_singolo', { "id_figura": +id_figura })
  }

  addSedeImpresa(params: any) {
    return this.be.updDati('upd_cu_add_imprese_sedi', params)
  }

  updSedeImpresa(params: any) {
    return this.be.updDati('upd_cu_upd_imprese_sedi', params)
  }

  addFiguraImpresa(params: any) {
    return this.be.updDati('upd_cu_add_imprese_figure', params)
  }

  updFiguraImpresa(params: any) {
    return this.be.updDati('upd_cu_upd_imprese_figure', params)
  }

  getTipiSediImpresa() {
    return this.be.getDati('get_cu_tipi_sede_impresa')
  }

  getTipiFigureImpresa() {
    return this.be.getDati('get_cu_tipi_figure_impresa')
  }

  checkEsisteCF(params: any) {
    return this.be.getDati('check_esiste_cf', params)
  }

  addSoggettoFisico(params: any) {
    return this.be.updDati('upd_cu_add_soggetti_fisici', params)
  }

  updSoggettoFisico(params: any) {
    return this.be.updDati('upd_cu_soggetti_fisici', params)
  }

  updSoggettoFisicoFromService(params: any) {
    return this.be.updDati('upd_cu_add_soggetti_fisici_from_service', params)
  }

  updSetCodiceStabilimento(id_stabilimento: any) {
    return this.be.updDati('upd_set_codice_stabilimento', { "id_stabilimento": +id_stabilimento })
  }

  getLineeBySel(params: any) {
    return this.be.getDati('get_cu_linee_by_sel', params)
  }

  getStruttureAsl() {
    return this.be.getDati('get_strutture_asl')
  }

  getStoricoStabilimento(id_stabilimento: any) {
    return this.be.getDati('get_cu_stabilimento_storico', { 'id_stabilimento': +id_stabilimento })
  }

  getTipoImport() {
    return this.be.getDati('get_tipo_import', {});
  }


  getElencoImportAnagrafica() {
    return this.be.getDati('get_elenco_import_anagrafica', {});
  }

  getSoggettiStabilimenti(cf: any) {
    return this.be.getDati('get_cu_soggetto_figure_stabilimenti', { "cf": cf })
  }

  getSoggettiFigure(cf: any) {
    return this.be.getDati('get_cu_soggetto_figure_imprese', { "cf": cf })
  }

  getPraticheStabilimento(id_stabilimento: number) {
    return this.be.getDati('get_cu_pratiche_by_stabilimento', { "id_stabilimento": id_stabilimento })
  }


  getCfDaBonificare(): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_cf_da_bonificare', args: '{}' }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_cf_da_bonificare') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getAutomezziBySel(params: any) {
    return this.be.getDati('get_cu_automezzi_by_sel', params);
  }

  insAutomezzo(params: any) {
    return this.be.updDati('ins_automezzo', params);
  }

  updAutomezzo(params: any) {
    return this.be.updDati('upd_automezzo', params);
  }

  insStabilimentiAutomezzi(params: any) {
    return this.be.updDati('ins_stabilimenti_automezzi', params);
  }

  updStabilimentiAutomezzi(params: any) {
    return this.be.updDati('upd_stabilimenti_automezzi', params);
  }

  getAutomezzoSingolo(id_automezzo: number) {
    return this.be.getDati('get_cu_automezzo_singolo', { id_automezzo: id_automezzo });
  }

  getAutomezzoStabilimentoSingolo(id_stabilimento_automezzi: number) {
    return this.be.getDati('get_cu_automezzo_stabilimento_singolo', { id_stabilimento_automezzi: id_stabilimento_automezzi });
  }

  getStabilimentiAutomezzi(id_automezzo: number) {
    return this.be.getDati('get_cu_stabilimenti_automezzi', { id_automezzo: id_automezzo });
  }

  getPIvaDaBonificare(): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_piva_da_bonificare', args: '{}' }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_piva_da_bonificare') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  addIndirizziTrasportatori(params: any) {
    return this.be.updDati('upd_add_indirizzi_trasportatori', params)
  }

}
