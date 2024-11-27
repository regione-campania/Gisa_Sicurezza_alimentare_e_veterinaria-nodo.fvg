/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core';
import { BdnfvgService } from 'src/app/portals/bdnfvg/bdnfvg.service';

@Injectable()
export class CapiInStallaService {
  constructor(private client: BdnfvgService) { }

  getCapiInStalla(funcName: string, params: any = {}) {
    return this.client.getDati(funcName, params);
  }

  updCapiInStalla(funcName: string, params: any = {}) {
    return this.client.updDati(funcName, params);
  }

  getWSBDNParams(funcName: string, params: any = {}) {
    return this.client.getDati(funcName, params);
  }

  getSOAPRequest(params: any = {}) {
    let queryString = Object.keys(params).map(key => key + '=' + params[key]).join('&');
    console.log("queryString:", queryString);
    return this.client.SOAPRequest(queryString);
  }

  generatePDF(params: any = {}) { return this.client.generatePDF(params); }
  reportPDF(params: any = {}) { return this.client.PDFGiornaliero(params); }
  getPDF(params: any = {}) { return this.client.getPDF(params); }
}
