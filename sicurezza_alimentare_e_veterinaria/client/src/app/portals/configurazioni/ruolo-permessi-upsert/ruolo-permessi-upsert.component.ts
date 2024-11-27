/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ASmartTableComponent, LoadingDialogService } from '@us/utils';
import { ConfigurazioniService } from '../configurazioni.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-ruolo-permessi-upsert',
  templateUrl: './ruolo-permessi-upsert.component.html',
  styleUrls: ['./ruolo-permessi-upsert.component.scss']
})
export class RuoloPermessiUpsertComponent {
  id_ruolo: any;
  ruolo: any;
  sezione: any;
  operazione: any;
  private _ui: any;
  private _risorsa: any;
  @ViewChild('tabellaPermessi') tabellaPermessi?: ASmartTableComponent;
  private _risorseSel: any;
  formModalita: FormGroup;
  private _modalita: any;
  private _id_modalita: any;
  private _id_ruolo_permesso: any;
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private LoadingService: LoadingDialogService,
    private cs: ConfigurazioniService,
    private fb: FormBuilder
  ) {
    this.formModalita = this.fb.group({
      id_modalita: this.fb.control(null, [Validators.required]),
    })
  }
  ngOnInit() {
    console.log(this.route.snapshot.url[0].path)
    this.route.queryParams.subscribe((res: any) => {
      this.id_ruolo = res['id_ruolo'];
      this.ruolo = res['ruolo'];
      this._id_modalita = res['id_modalita'];
      this._id_ruolo_permesso = res['id_ruolo_permesso'];

      if (res['sezione']) {
        this.sezione = res['sezione']
      }
    })
    if (this.route.snapshot.url[0].path == 'aggiungi-permesso') {
      this.operazione = 'Aggiungi';
      this.cs.getSezioni(this.id_ruolo).subscribe((res: any) => {
        if (res.esito) {
          this._ui = res.info.ui;
          this._risorsa = res.info.dati;
        }
      })

    }
    else {
      this.operazione = 'Modifica'
    }

    this.cs.getModalita().subscribe((res: any) => {
      if (res.esito) {
        this._modalita = res.info.dati;
        this.formModalita.controls['id_modalita'].setValue(this._id_modalita ?? 1);
      }
    })

  }

  get ui() { return this._ui; }
  get risorsa() { return this._risorsa; }
  get modalita() { return this._modalita; }

  addPermesso() {
    if(!this.tabellaPermessi?.selectedData?.length) {
      return;
    }
    this._risorseSel = [];
    this.tabellaPermessi?.selectedData.forEach((elem: any) => {
      this._risorseSel.push(elem.id_sezione);
    })
    // console.log(this._risorseSel);
    this.cs.insRuoloPermessi(this.id_ruolo, +this.formModalita.value.id_modalita, this._risorseSel).subscribe((res: any) => {
      console.log(res);
      if (!res.esito) {
        return;
      }
      this.ngOnInit();
    })
  }

  updModalita() {
    const params = {
      id_modalita: +this.formModalita.value.id_modalita,
      id_ruolo_permesso: +this._id_ruolo_permesso
    }
    this.cs.updModalitaSezione(params).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      this.router.navigate(['portali', 'configurazioni', 'ruoli', 'dettaglio-ruoli'], { queryParams: { id_ruolo: this.id_ruolo } })
    })
  }
}
