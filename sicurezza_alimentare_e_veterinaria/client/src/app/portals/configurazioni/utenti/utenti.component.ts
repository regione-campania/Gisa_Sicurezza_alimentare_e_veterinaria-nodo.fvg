/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService } from '@us/utils';
import { ConfigurazioniService } from '../configurazioni.service';
import { SharedService } from 'src/app/shared/shared.service';
import { map } from 'rxjs';

@Component({
  selector: 'app-utenti',
  templateUrl: './utenti.component.html',
  styleUrls: ['./utenti.component.scss']
})
export class UtentiComponent {

  formConfig: any
  loadingUtenti = false

  private _ui: any
  private _utenti: any
  private _strutture_asl: any

  constructor(
    private sharedService: SharedService,
    private route: ActivatedRoute,
    private router: Router,
    private LoadingService: LoadingDialogService,
    private cs: ConfigurazioniService
  ) { }

  ngOnInit() {
    this.cs.getStruttureAsl().subscribe((res: any) => {
      if (res.info) {
        this._strutture_asl = res.info.dati
        this.formConfig = this.sharedService
          .getFormDefinition('cu/', 'sel_utenti')
          .pipe(
            map((res) => {
              let info = JSON.parse(res.info[0]['configurazione']);
              let aslControl = info['controls'].find((c: any) => c.name == 'id_asl');
              if (aslControl) {
                aslControl.options.push({ value: null, innerText: '', selected: true })
                aslControl.options.push({ value: -1, innerText: 'REGIONE', selected: false })
                aslControl.options.push(...(this._strutture_asl
                  .map((obj: any) => { return { value: obj.id_asl, innerText: obj.descrizione } })));
              }
              return { info: info };
            })
          );

        this.cs.getUtentiBySel({ 'limite': '1000' }).subscribe((res: any) => {
          if (res.esito) {
            this._ui = res.info.ui;
            this._utenti = res.info.dati
          }
        })
      }
    })

  }

  goToDettaglio(id_utente: any) {
    this.router.navigate(['portali/configurazioni/utenti/dettaglio'], { queryParams: { id_utente: id_utente } });
  }

  ricercaUtenti(params: any) {
    this.loadingUtenti = true
    this._utenti = null
    this._ui = null
    this.cs.getUtentiBySel(params).subscribe((res: any) => {
      this.loadingUtenti = false
      if (res.info) {
        this._utenti = res.info.dati
        this._ui = res.info.ui
      }
    })
  }

  goToAggiungi() {
    this.router.navigate(['portali/configurazioni/utenti/aggiungi']);
  }

  get ui() { return this._ui };
  get utenti() { return this._utenti };
}
