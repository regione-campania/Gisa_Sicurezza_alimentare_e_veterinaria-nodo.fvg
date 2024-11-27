/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, Input, Output } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { options } from '@fullcalendar/core/preact';
import { FormConfig, LoadingDialogService } from '@us/utils';
import { map, of } from 'rxjs';
import { AppService } from 'src/app/app.service';
import { SharedService } from 'src/app/shared/shared.service';
import { SharedDataService } from 'src/app/services/shared-data.service';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';
import { AnagraficaService } from '../../anagrafica/anagrafica.service';

@Component({
  selector: 'app-durata-cu',
  templateUrl: './durata-cu.component.html',
  styleUrls: ['./durata-cu.component.scss']
})
export class DurataCuComponent {

  private _ui: any;
  private _controlli: any;
  private _tipologia_struttura: any;

  @Input() selezionaStab?: any;
  loadingDurataCU = false;

  constructor(
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute,
    private sharedService: SharedService,
    private app: AppService,
    private sharedData: SharedDataService,
    private cu: ControlliUfficialiService,
    private cus: AnagraficaService,
  ) { }

  formConfig: any;
  isUserResponsabile = false;

  ngOnInit() {
    this.isUserResponsabile = this.sharedData.get('activeMenuItem').modality == 'modifica'
    this.LoadingService.openDialog();
    this.cus.getTipologiaStrutturaAll().subscribe((res: any) => {
      this.LoadingService.closeDialog();
      if (res.esito) {
        // this._tipologia_struttura = res.info.dati; bugfix issue #11561
        this._tipologia_struttura = [
          { id_tipologia_struttura: null, descrizione: '' },
        ];
        this._tipologia_struttura.push(...res.info.dati);
        this.formConfig = this.sharedService
          .getFormDefinition('cu/', 'cu.sel_durata_cu')
          .pipe(
            map((res) => {
              let info = JSON.parse(res.info[0]['configurazione']);
              let control = info['controls'].find(
                (c: any) => c.name == 'id_tipologia_struttura'
              );
              control.options = this._tipologia_struttura.map((obj: any) => {
                return {
                  value: obj.id_tipologia_struttura,
                  innerText: obj.descrizione,
                };
              });
              return { info: info };
            })
          );
      }
    });
  }

  ricercaStabilimenti(params: any) {
    this.loadingDurataCU = true;
    this._controlli = null;
    this._ui = null;
    this.cu.getCuDurataCuBySel(params).subscribe((res: any) => {
      this.loadingDurataCU = false;
      if (res.info) {
        this._controlli = res.info.dati;
        this._ui = res.info.ui;
      }
    })
  }

  goToDettaglio(id_cu: any) {
    this.router.navigate(["portali/controlli-ufficiali/lista/dettaglio"], { queryParams: { id_cu: id_cu } });
  }

  get controlli() {
    return this._controlli;
  }
  get ui() {
    return this._ui;
  }
}
