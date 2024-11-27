/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { BackendCommunicationService, BackendResponse, BasicStorage } from "@us/utils";
import { Observable, map } from "rxjs";
import { baseUri } from "src/environments/environment";

@Injectable()
export class GestioneAttivitaService {

  storage = new BasicStorage();

  constructor(
    private http: HttpClient,
    private be: BackendCommunicationService
  ) { }

  getMenu(menu: string) {
    return this.be.getDati('get_menu', { menu: menu });
  }

  getTariffario() {
    return this.be.getDati('get_tariffario');
  }

  getTariffaVoci(idTariffa: string | number) {
    return this.be.getDati('get_tariffa_voci', { id_tariffa: idTariffa });
  }

  updTariffaVoci(idTariffa: string | number, dati: any[], data_da: string, id_tariffa_struttura: string) {
    return this.be.updDati('upd_tariffa_voci', {
      id_tariffa: idTariffa,
      dati: dati,
      data_da: data_da,
      id_tariffa_struttura: id_tariffa_struttura
    });
  }

  delTariffaVoci(id_tariffa_struttura: any) {
    return this.be.updDati('del_tariffa_struttura', { id_tariffa_struttura: id_tariffa_struttura });
  }

  getTariffa(idTariffa: string | number = -1) {
    return this.be.getDati('get_tariffa', { id_tariffa: idTariffa });
  }

  insTariffa(datiTariffa: any) {
    return this.be.updDati('ins_tariffa', datiTariffa);
  }

  updTariffa(datiTariffa: any) {
    return this.be.updDati('upd_tariffa', datiTariffa);
  }

  delTariffa(idTariffa: string | number) {
    return this.be.updDati('del_tariffa', { id_tariffa: idTariffa });
  }

  getCostoSimulato(quantita: number, parametri: any) {
    return this.be.updDati('get_costo_simulato', {
      quantita: quantita,
      parametri: parametri,
    });
  }

  getListaCalendari() {
    return this.be.getDati('get_lista_calendari', {});
  }

  getTipoListe() {
    return this.be.getDati('get_tipo_liste', {});
  }


  getFormatoListe() {
    return this.be.getDati('get_formato_import', {});
  }

  getStrutturaAsl(_params?: any) {
    return this.http
      .get(baseUri + 'api/getStrutturaAsl', { params: _params })
      .pipe(
        map((res: any) => {
          console.log('--- getStrutturaAsl response:');
          console.log(res);
          return res;
        })
      );
  }

  getStrutturaPiani(_params?: any) {
    return this.http
      .get(baseUri + 'api/getStrutturaPiani', { params: _params })
      .pipe(
        map((res: any) => {
          console.log('--- getStrutturaPiani response:');
          console.log(res);
          return res;
        })
      );
  }

  getExpConf() {
    return this.be.getDati('get_exp_conf');
  }

  getExpDati(idConf: number[]) {
    return this.be.getDati('get_exp_dati', { id: idConf });
  }

  getTariffarioPerRegole() {
    return this.be.getDati('get_tariffario_per_regole');
  }

  getTrfPerRegole(idTariffa: string | number) {
    return this.be.getDati('get_trf_per_regole', { id_tariffa: idTariffa });
  }

  updTrfPerRegole(idTariffa: string | number, operazioni: any[]) {
    return this.be.updDati('upd_trf_per_regole', {
      id_tariffa: idTariffa,
      operazioni: operazioni
    });
  }

  getTrfAttInviate() {
    return this.be.getDati('get_trf_att_inviate');
  }

  getMasterlist() { return this.be.getDati('get_master_list'); }

  getTariffaML(id: any) { return this.be.getDati('get_tariffa_ml', { id: id }); }

  updTariffaML(id: string, data: any) {
    return this.be.updDati('upd_tariffa_ml', { id: id, dati: data });
  }

  delTariffaML(id: string) { return this.be.updDati('del_tariffa_ml', { id: id }); }

  getUos() {
    return this.be.getDati('get_uos', { struct: "tree" });
  }

  getUosComuni(idStrutturaAsl: string | number | undefined) {
    return this.be.getDati('get_uos_comuni', {
      id_struttura_asl: idStrutturaAsl,
    });
  }

  getNominativiUos() {
    return this.be.getDati('get_nominativi_uos', { struct: 'tree' });
  }

  getNominativiComuni(id: string | number) {
    return this.be.getDati('get_nominativi_comuni', {
      id: id,
    });
  }

  getUoc() {
    return this.be.getDati('get_uoc', { struct: 'tree' });
  }

