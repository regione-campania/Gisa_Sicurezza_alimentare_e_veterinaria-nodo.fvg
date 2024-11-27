/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NotificationService, LoadingDialogService, BackendCommunicationService } from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'app-provvedimenti-add-cu',
  templateUrl: './provvedimenti-add-cu.component.html',
  styleUrls: ['./provvedimenti-add-cu.component.scss']
})
export class ProvvedimentiAddCuComponent {

  btnMode: any
  private form_ui: any

  private _id_cu: any;
  private _cu: any;
  private _id_norma_violata: any;
  private _ui_evidenze: any
  private _evidenze: any

  private _ui_provv: any
  private _provv: any

  private _tipi_provv: any;
  private provvedimento: any;

  data_min: any //= "1900-01-01"
  ora_min: any

  controllo_chiuso: boolean = false
  follow_up: boolean = false

  btnSave: boolean = false;
  btnDelete: boolean = false;
  tipoModale: "add" | "upd" = "add";
  errore_data: boolean = false;

  formNuovoProvvedimento = this.fb.group({
    //azione: this.fb.control(""),
    id_tipo_provv: this.fb.control(0, Validators.required),
    dt: this.fb.control("")
  });

  private modalAddProvv?: bootstrap.Modal;

  constructor(
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private fb: FormBuilder,
    private LoadingService: LoadingDialogService,
    private changeDetector: ChangeDetectorRef,
    private client: BackendCommunicationService,
    private router: Router,
    private cus: ControlliUfficialiService
  ) { }


  ngOnInit() {
    this.route.queryParams.subscribe(params => {
      this._id_cu = parseInt(params['id_cu']);
      this._id_norma_violata = parseInt(params['id_norma_violata']);

      this.cus.getCuSingolo(this._id_cu).subscribe((res: any) => {
        this._cu = res.info.dati[0]
        this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
        this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'cuProvvedimenti')) ?? { mode: 'view' } //se non è definito
        this.btnMode = this.form_ui.mode == 'view'

        this.data_min = new Date(this._cu.dt).toISOString().split('T')[0];
        this.ora_min = new Date(this._cu.dt).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });
      });
    });

    this.cus.getEvidenzeByNorma(this._id_cu, this._id_norma_violata).subscribe((res: any) => {
      if (res.esito) {
        this._ui_evidenze = res.info.ui;
        this._evidenze = res.info.dati;
        this.controllo_chiuso = res.info.controllo_chiuso;
        this.follow_up = res.info.follow_up;
      }
    });

    this.cus.getProvvedimenti(this._id_norma_violata).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      if (res.esito && res.info != null) {
        this._ui_provv = res.info.ui;
        this._provv = res.info.dati;
      }
    });

    this.modalAddProvv = new bootstrap.Modal('#modal-add-provv');
    this.LoadingService.closeDialog();
  }

  openModal(tipo: "add" | "upd", provv: any) {
    if (this.btnMode == true || this.controllo_chiuso == true || this.follow_up == true) {
      return;
    }
    this.formNuovoProvvedimento.reset();
    this.fetch();
    this.tipoModale = tipo;
    if (tipo == "upd") {
      this.provvedimento = provv;
      this.formNuovoProvvedimento.setValue({
        //azione: provv.azione,
        id_tipo_provv: provv.id_tipo_provv,
        dt: provv.dt
      });
    }
    this.modalAddProvv?.toggle();
  }

  fetch() {
    this.cus.getTipiProvvedimenti(this._id_norma_violata, this._evidenze[0].id_tipo_oggetto).subscribe((res: any) => { if (res.esito) { this._tipi_provv = res.info.dati; } });
  }

  checkTipoProvv(event: any) {
    if (event.target.selectedOptions[0].value != null) {
      this._tipi_provv.forEach((ele: any) => {
        if (ele.id_tipo_provv == event.target.selectedOptions[0].value) {
          if (ele.data_richiesta == true) {
            this.formNuovoProvvedimento.controls.dt.setValidators([Validators.required]);
          } else {
            this.formNuovoProvvedimento.controls.dt.clearValidators();
          }
        }
      });
    }
    this.formNuovoProvvedimento.controls.dt.setValue(this.formNuovoProvvedimento.value.dt ? this.formNuovoProvvedimento.value.dt : null);
    this.formNuovoProvvedimento.updateValueAndValidity();
  }

  insert() {
    if (!this.formNuovoProvvedimento.valid) {
      return;
    }
    this.modalAddProvv?.hide();
    this.LoadingService.openDialog();
    //parse int dei campi 
    if (this.formNuovoProvvedimento.value.id_tipo_provv != null) {
      this.provvedimento = {
        id_norma_violata: this._id_norma_violata,
        azione: null,//this.formNuovoProvvedimento.value.azione,
        id_tipo_provv: +this.formNuovoProvvedimento.value.id_tipo_provv,
        dt: this.formNuovoProvvedimento.value.dt != "" ? this.formNuovoProvvedimento.value.dt : null
      }
    }

    this.cus.addProvvedimento(this.provvedimento).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
        //window.location.reload()
      }
    });
  }

  delete(ar: any) {
    if (this.btnMode == true || this.controllo_chiuso == true || this.follow_up == true) {
      return;
    }
    this.LoadingService.openDialog();

    this.cus.delProvvedimento([ar.id_provv]).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
        //window.location.reload()
      }
    });
  }

  checkDate(event: any, form: any) {
    this.errore_data = false
    const regex = /^(19|20)[0-9]{2}-\d{2}-\d{2}$/ //per data
    let src = event.srcElement

    if (!src.validity.valid || !regex.test(src.value)) {
      form.controls.dt.setValue("")
      this.errore_data = true
    }

    form.updateValueAndValidity()
  }

  update() {
  }

  get id_cu() { return this._id_cu }
  get cu() { return this._cu }
  get ui_evidenze() { return this._ui_evidenze }
  get evidenze() { return this._evidenze }
  get ui_provv() { return this._ui_provv }
  get provv() { return this._provv }
  get tipi_provv() { return this._tipi_provv }

}
