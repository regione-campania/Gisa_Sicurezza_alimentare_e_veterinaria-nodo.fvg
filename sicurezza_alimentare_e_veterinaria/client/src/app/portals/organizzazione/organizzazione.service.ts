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
export class OrganizzazioneService {
  constructor(
    private http: HttpClient,
    private be: BackendCommunicationService) { }

  //RICORDARSI CHE LE FUNZIONI GIRANO SOTTO AGENDA

  getMenu(menu: string) {
    return this.be.getDati('get_menu', { menu: menu });
  }

  getPianiTotali() {
    return this.be.getDati('get_piani_totali');
  }

  getPianoSingolo(params: any) {
    return this.be.getDati('get_piano_singolo', params);
  }

  insPiano(params: any) {
    return this.be.updDati('ins_piano', params);
  }

  updPiano(params: any) {
    return this.be.updDati('upd_piano', params);
  }

  movePianoOrdinamento(params: any) {
    return this.be.updDati('move_piano_ordinamento', params);
  }

  getPianiTotaliSpostamento(params: any) {
    return this.be.getDati('get_piani_totali_spostamento', params)
  }

  movePiano(params: any) {
    return this.be.updDati('move_piano', params)
  }

  getStruttureAsl() {
    return this.be.getDati('get_strutture_asl');
  }

  getStruttureAslSingolo(params: any) {
    return this.be.getDati('get_strutture_asl_singolo',params);
  }


  getOrganigrammaRisorse() {
    return this.be.getDati('get_risorse');
  }

  getOrganigrammaRisorsaSingolo(params: any) {
    return this.be.getDati('get_risorsa_singolo', params);
  }

  getUtentiForStruttura(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'rbac/getDati', {
        params: { function: 'get_utenti_for_struttura', args: JSON.stringify(args) }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_utenti_for_struttura') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  insAsl(params: any) {
    return this.be.updDati('ins_asl',params);
  }

  updAsl(params: any) {
    return this.be.updDati('upd_asl',params);
  }

  updDelAsl(params: any) {
    return this.be.updDati('upd_del_asl', params);
  }


  insRisorsa(params: any) {
    return this.be.updDati('ins_risorsa',params);
  }

  getStruttureUtente(args: any = {}): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'rbac/getDati', {
        params: { function: 'get_strutture_utente', args: JSON.stringify(args) }
      })
      .pipe(
        map((res: any) => {
          console.log(`--- get_dati('get_strutture_utente') response: `, res);
          if (res === null) res = { esito: false, value: null, msg: null, info: false };
          if (res.info === null) res.info = res.esito;
          else res.info = JSON.parse(res.info);
          return res;
        })
      );
  }

  updDelRisorsa(params: any) {
    return this.be.updDati('upd_del_risorsa', params);
  }

  updDelPiano(params: any) {
    return this.be.updDati('upd_del_piano',params);
  }

  moveAslOrdinamento(params: any) {
    return this.be.updDati('move_asl_ordinamento',params);
  }

}
