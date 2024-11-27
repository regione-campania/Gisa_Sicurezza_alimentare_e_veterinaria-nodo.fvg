/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ASmartTableComponent, LoadingDialogService } from '@us/utils';
import { ConfigurazioniService } from '../../configurazioni.service';

@Component({
  selector: 'app-ruoli-strutture-utente',
  templateUrl: './ruoli-strutture-utente.component.html',
  styleUrls: ['./ruoli-strutture-utente.component.scss']
})
export class RuoliStruttureUtenteComponent {

  btnSalva: boolean = false

  private id_utente_struttura: any
  private _utente: any
  private _ui_utente: any
  private _ruoli: any
  private _ui_ruoli: any
  private id_ruolo_init: any
  private id_ruolo: any

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private LoadingService: LoadingDialogService,
    private changeDetector: ChangeDetectorRef,
    private cs: ConfigurazioniService
  ) { }

  ngOnInit() {
    this.route.queryParams.subscribe((res: any) => {
      this.id_utente_struttura = res['id_utente_struttura'];
      this.cs.getStruttureUtenteSingolo(this.id_utente_struttura).subscribe((res: any) => {
        if (res.info) {
          this._utente = res.info.dati[0]
          this._ui_utente = res.info.ui

          this.cs.getRuoliUtente(this.id_utente_struttura).subscribe((res: any) => {
            if (res.esito) {
              this._ui_ruoli = res.info.ui
              this._ruoli = res.info.dati
              setTimeout(() => {
                this._ruoli.forEach((ele: any) => {
                  if (ele.selezionato == true) {
                    this.id_ruolo_init = +ele.ruolo_id
                    this.id_ruolo = this.id_ruolo_init
                    this.selezionaRuolo(ele.ruolo_id)
                  }
                })
              }, 1)
            }
          })
        }
      })
    })
  }

  selezionaRuolo(ruolo_id: any) {
    this.resetRuolo()
    let rows = document.querySelectorAll('button[id^="riga_"]')

    rows.forEach((el: any) => {
      if (el.id == 'riga_' + ruolo_id) {
        if (el.className == "btn btn-secondary ms-auto") {
          el.className = "btn btn-primary ms-auto"
          el.innerHTML = '<i class="fa-solid fa-square-check"></i>'
          //el.innerText = "Selezionato"
          this.id_ruolo = ruolo_id
        } else {
          el.className = "btn btn-secondary ms-auto"
          el.innerHTML = '<i class="fa-regular fa-square"></i>'
          //el.innerText = "Seleziona"
        }
      }
    })

    if (this.id_ruolo != this.id_ruolo_init) this.btnSalva = true; else this.btnSalva = false;
  }

  resetRuolo() {
    let rows = document.querySelectorAll('button[id^="riga_"]');
    rows.forEach((el: any) => {
      el.className = "btn btn-secondary ms-auto"
      el.innerHTML = '<i class="fa-regular fa-square"></i>'
      //el.innerText = "Seleziona"
    })
  }

  salvaRuolo() {
    if(!this.btnSalva) {
      return;
    }
    this.cs.upsertUtenteStrutturaRuolo({ id_ruolo: this.id_ruolo, id_utente_struttura: this.id_utente_struttura }).subscribe((res: any) => {
      this.ngOnInit()
    })
  }

  get utente() { return this._utente }
  get ui_utente() { return this._ui_utente }
  get ruoli() { return this._ruoli }
  get ui_ruoli() { return this._ui_ruoli }

}
