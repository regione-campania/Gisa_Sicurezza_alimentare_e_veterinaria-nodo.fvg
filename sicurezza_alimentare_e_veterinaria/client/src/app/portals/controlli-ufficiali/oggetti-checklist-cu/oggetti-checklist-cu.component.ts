/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, ViewChild } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NotificationService, LoadingDialogService, BackendCommunicationService, ASmartTableComponent } from '@us/utils';
import * as bootstrap from 'bootstrap';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';

@Component({
  selector: 'app-oggetti-checklist-cu',
  templateUrl: './oggetti-checklist-cu.component.html',
  styleUrls: ['./oggetti-checklist-cu.component.scss']
})
export class OggettiChecklistCuComponent {

  @ViewChild('tabellaCL') tabellaCL?: ASmartTableComponent;

  private form_ui: any
  btnMode: any

  controllo_chiuso: boolean = false;
  oggetto_chiuso: boolean = false;
  follow_up: boolean = false;

  private _id_cu: any;
  private _cu: any;
  private _id_cu_oggetto: any;
  private _ui: any;
  private _oggetti_cl: any;

  private _eleSelezionati: any;
  private _cl_nuovi_stati: any;
  btnClose: boolean = false;

  formNuovoStatoMassivo = this.fb.group({
    id_stato_cl: this.fb.control("", Validators.required)
  });

  private modalChiudiMassivo?: bootstrap.Modal;

  constructor(
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private changeDetector: ChangeDetectorRef,
    private client: BackendCommunicationService,
    private router: Router,
    private cus: ControlliUfficialiService
  ) { }

  ngOnInit() {

    this.route.queryParams.subscribe(params => {
      this._id_cu = parseInt(params['id_cu']);
      this._id_cu_oggetto = parseInt(params['id_cu_oggetto']);

      this.cus.getCuSingolo(this._id_cu).subscribe((res: any) => {
        this._cu = res.info.dati[0]
        this.follow_up = this._cu.sigla_tecnica == 'FU' || this._cu.sigla_tecnica == 'FS'
        this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
        this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'cuOggetti')) ?? { mode: 'view' } //se non è definito
        this.btnMode = this.form_ui.mode == 'view'
      });
    });

    this.client.getDati('get_cu_oggetti_cl', { id_cu_oggetto: this._id_cu_oggetto }).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      //console.log(res);
      if (res.esito && res.info != null) {
        this._ui = res.info.ui;
        this._oggetti_cl = res.info.dati;
        this.controllo_chiuso = res.info.controllo_chiuso;
        this.oggetto_chiuso = res.info.oggetto_chiuso;
        this.follow_up = res.info.follow_up;
      } else {
        this._ui = [];
        this._oggetti_cl = [];
      }

      this.modalChiudiMassivo = new bootstrap.Modal('#modal-chiudi-massivo');
    });

  }

  ngAfterViewChecked(): void {
    if (this.tabellaCL?.selectedData.length != 0 && !this.btnMode) this.btnClose = true; else this.btnClose = false;
    this.changeDetector.detectChanges();
  }

  chiudi() {
    if (this.btnClose == false) {
      return;
    }
    this._eleSelezionati = [];
    this.tabellaCL?.selectedData.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id_cu_oggetto_cl);
    });
    //prendi modale da ogg-evidenze
    this.formNuovoStatoMassivo.reset();
    this.modalChiudiMassivo?.toggle();

    this.client.getDati('get_cu_cl_nuovi_stati_massivo', { "id_cu_oggetto_cl": this._eleSelezionati }).subscribe((res: any) => {
      if (res.esito) {
        this._cl_nuovi_stati = res.info.nuovi_stati;
        if (this._cl_nuovi_stati.length == 1)
          this.formNuovoStatoMassivo.setValue({ id_stato_cl: this._cl_nuovi_stati[0].id_stato_cl })
      }
    });
  }

  selezionaStato(id_stato: any) {
    //console.log(id_stato);
    this.formNuovoStatoMassivo.controls.id_stato_cl.setValue(id_stato);
    this.formNuovoStatoMassivo.updateValueAndValidity();

    this.aggiornaStato();
  }

  aggiornaStato() {
    this.modalChiudiMassivo?.hide();
    this.LoadingService.openDialog();

    this._eleSelezionati = [];
    this.tabellaCL?.selectedData.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id_cu_oggetto_cl);
    });

    this.client.updDati('upd_cu_cl_chiudi_massivo', { "id_cu_oggetto_cl": this._eleSelezionati, "id_nuovo_stato": this.formNuovoStatoMassivo.value.id_stato_cl ? parseInt(this.formNuovoStatoMassivo.value.id_stato_cl) : "" }).subscribe((res: any) => {
      if (res.esito) {
        //this.ngOnInit();
        window.location.reload()
      }
    });
  }

  apri(id: any) {
    this.LoadingService.openDialog();

    this.client.updDati('upd_cu_cl_apri', { "id_cu_oggetto_cl": id }).subscribe((res: any) => {
      if (res.esito) {
        //this.ngOnInit();
        window.location.reload()
      }
    });
  }

  gotoEvidenze(event: any, id_cu_oggetto_cl: any) {
    //if (+event.srcElement.parentElement.id == 0) return;
    //this.LoadingService.openDialog();
    this.router.navigate(["portali/controlli-ufficiali/lista/dettaglio/associa-oggetti/oggetti-checklist-cu/oggetti-evidenze-cu"], { queryParams: { id_cu: this._id_cu, id_cu_oggetto_cl: id_cu_oggetto_cl } });
  }

  get id_cu() { return this._id_cu; }
  get cu() { return this._cu; }
  get id_cu_oggetto() { return this._id_cu_oggetto; }
  get ui() { return this._ui; }
  get oggetti_cl() { return this._oggetti_cl; }
  get cl_nuovi_stati() { return this._cl_nuovi_stati; }

}
