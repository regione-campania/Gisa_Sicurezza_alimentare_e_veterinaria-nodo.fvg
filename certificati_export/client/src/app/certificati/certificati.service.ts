/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core'
import { HttpClient } from '@angular/common/http';
import { baseUri } from 'src/environments/environment';
import { CertificatiExportService } from '../certificati-export.service';


@Injectable({
  providedIn: "root"
})
export class CertificatiService {

  constructor(
    private http: HttpClient,
    private client: CertificatiExportService
  ) { }

  getDati(funzione: string, args?: any) {
    if (!args)
      args = '';
    else
      args = JSON.stringify(args);
    return this.http.get<any>(`${baseUri}ce/getDati?function=${funzione}&args=${args}`);
  }

  getListaCertificati() {
    return this.http.get<any>(`${baseUri}ce/getListaCertificati`);
  }

  getInfoCertificato(idCC: string) {
    return this.http.get<any>(`${baseUri}ce/getInfoCertificato?idCertificatoCompilato=${idCC}`);
  }

  getStatiCertificatoProssimo(idCC?: string) {
    return this.http.get<any>(`${baseUri}ce/getStatiCertificatoProssimo?idCertificatoCompilato=${idCC}`);
  }

  getTipiCertificato() {
    return this.http.get<any>(`${baseUri}ce/getTipiCertificato`);
  }

  getCampiByModulo(idModulo: any, idModuliAllegati: any[]) {
    return this.http.get<any>(`${baseUri}ce/getCampiByModulo?idModulo=${idModulo}&idModuliAllegati=${idModuliAllegati}`);
  }

  getCampiByIdCertificatoCompilato(idCertificatoCompilato: any) {
    return this.http.get<any>(`${baseUri}ce/getCampiByIdCertificatoCompilato?idCertificatoCompilato=${idCertificatoCompilato}`);
  }

  compilaCertificato(idModulo: any, idModuliAllegati: any[], valori: any, idCertificatoCompilato: any, calcoloAPosteriori?: boolean) {
    return this.http.post<any>(`${baseUri}ce/compilaCertificato?idModulo=${idModulo}&idModuliAllegati=${idModuliAllegati}&idCertificatoCompilato=${idCertificatoCompilato}&calcoloAPosteriori=${calcoloAPosteriori ?? false}`, { valori: valori }).toPromise();
  }

  salvaCertificato(datiCertificato: any, saveValues?: boolean) {
    return this.http.post<any>(`${baseUri}ce/salvaCertificato?saveValues=${saveValues != undefined ? true : false}`, datiCertificato);
  }

  updateCertificato(certificato: any = {}) {
    return this.http.post<any>(`${baseUri}ce/updateCertificato`, certificato);
  }

  sendEmailUrgenza(id_certificato: any) {
    return this.http.get<any>(`${baseUri}ce/sendEmailUrgenza?idCertificato=${id_certificato}`);
  }

  sendEmailEliminazione(id_certificato: any) {
    return this.http.get<any>(`${baseUri}ce/sendEmailEliminazione?idCertificato=${id_certificato}`);
  }

  duplicaCertificato(func: string, args: any = {}) {
    return this.http.post<any>(`${baseUri}ce/updDati`, {
      function: func,
      args: JSON.stringify(args)
    });
  }

  rilasciaCertificato(file: File, certificato: any = {}) {
    console.log("file:", file);
    console.log("certificato:", certificato);
    const formData = new FormData();
    formData.append("file", file, file.name);
    formData.append("certificato", JSON.stringify(certificato));
    return this.http.post<any>(`${baseUri}ce/rilasciaCertificato`, formData);
  }

  getTreeDenominazioneProdotti(params: any = {}) {
    return this.client.getDati('get_tree_denominazione_prodotti', params);
  }

  caricaPdfDaConfigurare(file: File){
    const formData = new FormData();
    formData.append("file", file, file.name);
    return this.http.post<any>(`${baseUri}ce/caricaPdfDaConfigurare`, formData);

  }

  async chiudiAttivita(idCertificatoCompilato: any){
    try{
      return await this.http.get<any>(`${baseUri}ce/chiudiAttivita?idCertificatoCompilato=${idCertificatoCompilato}`).toPromise();
    }catch(error){
      console.log(error);
      throw error;
    }
  }

  async inviaDatiTariffazione(datiTariffazione: any){
    try{
      return await this.http.post<any>(`${baseUri}ce/inviaDatiTariffazione`, datiTariffazione).toPromise();
    }catch(error){
      console.log(error);
      throw error;
    }
  }

}
