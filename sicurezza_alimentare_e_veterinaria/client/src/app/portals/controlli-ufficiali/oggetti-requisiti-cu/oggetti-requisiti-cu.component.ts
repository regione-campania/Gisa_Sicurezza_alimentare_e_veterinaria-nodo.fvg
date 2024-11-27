/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, ViewChild } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { LoadingDialogService, BackendCommunicationService, NotificationService, ASmartTableComponent } from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'app-oggetti-requisiti-cu',
  templateUrl: './oggetti-requisiti-cu.component.html',
  styleUrls: ['./oggetti-requisiti-cu.component.scss']
})
export class OggettiRequisitiCuComponent {

  @ViewChild('tabellaRequisiti') tabellaRequisiti?: ASmartTableComponent;

  private id_tipo_oggetto: any;
  private _ui_req: any;
  private _requisiti: any;
  private _eleSelezionati: any;
  //per modale
  private modalAddRequisiti?: bootstrap.Modal;

  btnDelete: boolean = false;
  tipoModale: "add" | "upd" = "add";

  private requisito: any;
  formNuovoRequisito = this.fb.group({
    norma: this.fb.control("", Validators.required),
    descr: this.fb.control("", Validators.required),
    cl: this.fb.control("", Validators.required)
  });

  constructor(
    private LoadingService: LoadingDialogService,
    private client: BackendCommunicationService,
    private notification: NotificationService,
    private route: ActivatedRoute,
    private changeDetector: ChangeDetectorRef,
    private fb: FormBuilder,
    private cus: ControlliUfficialiService,
  ) { }

  ngOnInit() {
    this.route.queryParams.subscribe(params => {
      this.id_tipo_oggetto = +params['id_tipo_oggetto'];
    });

    this.client.getDati('get_cu_tipo_oggetti_requisiti_validi', { id_tipo_oggetto: this.id_tipo_oggetto }).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      if (res.esito && res.info != null) {
        this._requisiti = res.info.dati;
        this._ui_req = res.info.ui;
      } else {
        this._requisiti = [];
        this._ui_req = [];
      }

    });
    this.modalAddRequisiti = new bootstrap.Modal('#modal-add-requisiti');
  }

  ngAfterViewChecked(): void {
    if (this.tabellaRequisiti?.selectedData.length != 0) this.btnDelete = true; else this.btnDelete = false;
    this.changeDetector.detectChanges();
  }

  openModal(tipo: "add" | "upd", req: any) {
    this.formNuovoRequisito.reset();
    this.tipoModale = tipo;
    if (tipo == "upd") {
      this.requisito = req;
      this.formNuovoRequisito.setValue({
        norma: req.norma_requisito,
        descr: req.descr_requisito,
        cl: req.cl_requisito
      });
    }
    this.modalAddRequisiti?.toggle();
  }

  insert() {
    if (!this.formNuovoRequisito.valid) {
      return;
    }
    this.modalAddRequisiti?.hide();
    this.LoadingService.openDialog();

    if (this.formNuovoRequisito.value != null) {
      this.requisito = {
        id_tipo_oggetto: this.id_tipo_oggetto,
        norma: this.formNuovoRequisito.value.norma,
        descr: this.formNuovoRequisito.value.descr,
        cl: this.formNuovoRequisito.value.cl
      }
    }

    this.cus.addTipoOggettiRequisitiValidi(this.requisito).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
      }
    });
  }

  update() {
    if (!this.formNuovoRequisito.valid) {
      return;
    }
    this.modalAddRequisiti?.hide();
    this.LoadingService.openDialog();

    if (this.formNuovoRequisito.value != null) {
      this.requisito = {
        id_requisito: this.requisito.id_requisito,
        norma: this.formNuovoRequisito.value.norma,
        descr: this.formNuovoRequisito.value.descr,
        cl: this.formNuovoRequisito.value.cl
      }
    }

    this.cus.updTipoOggettiRequisitiValidi(this.requisito).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
      }
    });
  }

  delete() {
    if (this.btnDelete == false) {
      return;
    }
    this.LoadingService.openDialog();
    this._eleSelezionati = [];
    this.tabellaRequisiti?.selectedData.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id_requisito);
    });

    this.cus.delTipoOggettiRequisitiValidi(this._eleSelezionati).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
      }
    });
  }

  get ui_req() { return this._ui_req }
  get requisiti() { return this._requisiti }
}