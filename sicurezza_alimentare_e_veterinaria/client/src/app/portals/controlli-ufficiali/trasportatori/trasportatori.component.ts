/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, ViewChild } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NotificationService, LoadingDialogService, BackendCommunicationService } from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';
import { FormIndirizzoMainComponent } from 'src/app/portals/anagrafica/form-indirizzo-main/form-indirizzo-main.component';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'app-trasportatori',
  templateUrl: './trasportatori.component.html',
  styleUrls: ['./trasportatori.component.scss']
})
export class TrasportatoriComponent {

  @ViewChild('formIndirizzo') formIndirizzo?: FormIndirizzoMainComponent;

  private modalAutomezzi?: bootstrap.Modal
  private modalIndirizzo?: bootstrap.Modal

  btnMode: any
  btnSave: any
  indiMode: any

  controllo_chiuso: any = false
  id_indirizzo: any
  indirizzo: any
  ui_indirizzo: any
  automezzi: any
  ui_automezzi: any

  automezzi_sel: any = []
  automezzi_stab: any
  ui_automezzi_stab: any

  private form_ui: any
  private _id_cu: any
  private _cu: any

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
    this.automezzi = null
    this.ui_automezzi = null

    this.LoadingService.openDialog()
    this.route.queryParams.subscribe(params => {
      this._id_cu = +params['id_cu']

      this.cus.getCuSingolo(this._id_cu).subscribe((res: any) => {
        if (res.info) {
          this._cu = res.info.dati[0]
          this.controllo_chiuso = this._cu.chiuso
          this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
          this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'cuNucleo')) ?? { mode: 'view' } //se non è definito
          this.btnMode = this.form_ui.mode == 'view'

          this.cus.getIndirizziTrasportatori(this._id_cu).subscribe(res => {
            this.LoadingService.closeDialog()
            if (res.info) {
              this.indirizzo = res.info.dati[0]
              this.ui_indirizzo = res.info.ui
              this.id_indirizzo = this.indirizzo.id_indirizzo

            }
            this.cus.getAutomezziCU(this._id_cu).subscribe(res => {
              if (res.info) {
                this.automezzi = res.info.dati
                this.ui_automezzi = res.info.ui
              }
            })

          })
        }

      });
    })

    this.modalAutomezzi = new bootstrap.Modal('#modal-automezzi')
    this.modalIndirizzo = new bootstrap.Modal('#modal-indirizzo')
  }

  ngAfterViewChecked() {
    this.btnSave = this.automezzi_sel.length <= 0
  }

  openModalAutomezzi(mode: 'add' | 'upd', ar: any) {
    this.automezzi_sel = []
    if (mode == 'add') {
      this.cus.getAutomezziStabilimento({ id_cu: this._id_cu, id_stabilimento: this._cu.id_az_sede }).subscribe(res => {
        if (res.info) {
          this.modalAutomezzi?.toggle()
          this.automezzi_stab = res.info.dati
          this.ui_automezzi_stab = res.info.ui
        }
      })

    }
  }

  openModalIndirizzo(mode: 'add' | 'upd', ar: any) {
    mode == 'add' ? this.indiMode = 'Aggiungi' : this.indiMode = 'Modifica'
    this.modalIndirizzo?.toggle()
  }

  selezionaAutomezzi(id_automezzo: any) {
    let rows = document.querySelectorAll('button[id^="riga_"]');
    rows.forEach((el: any) => {
      if (el.id == 'riga_' + id_automezzo) {
        if (el.className == "btn btn-secondary ms-auto") {
          el.className = "btn btn-primary ms-auto"
          el.innerHTML = '<i class="fa-solid fa-square-check"></i>'
          //el.innerText = "Selezionato"
          this.automezzi_sel.push(id_automezzo)
        } else {
          el.className = "btn btn-secondary ms-auto"
          el.innerHTML = '<i class="fa-regular fa-square"></i>'
          //el.innerText = "Seleziona"
          this.automezzi_sel = this.automezzi_sel.filter((item: any) => item !== id_automezzo)
        }
      }
    })
  }


  addAutomezzi() {
    this.modalAutomezzi?.hide()
    let params = {
      id_cu: this._id_cu,
      automezzi: this.automezzi_sel
    }
    this.cus.addAutomezzi(params).subscribe(res => {
      if (res.esito) {
        this.ngOnInit()
      }
    })
  }

  delAutomezzo(id_automezzo: any) {
    this.cus.delAutomezzo(id_automezzo).subscribe(res => {
      if (res.esito) {
        this.ngOnInit()
      }
    })
  }

  upsertIndirizzo() {
    let params = {
      nome_function: '',
      id_cu: this._id_cu
    }
    if (this.indiMode == 'Aggiungi') {
      params.nome_function = 'upd_add_indirizzi_trasportatori'
      this.formIndirizzo?.updIndirizzo(this.id_indirizzo, null, params);
    } else if (this.indiMode == 'Modifica') {
      params.nome_function = 'upd_upd_indirizzi_trasportatori'
      this.formIndirizzo?.updIndirizzo(this.id_indirizzo, null, params);
    }
  }

  get cu() { return this._cu }
}
