/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, Output } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { LoadingDialogService } from '@us/utils';
import { AnagraficaService } from '../anagrafica.service';
import { ActivatedRoute, Router } from '@angular/router';
import { map, of, share } from 'rxjs';
import { SharedService } from 'src/app/shared/shared.service';
import { AppService } from 'src/app/app.service';
import { anagraficaUnicaService } from '../../controlli-ufficiali/services/anagraficaUnica.service';
import { SharedDataService } from 'src/app/services/shared-data.service';

@Component({
  selector: 'app-imprese-main',
  templateUrl: './imprese-main.component.html',
  styleUrls: ['./imprese-main.component.scss'],
})
export class ImpreseMainComponent {
  @Output() valueEmitted = new EventEmitter<string>();
  aggiungiStabilimento: boolean = false;
  private _ui_imprese: any;
  private _imprese: any;
  private piva: any;
  pivaDaInviare: any = [];

  loadingImprese = false;

  formConfig: any;
  isUserResponsabile = false;

  constructor(
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private cus: AnagraficaService,
    private router: Router,
    private route: ActivatedRoute,
    private sharedService: SharedService,
    private app: AppService,
    private aus: anagraficaUnicaService,
    private sharedData: SharedDataService
  ) {
    this.formConfig = this.sharedService
      .getFormDefinition('cu/', 'cu.sel_imprese')
      .pipe(
        map((res) => {
          return { info: JSON.parse(res.info[0]['configurazione']) };
        })
      );
  }

  ngOnInit() {
    this.isUserResponsabile = this.sharedData.get('activeMenuItem').modality == 'modifica'
    if (
      this.route.snapshot.url[0] != undefined &&
      (this.route.snapshot.url[0].path === 'aggiungi' ||
        this.route.snapshot.url[0].path === 'subingresso')
    ) {
      this.aggiungiStabilimento = true;
    }
  }

  ricercaImprese(params: any) {
    this.loadingImprese = true;
    this._imprese = null;
    this._ui_imprese = null;
    params.vigenti = this.aggiungiStabilimento ? true : false;
    this.cus.getImpreseBySel(params).subscribe((res: any) => {
      this.loadingImprese = false;
      if (res.info) {
        this._imprese = res.info.dati;
        this._ui_imprese = res.info.ui;
      }
    });
  }

  goToDettaglio(id_impresa: any) {
    this.router.navigate(['portali/anagrafica/imprese/dettaglio'], {
      queryParams: { id_impresa: id_impresa },
    });
  }

  goToAggiungi() {
    this.router.navigate(['portali/anagrafica/imprese/aggiungi'], {
      queryParams: { id_impresa: null },
    });
  }

  selezionaImpresa(id_impresa: any) {
    let rows = document.querySelectorAll('button[id^="riga_"]');
    rows.forEach((el: any) => {
      if (el.id == 'riga_' + id_impresa) {
        el.className = 'btn btn-primary ms-auto';
        el.innerText = 'Selezionato';
      } else {
        el.className = 'btn btn-secondary ms-auto';
        el.innerText = 'Seleziona';
      }
    });
    this.valueEmitted.emit(id_impresa);
  }

  get ui_imprese() {
    return this._ui_imprese;
  }
  get imprese() {
    return this._imprese;
  }
}
