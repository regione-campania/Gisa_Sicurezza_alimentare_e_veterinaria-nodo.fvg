/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, ViewChild, ViewContainerRef } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { LoadingDialogService, BackendCommunicationService, NotificationService, ASmartTableComponent } from '@us/utils';
import * as bootstrap from 'bootstrap';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';

@Component({
  selector: 'app-oggetti-cu',
  templateUrl: './oggetti-cu.component.html',
  styleUrls: ['./oggetti-cu.component.scss']
})
export class OggettiCuComponent {

  @ViewChild('tabellaOggetti') tabellaOggetti?: ASmartTableComponent;

  private _ui: any;
  private _ui_req: any;
  private _oggetti: any;
  private _requisiti: any;
  private _eleSelezionati: any;
  //per modale
  private modalAddOggetti?: bootstrap.Modal;

  btnDelete: boolean = false;
  tipoModale: "add" | "upd" = "add";

  private oggetto: any;
  formNuovoOggetto = this.fb.group({
    sigla: this.fb.control("", Validators.required),
    cod: this.fb.control("", Validators.required),
    descr: this.fb.control("", Validators.required)
  });

  constructor(
    public viewContainer: ViewContainerRef,
    public modalService: NgbModal,
    private LoadingService: LoadingDialogService,
    private cus: ControlliUfficialiService,
    private client: BackendCommunicationService,
    private notification: NotificationService,
    private changeDetector: ChangeDetectorRef,
    private fb: FormBuilder,
    private router: Router
  ) { }

  ngOnInit() {
    this.client.getDati('get_cu_tipo_oggetti_validi').subscribe((res: any) => {
      this.LoadingService.closeDialog();
      this._ui = res.info.ui;
      this._ui_req = res.info.ui//{ "colonne": [{ "campo": "cod", "intestazione": "Codice", "tipo": "text", "editabile": false }, { "campo": "descr_requisito", "intestazione": "Descrizione", "tipo": "text", "editabile": false }] };
      this._oggetti = res.info.dati;
      this._requisiti = [];
    });
    this.modalAddOggetti = new bootstrap.Modal('#modal-add-oggetti');
  }

  gotoRequisiti(ar: any) {
    if (ar.id == 0) return;
    this.LoadingService.openDialog();
    this.router.navigate(["portali/controlli-ufficiali/oggetti/requisiti"], { queryParams: { id_tipo_oggetto: +ar.id } });
  }

  ngAfterViewChecked(): void {
    if (this.tabellaOggetti?.selectedData.length != 0) this.btnDelete = true; else this.btnDelete = false;
    this.changeDetector.detectChanges();
  }

  openModal(tipo: "add" | "upd", ogg: any) {
    this.formNuovoOggetto.reset();
    this.tipoModale = tipo;
    if (tipo == "upd") {
      this.oggetto = ogg;
      this.formNuovoOggetto.setValue({
        sigla: ogg.sigla,
        cod: ogg.cod,
        descr: ogg.descr
      });
    }
    this.modalAddOggetti?.toggle();
  }

  insert() {
    if (!this.formNuovoOggetto.valid) {
      return;
    }
    this.modalAddOggetti?.hide();
    this.LoadingService.openDialog();

    if (this.formNuovoOggetto.value != null) {
      this.oggetto = {
        sigla: this.formNuovoOggetto.value.sigla,
        cod: this.formNuovoOggetto.value.cod,
        descr: this.formNuovoOggetto.value.descr
      }
    }

    this.cus.addTipoOggettiValidi(this.oggetto).subscribe((res: any) => {
      if (res.esito) {
        //this.ngOnInit();
        window.location.reload();
      } else {
        this.LoadingService.closeDialog();
      }
    });
  }

  update() {
    if (!this.formNuovoOggetto.valid) {
      return;
    }
    this.modalAddOggetti?.hide();
    this.LoadingService.openDialog();

    if (this.formNuovoOggetto.value != null) {
      this.oggetto = {
        id_tipo_oggetto: this.oggetto.id_tipo_oggetto,
        sigla: this.formNuovoOggetto.value.sigla,
        cod: this.formNuovoOggetto.value.cod,
        descr: this.formNuovoOggetto.value.descr
      }
    }

    this.cus.updTipoOggettiValidi(this.oggetto).subscribe((res: any) => {
      if (res.esito) {
        //this.ngOnInit();
        window.location.reload();
      } else {
        this.LoadingService.closeDialog();
      }
    });
  }

  delete() {
    if (this.btnDelete == false) {
      return;
    }
    this.LoadingService.openDialog();
    this._eleSelezionati = [];
    this.tabellaOggetti?.selectedData.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id);
    });

    this.cus.delTipoOggettiValidi(this._eleSelezionati).subscribe((res: any) => {
      if (res.esito) {
        //this.ngOnInit();
        window.location.reload();
      } else {
        this.LoadingService.closeDialog();
      }
    });
  }

  get ui() { return this._ui; }
  get ui_req() { return this._ui_req; }
  get oggetti() { return this._oggetti; }
  get requisiti() { return this._requisiti; }

}
