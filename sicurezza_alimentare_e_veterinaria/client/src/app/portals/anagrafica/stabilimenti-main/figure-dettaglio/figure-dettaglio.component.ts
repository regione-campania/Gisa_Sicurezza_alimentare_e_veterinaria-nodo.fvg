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
  selector: 'app-figure-dettaglio',
  templateUrl: './figure-dettaglio.component.html',
  styleUrls: ['./figure-dettaglio.component.scss']
})
export class FigureDettaglioComponent {

  private _id_figura: any
  private _figura: any
  private _ui_figura: any
  disabilitaModifica: boolean = false;
  intestazione: any

  private impORstab: "" | "imp" | "stab" = "";

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private cus: AnagraficaService,
    private LoadingService: LoadingDialogService
  ) { }

  ngOnInit() {
    this.LoadingService.openDialog()
    this.route.queryParams.subscribe(params => {
      //this._id_figura = +params['id_figura']

      if (params['id_stabilimento_figura']) {
        this._id_figura = +params['id_stabilimento_figura']
        this.impORstab = "stab"
        this.intestazione = "Stabilimento"
        this.cus.getStabilimentiFigureSingolo(this._id_figura).subscribe((res: any) => {

          if (res.info) {
            this._figura = res.info.dati[0]
            this._ui_figura = res.info.ui
            this.disabilitaModifica = res.info.dati[0].figure_modificabili;
          }
          this.LoadingService.closeDialog()
        });
      }

      if (params['id_impresa_figura']) {
        this._id_figura = +params['id_impresa_figura']
        this.impORstab = "imp"
        this.intestazione = "Impresa"
        this.cus.getImpreseFigureSingolo(this._id_figura).subscribe((res: any) => {
          if (res.info) {
            this._figura = res.info.dati[0]
            this._ui_figura = res.info.ui
            this.disabilitaModifica = res.info.dati[0].figure_modificabili;
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
    if (this.impORstab == "stab")
      this.router.navigate(['portali/anagrafica/stabilimenti/figure/modifica'], { queryParams: { id_stabilimento_figura: this._id_figura } })
    if (this.impORstab == "imp")
      this.router.navigate(['portali/anagrafica/stabilimenti/figure/modifica'], { queryParams: { id_impresa_figura: this._id_figura } })
  }

  get figura() { return this._figura }
  get ui_figura() { return this._ui_figura }
}
