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
import { GestioneAttivitaService } from "../gestione-attivita.service";

@Injectable({
  providedIn: "root"
})
export class AttivitaInviateService {
  constructor(
    private be: BackendCommunicationService,
    private http: HttpClient,
  ) { }

  inviaPrestazioniSicer(params: any = {}): Observable<BackendResponse> {
    console.log("entrato nel servizio")
    let queryString = Object.keys(params).map(key => key + '=' + params[key]).join('&');
    console.log("querystring: ", queryString);
    return this.http
      .get(baseUri + 'fatturazione/inviaPrestazioniSicer?' + queryString)
      .pipe(
        map((res: any) => {
          //Costruzione del JSON per la creazione della tabella lato client
          console.log("res servizio: ", res);
          return res;
        })
      );
  }


}
