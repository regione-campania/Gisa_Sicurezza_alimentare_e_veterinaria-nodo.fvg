/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { baseUri } from "src/environments/environment";
import { CertificatiExportService } from "../certificati-export.service";

@Injectable({
  providedIn: 'root'
})
export class GestioneDelegheService {
  constructor(
    private http: HttpClient,
    private client: CertificatiExportService
  ) { }

  getUtentiStabilimento(id_stabilimento: number) {
    return this.client.getDati('get_access_stabilimenti', { id_stabilimento: id_stabilimento });
  }

  updAccessStabilimento(id_access_stabilimento: number, valido_da: string, valido_a: string, cf: string, nome: string, cognome: string) {
    return this.client.updDati('upd_access_stabilimento', {
      id_access_stabilimento: id_access_stabilimento,
      data_da: valido_da,
      data_a: valido_a,
      cf: cf,
      nome: nome,
      cognome: cognome
    });
  }

  insAccessStabilimento(dati: any = {}) {
    return this.client.updDati('ins_access_stabilimento', {...dati});
  }

  delAccessStabilimento(id_access_stabilimento: number) {
    return this.client.updDati('del_access_stabilimento', {
      id_access_stabilimento: id_access_stabilimento
    });
  }

  getContacts() { return this.client.getDati('get_contacts'); }

  getUser() {
    return this.http.post<any>(`${baseUri}um/getUser`, null);
  }
}
