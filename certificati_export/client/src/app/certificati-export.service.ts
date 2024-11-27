/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient } from "@angular/common/http";
import { Injectable } from '@angular/core';
import { baseUri } from "src/environments/environment";
import { map, Observable } from 'rxjs';
import { BackendResponse } from "@us/utils";

@Injectable({
  providedIn: 'root'
})
export class CertificatiExportService {

  constructor(private http: HttpClient) { }

  getDati(funcName: string, args: any = {}): Observable<BackendResponse> {
    return this.http.get(baseUri + 'ce/getDati', {
      params: { function: funcName, args: JSON.stringify(args) },
    }).pipe(
      map((res: any) => {
        console.log(`--- get_dati('${funcName}') response: `, res);
        if (res === null) res = { esito: false, value: null, msg: null, info: false };
        if (res.info === null) res.info = res.esito;
        else res.info = JSON.parse(res.info);
        return res;
      })
    );
  }

  updDati(funcName: string, args: any = {}): Observable<BackendResponse> {
    console.log("baseUri"+funcName);
    console.log("args"+args); 
    return this.http.post(baseUri + 'ce/updDati', {
      function: funcName, args: JSON.stringify(args),
    }).pipe(
      map((res: any) => {
        console.log(`--- upd_dati('${funcName}') response: `, res);
        if (res === null) res = { esito: false, value: null, msg: null, info: false };
        if (res.info === null) res.info = res.esito;
        else res.info = JSON.parse(res.info);
        return res;
      })
    )
  }

  getUserInfo() {
    return this.http.post<any>(`${baseUri}um/getUser`, null);
  }
}
