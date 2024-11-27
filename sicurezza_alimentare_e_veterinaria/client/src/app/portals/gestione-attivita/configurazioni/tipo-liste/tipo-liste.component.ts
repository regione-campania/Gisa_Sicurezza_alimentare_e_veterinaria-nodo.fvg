/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Input,OnInit, ViewChild } from '@angular/core';
import { ASmartTableComponent, BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';
import { GestioneAttivitaService } from 'src/app/portals/gestione-attivita/gestione-attivita.service';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { ActivatedRoute, Router } from '@angular/router';
import { InfoStrutturaPrimaria } from '../types';

import Swal from 'sweetalert2';
import { TipoListaPianiComponent } from './tipolista-piani/tipolista-piani.component';
import { ListaComponent } from './lista/lista.component';
import { AppService } from 'src/app/app.service';
@Component({
  selector: 'tipo-liste',
  templateUrl: './tipo-liste.component.html',
  styleUrls: ['./tipo-liste.component.scss']
})
export class TipoListeComponent implements OnInit {

  @ViewChild(ASmartTableComponent) tabella?: ASmartTableComponent;
  @Input() info?: InfoStrutturaPrimaria;
  @ViewChild('tipolistapiani') tipolistapiani!: TipoListaPianiComponent;
  @ViewChild('configuraliste') configuraliste!: ListaComponent;
  tipoliste?: any;
  formatoliste?: any;
  isRuoloAbilitato?:boolean=false;
  private _tipolisteSelezionate: any[] = [];
  private _ui?: any;
  private _ui_old?: any;
  private _formato_ui?: any;
  operazione = 'Lista';
  disableAddButton = false;

  constructor(
    private gs: GestioneAttivitaService,
    private client: BackendCommunicationService,
    private notificationService: NotificationService,
    private modalEngine: NgbModal,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private router: Router,
    private app: AppService
  ) { }

  ngOnInit(): void {

    this.loadUtente();
    this.loadFormatoListe();
    this._initTipoListe();

  }

  private loadUtente() {
    this.app.getUser().subscribe((res: any) => {
      if( res.id_ruolo == 0) {
       this.isRuoloAbilitato=true;

      }
     });
  }

  private loadFormatoListe() {
    this.gs.getFormatoListe().subscribe((res) => {
      console.log(res);
  //    console.log("this._ui:", this._ui);
      this._formato_ui = res?.info?.ui;
      this.formatoliste = res?.info?.dati;

    });
  }

  private _initTipoListe() {

    this.loadingService.openDialog();
    this.gs.getTipoListe().subscribe((res) => {
      console.log(res);
     //this.tipoliste = res?.info?.dati;
      //this._ui = res?.info?.ui;
    // console.log("this._ui:", this._ui);
     // this.tipoliste=null;
     // this._ui=null;
      this.tipoliste = res.info.dati;

     if( this._ui_old==null){
      this._ui = res.info.ui;
      this._ui_old=this._ui ;
    }else{
      this._ui =this._ui_old;
    }
     //this.gs.storage.setItem('tipoliste', this.tipoliste);
     this.loadingService.closeDialog();
    });


  }


  // getter methods
  get configurazioneSelezionate() { return this._tipolisteSelezionate; }

  get ui() { return this._ui; }

  deleteTipoLista(idTipoLista: any) {
    console.log("idTipoLista:", idTipoLista);

    this.client .updDati(`del_tipo_lista`, { id: idTipoLista })
      .subscribe((res: any) => {
        if(res.esito){

          this._initTipoListe();

        }else{

          Swal.fire({
            icon: 'warning',
            title: 'Attenzione'    ,
            text:res.msg
          });
         return;
        }

      });
  }



  openPopup(event: any, modalRef: any, op: string) {
    console.log("operazione"+op);
    return this.modalEngine.open(modalRef, { modalDialogClass: 'system-modal' });
  }

  finestraTipoLista?: NgbModalRef;

  closeProva() {
    this.finestraTipoLista?.close();
  }

  closePopup() {
 //   this.modalEngine.dismissAll();
   // this._initTipoListe();
   this.finestraTipoLista?.close();
  }

  closePopupPiani() {
    this.finestraTipoLista?.close();
    this._initTipoListe();
  }

  save(event: any) {
    event.preventDefault();
    console.log("formato");

    const descr: string = (<HTMLInputElement>document.getElementById('descr')).value;
    const cod: string = (<HTMLInputElement>document.getElementById('cod')).value;
    var formato ="";


    if (descr.trim() === "") {
      this.notificationService.push({
        notificationClass: 'error',
        content: `Attenzione! Inserire la descrizione.`
      });
      this.disableAddButton = false;
      return;
    }

    if (cod.trim() === "") {
      this.notificationService.push({
        notificationClass: 'error',
        content: `Attenzione! Inserire il codice.`
      });
      this.disableAddButton = false;
      return;
    }
    console.log("prova sono qui " );
    console.log("prova",(<HTMLInputElement>document.querySelector('input[name="formato"]:checked ')) );
  //

    if ((<HTMLInputElement>document.querySelector('input[name="formato"]:checked ')) ==null) {
      this.notificationService.push({
        notificationClass: 'error',
        content: `Attenzione! Inserire il formato.`
      });
      this.disableAddButton = false;
      return;
    }
    else{
      formato=(<HTMLInputElement>document.querySelector('input[name="formato"]:checked')).id;
    }


    let dataToSend = {
      descr: descr,
      cod: cod,
      formato:formato,
    };
    this.closePopup();
    this.disableAddButton = false;

   this.client
      .updDati(`ins_tipo_lista`, dataToSend)
      .subscribe((res: any) => {
        console.log(res);

        this._initTipoListe();


      });
  }


  onClick(tipolista:any): void {
    console.log("onclick");
    console.log("tipolista:", tipolista);



      this.router.navigate(
        ["./lista"],
        {relativeTo: this.route, queryParams:  { idTipoLista: tipolista.id_tipo_lista ,descrTipoLista:tipolista.descr,formato:tipolista.formato,formato_descr:tipolista.formato_descr}}
      );


  }

  public get infoPiani() {
    return this.info?.struttureAssociate.find(s => s.label == 'Tipo Liste Piani');
  }





  openPopupConfiguraListe(event: any, tipolista:any,tag_configura: any) {

    this.configuraliste = tag_configura;
    console.log("tipolista",tipolista);
    this.configuraliste.getConfiguraListe(tipolista);


  }

  closePopupConfiguraListe() {
    console.log("closePopupConfiguraListe");
    this.modalEngine.dismissAll();
     this._initTipoListe();
  }

  openPopupAssociaPiani(event: any, tipolista:any,tag_associa_piani: any) {

    this.tipolistapiani = tag_associa_piani;
     this.tipolistapiani.getTipoListaPiani(tipolista);


  }

  closePopupAssociaPiani() {
    console.log("closePopupAssociaPiani");
    this.modalEngine.dismissAll();
    this._initTipoListe();
  }

  // configuraPiani(tipolista:any): void {
  //   console.log("onclick");
  //   console.log("configuraPiani:", tipolista);



  //     this.router.navigate(
  //       ["./tipolistapiani"],
  //       {relativeTo: this.route, queryParams:  { idTipoLista:tipolista.id_tipo_lista}}
  //     );


  // }

}
