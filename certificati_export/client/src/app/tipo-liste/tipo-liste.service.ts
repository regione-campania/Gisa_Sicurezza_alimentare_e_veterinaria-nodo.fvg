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
export class TipoListeService {
  constructor(
    private http: HttpClient,
    private be: CertificatiExportService
  ) { }


  getTipoListe(idasl:any) {
    console.log("sono in gettipoliste"+idasl);
  //  getTipoListe() {
    return this.be.getDati('get_liste', {id_asl: idasl });
 // return this.be.getDati('get_liste', {});
  }
 
  getGestori() {
    return this.be.getDati('get_gestori_liste', {});
  }
    getDettaglioTipoListe(idTipoLista:any, idStab:any) {
      console.log("id"+idTipoLista);
      return this.be.getDati('get_valori_by_id_lista', { id_lista: idTipoLista, id_stabilimento:idStab});
    }

  deleteTipoListe(idTipoLista:any) {
    return this.be.updDati(`del_lista`, { id: idTipoLista });
  }


  insTipoListe(descrizione:any,gestore:any,rifTipoProd:string) {
    console.log("insTipoListe descrizione"+descrizione);
    return this.be.updDati('ins_lista',{descr:descrizione,gest:gestore,legatoTipoProd:rifTipoProd});
 }
 
 loadImportLista(idLista:number, datiDaCaricare:any) {
  console.log("load_import_lista");
  console.log("datiDaCaricare"+datiDaCaricare);
  console.log("idLista"+idLista);
 return this.be.updDati('load_import_lista',  {id_lista: idLista, lista: datiDaCaricare});  
     
  
}
loadImportListaRecord(idLista:number, datiDaCaricare:any,idstab:string) {
  console.log("loadImportListaRecord");
  console.log("datiDaCaricare"+datiDaCaricare);
  console.log("idLista"+idLista);
 return this.be.updDati('load_import_record',  {id_lista: idLista, lista: datiDaCaricare,id_stabilimento:idstab});  
     
  
}
deleteRecordLista(idLista:number, recordDaEliminare:any) {
  console.log("deleteRecordLista");
  console.log("recordDaEliminare"+recordDaEliminare);
  console.log("idLista"+idLista);
 return this.be.updDati('delete_lista_record',  {id_lista: idLista, lista: recordDaEliminare});  
     
  
}
}
