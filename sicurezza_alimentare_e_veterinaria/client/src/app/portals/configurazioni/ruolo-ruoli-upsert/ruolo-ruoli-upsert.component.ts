/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ASmartTableComponent, LoadingDialogService } from '@us/utils';
import { ConfigurazioniService } from '../configurazioni.service';

@Component({
  selector: 'app-ruolo-ruoli-upsert',
  templateUrl: './ruolo-ruoli-upsert.component.html',
  styleUrls: ['./ruolo-ruoli-upsert.component.scss']
})
export class RuoloRuoliUpsertComponent {
  private _uiRuoloRuoli: any;
  private _ruoloRuoli: any;
  private id_ruolo: any;
  private _ruoliSel: any;
  ruolo: any;
  @ViewChild('tabellaRuoloRuoli') tabellaRuoloRuoli?: ASmartTableComponent;
  operazione: any;
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private LoadingService: LoadingDialogService,
    private cs: ConfigurazioniService
  ) { }
  ngOnInit() {
    console.log(this.route.snapshot.url[0].path)
    if (this.route.snapshot.url[0].path == 'aggiungi-ruolo-ruoli') {
      this.operazione = 'Aggiungi';
    }
    this.route.queryParams.subscribe((res: any) => {
      this.id_ruolo = res['id_ruolo'];
      this.ruolo = res['ruolo'];
      this.cs.getRuoloRuoliForAdd(this.id_ruolo).subscribe((res: any) => {
        if (res.esito) {
          this._uiRuoloRuoli = res.info.ui;
          this._ruoloRuoli = res.info.dati;
        }
      })
    })
  }

  salvaRuoloRuoli() {
    if(!this.tabellaRuoloRuoli?.selectedData?.length) {
      return;
    }
    this._ruoliSel = [];
    this.tabellaRuoloRuoli?.selectedData.forEach((elem: any) => {
      this._ruoliSel.push(elem.id_ruolo);
    })
    console.log(this._ruoliSel);
    this.cs.insRuoloRuoli(this.id_ruolo, this._ruoliSel).subscribe((res: any) => {
      console.log(res);
      if (!res.esito) {
        return;
      }
      this.ngOnInit();
    })
  }
  
  get uiRuoloRuoli() { return this._uiRuoloRuoli };
  get ruoloRuoli() { return this._ruoloRuoli };
}
