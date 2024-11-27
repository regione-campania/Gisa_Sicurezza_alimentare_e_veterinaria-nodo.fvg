/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { baseUri, environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class PdfRiepilogoService {

  constructor(
    private http: HttpClient
  ) { }

  downloadRiepilogoStab(stabilimento: any, nuovoPdf: any, tipoDocumento: any): Observable<Blob> {
    return this.http.request<any>('POST', baseUri + `verbali_cu/getRiepilogoStabilimento?descrizioneVerbale=${tipoDocumento}&nuovoPdf=${nuovoPdf}`,
      { body: stabilimento, responseType: 'blob' as 'json' })
  }
}
