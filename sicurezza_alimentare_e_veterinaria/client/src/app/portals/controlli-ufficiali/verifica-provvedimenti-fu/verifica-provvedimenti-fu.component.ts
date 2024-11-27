/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, ViewChild } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NotificationService, LoadingDialogService, BackendCommunicationService, ASmartTableComponent } from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'app-verifica-provvedimenti-fu',
  templateUrl: './verifica-provvedimenti-fu.component.html',
  styleUrls: ['./verifica-provvedimenti-fu.component.scss']
})
export class VerificaProvvedimentiFuComponent {

  @ViewChild('tabellaSel') tabella_sel?: ASmartTableComponent;
  @ViewChild('tabellaNoSel') tabella_no_sel?: ASmartTableComponent;

  btnAssocia: boolean = false;
  btnRimuovi: boolean = false;
  btnClose: boolean = false;
  private form_ui: any
  btnMode: any

  controllo_chiuso: boolean = false;

  private _eleSelezionati: any[] = [];

  private _id_cu: any;
  private _cu: any;
  private _id_provv: any;
  private _provv_sel: any;
  private _ui_sel: any;
  private _provv_no_sel: any;
  private _ui_no_sel: any;

  private modalRisoluzione?: bootstrap.Modal;

  constructor(
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private cus: ControlliUfficialiService,
    private fb: FormBuilder,
    private LoadingService: LoadingDialogService,
    private changeDetector: ChangeDetectorRef,
    private client: BackendCommunicationService,
    private router: Router
  ) { }

  ngOnInit() {
    this.route.queryParams.subscribe(params => {
      this._id_cu = +params['id_cu'];

      this.cus.getCuSingolo(this._id_cu).subscribe((res: any) => {
        this._cu = res.info.dati[0]
        this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
        this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'fuProvvedimenti')) ?? { mode: 'view' } //se non è definito
        this.btnMode = this.form_ui.mode == 'view'
      });
    });

    this.cus.getProvvFU(this._id_cu).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      this._ui_sel = res.info.provv_sel.ui;
      this._provv_sel = res.info.provv_sel.dati;
      this._ui_no_sel = res.info.provv_no_sel.ui;
      this._provv_no_sel = res.info.provv_no_sel.dati;
      this.controllo_chiuso = res.info.controllo_chiuso
    });

    this.modalRisoluzione = new bootstrap.Modal('#modal-risoluzione');
  }

  ngAfterViewChecked(): void {
    if (this.tabella_no_sel?.selectedData.length != 0) this.btnAssocia = true; else this.btnAssocia = false;
    if (this.tabella_sel?.selectedData.length != 0) this.btnRimuovi = true; else this.btnRimuovi = false;
    this.changeDetector.detectChanges();
  }

  openModal(idProvv: any) {
    this.modalRisoluzione?.toggle()
    this._id_provv = idProvv;
  }

  //associa provvedimento
  addProvv() {

    this._eleSelezionati = [];

    this._provv_sel.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id_provv);
    });
    this.tabella_no_sel?.selectedData.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id_provv);
    });

    if (this._eleSelezionati.length != 0) {
      this.LoadingService.openDialog();
      this.client.updDati('upd_cu_provv_fu', { id_cu: this._id_cu, id_provv: this._eleSelezionati }).subscribe((res: any) => {
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Errore durante l\'associazione.'
          });
        }
        this.ngOnInit();
        //window.location.reload()
      });
    } else {
      this.notificationService.push({
        notificationClass: 'error',
        content: 'Attenzione! Selezionare almeno un oggetto.'
      });
      return;
    }
  }

  //dissocia provvedimento
  rmvProvv() {

    this._eleSelezionati = [];
    this.tabella_sel?.selectedData.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id_provv);
    });
    let tuttiElementi: any[] = [];
    this._provv_sel.forEach((ele: any) => {
      tuttiElementi.push(ele.id_provv);
    });
    //tutti gli elementi non selezionati
    let diff = tuttiElementi.filter(item => this._eleSelezionati.indexOf(item) < 0);


    if (this._eleSelezionati.length != 0) {
      this.LoadingService.openDialog();
      this.client.updDati('upd_cu_provv_fu', { id_cu: this._id_cu, id_provv: diff }).subscribe((res: any) => {
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Errore durante la rimozione.'
          });
        }
        this.ngOnInit();
        //window.location.reload()
      });
    } else {
      this.notificationService.push({
        notificationClass: 'error',
        content: 'Attenzione! Selezionare almeno un oggetto.'
      });
      return;
    }
  }

  //modifica stato provvedimento
  updProvv(stato: boolean) {
    //console.log(this._id_provv + " " + stato);
    this.modalRisoluzione?.hide()
    this.client.updDati('upd_cu_provv_fu_stato', { id_provv_fu: this._id_provv, stato: stato }).subscribe((res: any) => {
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: 'Errore durante la rimozione.'
        });
      }
      this.ngOnInit();
      //window.location.reload()
    });

  }

  gotoEvidenze(idProvvFu: any) {
    this.LoadingService.openDialog();
    this.router.navigate(["portali/controlli-ufficiali/lista/dettaglio/verifica-provvedimenti/evidenze-provvedimenti"], { queryParams: { id_cu: this.id_cu, id_provv_fu: idProvvFu } });
  }

  get id_cu() { return this._id_cu }
  get cu() { return this._cu }
  get ui_sel() { return this._ui_sel };
  get ui_no_sel() { return this._ui_no_sel };
  get provv_sel() { return this._provv_sel };
  get provv_no_sel() { return this._provv_no_sel };
}
