/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { FormConfig, LoadingDialogService } from '@us/utils';
import { AnagraficaService } from '../anagrafica.service';
import { map, of } from 'rxjs';
import { SharedService } from 'src/app/shared/shared.service';
import { AppService } from 'src/app/app.service';
import { SharedDataService } from 'src/app/services/shared-data.service';

@Component({
  selector: 'app-soggetti-main',
  templateUrl: './soggetti-main.component.html',
  styleUrls: ['./soggetti-main.component.scss']
})
export class SoggettiMainComponent implements OnInit {

  private _ui_soggetti: any
  private _soggetti: any
  formConfig: any;
  disabilitaAnag: boolean = true
  loadingSoggetti = false;
  isUserResponsabile = false;

  constructor(
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private ans: AnagraficaService,
    private router: Router,
    private route: ActivatedRoute,
    private changeDetector: ChangeDetectorRef,
    private sharedService: SharedService,
    private sharedData: SharedDataService,
    private app: AppService
  ) {
    this.formConfig = this.sharedService
      .getFormDefinition('cu/', 'cu.sel_soggetti_fisici')
      .pipe(
        map((res) => {
          return { info: JSON.parse(res.info[0]['configurazione']) };
        })
      );
  }

  ngOnInit(): void {
    this.isUserResponsabile = this.sharedData.get('activeMenuItem').modality == 'modifica'
  }

  ricercaSoggetti(params: any) {
    this.loadingSoggetti = true;
    this._soggetti = null;
    this._ui_soggetti = null;
    this.ans.getSoggettiBySel(params).subscribe((res: any) => {
      this.loadingSoggetti = false;
      if (res.info) {
        this._soggetti = res.info.dati
        this._ui_soggetti = res.info.ui
      }
    });
  }

  ngAfterViewChecked() {
    this.changeDetector.detectChanges()
  }

  goToAggiungiSoggetto() {
    this.router.navigate(['portali/anagrafica/soggetti-fisici/aggiungi'], { queryParams: { id_soggetto_fisico: null } })
  }

  goToDettaglio(id_soggetto_fisico: any) {
    this.router.navigate(['portali/anagrafica/soggetti-fisici/dettaglio'], { queryParams: { id_soggetto_fisico: +id_soggetto_fisico } })
  }

  goToVerificaAnagrafica(params: any) {
    if (this.disabilitaAnag == true) {
      return;
    }
    let queryParams = {
      nome: params.nome,
      cognome: params.cognome,
      cf: params.cf
    }
    this.router.navigate(['portali/anagrafica/soggetti-fisici/anagrafica-assistiti'], { queryParams: queryParams })
  }

  onFormValueChange(formData: any) {
    // this.disabilitaAnag = true;
    // for (let key in formData) {
    //   if (key != 'limite' && (formData[key] != null && formData[key] != ''))
    //     this.disabilitaAnag = false;
    // }

    if ((formData.nome != null && formData.nome != '' && formData.cognome != null && formData.cognome != '')
      || formData.cf != null && formData.cf != '') {
      this.disabilitaAnag = false
    } else {
      this.disabilitaAnag = true
    }
  }

  get soggetti() { return this._soggetti }
  get ui_soggetti() { return this._ui_soggetti }
}