  getUocPiani(idStrutturaAsl: string | number) {
    return this.be.getDati('get_uoc_piani', {
      id_struttura_asl: idStrutturaAsl,
    });
  }

  getNsComuni(idStrutturaAsl: string | number) {
    return this.be.getDati('get_ns_comuni', {
      id_struttura_asl: idStrutturaAsl,
    });
  }

  getNsPiani(idNominativoStruttura: string | number) {
    return this.be.getDati('get_ns_piani', {
      id_nominativo_struttura: idNominativoStruttura,
    });
  }

  getTariffeExport() { return this.be.getDati('get_tariffe_export'); }


  /********************TIPOLISTA PIANI SERVICE **************/
  getTipoListaPiani(idTipoLista: string | number) {
    return this.be.getDati('get_tipolista_piani', {
      id_tipo_lista: idTipoLista,
    });
  }

  /*************************** TIPO LINEE SERVICES ****************************/
  getPiani() {
    return this.be.getDati('get_piani');
  }


  getTipoLinee(id_piano: string | number | undefined) {
    return this.be.getDati('get_tipo_linee_per_piani', {
      id_piano: id_piano
    });
  }

  updLineePiano(
    id_piano: string | number | undefined,
    id_linee: (string | number | undefined)[]
  ) {
    return this.be.updDati('upd_tipo_linee_per_piano', {
      id_piano: id_piano,
      id_tipo_linee: id_linee
    });
  }
  /****************************************************************************/

  /**************************** PIANI - FREQUENZE *****************************/
  getFrequenzePiano(id_piano: string | number | undefined) {
    return this.be.getDati('get_piano_freq', {
      id_piano: id_piano
    });
  }

  updPianoFreq(id_piano: string | number | undefined, piano_freq: any) {
    return this.be.updDati('upd_piano_freq', {
      id_piano: id_piano,
      piano_freq: piano_freq
    });
  }
  /****************************************************************************/

  /****************************** PERSONE - LINEE *****************************/
  getNSLinee(id_nominativo_struttura: string | number | undefined) {
    return this.be.getDati('get_ns_linee', {
      id_nominativo_struttura: id_nominativo_struttura
    });
  }

  updNSLinee(id_nominativo_struttura: number | undefined, id_linee: number[] | undefined) {
    return this.be.updDati('upd_ns_linee', {
      id_nominativo_struttura: id_nominativo_struttura,
      id_linee: id_linee
    });
  }
  /****************************************************************************/

  /***************************** PIANI - TARIFFE ******************************/
  getTariffarioPerPiani(id_piano: string | number | undefined) {
    return this.be.getDati('get_tariffario_per_piani', {
      id_piano: id_piano
    });
  }

  updTariffaPiano(id_piano: string | number | undefined, id_tariffa: string | number | undefined) {
    return this.be.updDati('upd_tariffa_piano', {
      id_piano: id_piano,
      id_tariffa: id_tariffa
    });
  }
  /****************************************************************************/

  /***************************** PIANO - PERIODO ******************************/
  getPianoPeriodo(id_piano: string | number | undefined) {
    return this.be.getDati('get_piano_periodo', {
      id_piano: id_piano
    });
  }

  updPianoPeriodo(id_piano: string | number | undefined, periodo: string) {
    return this.be.updDati('upd_piano_periodo', {
      id_piano: id_piano,
      periodo: periodo
    });
  }
  /****************************************************************************/

