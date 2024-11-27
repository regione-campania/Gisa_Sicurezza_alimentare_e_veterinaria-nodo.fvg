/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/


import { Component,  OnInit , ViewChild} from '@angular/core';

import { NgbModal } from '@ng-bootstrap/ng-bootstrap';

import {LoadingDialogService, BackendCommunicationService, NotificationService} from '@us/utils';

import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'listadet',
  templateUrl: './listadet.component.html',
  styleUrls: ['./listadet.component.scss']
})
export class ListaDetComponent implements OnInit {
  @ViewChild('content') content: any;

  ui: any = null;
  listaDati= [];
  listaSelezionata: any = null;

 
    closeResult!: string;
   _idLista: string = "";
   _descr: string = "";
  
  constructor(
    private loadingService: LoadingDialogService,
    private modalEngine: NgbModal,
    private bc: BackendCommunicationService,
    private route: ActivatedRoute,
    private notificationService: NotificationService,
  ) { }
 
  /* open() {
    // and use the reference from the component itself
    this.modalEngine.open(this.content).result.then((result) => {
        this.closeResult = `Closed with: ${result}`;
    }, (reason) => {
        console.log(reason);
    });
} */
 
   
ngOnInit(): void {
  this.route.queryParams.subscribe(params =>{
   
 // this.getdettaglio( params['idLista'],params['formato']);
})
}

 

 getdettaglio( id_lista:any,formato:any){
  
    this.loadingService.openDialog('Caricamento in corso');
    //this.route.queryParams.subscribe((params: any) => {
   //   console.log("params", params);
     // let formato= params['formato'];
      this.idLista= id_lista;
      
      let funzione='get_cf_allevamenti';

      if(formato==1){
        funzione ='get_cf_allevamenti';
        console.log("funzione", funzione);
       }
       if(formato==2){
        funzione='get_import_formato_linea';        
        console.log("funzione", funzione);
       }     
     
      
       

      this.bc.getDati(funzione, { id_lista: this._idLista}).subscribe((risultato: any) => {
        console.log("funzione:", funzione);
        this.loadingService.closeDialog();
        console.log("risultato:", risultato);

   
        if (!risultato.esito) {
          this.loadingService.closeDialog();
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Non sono presenti dati.'
          });
          return;
        }
        
 
        this.ui = risultato.info.ui;
        this.listaDati = risultato.info.dati;        
        this.loadingService.closeDialog();
      //})
    }) 
  }


  public set idLista(val:string){
    this._idLista= val;
  }
  public get idLista(){
    
    return this._idLista;
  }

  public set descr(val:string){
    this._descr=val;
  }
 
  public get descr(){
    return this._descr;
  }
 
  
}
