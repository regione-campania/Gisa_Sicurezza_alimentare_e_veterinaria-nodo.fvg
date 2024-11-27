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
import { AnagraficaService } from '../anagrafica.service';
import { AppService } from 'src/app/app.service';
import { SharedService } from 'src/app/shared/shared.service';
import { SharedDataService } from 'src/app/services/shared-data.service';

@Component({
  selector: 'app-stabilimenti-main',
  templateUrl: './stabilimenti-main.component.html',
  styleUrls: ['./stabilimenti-main.component.scss'],
})
export class StabilimentiMainComponent {
  @Output() valueEmitted = new EventEmitter<string>();

  private _ui_stabilimenti: any;
  private _stabilimenti: any;
  private _tipologia_struttura: any;

  @Input() selezionaStab?: any;
  loadingStabilimenti = false;

  constructor(
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private cus: AnagraficaService,
    private router: Router,
    private route: ActivatedRoute,
    private sharedService: SharedService,
    private app: AppService,
    private sharedData: SharedDataService
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
          .getFormDefinition('cu/', 'cu.sel_stabilimenti')
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
    this.loadingStabilimenti = true;
    this._stabilimenti = null;
    this._ui_stabilimenti = null;
    this.cus.getStabilimentiBySel(params).subscribe((res: any) => {
      this.loadingStabilimenti = false;
      if (res.info) {
        this._stabilimenti = res.info.dati;
        this._ui_stabilimenti = res.info.ui;
      }
    });
  }

  goToDettaglio(id_stabilimento: any) {
    this.router.navigate(['portali/anagrafica/stabilimenti/dettaglio'], {
      queryParams: { id_stabilimento: id_stabilimento },
    });
  }

  goToAggiungiStabilimento() {
    this.router.navigate(['portali/anagrafica/stabilimenti/aggiungi'], {
      queryParams: { id_impresa: null },
    });
  }

  selezionaImpresa(id_stabilimento: any) {
    let rows = document.querySelectorAll('button[id^="riga_"]');
    rows.forEach((el: any) => {
      if (el.id == 'riga_' + id_stabilimento) {
        el.className = 'btn btn-primary ms-auto';
        el.innerText = 'Selezionato';
      } else {
        el.className = 'btn btn-secondary ms-auto';
        el.innerText = 'Seleziona';
      }
    });
    this.valueEmitted.emit(id_stabilimento);
  }

  get stabilimenti() {
    return this._stabilimenti;
  }
  get ui_stabilimenti() {
    return this._ui_stabilimenti;
  }
  get tipologia_struttura() {
    return this._tipologia_struttura;
  }
}
