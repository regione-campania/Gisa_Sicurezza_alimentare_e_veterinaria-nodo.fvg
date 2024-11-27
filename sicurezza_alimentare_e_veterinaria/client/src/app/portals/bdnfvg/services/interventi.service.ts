/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core'
import { BdnfvgService } from 'src/app/portals/bdnfvg/bdnfvg.service';
import { LoadingDialogService } from '@us/utils';
import { Observable } from 'rxjs/internal/Observable';
import { HttpClient } from '@angular/common/http';
import { baseUri } from 'src/environments/environment';

@Injectable()
export class InterventiService {

  constructor(
    private loadingService: LoadingDialogService,
    private client: BdnfvgService,
  ) { }

  /************************************ GET ***********************************/
  getInterventi() {
    this.loadingService.openDialog("Caricamento Interventi...");
    return this.client.getDati('get_interventi');
  }

  getInterventiNote(id_intervento: number) {
    return this.client.getDati('get_interventi_note', {
      id_intervento: id_intervento
    });
  }

  getInterventiFiltered(id_allevamento: number) {
    return this.client.getDati('get_interventi_per_allevamenti', {
      id_allevamento: id_allevamento
    });
  }

  getInfoIntervento(id_intervento: number) {
    return this.client.getDati('get_info_intervento', {
      id_intervento: id_intervento
    });
  }

  getPiani() {
    this.loadingService.openDialog('Caricamento Piani...');
    return this.client.getDati('get_piani');
  }

  getRisultati(id_intervento: number) {
    this.loadingService.openDialog('Caricamento Risultati...');
    return this.client.getDati('get_risultati', {
      id_intervento: id_intervento
    });
  }

  getQualificheSanitarie(idIntervento: number) {
    return this.client.getDati('get_qualifiche_sanitarie', {
      id_intervento: idIntervento
    });
  }

  insertInfoSanitarie(params: any) {
    return this.client.insertInfoSanitarie(params);
  }

  getCapiGiornata(id_intervento: number, id_giornata: number) {
    return this.client.getDati('get_capi_giornata', {
      id_intervento: id_intervento, id_giornata: id_giornata
    });
  }

  getPoolGiornata(id_giornata: number, id_intervento: number) {
    return this.client.getDati('get_pool_giornata', {
      id_giornata: id_giornata,
      id_intervento: id_intervento
    });
  }

  getCapiPool(pool: string) {
    return this.client.getDati('get_capi_pool', {
      pool: pool
    });
  }

  getGiornate(id_intervento: number) {
    return this.client.getDati('get_giornate', {
      id_intervento: id_intervento
    });
  }

  getListaPiani() {
    this.loadingService.openDialog('Caricamento Piani...');
    return this.client.getDati('get_lista_piani');
  }

  /*
  getAllevamentiPiano(id_piano: number) {
    return this.client.getDati('get_piano_allevamenti', { id_piano: id_piano });
  }
  */

  getAllevamentiPiani(selected_piani: number[]) {
    return this.client.getDati('get_piano_allevamenti', { selected_piani: selected_piani });
  }

  getAziendePiani(selected_piani: number[], idStrutturaRoot: number) {
    return this.client.getDati('get_piano_aziende', { selected_piani: selected_piani, id_struttura_root: idStrutturaRoot });
  }

  getVeterinari(data_inizio: string, idStrutturaRoot: number | string) {
    return this.client.getDati('get_veterinari_carico', {
      data_inizio: data_inizio,
      id_struttura_root: idStrutturaRoot
    });
  }

  getBarcodes(params: any = {}) {
    return this.client.generatePDF(params);
  }

  PDFGiornaliero(params: any = {}) {
    return this.client.PDFGiornaliero(params);
  }

  getPDF(params: any = {}) { return this.client.getPDF(params); }

  getPDFFromDB(params: any = {}) { return this.client.getPDFFromDB(params); }

  getLaboratori(params: any = {}) {
    return this.client.getDati('get_laboratori', params);
  }

  getMatriciIntervento(id_intervento: number, id_giornata: number) {
    return this.client.getDati('get_matrici_intervento', {
      id_intervento: id_intervento,
      id_giornata: id_giornata
    });
  }

  getMatriceGiornata(id_giornata: number) {
    return this.client.getDati('get_matrice_giornata', {
      id_giornata: id_giornata
    });
  }

