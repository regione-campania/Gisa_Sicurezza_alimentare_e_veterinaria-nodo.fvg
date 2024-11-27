/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService } from '@us/utils';
import { ConfigurazioniComponent } from 'src/app/portals/gestione-attivita/configurazioni/configurazioni.component';
import { ConfigurazioniService } from '../configurazioni.service';
import * as bootstrap from 'bootstrap';
import { FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-ruoli',
  templateUrl: './ruoli.component.html',
  styleUrls: ['./ruoli.component.scss']
})
export class RuoliComponent {

  tipoModale: 'Aggiungi' | 'Modifica' = 'Aggiungi'
  private _ui: any
  private _ruoli: any

  private modalRuoli?: bootstrap.Modal

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private cs: ConfigurazioniService
  ) { }

  formRuolo = this.fb.group({
    id: this.fb.control(""),
    sigla: this.fb.control("", Validators.required),
    descr: this.fb.control("", Validators.required)
  });

  ngOnInit() {
    this.cs.getRuoli().subscribe((res: any) => {
      if (res.esito) {
        this._ui = res.info.ui;
        this._ruoli = res.info.dati
      }
    })

    this.modalRuoli = new bootstrap.Modal('#modal-ruoli')
  }

  openModalRuoli(mode: 'add' | 'upd', ar: any) {
    this.formRuolo.reset()
    if (mode == 'add') {
      this.tipoModale = 'Aggiungi'
    }

    if (mode == 'upd') {
      this.tipoModale = 'Modifica'
      this.formRuolo.patchValue({
        id: ar.id,
        sigla: ar.sigla,
        descr: ar.descr,
      })
    }

    console.log(this.formRuolo.value)
    this.modalRuoli?.toggle()
  }

  upsertRuoli() {
    if(!this.formRuolo.valid) {
      return;
    }
    console.log(this.formRuolo.value)
    if (this.tipoModale == 'Aggiungi') {
      this.cs.addRuolo({ ...this.formRuolo.value }).subscribe(res => {
        if (res.esito) {
          this.modalRuoli?.hide()
          this.ngOnInit()
        }
      })
    }

    if (this.tipoModale == 'Modifica') {
      this.cs.updRuolo({ ...this.formRuolo.value }).subscribe(res => {
        if (res.esito) {
          this.modalRuoli?.hide()
          this.ngOnInit()
        }
      })
    }
  }

  goToDettaglio(id_ruolo: any) {
    this.router.navigate(['portali', 'configurazioni', 'ruoli', 'dettaglio-ruoli'], { queryParams: { id_ruolo: +id_ruolo } });
  }

  get ui() { return this._ui };
  get ruoli() { return this._ruoli };
}
