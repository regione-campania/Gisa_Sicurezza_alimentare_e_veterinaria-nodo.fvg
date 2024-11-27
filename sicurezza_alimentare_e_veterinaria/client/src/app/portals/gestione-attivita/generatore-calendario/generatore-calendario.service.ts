/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core';
import { BackendCommunicationService } from '@us/utils';

@Injectable({
  providedIn: 'root'
})
export class GeneratoreCalendarioService {

  constructor(private client: BackendCommunicationService) { }

  getCalendario(idElabCal: number) {
    return this.client.getDati('get_calendario', { id_elab_cal: idElabCal });
  }

  getCalendarioInfo(idElabCal: number) {
    return this.client.getDati('get_calendario_info', { id_elab_cal: idElabCal });
  }

  annullaElabCal(idElabCal: number) {
    return this.client.updDati('annulla_elab_cal', { id_elab_cal: idElabCal });
  }

  generaCalendario(idElabCal: number) {
    return this.client.updDati('genera_calendario', { id_elab_cal: idElabCal });
  }

  riversaCalendario(idElabCal: number) {
    return this.client.updDati('riversa_calendario', {
      id_elab_cal: idElabCal,
    });
  }

  riversaAttivitaCalendario(idAttivita: number[]) {
    return this.client.updDati('riversa_calendario', {
      id_attivita: idAttivita,
    });
  }

  getCalRiepiloghi(idElabCal: number) {
    return this.client.getDati('get_cal_riepiloghi', { id_elab_cal: idElabCal });
  }

  getCalRiepilogo(idElabCal: number) {
    return this.client.getDati('get_cal_riepilogo', { id_elab_cal: idElabCal });
  }

  getCalRiepilogoLinee(idElabCal: number) {
    return this.client.getDati('get_cal_riepilogo_linee', {
      id_elab_cal: idElabCal,
    });
  }

  getLineeCalendario(idElabCal: number) {
    return this.client.getDati('get_linee_calendario', {
      id_elab_cal: idElabCal,
    });
  }

  getNominativiCalendario(idElabCal: number) {
    return this.client.getDati('get_nominativi_calendario', {
      id_elab_cal: idElabCal,
    });
  }

  attAssociaLinea(idLinea: number, idAttivita: number[]) {
    return this.client.updDati('upd_att_associa_linea', {
      id_linea: idLinea,
      id_attivita: idAttivita,
    });
  }

  attEliminaLinea(idAttivita: number[]) {
    return this.client.updDati('att_elimina_linea', {
      id_attivita: idAttivita,
    });
  }

  updAttAssociaNominativo(idNominativo: number, idAttivita: number[]) {
    return this.client.updDati('upd_att_associa_nominativo', {
      id_nominativo: idNominativo,
      id_attivita: idAttivita,
    });
  }

  attEliminaNominativo(idAttivita: number[]) {
    return this.client.updDati('att_elimina_nominativo', {
      id_attivita: idAttivita,
    });
  }

  updEvAssociaPartner(idPartner: string, idEvento: string[]) {
    return this.client.updDati('upd_ev_associa_partner', {
      id_partner: idPartner,
      id_evento: idEvento
    })
  }

  updAttAssociaPartner(idPartner: string, idAttivita: string[]) {
    return this.client.updDati('upd_att_associa_partner', {
      id_partner: idPartner,
      id_attivita: idAttivita
    })
  }

  updEvEliminaPartner(idEvento: string[]) {
    return this.client.updDati('upd_ev_elimina_partner', {
      id_evento: idEvento
    })
  }

  updAttEliminaPartner(idAttivita: string[]) {
    return this.client.updDati('upd_att_elimina_partner', {
      id_attivita: idAttivita
    })
  }

  attCambiaData(
    dateOrShift: string | { shift: number; shiftType: 'giorni' | 'mesi' | 'settimane' },
    idAttivita: number[]
  ) {
    let args;
    if (typeof dateOrShift === 'string')
      args = { data: dateOrShift, id_attivita: idAttivita };
    else
      args = {
        shift: dateOrShift.shift,
        shift_type: dateOrShift.shiftType,
        id_attivita: idAttivita,
      };
    return this.client.updDati('upd_att_cambia_data', args);
  }

  attEliminaData(idAttivita: number[]) {
    return this.client.updDati('att_elimina_data', { id_attivita: idAttivita });
  }

  attAssociaValidita(validoDa: string, validoA: string, idAttivita: number[]) {
    return this.client.updDati('upd_att_associa_validita', {
      valido_da: validoDa,
      valido_a: validoA,
      id_attivita: idAttivita,
    });
  }

  attEliminaValidita(idAttivita: number[]) {
    return this.client.updDati('att_elimina_validita', { id_attivita: idAttivita });
  }

  getElabNsPiani(idElabCal: number) {
    return this.client.getDati('get_elab_ns_piani', { id_elab_cal: idElabCal });
  }

  updElabNsPiani(idElabCal: number, ns: any[] = [], piani: any[] = []) {
    return this.client.updDati('upd_elab_ns_piani', {
      id_elab_cal: idElabCal,
      ns: ns,
      piani: piani,
    });
  }

  getElabLinee(idElabCal: number) {
    return this.client.getDati('get_elab_linee', { id_elab_cal: idElabCal });
  }

  updElabLinee(idElabCal: number, lineeSelezionate: any[] = []) {
    return this.client.updDati('upd_elab_linee', {
      id_elab_cal: idElabCal,
      id_linea_piani: lineeSelezionate,
    });
  }

  getElabCalParams(idElabCal: number) {
    return this.client.getDati('get_elab_cal_params', { id_elab_cal: idElabCal });
  }

  updElabCalParams(idElabCal: number, params: { tag: string, val: string }[]) {
    return this.client.updDati('upd_elab_cal_params', {
      id_elab_cal: idElabCal,
      params: params,
    });
  }

  getElabLog(idElabCal: number) {
    return this.client.getDati('get_elab_log', { id_elab_cal: idElabCal });
  }

  // TODO: Da modificare
  loadLineeXLS() { return this.client.updDati('load_linee_xls') }
}