  getTipoDettaglio(id_giornata: number) {
    return this.client.getDati('get_tipo_dettaglio', {
      id_giornata: id_giornata
    });
  }

  generaRiepilogoIntervento(params: any) {
    return this.client.riepilogoPDF(params);
  }
  /****************************************************************************/

  /********************************* UPDATES **********************************/

  creaIntervento(piani_selezionati: number[], id_allevamento: number, dt: string, dt_fine: string, veterinari: number[]) {
    return this.client.updDati('crea_intervento', {
      piani_selezionati: piani_selezionati,
      id_allevamento: id_allevamento,
      dt: dt,
      dt_fine: dt_fine,
      veterinari: veterinari,
    });
  }

  creaInterventoAzienda(piani_selezionati: number[], id_azienda:number, id_allevamento_per_cal: number, dt: string, dt_fine: string, veterinari: number[]) {
    return this.client.updDati('crea_intervento', {
      piani_selezionati: piani_selezionati,
      id_azienda: id_azienda,
      id_allevamento: id_allevamento_per_cal,
      dt: dt,
      dt_fine: dt_fine,
      veterinari: veterinari,
    });
  }

  chiudiIntervento(params: any = {}) {
    return this.client.updDati('chiudi_intervento',params);
  }
  
  updInterventoApri(params: any = {}) {
    return this.client.updDati('upd_intervento_apri', params);
  }

  updInterventoNote(params: any = {}) {
    return this.client.updDati('upd_intervento_note', params);
  }
  
  deleteIntervento(params: any = {}) {
    return this.client.updDati('upd_del_intervento', params);
  }

  insGiornata(id_intervento: number, data: string | null, idTipoMetodo: number, idMatrice: number, idAllevamento: number) {
    return this.client.updDati('ins_giornata', {
      id_intervento: id_intervento,
      dt: data,
      id_matrice: idMatrice,
      id_tipo_metodo: idTipoMetodo,
      id_allevamento: idAllevamento
    });
  }

  updGiornate(tipo_dettaglio: string, id_intervento: number, id_giornata: number, dt: string, dati: any[]) {
    return this.client.updDati('upd_giornate', {
      tipo_dettaglio: tipo_dettaglio,
      id_intervento: id_intervento,
      id_giornata: id_giornata,
      dt: dt,
      dati: dati
    });
  }

  updRisultati(dati: any) {
    return this.client.updDati('upd_risultati', dati);
  }

  updInterventoEsito(id_intervento: number, id_tipo_esito: number) {
    return this.client.updDati('upd_intervento_esito', {
      id_intervento: id_intervento,
      id_tipo_esito: id_tipo_esito
    });
  }

  updRisultatoCapo(id_capo_intervento: number, id_piano: number, risultato: any, tipo: string) {
    return this.client.updDati('upd_capo_risultato',{
      id_intervento_capi: id_capo_intervento,
      id_piano: id_piano,
      risultato: risultato,
      tipo: tipo
    })
  }

  unlockRisultati(idRisultato: any, tipo: any){
    return this.client.updDati('unlock_risultati',{
      id_intervento_capi: idRisultato,
      tipo: tipo
    })
  }

  updPool(params: any = {}) {
    return this.client.updDati('upd_pool', params);
  }

  updPoolPiani(params: any = {}) {
    return this.client.updDati('upd_pool_piani', params);
  }

  deletePool(codice_pool: string, id_giornata: number) {
    return this.client.updDati('delete_pool', { codice_pool: codice_pool, id_giornata: id_giornata });
  }

  updPrinted(id_capi: number[]) {
    return this.client.updDati('upd_printed', { id_capi: id_capi });
  }

  /*inviaPreacc(id_intervento: number) {
    return this.client.updDati('invia_preacc', { id_intervento: id_intervento });
  }*/

  

  insEventoCalendario(vet: number[], inizioIntervento: any, fineIntervento: any, idIntervento: number, piani: number[], nominativi_struttura: number []) {
    return this.client.updDati('ins_evento_calendario', {
      vet: vet,
      inizio_intervento: inizioIntervento,
      fine_intervento: fineIntervento,
      id_intervento: idIntervento,
      id_piani: piani,
      nominativi_struttura: nominativi_struttura
    });
  }
  /****************************************************************************/

  /********************************** ISZVE ***********************************/
  callIZSVEJob() { return this.client.callIZSVEJob(); }
  /****************************************************************************/
}
