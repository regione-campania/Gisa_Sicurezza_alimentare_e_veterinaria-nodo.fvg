/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BackendCommunicationService, NotificationService } from '@us/utils';
import { baseUri, environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class AppService {

  /** Referenza all'environment corrente */
  get env() {
    return environment;
  }

  constructor(
    private http: HttpClient,
    private be: BackendCommunicationService,
    public notification: NotificationService
  ) { }

  getUser() {
    return this.http.get<any>(baseUri + 'um/getUser');
  }

  getAmbiente() {
    return this.http.get<any>(baseUri + 'um/getAmbiente');
  }

  getNominativiUos() {
    return this.be.getDati('get_nominativi_uos', { struct: 'tree' });
  }

  getNominativiUosByAsl() {
    return this.be.getDati('get_nominativi_uos_by_asl', { struct: 'tree' });
  }


  getManuali() {
    return this.be.getDati('get_manuali');
  }

  downloadManuale(manuale: string) {
    return this.http.request<any>('POST', baseUri + 'manuali/' + manuale, {
      observe: 'response',
      responseType: 'blob' as 'json',
    });
  }

}
