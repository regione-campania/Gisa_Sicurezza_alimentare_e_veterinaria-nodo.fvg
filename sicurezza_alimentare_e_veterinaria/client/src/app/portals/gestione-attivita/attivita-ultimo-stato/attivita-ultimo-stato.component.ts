/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-attivita-ultimo-stato',
  templateUrl: './attivita-ultimo-stato.component.html',
  styleUrls: ['./attivita-ultimo-stato.component.scss']
})
export class AttivitaUltimoStatoComponent implements OnInit {
  private _id_att_inviata?: any;
  private _uiUltimoStato?: any;
  private _retDatiUltimoStato?: any;
  private _ui?: any;
  private _retDati?: any;
  private _ar: any;
  modaleDettaglio?: NgbModalRef;
  @ViewChild('templateModaleDettaglio') dettaglioTemplate!: TemplateRef<any>
  constructor(
    private route: ActivatedRoute,
    private client: BackendCommunicationService,
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private modalEngine: NgbModal,
  ) { }
  ngOnInit(): void {
    this.route.queryParams.subscribe((res: any) => {
      console.log("id attivita inviata: ", res['id_att_inviata']);
      this._id_att_inviata = res['id_att_inviata'];
    })
    //Tabella per l'ultimo stato di un'attività
    this.client.getDati('get_trf_att_inviate_ultimo_stato', { id_att_inviata: parseInt(this._id_att_inviata) }).subscribe((res: any) => {
      console.log("dati attivita ultimo stato: ", res);
      this._uiUltimoStato = res.info.ui;
      this._retDatiUltimoStato = res.info.dati;
    })
    //Tabella che mostra tutti gli stati
    this.client.getDati('get_trf_att_inviate_stati', { id_att_inviata: parseInt(this._id_att_inviata) }).subscribe((res: any) => {
      console.log("dati attivita stati: ", res);
      this._ui = res.info.ui;
      this._retDati = res.info.dati;
    })
  }
  openModal(content: any, size: string = 'lg') {
    return this.modalEngine.open(content, {
      modalDialogClass: 'modal-fade',
      size: size,
      centered: true
    });
  }
  //Funzione per permettere di aprire il modal con il dettaglio del ret
  mostraDettagli(ar : any){
    this._ar = ar.ret;
    this.modaleDettaglio = this.openModal(this.dettaglioTemplate);
  }
  get uiUltimoStato() { return this._uiUltimoStato; }
  get retDatiUltimoStato() { return this._retDatiUltimoStato; }
  get ui() {return this._ui;}
  get retDati() {return this._retDati;}
  get ar() {return this._ar;}
}
