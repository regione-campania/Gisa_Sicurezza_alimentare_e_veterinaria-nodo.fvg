/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { baseUri } from "src/environments/environment";
import { CertificatiExportService } from "../../certificati-export.service";

@Injectable({
  providedIn: 'root'
})
export class ValidaUtentiService {
  constructor(
    private http: HttpClient,
    private client: CertificatiExportService
  ) { }

  getUtentiDaValidare() {
    return this.client.getDati('get_utenti_da_validare', {});
  }

  updValidaUtenti(params: any = {}) {
    return this.client.updDati('upd_valida_utenti', params);
  }

  spedisciEmail(email_da_validare: string[]) {
    return this.http.get<any>(`${baseUri}ce/sendEmailUtenteValidato?emailDaValidare=${JSON.stringify(email_da_validare)}`);
    // return this.http.get<any>(`${baseUri}ce/sendEmailUrgenza?idCertificato=${id_certificato}`);
  }
}
