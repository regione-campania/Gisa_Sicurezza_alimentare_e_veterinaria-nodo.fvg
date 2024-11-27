/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { BackendCommunicationService, BackendResponse } from "@us/utils";
import { map, Observable } from "rxjs";
import { baseUri } from "src/environments/environment";

@Injectable()
export class ConfigurazioniService {
  constructor(
    private http: HttpClient,
    private be: BackendCommunicationService) { }

  getMenu(menu: string) {
    return this.be.getDati('get_menu', { menu: menu });
  }

  getRuoli() {
    return this.be.getDati('get_ruoli');
  }

  getRuoloSingolo(id_ruolo: number) {
    return this.be.getDati('get_ruolo_singolo', { id_ruolo: +id_ruolo });
  }

  getRuoliPermessi(id_ruolo: number) {
    return this.be.getDati('get_ruoli_permessi', { id_ruolo: +id_ruolo });
  }

  getRuoloRuoli(id_ruolo: number) {
    return this.be.getDati('get_ruolo_ruoli', { id_ruolo: id_ruolo });
  }

  getUtenti() {
    return this.be.getDati('get_utenti');
  }

  getUtentiForStruttura(id_struttura: number) {
    return this.be.getDati('get_utenti_for_struttura', { id_struttura: +id_struttura });
  }

  getUtentiRuoli(cf: any) {
    return this.be.getDati('get_utente_ruoli', { cf: cf });
  }

  getUtenteSingolo(id_utente: any) {
    return this.be.getDati('get_utente_singolo', { id_utente: id_utente });
  }

  getRuoliUtente(id_utente_struttura: number) {
    return this.be.getDati('get_ruoli_utente', { id_utente_struttura: +id_utente_struttura });
  }

  insRuoliUtente(id_utente: number, id_ruoli: number | any[]) {
    return this.be.updDati('upd_ins_ruoli_utente', { id_utente: +id_utente, id_ruoli: id_ruoli })
  }

  delRuoliUtente(id_utente: number, id_ruolo: number | any) {
    return this.be.updDati('upd_del_ruoli_utente', { id_utente: +id_utente, id_ruolo: id_ruolo })
  }

  getSezioni(id_ruolo: number | any) {
    return this.be.getDati('get_sezioni', { id_ruolo: +id_ruolo });
  }

  getModalita() {
    return this.be.getDati('get_modalita');
  }

  insRuoloPermessi(id_ruolo: number, id_modalita: number, id_sezione: number | any[]) {
    return this.be.updDati('upd_ins_ruolo_permesso', { id_ruolo: id_ruolo, id_modalita: id_modalita, id_sezione: id_sezione })
  }

  delRuoloPermesso(id_ruolo_permesso: number, id_permesso: number) {
    return this.be.updDati('upd_del_ruolo_permesso', { id_ruolo_permesso: id_ruolo_permesso, id_permesso: id_permesso })
  }

  getRuoloRuoliForAdd(id_ruolo_cte: number) {
    return this.be.getDati('get_ruolo_ruoli_for_add', { id_ruolo_cte: id_ruolo_cte })
  }

  insRuoloRuoli(id_ruolo: number, id_ruoli_cti: number | any[]) {
    return this.be.updDati('upd_ins_ruolo_ruoli', { id_ruolo: +id_ruolo, id_ruoli_cti: id_ruoli_cti })
  }

  delRuoloRuoli(id_ruolo_ruoli: number) {
    return this.be.updDati('upd_del_ruolo_ruoli', { id_ruolo_ruoli: id_ruolo_ruoli })
  }

  getPermessi(id_ruolo: number) {
    return this.be.getDati('get_permessi', { id_ruolo: +id_ruolo })
  }

  updModalitaSezione(params: any) {
    return this.be.updDati('upd_modalita_sezione', params)
  }

  getTipiOperazioni() {
    return this.be.getDati('get_tipi_operazioni')
  }

  getOperazioniBySel(params: any) {
    return this.be.getDati('get_operazioni_by_sel', params)
  }

  getDettaglioOperazioni(id_transazione: number, vista: any, identificativo: any) {
    return this.be.getDati('get_dettaglio_operazione', { id_transazione: id_transazione, vista: vista, identificativo: identificativo });
  }

