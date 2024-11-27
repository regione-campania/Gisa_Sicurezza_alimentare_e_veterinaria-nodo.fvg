/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { LoadingDialogService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';

@Component({
  selector: 'app-soggetti-dettaglio',
  templateUrl: './soggetti-dettaglio.component.html',
  styleUrls: ['./soggetti-dettaglio.component.scss']
})
export class SoggettiDettaglioComponent {

  private _id_soggetto_fisico: any
  private _soggetto: any
  private _ui_soggetto: any
  private _soggettoStab: any
  private _ui_soggettoStab: any
  private _soggettoImp: any
  private _ui_soggettoImp: any
  disabilitaModSogg: any

  constructor(
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private ans: AnagraficaService,
    private router: Router,
    private route: ActivatedRoute,
  ) { }

  ngOnInit() {
    this.route.queryParams.subscribe(params => {
      this._id_soggetto_fisico = params['id_soggetto_fisico']

      this.ans.getSoggettoSingolo(+this._id_soggetto_fisico).subscribe((res: any) => {
        this._soggetto = res.info.dati[0]
        this._ui_soggetto = res.info.ui

        if (!this._soggetto.soggetto_fisico_modificabile) {
          this.disabilitaModSogg = true;
        }
        this.ans.getSoggettiStabilimenti(this._soggetto.codice_fiscale).subscribe((res: any) => {
          if (!res.esito) {
            return;
          }
          if (!res.info) {
            return;
          }
          this._soggettoStab = res.info.dati;
          this._ui_soggettoStab = res.info.ui;
        })
        this.ans.getSoggettiFigure(this._soggetto.codice_fiscale).subscribe((res: any) => {
          if (!res.esito) {
            return;
          }
          if (!res.info) {
            return;
          }
          this._soggettoImp = res.info.dati;
          this._ui_soggettoImp = res.info.ui;
        })
      });
    });
  }

  goToModifica() {
    if (this.disabilitaModSogg == true) {
      return;
    }
    this.router.navigate(['portali/anagrafica/soggetti-fisici/modifica'], { queryParams: { id_soggetto_fisico: this._id_soggetto_fisico } })
  }

  goToStabilimento(id_stabilimento: any) {
    this.router.navigate(['portali/anagrafica/stabilimenti/dettaglio'], { queryParams: { id_stabilimento: +id_stabilimento } })
  }

  goToImpresa(id_impresa: any) {
    this.router.navigate(['portali/anagrafica/imprese/dettaglio'], {
      queryParams: { id_impresa: id_impresa },
    });
  }

  get soggetto() { return this._soggetto }
  get ui_soggetto() { return this._ui_soggetto }
  get soggettoStab() { return this._soggettoStab }
  get ui_soggettoStab() { return this._ui_soggettoStab }
  get soggettoImp() { return this._soggettoImp }
  get ui_soggettoImp() { return this._ui_soggettoImp }
}
