/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';

@Component({
  selector: 'app-sedi-dettaglio',
  templateUrl: './sedi-dettaglio.component.html',
  styleUrls: ['./sedi-dettaglio.component.scss']
})
export class SediDettaglioComponent {

  private _id_sede: any
  private _sede: any
  private _ui_sede: any
  private isStab: boolean = true
  disabilitaModifica: boolean = false;
  intestazione: any

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private cus: AnagraficaService,
    private LoadingService: LoadingDialogService
  ) { }

  ngOnInit() {
    this.LoadingService.openDialog()
    this.route.queryParams.subscribe(params => {
      // this._id_sede = +params['id_sede']
      if (params['id_sede_stabilimento']) {
        this._id_sede = +params['id_sede_stabilimento'];
        this.isStab = true
        this.intestazione = "Stabilimento"
        this.cus.getStabilimentiSediSingolo(+params['id_sede_stabilimento']).subscribe((res: any) => {
          if (res.info) {
            this._sede = res.info.dati[0]
            this._ui_sede = res.info.ui
            this.disabilitaModifica = res.info.dati[0].sedi_modificabili;
          }
          this.LoadingService.closeDialog()
        });
      }

      if (params['id_sede_impresa']) {
        this._id_sede = +params['id_sede_impresa'];
        this.isStab = false
        this.intestazione = "Impresa"
        this.cus.getImpreseSediSingolo(+params['id_sede_impresa']).subscribe((res: any) => {
          if (res.info) {
            this._sede = res.info.dati[0]
            this._ui_sede = res.info.ui
            this.disabilitaModifica = res.info.dati[0].sedi_modificabili;
          }
          this.LoadingService.closeDialog()
        })
      }
    });

  }

  goToModifica() {
    if (this.disabilitaModifica == false) {
      return;
    }
    if(this.isStab)
      this.router.navigate(['portali/anagrafica/stabilimenti/sedi/modifica'], { queryParams: { id_sede_stabilimento: this._id_sede } })
    else
      this.router.navigate(['portali/anagrafica/stabilimenti/sedi/modifica'], { queryParams: { id_sede_impresa: this._id_sede } })
  }

  get sede() { return this._sede }
  get ui_sede() { return this._ui_sede }
}
