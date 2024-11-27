/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient, HttpHeaders, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core'
import { baseUri } from 'src/environments/environment';
import { map, Observable } from 'rxjs';
import { BackendCommunicationService, BackendResponse } from '@us/utils';

@Injectable({
  providedIn: "root"
})
export class anagraficaUnicaService {
  constructor(
    private http: HttpClient,
    //private be: BackendCommunicationService
  ) { }
  //chiamata servizio ricercaAnagrafica di tipo Soap passando l'oggetto come input.
  //Viene fatta nel file js anagraficaunica.js
  ricercaAnagrafica(params: any = {}): Observable<BackendResponse> {
    //Trasformazione dell'oggetto in una query string per la chiamata http
    let queryString = Object.keys(params).map(key => key + '=' + params[key]).join('&');
    //Chiamata http al server con url + query string
    return this.http
      .get(baseUri + 'anagraficaunica/ricerca?' + queryString)
      .pipe(
        map((res: any) => {
          //Costruzione del JSON per la creazione della tabella lato client
          res.info = {
            ui: {
              colonne: [{
                campo: "Nome",
                editabile: false,
                intestazione: "Nome",
                tipo: "text",
              },
              {
                campo: "Cognome",
                editabile: false,
                intestazione: "Cognome",
                tipo: "text",
              },
              {
                campo: "CodiceFiscale",
                editabile: false,
                intestazione: "Codice Fiscale",
                tipo: "text",
              }]
            },
            dati: res.Anagrafica
          };
          return res;
        })
      );
  }


  dettaglioCompletoImpresa(piva: any): Observable<BackendResponse> {
    return this.http
      .get(baseUri + 'anagraficaunica/parixDettaglioCompletoImpresa?piva=' + piva)
      .pipe(
        map((res: any) => {
          return res;
        })
      );
  }

  // bonificaPARIXImprese(piva: any): Observable<BackendResponse> {
  //   return this.http.request<any>('POST', baseUri + `anagraficaunica/parixBonificaImpresa`,
  //     { body: piva })
  //     .pipe(
  //       map((res: any) => {
  //         return res;
  //       })
  //     );
  //   }

  // ---------------------------------------------------------------------------
}
