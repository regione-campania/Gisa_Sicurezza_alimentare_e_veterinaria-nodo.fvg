/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core'
import { baseUri } from 'src/environments/environment';
import { map, Observable } from 'rxjs';
import { BackendCommunicationService, BackendResponse } from '@us/utils';

@Injectable()
export class BdnfvgService {

  constructor(
    private http: HttpClient,
    private be: BackendCommunicationService
  ) { }

  getDati(funcName: string, args: any = {}): Observable<BackendResponse> {
    return this.be.getDati(funcName, args);
  }

  updDati(functionName: string, args: any = {}): Observable<BackendResponse> {
    return this.be.updDati(functionName, args);
    //baseUri + 'bdnfvg/updDati'
  }

  getMenu(menu: string) {
    return this.be.getDati('get_menu', { menu: menu });
  }

  SOAPRequest(queryString: string): Observable<BackendResponse> {
    console.log("----- bdrfvgService -----");
    return this.http.get(baseUri + 'bdnfvg/soapRequest?' + queryString).pipe(
      map((res: any) => {
        console.log("SOAP res:", res);
        return res;
      })
    )
  }
  
  invioSanan(id_intervento: number | string): Observable<BackendResponse> {
    console.log("----- bdrfvgService -----");
    return this.http.get(baseUri + 'bdnfvg/invioSanan?id_intervento=' + id_intervento).pipe(
      map((res: any) => {
        console.log("Sanan res:", res);
        return res;
      })
    )
  }

  PDFGiornaliero(params: any = {}): Observable<HttpResponse<Blob>> {
    return this.http.request<any>('POST', baseUri + 'bdnfvg/PDF_Giornaliero', { body: params, observe: 'response', responseType: 'blob' as 'json' });
  }

  generatePDF(params: any = {}): Observable<HttpResponse<Blob>> {
    return this.http.request<any>('POST', baseUri + 'bdnfvg/generatePDF', { body: params, observe: 'response', responseType: 'blob' as 'json' });
  }

  riepilogoPDF(params: any = {}): Observable<HttpResponse<Blob>> {
    return this.http.request<any>('POST', baseUri + 'bdnfvg/riepilogoPDF', { body: params, observe: 'response', responseType: 'blob' as 'json' });
  }

  getPDF(params: any = {}): Observable<HttpResponse<Blob>> {
    return this.http.request<any>('POST', baseUri + 'bdnfvg/getPDF', { body: params, observe: 'response', responseType: 'blob' as 'json' });
  }

  getPDFFromDB(params: any = {}): Observable<HttpResponse<Blob>> {
    return this.http.request<any>('POST', baseUri + 'bdnfvg/getPDFFromDB', { body: params, observe: 'response', responseType: 'blob' as 'json' });
  }

  insertInfoSanitarie(params: any): Observable<BackendResponse> {
    return this.http.request<any>('POST', baseUri + 'bdnfvg/insertInfoSanitarie', { body: params })
  }

  getRdpFirmato(rdpCod: any){
    window.location.href = baseUri + 'preaccettazione/getRdpFirmato?rdpcod=' + rdpCod;
  }

  // ---------------------------------- ISZVE ----------------------------------
  callIZSVEJob(): Observable<BackendResponse> {
    return this.http.get(baseUri + 'preaccettazione/izsveJob').pipe(
      map((res: any) => {
        return res;
      })
    )
  }
  // ---------------------------------------------------------------------------
}
