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
export class allegaFileCU {
    constructor(
        private http: HttpClient,
        //private be: BackendCommunicationService
    ) { }
    AllegaPDF(file: File, id_modulo: number, descr_modulo: string) {
        const formData = new FormData();
        formData.append("file", file, file.name);
        return this.http.post<any>(`${baseUri}cu/AllegaPDF?id_modulo=` + id_modulo + '&descr_modulo=' + descr_modulo, formData);
    }

    getPDFAllegati(id_modulo: number, descr_modulo: string) {
        return this.http.post<any>(`${baseUri}cu/getPdfAllegati?id_modulo=` + id_modulo + '&descr_modulo=' + descr_modulo, null);
    }

    EliminaPDF(id: number) {
        return this.http.post<any>(`${baseUri}cu/EliminaPDF?id=` + id, null);
    }

    DownloadPDF(id: any): Observable<HttpResponse<Blob>> {

        return this.http.request<any>('POST', `${baseUri}cu/DownloadPDF?id=` + id,
            { observe: 'response', responseType: 'blob' as 'json' })
    }
}