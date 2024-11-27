/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { ConfigurazioniService } from '../configurazioni.service';
import { LoadingDialogService } from '@us/utils';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-dettaglio-utente',
  templateUrl: './dettaglio-utente.component.html',
  styleUrls: ['./dettaglio-utente.component.scss']
})
export class DettaglioUtenteComponent {
  private _uiUtente: any
  private _utente: any
  private _uiUtentiRuoli: any
  private _utentiRuoli: any
  private cf: any
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private LoadingService: LoadingDialogService,
    private cs: ConfigurazioniService
  ) { }
  ngOnInit() {
    this.route.queryParams.subscribe((res: any) => {
      this.cf = res['cf'];
      this.cs.getUtenteSingolo(this.cf).subscribe((res: any) => {
        if (res.esito) {
          this._uiUtente = res.info.ui;
          this._utente = res.info.dati[0]
        }
      })
    })
    this.cs.getUtentiRuoli(this.cf).subscribe((res: any) => {
      if (res.esito) {
        this._uiUtentiRuoli = res.info.ui;
        this._utentiRuoli = res.info.dati
      }
    })
  }
  get uiUtente() { return this._uiUtente };
  get utente() { return this._utente };
  get uiUtentiRuoli() { return this._uiUtentiRuoli };
  get utentiRuoli() { return this._utentiRuoli };

  goToAggiungiRuolo() {
    this.router.navigate(['portali', 'configurazioni', 'utenti', 'dettaglio-utente', 'aggiungi'], { queryParams: { id_utente: this._utente.id_utente } })
  }

  delRuolo(ar: any) {
    console.log(ar);
    this.cs.delRuoliUtente(ar.id_utente, ar.id_ruolo).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      this.ngOnInit();
    })
  }
}

