/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpResponse, HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { LoadingDialogService } from '@us/utils';
import { environment } from 'src/environments/environment';

@Injectable()
export class DocumentiService {

    constructor(
        private http: HttpClient,
        private ls: LoadingDialogService
    ) { }

    generaPdf(descrModulo: string, idModulo: number, filename: string, data: any) {
        let url = `${environment.protocol}://${environment.host}:${environment.port}/${environment.root}documenti/generaPdf?descrModulo=${descrModulo}&idModulo=${idModulo}&filename=${filename}`;
        console.log(url);
        try{
            this.ls.openDialog('Generazione PDF in corso');
            this.http.request<any>('POST', url,
                { body: data, observe: 'response', responseType: 'blob' as 'json' }).subscribe(data => {
                    this.download(data);
                    this.ls.closeDialog();
                })
        }catch(err){
            this.ls.closeDialog();
            console.log(err);
        }
    }

    download(data: any) {
        console.log(data);
        let body = data.body;
        let fileName = data.headers.get('content-disposition').split('filename="')[1].replaceAll('"', '');
        const url = URL.createObjectURL(body);
        const a = document.createElement('a');
        a.href = url;
        a.download = fileName ?? '';
        a.click();
        setTimeout(function () {
            a.remove();
            URL.revokeObjectURL(url);
        }, 100);
    }

}
