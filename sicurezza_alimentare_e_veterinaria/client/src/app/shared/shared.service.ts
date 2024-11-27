/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core';
import { BackendCommunicationService } from '@us/utils';
import { baseUri } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class SharedService {

  constructor(
    private be: BackendCommunicationService
  ) { }

  getMenu(endpoint: string, menu: string) {
    this.prepareUri(endpoint);
    return this.be.getDati('get_menu', { menu: menu});
  }

  getFormDefinition(endpoint: string, functionName: string) {
    this.prepareUri(endpoint);
    return this.be.getDati('get_form_definition', { funct: functionName })
  }

  getAgTipoEventi() {
    this.prepareUri('api/');
    return this.be.getDati('get_ag_tipo_eventi');
  }

  insEvento(data: {
    id_tipo_evento: string,
    id_ns: string,
    inizio: string,
    fine: string,
    id_piano?: string,
    id_linea?: string,
    id_stabilimento?: string,
    id_partner?: string
  }) {
    this.prepareUri('api/');
    return this.be.updDati('ins_evento', data);
  }

  getNs() {
    this.prepareUri('api/');
    return this.be.getDati('get_ns');
  }

  getPianiByNs(idNs: string, idTipoEvento: string) {
    this.prepareUri('api/');
    return this.be.getDati('get_piani_by_ns', {
      id_ns: idNs,
      id_tipo_evento: idTipoEvento
    })
  }

  getLineeByNsPiano(idNs: string, idPiano: string) {
    this.prepareUri('api/');
    return this.be.getDati('get_linee_by_ns_piano', {
      id_ns: idNs,
      id_piano: idPiano
    })
  }

  getAzSedi() {
    this.prepareUri('api/');
    return this.be.getDati('get_az_sedi');
  }

  //helper
  prepareUri(path: string) {
    this.be.baseUri = baseUri + path;
  }

}
