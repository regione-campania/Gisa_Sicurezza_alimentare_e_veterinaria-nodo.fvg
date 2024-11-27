/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, Input, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { LoadingDialogService } from '@us/utils';
import { AnagraficaService } from '../anagrafica.service';
import { ActivatedRoute, Router } from '@angular/router';
import { SharedService } from 'src/app/shared/shared.service';
import { AppService } from 'src/app/app.service';
import { map } from 'rxjs';
import { SharedDataService } from 'src/app/services/shared-data.service';

@Component({
  selector: 'app-automezzi-main',
  templateUrl: './automezzi-main.component.html',
  styleUrls: ['./automezzi-main.component.scss']
})
export class AutomezziMainComponent {
  @Output() valueEmitted = new EventEmitter<string>();

  private _ui_automezzi: any;
  private _automezzi: any;

  @Input() selezionaStab?: any;
  loadingAutomezzi = false;
  formConfig: any;
  formConfigStab: any;
  formDataStab: FormGroup
  _operazione: any;

  private _ui_stabilimenti: any;
  private _stabilimenti: any;
  private _tipologia_struttura: any;

  loadingStabilimenti = false;
  isUserResponsabile = false;

  constructor(
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private cus: AnagraficaService,
    private router: Router,
    private route: ActivatedRoute,
    private sharedService: SharedService,
    private app: AppService,
    private sharedData: SharedDataService
  ) {
    this.formDataStab = this.fb.group({
      data_inizio_validita: this.fb.control(null, [Validators.required]),
      data_fine_validita: this.fb.control(null),
      id_stabilimento: this.fb.control(null, [Validators.required]),
    })
  }

  ngOnInit() {
    this.isUserResponsabile = this.sharedData.get('activeMenuItem').modality == 'modifica'
    this.formConfig = this.sharedService
      .getFormDefinition('cu/', 'cu.sel_automezzi')
      .pipe(
        map((res) => {
          let info = JSON.parse(res.info[0]['configurazione']);
          return { info: info };
        })
      );
    if (this.selezionaStab == true) {
      this.LoadingService.openDialog();
      this.LoadingService.closeDialog();
      this.formConfigStab = this.sharedService
        .getFormDefinition('cu/', 'cu.sel_stabilimenti_automezzi')
        .pipe(
          map((res) => {
            let info = JSON.parse(res.info[0]['configurazione']);
            return { info: info };
          })
        );
    }
  }

  ricercaAutomezzi(params: any) {
    this.loadingAutomezzi = true;
    this._automezzi = null;
    this._ui_automezzi = null;
    this.cus.getAutomezziBySel(params).subscribe((res: any) => {
      this.loadingAutomezzi = false;
      if (res.info) {
        this._automezzi = res.info.dati;
        this._ui_automezzi = res.info.ui;
      }
    });
  }

  goToAggiungiAutomezzo() {
    this.router.navigate(['portali/anagrafica/automezzi/aggiungi']);
  }

  goToDettaglio(id_automezzo: any) {
    this.router.navigate(['portali/anagrafica/automezzi/dettaglio'], {
      queryParams: { id_automezzo: +id_automezzo },
    });
  }

  selezionaStabilimento(id_stabilimento: any) {
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

  checkDate(event: any, form: any) {
    const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
    let src = event.srcElement as HTMLInputElement;
    let nomeForm = null;
    nomeForm = src.getAttribute('formControlName');
    if (!src.validity.valid || !regex.test(src.value)) form.get(nomeForm).setValue("")


    // Object.keys(form.controls).forEach((controlName) => {
    //   if (controlName === 'data_inizio_validita' || controlName === 'data_fine_validita') {
    //     nomeForm = controlName;
    //     console.log("nomeForm:",nomeForm);
    //     if (!src.validity.valid || !regex.test(src.value)) {
    //       console.log(nomeForm);
    //       form.get(nomeForm).setValue("")
    //       console.log("entrato");
    //     }
    //   }
    // })

  }
  get automezzi() {
    return this._automezzi;
  }
  get ui_automezzi() {
    return this._ui_automezzi;
  }
  get stabilimenti() {
    return this._stabilimenti;
  }
  get ui_stabilimenti() {
    return this._ui_stabilimenti;
  }

  set setOperazione(x: any) { this._operazione = x; }
}
