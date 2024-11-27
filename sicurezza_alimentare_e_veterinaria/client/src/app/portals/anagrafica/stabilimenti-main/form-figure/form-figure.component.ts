/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, OnInit, Output, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';
import { FormIndirizzoMainComponent } from '../../form-indirizzo-main/form-indirizzo-main.component';

@Component({
  selector: 'app-form-figure',
  templateUrl: './form-figure.component.html',
  styleUrls: ['./form-figure.component.scss']
})
export class FormFigureComponent implements OnInit {
  //----------------------------VARIABILI---------------------
  private _tipiFigure: any;
  private _retDatiFigure?: any;
  formFigura: FormGroup;
  dataMin: any;
  _id_stabilimento: any;
  _id_impresa: any;
  tipoOperazione: any;
  parix_soggetto: any;
  stabilimento: any;
  impresa: any;
  valoreResidenza: any;
  idIndirizzoSoggetto: any;
  private _uiInd: any;
  private _indirizzo: any;
  @ViewChild('formIndirizzo') _formIndirizzo?: FormIndirizzoMainComponent;
  @Output() valueEmitted = new EventEmitter<any>();
  //--------------------COSTRUTTORE---------------------------
  constructor(
    private ComunicazioneDB: BackendCommunicationService,
    private LoadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private router: Router,
    private fb: FormBuilder,
    private cus: AnagraficaService
  ) {
    this.formFigura = this.fb.group({
      figura: this.fb.control(null, [Validators.required]),
      nome: this.fb.control(null, [Validators.required]),
      cognome: this.fb.control(null, [Validators.required]),
      cf: this.fb.control(null, [Validators.required]),
      data_inizio_validita: this.fb.control(null, [Validators.required]),
      data_fine_validita: this.fb.control(null),
      valore: this.fb.control(null, [Validators.required]),
    })
  }
  //------------------NGONINIT--------------------------------
  ngOnInit(): void {
    this.route.queryParams.subscribe((res: any) => {
      console.log("path form figure:", this.route.snapshot.url[0].path)
      this.tipoOperazione = this.route.snapshot.url[0].path;
      if (res['parix_soggetto']) {
        this.parix_soggetto = JSON.parse(res['parix_soggetto'])
      }
      if (res['id_stabilimento']) {
        this._id_stabilimento = res['id_stabilimento'];
        this.cus.getStabilimentoSingolo(this._id_stabilimento).subscribe((res: any) => {
          if (res.esito) {
            this.stabilimento = res.info.dati[0]
            console.log(this.stabilimento)
            this.dataMin = (this.stabilimento.inizio_validita).split('T')[0]
          }
        })
        this.cus.getStabilimentiFigure(this._id_stabilimento).subscribe((res: any) => {
          this._retDatiFigure = res.info?.dati;
          if (!res.esito) {
            return;
          }
          this.cus.getTipiFigure().subscribe((res: any) => {
            if (!res.esito) {
              this.LoadingService.closeDialog();
              return;
            }
            if (!res.info) {
              return;
            }
            console.log("dati tipo figure", res);
            if (!res.esito) {
              return;
            }
            this._tipiFigure = res.info?.dati;
            if (!res['parix_soggetto']) {
              if (this._retDatiFigure) {
                for (let i = 0; i < this._retDatiFigure.length; i++) {
                  if (!this._retDatiFigure[i].fine_validita) {
                    this._tipiFigure = this._tipiFigure.filter((elem: any) => elem.sigla !== this._retDatiFigure[i].sigla_tipo_figura);
                  }
                }
              }
            }
          })
        })
      }
      if (res['id_impresa']) {
        this._id_impresa = res['id_impresa'];
        this.cus.getImpresaSingolo(this._id_impresa).subscribe((res: any) => {
          if (res.esito) {
            this.impresa = res.info.dati[0];
            console.log(this.impresa);
          }
        })
        this.cus.getImpreseFigure(this._id_impresa).subscribe((res: any) => {
          this._retDatiFigure = res.info?.dati;
          if (!res.esito) {
            return;
          }
          this.cus.getTipiFigureImpresa().subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            this._tipiFigure = res.info?.dati
            if (!res['parix_soggetto']) {
              if (this._retDatiFigure) {
                for (let i = 0; i < this._retDatiFigure.length; i++) {
                  if (this._retDatiFigure[i].sigla_tipo_figura === 'Legale Rappresentante') {
                    if (!this._retDatiFigure[i].fine_validita) {
                      this._tipiFigure = this._tipiFigure.filter((elem: any) => (elem.sigla !== this._retDatiFigure[i].sigla_tipo_figura));
                    }
                  }
                }
              }
            }
          })
        })
      }
    })
  }
  //--------------------------FUNZIONI-------------------------------
  checkDate(event: any, form: any) {
    const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
    let src = event.srcElement as HTMLInputElement;
    let nomeForm = null;
    //console.log(src.getAttribute('formControlName'));
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

    form.updateValueAndValidity()
  }

  //Controllo sul codice fiscale e se c'è valorizzazione del nome e cognome per quando si aggiunge la figura
  checkCodiceFiscale(event: any, form: any) {
    //console.log("valore evento:", event.target.value);
    let cfPreso = event.target.value;
    form.controls.nome.setValue("");
    form.controls.cognome.setValue("");
    const params = {
      cf: cfPreso
    }
    //Mi serve perchè parte la chiamata una seconda volta con valori vuoti e quindi non faccio partire la chiamata al DB
    if (cfPreso == null || cfPreso == '') {
      return;
    }
    this.ComunicazioneDB.getDati('get_cu_soggetti_fisici_by_sel', params).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      if (!res.info) {
        this.notificationService.push({
          notificationClass: 'error',
          content: "Codice fiscale inesistente"
        });
        return;
      }

      console.log("res soggetti:", res);
      if (res.info.dati[0].nome || res.info.dati[0].cognome) {
        form.controls.nome.setValue(res.info.dati[0].nome);
        form.controls.cognome.setValue(res.info.dati[0].cognome);
      }
      this.idIndirizzoSoggetto = res.info.dati[0].indirizzo_id;
      this.ComunicazioneDB.getDati('get_cu_indirizzi', { id_indirizzo: parseInt(this.idIndirizzoSoggetto) }).subscribe((res: any) => {
        this._uiInd = res.info.ui;
        this._indirizzo = res.info.dati[0];
      })
    })
  }

  checkValoreResidenza(event: any) {
    this.valoreResidenza = event.target.value;
    console.log("ci sono", this.valoreResidenza);
    this.valueEmitted.emit(this.valoreResidenza);
  }
  //   public removeValidators(form: FormGroup) {
  //     for (const key in form.controls) {
  //         form.get(key).clearValidators();
  //         form.get(key).updateValueAndValidity();
  //     }
  // }


  //     public addValidators(form: FormGroup) {
  //     for (const key in form.controls) {
  //         form.get(key).setValidators([Validators.required]);
  //         form.get(key).updateValueAndValidity();
  //     }
  // }
  //------------------GETTER E SETTER-------------------------
  get tipiFigure() { return this._tipiFigure; }
  get uiInd() { return this._uiInd; }
  get indirizzo() { return this._indirizzo; }
  set set_uiInd(x: any) { this._uiInd = x; }
  set set_indirizzo(x: any) { this._indirizzo = x; }
  public setValoreResidenza(x: any) {
    this.valoreResidenza = x;
  }
}
