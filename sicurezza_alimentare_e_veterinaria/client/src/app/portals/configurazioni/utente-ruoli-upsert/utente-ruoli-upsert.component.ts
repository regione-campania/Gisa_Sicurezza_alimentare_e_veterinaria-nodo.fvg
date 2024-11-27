/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { ConfigurazioniService } from '../configurazioni.service';
import { ASmartTableComponent, LoadingDialogService, NotificationService } from '@us/utils';
import { ActivatedRoute, Router } from '@angular/router';
import { FormBuilder } from '@angular/forms';

@Component({
  selector: 'app-utente-ruoli-upsert',
  templateUrl: './utente-ruoli-upsert.component.html',
  styleUrls: ['./utente-ruoli-upsert.component.scss']
})
export class UtenteRuoliUpsertComponent {
  //---------------------------VARIABILI-------------------------------
  private _ui: any;
  private _ruoli: any;
  private _ruoliSel: any;
  private id_utente: any;
  @ViewChild('tabellaRuoli') tabellaRuoli?: ASmartTableComponent;
  //---------------------------COSTRUTTORE---------------------------
  constructor(private cs: ConfigurazioniService,
    private LoadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private router: Router,
    private fb: FormBuilder) {

  }
  //---------------------------------NGONINIT------------------------
  ngOnInit(): void {
    console.log(this.route.snapshot.url[0].path)
    this.route.queryParams.subscribe((res: any) => {
      this.id_utente = res['id_utente'];
      this.cs.getRuoliUtente(this.id_utente).subscribe((res: any) => {
        if (res.esito) {
          this._ui = res.info.ui;
          this._ruoli = res.info.dati
        }
      })
    })
  }
  get ui() { return this._ui };
  get ruoli() { return this._ruoli };

  salvaRuoli() {
    if(!this.tabellaRuoli?.selectedData?.length) {
      return;
    }
    this._ruoliSel = [];
    this.tabellaRuoli?.selectedData.forEach((elem: any) => {
      this._ruoliSel.push(elem.id);
    })
    console.log(this._ruoliSel);
    this.cs.insRuoliUtente(this.id_utente, this._ruoliSel).subscribe((res: any) => {
      console.log(res);
      if (!res.esito) {
        return;
      }
      this.ngOnInit();
    })
  }
}
