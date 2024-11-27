/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Input, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { GeneratoreCalendarioService } from '../generatore-calendario.service';
import { NotificationService } from '@us/utils';
import { throwError } from 'rxjs';

@Component({
  selector: 'gen-settaggi',
  templateUrl: './settaggi.component.html',
  styleUrls: ['./settaggi.component.scss'],
})
export class SettaggiComponent implements OnChanges {

  @Input() elab?: { id: number, descr: string, bloccato: boolean, elaborato: boolean };

  loading = false;
  intervalloPeriodo?: { da: string, a: string };
  form = this.fb.group({
    ispettore: false,
    linea: false,
    periodo_da: '',
    periodo_a: '',
    casuale: 50,
    machine: 50,
    ultima_visita: 50,
    non_visitati_dal: '',
    non_visitati_dal_valore: '',
  })

  constructor(
    private fb: FormBuilder,
    private gs: GeneratoreCalendarioService,
    private notification: NotificationService
  ) { }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['elab']) {
      this.init();
    }
  }

  init() {
    if (this.elab) {
      this.loading = true;
      this.gs
        .getElabCalParams(this.elab!.id)
        .subscribe((res) => {
          this.loading = false;
          if (!res.esito) {
            this.notification.push({
              notificationClass: 'error',
              content: 'Errore nel caricamento dei parametri',
            });
            return;
          }
          let params: any = {};
          for (let p of res.info) {
            params[p.type_param] = p.value == 'true' || p.value == 'false' ? p.value == 'true' : p.value;
          }
          this.form.patchValue(params);
          this.intervalloPeriodo = { da: params['periodo_da'], a: params['periodo_a'] }
          if (this.elab!.bloccato || this.elab!.elaborato) this.form.disable();
        });
    }
  }

  updSettaggi() {
    if (this.elab) {
      return this.gs.updElabCalParams(
        this.elab.id,
        this.settaggiParams
      )
    } else {
      return throwError(() => new Error('Nessun elaborazione presente.'));
    }
  }

  //computed
  get settaggiParams() {
    const form: any = this.form.value;
    let params = [];
    for (let p in form) params.push({ tag: p, val: form[p] });
    return params;
  }

  get isPeriodoValid() {
    if (!this.form) return true;
    let start = this.form.get('periodo_da')!.value ?? '';
    let end = this.form.get('periodo_a')!.value ?? '';
    return (new Date(start) <= new Date(end))
  }

}
