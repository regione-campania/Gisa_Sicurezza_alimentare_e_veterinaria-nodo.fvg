/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ASmartTableComponent, LoadingDialogService } from '@us/utils';
//import { AppService } from 'src/app.service';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { TipoListeService } from './tipo-liste.service';
import { Router } from '@angular/router';
import { UserService } from '../user/user.service';

import Swal from 'sweetalert2';

@Component({
  selector: 'tipo-liste',
  templateUrl: './tipo-liste.component.html',
  styleUrls: ['./tipo-liste.component.scss']
})
export class TipoListeComponent implements OnInit {

  @ViewChild(ASmartTableComponent) tabella?: ASmartTableComponent;

  tipoliste?: any;
  gestoriliste?: any;
  _id_asl?: any;
  utenteASL = false;
  id_stabilimento = "";
  private _tipolisteSelezionate: any[] = [];
  private _ui?: any;
  private _ui_old?: any;
  private _ui_gestori?: any;
  operazione = 'Lista';
  disableAddButton = false;
  hideTipoProd = false;
  finestraTipoLista?: NgbModalRef;


  constructor(
    private app: TipoListeService,
    private modalEngine: NgbModal,
    private loadingService: LoadingDialogService,
    private router: Router,
    private us: UserService
  ) { }

  ngOnInit(): void {

    // this.loadUtente();
    this._initTipoListe();

  }


  private loadUtente() {
    this.us.getUser().subscribe((res: any) => {

      if (res.id_asl != null) {
        this._id_asl = res.id_asl;
        this.utenteASL = true;
        console.log("_initTipoListe this._id_asl :", this._id_asl);
        console.log("initTipoListe", this.utenteASL);
      }
      else {
        this.id_stabilimento = res.id_stabilimento;
      }
    });

  }

  private _initTipoListe() {
    this.loadingService.openDialog();

    this.us.getUser().subscribe((res: any) => {

      if (res.id_asl != null) {
        this._id_asl = res.id_asl;
        this.utenteASL = true;
        console.log("_initTipoListe this._id_asl :", this._id_asl);
        console.log("initTipoListe", this.utenteASL);
      }
      else {
        this.id_stabilimento = res.id_stabilimento;
      }
      this.app.getTipoListe(this._id_asl).subscribe((res: any) => {

        this.tipoliste = res.info.dati.map((d: any) => {
          let value = d['rif_tipo_prodotto'] == true ? "SI" : "NO";
          d['rif_tipo_prodotto'] = value;
          return d;
        });
        //  this._ui = res.info.ui;

        if (this._ui_old == null) {
          this._ui = res.info.ui;
          this._ui_old = this._ui;
        } else {
          this._ui = this._ui_old;
        }
        console.log("this._ui-colonne:", res.info.ui.colonne);
      });
      this.loadingService.closeDialog();

    });


    this.app.getGestori().subscribe((res: any) => {
      console.log(res);

      this._ui_gestori = res.info.ui;
      this.gestoriliste = res.info.dati;
      console.log("getGestori:", this._ui_gestori);
    });


  }


  // getter methods
  get configurazioneSelezionate() { return this._tipolisteSelezionate; }

  get ui() { return this._ui; }

  deleteTipoLista(idTipoLista: any) {
    console.log("idTipoLista:", idTipoLista);
    this.app.deleteTipoListe(idTipoLista).subscribe((res: any) => {
      console.log("res:", res.msg);
      if (res.esito) {
        this._initTipoListe();

      } else {

        Swal.fire({
          icon: 'warning',
          title: 'Attenzione',
          text: res.msg
        });
        return;
      }
    });
  }






  openPopup(event: any, modalRef: any, op: string) {
    event.preventDefault();
    event.stopPropagation();
    console.log("operazione" + op);
    this.hideTipoProd = false;
    return this.modalEngine.open(modalRef, { modalDialogClass: 'system-modal' });
  }

  closePopup() {
    this.hideTipoProd = false;
    this.finestraTipoLista?.close();
    // this.modalEngine.dismissAll();
  }

  hide(event: any) {

    const gestore: string = (<HTMLInputElement>document.querySelector('input[name="gestore"]:checked')).value;
    if (gestore == "1") {
      this.hideTipoProd = false;
    }
    else {
      this.hideTipoProd = true;
    }
  }

  save(event: any) {

    this.disableAddButton = true;
    var gestore = "";
    const descr: string = (<HTMLInputElement>document.getElementById('descr')).value;
    var rifTipoProd = "";


    if (descr.trim() === "") {
      console.log("descr trim()");

      Swal.fire({
        icon: 'warning',
        title: 'Attenzione! Inserire la descrizione.`'

      });

      this.disableAddButton = false;
      return;
    }



    if (<HTMLInputElement>document.querySelector('input[name="gestore"]:checked') != null) {
      gestore = (<HTMLInputElement>document.querySelector('input[name="gestore"]:checked')).id;
    }
    if (gestore.trim() === "") {
      Swal.fire({
        icon: 'warning',
        title: 'Attenzione! Inserire il gestore.'
      });
      this.disableAddButton = false;
      return;
    }


    if (<HTMLInputElement>document.querySelector('input[name="rifTipoProd"]:checked') != null) {
      rifTipoProd = (<HTMLInputElement>document.querySelector('input[name="rifTipoProd"]:checked')).value;
    }
    if (gestore.trim() === "1") { rifTipoProd = "false"; }
    if (gestore.trim() === "2" && rifTipoProd === "") {
      Swal.fire({
        icon: 'warning',
        title: ' Attenzione! Inserire se legata al tipo prodotto .'
      });
      this.disableAddButton = false;
      return;
    }



    this.closePopup();
    this.disableAddButton = false;
    this.app.insTipoListe(descr.trim(), gestore.trim(), rifTipoProd).subscribe((res: any) => {
      console.log(res);
      this._initTipoListe();

    });




  }



  onClick(tipolista: any): void {
    console.log("onclick");
    console.log("tipolista gestore:", tipolista.abilitatoimport);
    this.router.navigate(['user/lista'], {
      queryParams: { idTipoLista: tipolista.id, descr: tipolista.descr, rifTipoProdotto: tipolista.rif_tipo_prodotto }
    });

  }

}
