/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { baseUri } from 'src/environments/environment';

@Injectable()
export class ImportaMovimentazioniService {
  constructor(private http: HttpClient) { }

  importaMovimentazioni(params: any = {}): Observable<HttpResponse<Blob>> {
    return this.http.request<any>('POST', baseUri + 'bdnfvg/importaMovimentazioni', {
      body: params,
      observe: 'response',
      responseType: 'json'
    });
  }
}
