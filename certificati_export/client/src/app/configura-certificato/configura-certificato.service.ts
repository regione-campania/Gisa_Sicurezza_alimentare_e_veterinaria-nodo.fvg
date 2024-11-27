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
export class ConfiguraCertificatoService {
    constructor(
        private http: HttpClient,
        private client: CertificatiExportService
    ) { }

    insertModuloCampi(params: any = {}) {
        return this.client.updDati('insert_modulo_campi', params);
    }

    eliminaCertificato(params: any = {}) {
        return this.client.updDati('elimina_certificato', params);
    }

    memorizzaPDFConfigurato(params: any = {}) {
        return this.http.post<any>(`${baseUri}ce/memorizzaPdfConfigurato`, params);
    }
}
