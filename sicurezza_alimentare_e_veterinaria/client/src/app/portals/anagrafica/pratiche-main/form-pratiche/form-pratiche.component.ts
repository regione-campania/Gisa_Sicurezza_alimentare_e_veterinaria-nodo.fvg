/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NotificationService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';
import { AppService } from 'src/app/app.service';

@Component({
  selector: 'app-form-pratiche',
  templateUrl: './form-pratiche.component.html',
  styleUrls: ['./form-pratiche.component.scss']
})
export class FormPraticheComponent {

  @Output() valueEmitted = new EventEmitter<string>();

  formPratiche = this.fb.group({
    id_utente: this.fb.control(null),
    id_pratica: this.fb.control(null),
    descr_tipo_pratica: this.fb.control(null),
    id_tipo_pratica: this.fb.control(null, [Validators.required]),
    n_pratica: this.fb.control(null, [Validators.required]),
    data_pratica: this.fb.control(null, [Validators.required]),
    data_autorizzazione: this.fb.control(null),
    id_stabilimento: this.fb.control(null),
  })
  tipi_pratiche: any
  selezionaStab: any = false

  flagModifica = false

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private cus: AnagraficaService,
    private notificationService: NotificationService,
    private ap: AppService,
    private fb: FormBuilder,
  ) { }

  ngOnInit() {
    if (this.route.snapshot.url[0].path == "modifica") {
      this.flagModifica = true
    }

    this.cus.getTipiPratiche().subscribe((res: any) => {
      if (res.info) {
        this.tipi_pratiche = res.info.dati
        this.ap.getUser().subscribe((res: any) => {
          this.formPratiche.controls.id_utente.setValue(res.id_utente)
        })
      }
    })
  }

  ngAfterViewChecked() {
    if (this.tipi_pratiche)
      this.checkTipoPratica({ "target": { "value": this.formPratiche.value.id_tipo_pratica } })
  }

  trimCampo(campo: any){
    //campo è <form>.controls.<nome_campo>
    campo.setValue(campo.value.trim())
  }

  checkTipoPratica(event: any) {
    //controlla stab richiesto
    if (!event.target || event.target.value == "") {
      this.selezionaStab = false
    } else {
      this.tipi_pratiche.forEach((tp: any) => {
        if (tp.id == event.target.value) {
          if (tp.stab_richiesto == true) {
            this.formPratiche.controls['id_stabilimento'].setValidators([Validators.required]);
            this.selezionaStab = true
          }
          else {
            this.formPratiche.controls['id_stabilimento'].clearValidators()
            this.formPratiche.controls['id_stabilimento'].setValue(null)
            this.selezionaStab = false
          }
        }
      })
    }

    this.formPratiche.controls['id_stabilimento'].updateValueAndValidity()
    this.valueEmitted.emit(this.selezionaStab)
  }

}