  /**************************** PIANO - OGGETTI *******************************/
  getPianoOggetti(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'cu/getDati', {
        params: { function: 'get_cu_tipi_oggetti_piano', args: JSON.stringify(args) },
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_cu_tipi_oggetti_piano') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  updPianoOggetti(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'cu/updDati', {
        function: 'upd_cu_tipi_oggetti_piano',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('upd_cu_tipi_oggetti_piano') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }
  /****************************************************************************/

  /**************************** PIANO - PROFILASSI*****************************/
  getPianiProfilassi(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'bdnfvg/getDati', {
        params: { function: 'get_piani_prof', args: JSON.stringify(args) },
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_piani_prof') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  updPianiProfilassi(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'bdnfvg/updDati', {
        function: 'upd_piano_profilassi',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('upd_piano_profilassi') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  /****************************************************************************/

  /***************************** PIANO - TIPOLOGIA CONTROLLO*******************/

  getPianoTipologiaControllo(id_piano: string | number | undefined) {
    return this.be.getDati('get_tipologia_controllo_piani', {
      id_piano: id_piano
    });
  }

  updPianoTipologiaControllo(id_piano: string | number | undefined, id_tipologia_controllo: string | number | number[]) {
    return this.be.updDati('upd_tipologia_controllo_piani', {
      id_piano: id_piano,
      id_tipologia_controllo: id_tipologia_controllo
    });
  }
  /****************************************************************************/

  /**************************** TIPOLOGIA STABILIMENTO *******************************/
  getTipologiaStrutturaStabilimento(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'cu/getDati', {
        params: { function: 'get_tipologie_struttura_stabilimento', args: JSON.stringify(args) },
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_tipologie_struttura_stabilimento') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }
  /****************************************************************************/

  /**************************** CATEGORIZZAZIONE RISCHIO *******************************/
  getCategorizzazioneRischioAlberi(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'cu/getDati', {
        params: { function: 'get_categorie_rischio_alberi', args: JSON.stringify(args) },
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_categorie_rischio_alberi') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  updCategorizzazioneRischioAlberi(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'cu/updDati', {
        function: 'upd_categorie_rischio_alberi',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('upd_categorie_rischio_alberi') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }
  /****************************************************************************/
  updUosComuni(idStrutturaAsl: string | number, idComuni: string[] | number[]) {
    return this.be.updDati('upd_uos_comuni', {
      id_struttura_asl: idStrutturaAsl,
      id_comuni: idComuni,
    });
  }

  updNsComuni(
    idNominativoStruttura: string | number,
    idStrutturaComune: string[] | number[]
  ) {
    return this.be.updDati('upd_ns_comuni', {
      id_nominativo_struttura: idNominativoStruttura,
      id_struttura_comune: idStrutturaComune,
    });
  }

  updUocPiani(
    idStrutturaAsl: string | number,
    idPiano: (string | number)[]
  ) {
    return this.be.updDati('upd_uoc_piani', {
      id_struttura_asl: idStrutturaAsl,
      id_piano: idPiano,
    });
  }

  updNsPiani(
    idNs: string | number,
    idPiano: (string | number)[]
  ) {
    return this.be.updDati('upd_ns_piani', {
      id_ns: idNs,
      id_piano: idPiano,
    });
  }

  updTipoListaPerPiano(
    idTipoLista: string | number,
    idPiano: (string | number)[]
  ) {
    return this.be.updDati('upd_tipo_lista_per_piano', {
      id_tipo_lista: idTipoLista,
      id_piano: idPiano,
    });
  }
  updClonaNsPiani(
    idNs: string | number,
    clone: (string | number)[]
  ) {
    return this.be.updDati('upd_clona_ns_piani', {
      id_ns: idNs,
      clone: clone,
    });
  }

  updClonaTipoLineePerPiano(
    idPiano: string | number,
    clone: (string | number)[]
  ) {
    return this.be.updDati('upd_clona_tipo_linee_per_piano', {
      id_piano: idPiano,
      clone: clone,
    });
  }

  getScarti(idFlusso: string | number) {
    return this.be.getDati('get_dettaglio_scarto_aziende', { id_flusso: idFlusso });
  }


  /***************************** WEB SERVICE CALL *****************************/
  /**
   * Effettua una richiesta SOAP inviando il WSDL, il metodo, username e
   * password.
   *
   * @param queryString Parametri da passare al WS per effettuare la call
   * @returns Ritorna i dati della chiamata
   */
  SOAPRequest(queryString: string): Observable<BackendResponse> {
    console.log("\n----- SOAP Request -----\n");
    return this.http.post(baseUri + 'api/soapRequest', { xml: queryString }).pipe(
      map((res: any) => {
        console.log("SOAP res:", res);
        return res;
      })
    );
  }
  /****************************************************************************/

  /****************************************************************************/

  /**************************** SOGGETTI FISICI *******************************/
  getSoggettiFisici(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'cu/getDati', {
        params: { function: 'get_cu_soggetti_fisici_by_sel', args: JSON.stringify(args) },
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_cu_soggetti_fisici_by_sel') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }
  getStabilimenti(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'cu/getDati', {
        params: { function: 'get_cu_stabilimenti_by_sel', args: JSON.stringify(args) },
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_cu_stabilimenti_by_sel') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getTipologieStruttura(): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'cu/getDati', {
        params: { function: 'get_tipologie_struttura_all', args: '{}' },
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_tipologie_struttura_all') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getAttivitaBySel(params : any) {
    return this.be.getDati('get_attivita_by_sel',params);
  }

  getTrfAttivitaInviateBySel(params: any) {
    return this.be.getDati('get_trf_att_inviate_by_sel',params);
  }
}
