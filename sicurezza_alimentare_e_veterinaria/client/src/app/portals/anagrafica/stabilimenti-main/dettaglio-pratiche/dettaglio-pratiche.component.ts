/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { LoadingDialogService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-dettaglio-pratiche',
  templateUrl: './dettaglio-pratiche.component.html',
  styleUrls: ['./dettaglio-pratiche.component.scss']
})
export class DettaglioPraticheComponent {
  private _ui: any;
  private _pratiche: any;
  private _id_stabilimento: any;
  disabilitaAggiungi: boolean = false;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private ans: AnagraficaService,
    private LoadingService: LoadingDialogService,
  ) { }
  ngOnInit() {
    this.route.queryParams.subscribe((res: any) => {
      this.ans.getMenu('anagrafica').subscribe((res: any) => {
        if (res.info) {
          let menu = res.info
          menu.forEach((voce: any) => {
            if (voce.cod == 'pratiche' && voce.modality == 'modifica') {
              this.disabilitaAggiungi = true;
            }
          });
        }
      })
      this._id_stabilimento = res['id_stabilimento'];
      this.ans.getPraticheStabilimento(this._id_stabilimento).subscribe((res: any) => {
        this._ui = res.info.ui;
        this._pratiche = res.info.dati;
      })
    })
  }

  goToDettaglio(id_pratica: any) {
    this.router.navigate(['portali/anagrafica/pratiche/dettaglio'], {
      queryParams: { id_pratica: id_pratica },
    });
  }

  goToAggiungiPratica() {
    this.router.navigate(['portali/anagrafica/pratiche/aggiungi'])
  }

  get ui() { return this._ui; }
  get pratiche() { return this._pratiche; }
}
