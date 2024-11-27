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
  selector: 'app-linee-dettaglio',
  templateUrl: './linee-dettaglio.component.html',
  styleUrls: ['./linee-dettaglio.component.scss']
})
export class LineeDettaglioComponent {

  private _id_linea: any
  private _linea: any
  private _ui_linea: any
  disabilitaModifica: boolean = false;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private cus: AnagraficaService,
    private LoadingService: LoadingDialogService
  ) { }

  ngOnInit() {
    this.LoadingService.openDialog()
    this.route.queryParams.subscribe(params => {
      this._id_linea = +params['id_linea']

      this.cus.getStabilimentiLineeSingolo(this._id_linea).subscribe((res: any) => {

        if (res.info) {
          this._linea = res.info.dati[0]
          this._ui_linea = res.info.ui
          this.disabilitaModifica = res.info.dati[0].linee_modificabili;
        }
        this.LoadingService.closeDialog()
      });
    });
  }

  goToModifica() {
    if (this.disabilitaModifica == false) {
      return;
    }
    this.router.navigate(['portali/anagrafica/stabilimenti/linee/modifica'], { queryParams: { id_linea: this._id_linea } })
  }

  goToStabilimento() {
    //this.LoadingService.openDialog()
    this.router.navigate(['portali/anagrafica/stabilimenti/dettaglio'], { queryParams: { id_stabilimento: this._linea.id_stabilimento } })
  }

  get linea() { return this._linea }
  get ui_linea() { return this._ui_linea }

}
