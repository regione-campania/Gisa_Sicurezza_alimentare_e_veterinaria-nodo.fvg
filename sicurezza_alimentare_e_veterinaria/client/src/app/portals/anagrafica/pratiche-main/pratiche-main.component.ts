/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { LoadingDialogService } from '@us/utils';
import { map } from 'rxjs';
import { SharedService } from 'src/app/shared/shared.service';
import { AnagraficaService } from '../anagrafica.service';
import { AppService } from 'src/app/app.service';
import { SharedDataService } from 'src/app/services/shared-data.service';

@Component({
  selector: 'app-pratiche-main',
  templateUrl: './pratiche-main.component.html',
  styleUrls: ['./pratiche-main.component.scss']
})
export class PraticheMainComponent {

  private _ui_pratiche: any;
  private _pratiche: any;

  private _tipi_pratiche: any

  loadingPratiche = false;
  formConfig: any;
  isUserResponsabile: any

  constructor(
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private cus: AnagraficaService,
    private router: Router,
    private route: ActivatedRoute,
    private sharedService: SharedService,
    private sharedData: SharedDataService,
    private app: AppService
  ) { }

  ngOnInit() {

    this.isUserResponsabile = this.sharedData.get('activeMenuItem').modality == 'modifica'

    this.cus.getTipiPratiche().subscribe((res: any) => {
      if (res.info) {

        this._tipi_pratiche = [{ "id_tipo_pratiche": null, "id": "", "descr": "" }]
        this._tipi_pratiche.push(...res.info.dati)
        this.formConfig = this.sharedService
          .getFormDefinition('cu/', 'cu.sel_pratiche')
          .pipe(
            map((res) => {
              let info = JSON.parse(res.info[0]['configurazione']);
              let control = info['controls'].find((c: any) => c.name == 'id_tipo_pratiche');
              control.options =
                this._tipi_pratiche
                  .map((obj: any) => { return { value: obj.id_tipo_pratiche, innerText: obj.descr } })
              return { info: info };
            })
          );
      }
    })
  }

  ricercaPratiche(params: any) {
    this.loadingPratiche = true;
    this._pratiche = null;
    this._ui_pratiche = null;
    //params.vigenti = this.aggiungiPratiche ? true : false;
    console.log(params)
    this.cus.getPraticheBySel(params).subscribe((res: any) => {
      this.loadingPratiche = false;
      if (res.info) {
        this._pratiche = res.info.dati;
        this._ui_pratiche = res.info.ui;
      }
    });
  }

  goToDettaglio(id_pratica: any) {
    this.router.navigate(['portali/anagrafica/pratiche/dettaglio'], {
      queryParams: { id_pratica: id_pratica },
    });
  }

  goToAggiungi() {
    this.router.navigate(['portali/anagrafica/pratiche/aggiungi'], {
      queryParams: { id_pratica: null },
    });
  }


  get ui_pratiche() { return this._ui_pratiche; }
  get pratiche() { return this._pratiche; }

}