  getOperazioneSingolo(id_transazione: number) {
    return this.be.getDati('get_operazione_singolo', { id_transazione: id_transazione });
  }

  getPianiTotali(): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_piani_totali', args: '{}' }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_piani_totali') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getPianoSingolo(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_piano_singolo', args: JSON.stringify(args) }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_piano_singolo') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  insPiano(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'api/updDati', {
        function: 'ins_piano',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('ins_piano') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  updPiano(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'api/updDati', {
        function: 'upd_piano',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('upd_piano') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  movePianoOrdinamento(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'api/updDati', {
        function: 'move_piano_ordinamento',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('move_piano_ordinamento') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getPianiTotaliSpostamento(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_piani_totali_spostamento', args: JSON.stringify(args) }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_piani_totali_spostamento') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  movePiano(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'api/updDati', {
        function: 'move_piano',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('move_piano') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getStruttureAslSingolo(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_strutture_asl_singolo', args: JSON.stringify(args) }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_strutture_asl_singolo') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getOrganigrammaRisorse(): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_risorse', args: '{}' }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_risorse') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getOrganigrammaRisorsaSingolo(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'api/getDati', {
        params: { function: 'get_risorsa_singolo', args: JSON.stringify(args) }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_risorsa_singolo') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  insAsl(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'api/updDati', {
        function: 'ins_asl',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('ins_asl') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  updAsl(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'api/updDati', {
        function: 'upd_asl',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('upd_asl') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  updDelAsl(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'api/updDati', {
        function: 'upd_del_asl',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('upd_del_asl') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  insRisorsa(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'api/updDati', {
        function: 'ins_risorsa',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('ins_risorsa') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  updDelRisorsa(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'api/updDati', {
        function: 'upd_del_risorsa',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('upd_del_risorsa') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  updDelPiano(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'api/updDati', {
        function: 'upd_del_piano',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('upd_del_piano') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  moveAslOrdinamento(args: any = {}): Observable<BackendResponse> {
    return this.http
      .post(baseUri + 'api/updDati', {
        function: 'move_asl_ordinamento',
        args: JSON.stringify(args),
      })
      .pipe(
        map((res: any) => {
          console.log(`--- upd_dati('move_asl_ordinamento') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  getStruttureAsl() {
    return this.be.getDati('get_strutture_asl')
  }

  checkEsisteCF(params: any) {
    return this.be.getDati('check_esiste_cf', params)
  }

  getSoggettiBySel(params: any) {
    return this.be.getDati('get_cu_soggetti_fisici_by_sel', params)
  }

  getQualifiche() {
    return this.be.getDati('get_qualifiche')
  }

  aggiungiUtente(params: any) {
    return this.be.updDati('upd_add_utente', params)
  }

  modificaUtente(params: any) {
    return this.be.updDati('upd_upd_utente', params)
  }

  getUtentiBySel(params: any) {
    return this.be.getDati('get_utenti_by_sel', params)
  }

  getStruttureByAsl(idAsl: number) {
    return this.be.getDati('get_strutture_by_asl', { id_asl: idAsl })
  }

  aggiungiStrutturaUtente(params: any) {
    return this.be.updDati('upd_add_struttura_utente', params)
  }

  modificaStrutturaUtente(params: any) {
    return this.be.updDati('upd_upd_struttura_utente', params)
  }

  getStruttureUtente(idUtente: number) {
    return this.be.getDati('get_utente_strutture', { id_utente: idUtente })
  }

  getStruttureUtenteSingolo(id: number) {
    return this.be.getDati('get_utente_strutture_singolo', { id_utente_struttura: id })
  }

  upsertUtenteStrutturaRuolo(params: any) {
    return this.be.updDati('upd_utente_struttura_ruolo', params)
  }

  getRiepilogoCU(params: any) {
    return this.be.getDati('get_riepilogo_cu', params)
  }

  addRuolo(params: any) {
    return this.be.updDati('upd_add_ruolo', params)
  }

  updRuolo(params: any) {
    return this.be.updDati('upd_upd_ruolo', params)
  }
}
