/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { ImpreseMainComponent } from '../../imprese-main/imprese-main.component';
import { ActivatedRoute, Router } from '@angular/router';
import { BackendResponse, NotificationService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';
import { FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-stabilimenti-subingresso',
  templateUrl: './stabilimenti-subingresso.component.html',
  styleUrls: ['./stabilimenti-subingresso.component.scss']
})
export class StabilimentiSubingressoComponent {

  @ViewChild('ricercaImpresa') ricercaImpresa?: ImpreseMainComponent;
  private _id_stabilimento: any
  private _stabilimento: any
  private _ui_stabilimento: any
  private _impresa: any
  private _ui_impresa: any
  private _linee: any
  private lineeSel: any[] = [];

  inizio_validita: any

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private ans: AnagraficaService,
    private notificationService: NotificationService,
  ) { }

  formSubingresso = this.fb.group({
    id_stabilimento: this.fb.control("", Validators.required),
    id_impresa: this.fb.control("", Validators.required),
    data_domanda: this.fb.control("", Validators.required),
    data_registrazione: this.fb.control("", Validators.required),
  })

  ngOnInit() {
    this.route.queryParams.subscribe((res: any) => {
      this._id_stabilimento = res['id_stabilimento']
      this.formSubingresso.controls.id_stabilimento.setValue(this._id_stabilimento)

      this.ans.getStabilimentoSingolo(this._id_stabilimento).subscribe((res: any) => {
        if (res.esito) {
          this._stabilimento = res.info.dati[0]
          this._ui_stabilimento = res.info.ui

          //this.inizio_validita = new Date(this._stabilimento.latest_storico).toISOString().split('T')[0]
          this.inizio_validita = new Date(this._stabilimento.inizio_validita).toISOString().split('T')[0]

          this.ans.getImpresaSingolo(this._stabilimento.id_impresa).subscribe((res: any) => {
            if (res.esito) {
              this._impresa = res.info.dati[0]
              this._ui_impresa = res.info.ui
            }
          })

          this.ans.getStabilimentiLinee(this._id_stabilimento).subscribe(res => {
            if (res.esito) {
              this._linee = res.info.dati
            }
          })
        }
      })
    });
  }

  impresaSelezionata(id_impresa: any) {
    this.formSubingresso.controls.id_impresa.setValue(id_impresa)
  }

  doSubingresso() {
    let params = {
      id_stabilimento: this.formSubingresso.value.id_stabilimento ? +this.formSubingresso.value.id_stabilimento : null,
      id_impresa: this.formSubingresso.value.id_impresa ? +this.formSubingresso.value.id_impresa : null,
      data_domanda: this.formSubingresso.value.data_domanda,
      data_registrazione: this.formSubingresso.value.data_registrazione,
      linee: this.lineeSel
    }
    console.log(params)
    this.ans.stabilimentoSubingresso(params).subscribe((res: any) => {
      if (res.esito)
        this.router.navigate(['portali/anagrafica/stabilimenti/dettaglio'], { queryParams: { id_stabilimento: res.info.id_stabilimento } })
    })
  }

  checkDate(event: any, form: any) {
    const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
    let src = event.srcElement
    let nomeForm = src.attributes.formControlName.value
    if (!src.validity.valid || !regex.test(src.value)) form.get(nomeForm).setValue("")

    form.updateValueAndValidity()
  }

  selezionaLinea(id_linea: any) {
    let rows = document.querySelectorAll('button[id^="l_riga_"]');
    rows.forEach((el: any) => {
      if (el.id == 'l_riga_' + id_linea) {
        if (el.className == "btn btn-secondary ms-auto") {
          el.className = "btn btn-primary ms-auto"
          el.innerHTML = '<i class="fa-solid fa-square-check"></i>'
          //el.innerText = "Selezionato"
          this.lineeSel.push(id_linea)
        } else {
          el.className = "btn btn-secondary ms-auto"
          el.innerHTML = '<i class="fa-regular fa-square"></i>'
          //el.innerText = "Seleziona"
          this.lineeSel = this.lineeSel.filter((item) => item !== id_linea)
        }
      }
    })

  }

  get stabilimento() { return this._stabilimento }
  get ui_stabilimento() { return this._ui_stabilimento }
  get impresa() { return this._impresa }
  get ui_impresa() { return this._ui_impresa }
  get linee() { return this._linee }

}
