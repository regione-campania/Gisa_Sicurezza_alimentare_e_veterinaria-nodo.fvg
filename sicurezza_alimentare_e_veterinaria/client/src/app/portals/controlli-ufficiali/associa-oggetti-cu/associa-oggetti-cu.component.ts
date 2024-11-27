/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild, ViewContainerRef, AfterViewChecked, OnInit, ChangeDetectorRef } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService, BackendCommunicationService, NotificationService, ASmartTableComponent } from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';
import { FormBuilder, Validators } from '@angular/forms';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'app-associa-oggetti-cu',
  templateUrl: './associa-oggetti-cu.component.html',
  styleUrls: ['./associa-oggetti-cu.component.scss']
})
export class AssociaOggettiCuComponent implements OnInit, AfterViewChecked {

  @ViewChild('oggettiSel') tabella_sel?: ASmartTableComponent;
  @ViewChild('oggettiNoSel') tabella_no_sel?: ASmartTableComponent;

  private form_ui: any
  btnMode: any

  btnAssocia: boolean = false;
  btnRimuovi: boolean = false;
  btnClose: boolean = false;

  controllo_chiuso: boolean = false;
  follow_up: boolean = false;

  private _eleSelezionati: any[] = [];

  private _id_cu: any;
  private _cu: any;
  private _oggetti_sel: any;
  private _ui_sel: any;
  private _oggetti_no_sel: any;
  private _ui_no_sel: any;

  private _cl_nuovi_stati: any;
  private id_oggetto: any;

  formNuovoStatoOggetto = this.fb.group({
    id_stato_oggetto: this.fb.control("", Validators.required)
  });

  private modalChiudi?: bootstrap.Modal;

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
        this.follow_up = this._cu.sigla_tecnica == 'FU' || this._cu.sigla_tecnica == 'FS'
        this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
        this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'cuOggetti')) ?? { mode: 'view' } //se non è definito
        this.btnMode = this.form_ui.mode == 'view'
      });
    });

    this.cus.getCuOggettiAssoc(this._id_cu).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      this._ui_sel = res.info.lista_sel.ui;
      this._oggetti_sel = res.info.lista_sel.dati;
      this._ui_no_sel = res.info.lista_no_sel.ui;
      this._oggetti_no_sel = res.info.lista_no_sel.dati;
      this.controllo_chiuso = res.info.controllo_chiuso
      this.follow_up = res.info.follow_up

    });

    this.modalChiudi = new bootstrap.Modal('#modal-chiudi');
  }

  ngAfterViewChecked(): void {
    if (this.tabella_no_sel?.selectedData.length != 0 && !this.btnMode) this.btnAssocia = true; else this.btnAssocia = false;
    if (this.tabella_sel?.selectedData.length != 0 && !this.btnMode) this.btnRimuovi = true; else this.btnRimuovi = false;
    this.changeDetector.detectChanges();
  }

  associaCuOggetto() {
    if(this.btnAssocia == false) {
      return;
    }
    this._eleSelezionati = [];

    this._oggetti_sel.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id_tipo_oggetto);
    });
    this.tabella_no_sel?.selectedData.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id_tipo_oggetto);
    });

    if (this._eleSelezionati.length != 0) {
      this.LoadingService.openDialog();
      this.client.updDati('upd_cu_oggetti', { id_cu: this._id_cu, id_oggetti: this._eleSelezionati }).subscribe((res: any) => {
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Errore durante l\'associazione.'
          });
        }
        this.ngOnInit();
      });
    } else {
      this.notificationService.push({
        notificationClass: 'error',
        content: 'Attenzione! Selezionare almeno un oggetto.'
      });
      return;
    }
  }

  rimuoviCuOggetto() {
    this._eleSelezionati = [];
    this.tabella_sel?.selectedData.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id_tipo_oggetto);
    });
    let tuttiElementi: any[] = [];
    this._oggetti_sel.forEach((ele: any) => {
      tuttiElementi.push(ele.id_tipo_oggetto);
    });
    //tutti gli elementi non selezionati
    let diff = tuttiElementi.filter(item => this._eleSelezionati.indexOf(item) < 0);


    if (this._eleSelezionati.length != 0) {
      this.LoadingService.openDialog();
      this.client.updDati('upd_cu_oggetti', { id_cu: this._id_cu, id_oggetti: diff }).subscribe((res: any) => {
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Errore durante la rimozione.'
          });
        }
        this.ngOnInit();
      });
    } else {
      this.notificationService.push({
        notificationClass: 'error',
        content: 'Attenzione! Selezionare almeno un oggetto.'
      });
      return;
    }
  }

  chiudi(id: any) {
    this.modalChiudi?.toggle();
    if (+id != 0) this.id_oggetto = +id; else return;

    this.cus.getNuoviStatiOggetto(this.id_oggetto).subscribe((res: any) => {
      if (res.esito) {
        this._cl_nuovi_stati = res.info.nuovi_stati;
        if (this._cl_nuovi_stati.length == 1)
          this.formNuovoStatoOggetto.setValue({ id_stato_oggetto: this._cl_nuovi_stati[0].id_stato_oggetto })
      }
    });

  }

  selezionaStato(id_stato: any) {
    //console.log(id_stato);
    // let rows = document.querySelectorAll('tr[id^="riga_"]');
    // rows.forEach(row => {
    //   row.classList.remove("selezionato");
    // });

    // let row = document.getElementById("riga_" + id_stato);
    // row?.classList.toggle("selezionato");

    this.formNuovoStatoOggetto.controls.id_stato_oggetto.setValue(id_stato);
    this.formNuovoStatoOggetto.updateValueAndValidity();

    this.aggiornaStato();
    //console.log(this.formNuovoStatoOggetto.value)
  }

  aggiornaStato() {
    this.modalChiudi?.hide();
    this.LoadingService.openDialog();

    this.client.updDati('upd_cu_oggetto_chiudi', { "id_cu_oggetto": this.id_oggetto, "id_nuovo_stato": this.formNuovoStatoOggetto.value.id_stato_oggetto ? +this.formNuovoStatoOggetto.value.id_stato_oggetto : "" }).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
      }
    });
  }

  apri(id: any) {
    this.LoadingService.openDialog();
    if (+id != 0) this.id_oggetto = +id; else return;

    this.client.updDati('upd_cu_oggetto_apri', { "id_cu_oggetto": this.id_oggetto }).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
      }
    });
  }

  dettaglioOggetto(idOgg: any) {
    //if (+event.srcElement.parentElement.id == 0) return;
    this.LoadingService.openDialog();
    this.router.navigate(["portali/controlli-ufficiali/lista/dettaglio/associa-oggetti/oggetti-checklist-cu"], { queryParams: { id_cu: this.id_cu, id_cu_oggetto: idOgg } });
  }

  get id_cu() { return this._id_cu };
  get cu() { return this._cu };
  get ui_sel() { return this._ui_sel };
  get ui_no_sel() { return this._ui_no_sel };
  get oggetti_sel() { return this._oggetti_sel };
  get oggetti_no_sel() { return this._oggetti_no_sel };
  get cl_nuovi_stati() { return this._cl_nuovi_stati; }

}
