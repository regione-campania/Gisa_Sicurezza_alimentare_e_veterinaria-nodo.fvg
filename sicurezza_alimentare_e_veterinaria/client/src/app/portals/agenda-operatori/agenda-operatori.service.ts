/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core';
import { BackendCommunicationService, BasicStorage } from '@us/utils';

@Injectable()
export class AgendaOperatoriService {

  storage = new BasicStorage();

  constructor(
    private be: BackendCommunicationService,
  ) { }

  getMenu(menu: string) {
    return this.be.getDati('get_menu', { menu: menu});
  }

  /**
   * Ritorna la lista delle risorse.
   */
  getCalendari() {
    return this.be.getDati('get_agende');
  }

  /**
   * Ritorna la lista delle attività dell'utente loggato.
   */
  getEventiStruttura() {
    return this.be.getDati('get_eventi_struttura');
  }

  getNs() {
    return this.be.getDati('get_ns');
  }

  getLinee() {
    return this.be.getDati('get_linee');
  }

  getPianiByNs(idNs: string, idTipoEvento: string) {
    return this.be.getDati('get_piani_by_ns', {
      id_ns: idNs,
      id_tipo_evento: idTipoEvento
    })
  }

  getLineeByNsPiano(idNs: string, idPiano: string) {
    return this.be.getDati('get_linee_by_ns_piano', {
      id_ns: idNs,
      id_piano: idPiano
    })
  }

  updEvElimina(idEvento: string[] | number[]) {
    return this.be.updDati('upd_ev_elimina', {
      id_evento: idEvento.map(id => +id) //mappa gli id nel tipo number
    })
  }

  updEvAssociaLinea(idLinea: string, idEvento: string[] | number[]) {
    return this.be.updDati('upd_ev_associa_linea', {
      id_linea: idLinea,
      id_evento: idEvento
    })
  }

  updEvEliminaLinea(idEvento: string[] | number[]) {
    return this.be.updDati('upd_ev_elimina_linea', {
      id_evento: idEvento
    })
  }

  updEvAssociaNominativo(idNominativo: string, idEvento: string[] | number[]) {
    return this.be.updDati('upd_ev_associa_nominativo', {
      id_nominativo: idNominativo,
      id_evento: idEvento
    })
  }

  updEvAssociaPartner(idPartner: string, idEvento: string[] | number[]) {
    return this.be.updDati('upd_ev_associa_partner', {
      id_partner: idPartner,
      id_evento: idEvento
    })
  }

  updEvEliminaPartner(idEvento: string[] | number[]) {
    return this.be.updDati('upd_ev_elimina_partner', {
      id_evento: idEvento
    })
  }

  updEvCambiaData(
    dateOrShift: string | { shift: number; shiftType: 'giorni' | 'mesi' | 'settimane' },
    idEvento: string[] | number[]
  ) {
    let args;
    if (typeof dateOrShift === 'string')
      args = { data: dateOrShift, id_evento: idEvento };
    else
      args = {
        shift: dateOrShift.shift,
        shift_type: dateOrShift.shiftType,
        id_evento: idEvento,
      };
    return this.be.updDati('upd_ev_cambia_data', args);
  }

  updEvAssociaValidita(validoDa: string, validoA: string, idEvento: string[] | number[]) {
    return this.be.updDati('upd_ev_associa_validita', {
      valido_da: validoDa,
      valido_a: validoA,
      id_evento: idEvento
    })
  }

  updEvEliminaValidita(idEvento: string[] | number[]) {
    return this.be.updDati('upd_ev_elimina_validita', {
      id_evento: idEvento
    })
  }

  insEvento(data: {
    id_tipo_evento: string,
    id_ns: string,
    id_piano: string,
    id_linea: string,
    inizio: string,
    fine: string
  }) {
    return this.be.updDati('ins_evento', data);
  }

  creaCuFromEvento(idEvento: string | number) {
    return this.be.getDati('crea_cu_from_evento', { id_evento: idEvento })
  }

  creaContrUffFromEvento(idEvento: string | number) {
    return this.be.updDati('crea_contr_uff_from_evento', { id_evento: +idEvento });
  }

  getUos() {
    return this.be.getDati('get_uos', { struct: "tree" });
  }

  getAgTipoEventi() {
    return this.be.getDati('get_ag_tipo_eventi');
  }

  getNominativiCarico() {
    return this.be.getDati('get_nominativi_carico');
  }

  getAgConf() {
    return this.be.getDati('get_ag_conf');
  }
}
