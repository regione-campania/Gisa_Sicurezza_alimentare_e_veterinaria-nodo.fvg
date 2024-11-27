/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService } from '@us/utils';
import { ConfigurazioniService } from '../configurazioni.service';

@Component({
  selector: 'app-dettaglio-ruoli',
  templateUrl: './dettaglio-ruoli.component.html',
  styleUrls: ['./dettaglio-ruoli.component.scss']
})
export class DettaglioRuoliComponent {
  private _uiPermessi: any;
  private _ruoliPermessi: any;
  private _uiRuoloRuoli: any;
  private _ruoloRuoli: any;
  private id_ruolo: any;
  ruolo: any;
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private LoadingService: LoadingDialogService,
    private cs: ConfigurazioniService
  ) { }
  ngOnInit() {
    this.route.queryParams.subscribe((res: any) => {
      this.id_ruolo = res['id_ruolo'];
      this.cs.getRuoloSingolo(this.id_ruolo).subscribe((res: any) => {
        console.log(res);
        this.ruolo = res.info.dati[0].descr;
      })
      this.cs.getRuoliPermessi(this.id_ruolo).subscribe((res: any) => {
        if (res.esito) {
          this._uiPermessi = res.info.ui;
          this._ruoliPermessi = res.info.dati
        }
      })
    })
    this.cs.getRuoloRuoli(this.id_ruolo).subscribe((res: any) => {
      if (res.esito) {
        this._uiRuoloRuoli = res.info.ui;
        this._ruoloRuoli = res.info.dati
      }
    })
  }

  goToAggiungiPermesso() {
    this.router.navigate(['portali', 'configurazioni', 'ruoli', 'dettaglio-ruoli', 'aggiungi-permesso'], { queryParams: { id_ruolo: this.id_ruolo, ruolo: this.ruolo } })
  }

  goToModificaModalita(ar: any) {
    console.log(ar)
    this.router.navigate(['portali', 'configurazioni', 'ruoli', 'dettaglio-ruoli', 'modifica-modalita'], { queryParams: { id_ruolo: this.id_ruolo, ruolo: this.ruolo, id_modalita: ar.id_modalita, id_ruolo_permesso: ar.id_ruolo_permesso, sezione: ar.descr_portale + ' - ' + ar.descr_sezione } })
  }

  goToAggiungiRuoloRuoli() {
    this.router.navigate(['portali', 'configurazioni', 'ruoli', 'dettaglio-ruoli', 'aggiungi-ruolo-ruoli'], { queryParams: { id_ruolo: this.id_ruolo, ruolo: this.ruolo } })
  }

  delPermesso(ar: any) {
    console.log(ar);
    this.cs.delRuoloPermesso(ar.id_ruolo_permesso, ar.id_permesso).subscribe((res: any) => {
      this.ngOnInit();
    })
  }

  delRuoloRuoli(ar: any) {
    console.log(ar);
    this.cs.delRuoloRuoli(ar.id_ruolo_ruoli).subscribe((res: any) => {
      this.ngOnInit();
    })
  }


  get uiPermessi() { return this._uiPermessi };
  get ruoliPermessi() { return this._ruoliPermessi };
  get uiRuoloRuoli() { return this._uiRuoloRuoli };
  get ruoloRuoli() { return this._ruoloRuoli };
}

