/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';

@Component({
  selector: 'app-form-sedi',
  templateUrl: './form-sedi.component.html',
  styleUrls: ['./form-sedi.component.scss']
})
export class FormSediComponent implements OnInit {
  //------------------------------------VARIABILI--------------------------
  emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
  formSede: FormGroup;
  _id_stabilimento: any;
  _id_impresa: any;
  _id_sede: any;
  dataMin: any;
  stabilimento: any;
  impresa: any;
  private _retDatiSedi: any;
  private _tipiSedi: any;
  private _tipiImprese: any;
  tipoOperazione: any;
  disabilitaTipoSede: boolean = false
  sede: any
  //----------------------------COSTRUTTORE-------------------------
  constructor(
    private LoadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private router: Router,
    private fb: FormBuilder,
    private cus: AnagraficaService,
  ) {
    this.formSede = this.fb.group({
      sede: this.fb.control(null, [Validators.required]),
      descr_sede: this.fb.control(""),
      // piva: this.fb.control(null, [Validators.required]),
      pec: this.fb.control(null, [Validators.required, Validators.pattern(this.emailPattern)]),
      email: this.fb.control(null, [Validators.pattern(this.emailPattern)]),
      // sdi: this.fb.control(null, [Validators.required]),
      // split_payement: this.fb.control(null, [Validators.required]),
      // cf: this.fb.control(null, [Validators.required]),
      // cod_tipo_impresa: this.fb.control(null, [Validators.required]),
      data_inizio_validita: this.fb.control(null, [Validators.required]),
      data_fine_validita: this.fb.control(null),
    })
  }
  //-------------------------------NGONINIT-------------------------------
  ngOnInit(): void {
    this.route.queryParams.subscribe((res: any) => {
      console.log("path form sedi:", this.route.snapshot.url[0].path)
      this.tipoOperazione = this.route.snapshot.url[0].path;
      this.tipoOperazione === 'modifica' ? this.disabilitaTipoSede = true : this.disabilitaTipoSede = false;

      if (res['id_stabilimento']) {
        this._id_stabilimento = res['id_stabilimento'];
        this.cus.getStabilimentoSingolo(this._id_stabilimento).subscribe((res: any) => {
          if (res.esito) {
            this.stabilimento = res.info.dati[0]
            console.log(this.stabilimento)
            this.dataMin = (this.stabilimento.inizio_validita).split('T')[0]
            this.formSede.controls['pec'].setValue(this.stabilimento.pec_impresa);
          }
        })
        this.cus.getStabilimentiSedi(this._id_stabilimento).subscribe((res: any) => {
          if (!res.esito) {
            return;
          }
          this._retDatiSedi = res.info?.dati;
          this.cus.getTipiSedi().subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            this._tipiSedi = res.info?.dati;
            if (this._retDatiSedi) {
              for (let i = 0; i < this._retDatiSedi.length; i++) {
                if (!this._retDatiSedi[i].fine_validita) {
                  this._tipiSedi = this._tipiSedi.filter((elem: any) => elem.sigla !== this._retDatiSedi[i].sigla_tipo_sede);
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
            this.formSede.controls['pec'].setValue(this.impresa.pec);
          }
        })

        this.cus.getImpreseSedi(this._id_impresa).subscribe((res: any) => {
          if (!res.esito) {
            return;
          }
          this._retDatiSedi = res.info?.dati;
          console.log(this._retDatiSedi);
          this.cus.getTipiSediImpresa().subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            this._tipiSedi = res.info?.dati;
            console.log(this._tipiSedi);
            if (this._retDatiSedi) {
              for (let i = 0; i < this._retDatiSedi.length; i++) {
                if (!this._retDatiSedi[i].fine_validita) {
                  this._tipiSedi = this._tipiSedi.filter((elem: any) => elem.sigla !== this._retDatiSedi[i].sigla_tipo_sede);
                }
              }
            }
          })
        })

        this.cus.getTipiImprese().subscribe((res: any) => {
          if (!res.esito) {
            this.LoadingService.closeDialog();
            return;
          }
          if (!res.info) {
            return;
          }
          console.log("dati tipo imprese", res);
          this._tipiImprese = res.info.dati;
        })
      }

      if (res['id_sede']) {
        this._id_sede = res['id_sede']
        this.cus.getStabilimentiSediSingolo(this._id_sede).subscribe((res: any) => {
          if (!res.esito) {
            return;
          }
          this._retDatiSedi = res.info?.dati;
          this.cus.getTipiSedi().subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            this._tipiSedi = res.info?.dati;
            if (this._retDatiSedi) {
              for (let i = 0; i < this._retDatiSedi.length; i++) {
                if (!this._retDatiSedi[i].fine_validita) {
                  this._tipiSedi = this._tipiSedi.filter((elem: any) => elem.sigla !== this._retDatiSedi[i].sigla_tipo_sede);
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
    nomeForm = src.getAttribute('formControlName');
    if (!src.validity.valid || !regex.test(src.value)) {
      form.get(nomeForm).setValue("")
      console.log("entrato");
    }

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
  //-----------------------GETTER E SETTER---------------------------
  get tipiSedi() { return this._tipiSedi; }
  get tipiImprese() { return this._tipiImprese; }

  setTipiSedi(sedi: any) { this._tipiSedi = sedi }
  setDisabilitaTipoSede(bool: boolean) { this.disabilitaTipoSede = bool }
}
