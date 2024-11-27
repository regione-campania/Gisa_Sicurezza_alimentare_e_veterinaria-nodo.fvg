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
export class ControlliUfficialiService {
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

  getTipiProvvedimenti(idNorma: string | number, idTipoOggetto: string | number) {
    return this.be.getDati('get_cu_tipi_provv', { "id_norma": idNorma, "id_tipo_oggetto": idTipoOggetto })
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

  getNominativoProvvedimenti(idCu: string | number) {
    return this.be.getDati('get_cu_nominativo_provv', { "id_cu": +idCu })
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
  checkAutomezziCT(idCu: string | number) {
    return this.be.getDati('cu_check_automezzi', { "id_cu": +idCu })
  }

  checkStabilimentoCU(idCu: string | number) {
    return this.be.getDati('cu_check_stabilimento', { "id_cu": +idCu })
  }

  checkCategoriaRischioCU(idCu: string | number) {
    return this.be.getDati('cu_check_categoria_rischio', { "id_cu": +idCu })
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

  getCategRischio() {
    return this.be.getDati('get_categ_rischio')
  }

  getCategRischioCU(idCu: string | number) {
    return this.be.getDati('get_cu_categ_eval', { id_cu: +idCu })
  }

  updCategRischioCU(params: any) {
    return this.be.updDati('upd_cu_categ_eval', params)
  }

  getImpreseBySel(params: any) {
    return this.be.getDati('get_cu_imprese_by_sel', params)
  }

  getStabilimentiBySel(params: any) {
    return this.be.getDati('get_cu_stabilimenti_by_sel', params)
  }

  getImpresaSingolo(id_impresa: any) {
    return this.be.getDati('get_cu_impresa_singolo', { "id_impresa": +id_impresa })
  }

  getStabilimentoSingolo(id_stabilimento: any) {
    return this.be.getDati('get_cu_stabilimento_singolo', { "id_stabilimento": +id_stabilimento })
  }

  updImpresa(params: any) {
    return this.be.updDati('upd_cu_imprese', params)
  }

  addImpresa(params: any) {
    return this.be.updDati('upd_cu_add_impresa', params)
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

  getSoggettiBySel(params: any) {
    return this.be.getDati('get_cu_soggetti_fisici_by_sel', params)
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

  updFirmatarioVerbale(params: any) {
    return this.be.updDati('upd_cu_firmatario_verbale', params)
  }

  getIndirizziTrasportatori(idCu: any) {
    return this.be.getDati('get_cu_indirizzi_trasportatori', { id_cu: +idCu })
  }

  getAutomezziStabilimento(params: any) {
    return this.be.getDati('get_cu_stabilimento_automezzi', params)
  }

  getAutomezziCU(idCu: any) {
    return this.be.getDati('get_cu_automezzi', { id_cu: +idCu })
  }

  addAutomezzi(params: any) {
    return this.be.updDati('upd_add_automezzi', params)
  }

  delAutomezzo(idAutomezzo: any) {
    return this.be.updDati('upd_del_automezzo', { id_automezzo: idAutomezzo })
  }

  getCuDurataCuBySel(params: any) {
    return this.be.getDati('get_cu_durata_cu_by_sel',params)
  }
}
