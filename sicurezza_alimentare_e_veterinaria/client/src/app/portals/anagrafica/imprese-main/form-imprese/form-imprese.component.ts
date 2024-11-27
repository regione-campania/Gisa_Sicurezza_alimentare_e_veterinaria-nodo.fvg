/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ElementRef, Input, OnInit, Renderer2, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';
import { ImpreseUpsertComponent } from '../imprese-upsert/imprese-upsert.component';

@Component({
  selector: 'app-form-imprese',
  templateUrl: './form-imprese.component.html',
  styleUrls: ['./form-imprese.component.scss']
})
export class FormImpreseComponent implements OnInit {
  //--------------------VARIABILI-----------------------
  formImpresa: FormGroup;
  emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
  private _tipiImprese: any;
  tipoOperazione: any;
  flagVerifica: boolean = false;
  isEnabled: boolean = true;
  maxValue: number = 16;
  @Input() _id_impresa_preso: any;
  _id_impresa: any;
  @ViewChild('addObbligatorieta') addObbligatorieta: ElementRef | undefined;
  appendObb: any;
  obbligatorieta: any;
  mostraSDI: boolean = true

  private parix_impresa: any
  //-----------------------COSTRUTTORE-------------------
  constructor(private fb: FormBuilder,
    private route: ActivatedRoute,
    private ComunicazioneDB: BackendCommunicationService,
    private LoadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private renderer: Renderer2
  ) {
    this.formImpresa = this.fb.group({
      nome: this.fb.control(null, [Validators.required]),
      piva: this.fb.control(null, [Validators.required]),
      pec: this.fb.control(null, [Validators.required, Validators.pattern(this.emailPattern)]),
      email: this.fb.control(null, Validators.pattern(this.emailPattern)),
      sdi: this.fb.control(null),
      split_payement: this.fb.control(null),
      cf: this.fb.control(null),
      cod_tipo_impresa: this.fb.control(null, [Validators.required]),
      data_inizio_validita: this.fb.control(null, [Validators.required]),
      data_fine_validita: this.fb.control(null),
    })
  }
  //-------------------------------NGONINIT------------------------------------
  ngOnInit(): void {
    console.log(this.route.snapshot.url[0].path)
    this.tipoOperazione = this.route.snapshot.url[0].path;
    this.route.queryParams.subscribe((res: any) => {
      if (res['parix_impresa']) {
        this.parix_impresa = JSON.parse(res['parix_impresa'])
      }
    })
    if (this.tipoOperazione === 'modifica') {
      this._id_impresa = this._id_impresa_preso
      console.log(this._id_impresa)
      this.flagVerifica = true;
      this.formImpresa.get('cod_tipo_impresa')?.disable();
    }
    else {
      this.notificationService.push({
        notificationClass: 'warning',
        content: "Attenzione! Ricordarsi di controllare il codice fiscale dopo aver inserito il tipo impresa."
      })
    }
    //----------------------------------------------------------------------------------------
    //Funzione per prendere i tipi di imprese per lo stabilimento per creare la select per la modifica
    this.ComunicazioneDB.getDati('get_cu_tipo_imprese').subscribe((res: any) => {
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

  //----------------------------------FUNZIONI-----------------------------------

  checkCodiceFiscale(event: any, form: any) {
    //let datoPreso = event.target.value;
    let formPresa = form.getRawValue();
    if (formPresa.cod_tipo_impresa === 'P' || formPresa.cod_tipo_impresa === 'D') {
      if (formPresa.cf == null || formPresa.cod_tipo_impresa == null) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: "Compilare i campi \"Tipo Impresa\" e Codice \"Fiscale\"."
        })
        return
      }
    }
    const params = {
      cod_fis: form.value.cf,
      tipo_impresa: formPresa.cod_tipo_impresa,
      id_impresa: 0,
    }
    // console.log(params);
    if (this.tipoOperazione === 'modifica') {
      params.id_impresa = +this._id_impresa
      // console.log(params);
    }
    if (!formPresa.cod_tipo_impresa) {
      return;
    }
    this.ComunicazioneDB.getDati('check_esiste_impresa', params).subscribe((res: any) => {
      if (!res.esito) {
        if (formPresa.cod_tipo_impresa === 'P') {
          form.controls.cf.setValue(null);
          form.controls.nome.setValue(null);
        }
        else {
          form.controls.cf.setValue(null);
        }
        return;
      }

      if (!form.value.cf) {
        return;
      }
      // || !formPresa.cod_tipo_impresa
      if (formPresa.cod_tipo_impresa === 'P' || formPresa.cod_tipo_impresa === 'D') {
        this.flagVerifica = true;
        this.ComunicazioneDB.getDati('get_cu_soggetti_fisici_by_sel', { cf: form.value.cf }).subscribe((res: any) => {
          if (!res.esito) {
            if (formPresa.cod_tipo_impresa === 'P') {
              form.controls.nome.setValue(null);
              form.controls.cf.setErrors({ 'incorrect': true })
            }
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
          if (!form.value.nome) {
            //if (formPresa.cod_tipo_impresa === 'P') {
            if (res.info.dati[0].nome || res.info.dati[0].cognome) {
              form.controls.nome.patchValue(res.info.dati[0].cognome + ' ' + res.info.dati[0].nome);
            }
            //}
          }
        })
      }
    })
  }



  checkPIva(event: any, form: any) {
    let datoPreso = event.target.value;
    const params = {
      piva: datoPreso ? datoPreso : null,
      id_impresa: 0,
    }
    // console.log(params);
    if (this.tipoOperazione === 'modifica') {
      params.id_impresa = +this._id_impresa
    }
    this.ComunicazioneDB.getDati('check_esiste_impresa', params).subscribe((res: any) => {
      if (!res.esito) {
        form.controls.piva.setValue(null);
        return;
      }
      //console.log("res check:", res);
    })
  }

  checkDate(event: any, form: any) {

    const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
    let src = event.srcElement as HTMLInputElement;
    let nomeForm = null;
    nomeForm = src.getAttribute('formControlName');
    if (!src.validity.valid || !regex.test(src.value)) form.get(nomeForm).setValue(null)

    // Object.keys(form.controls).forEach((controlName) => {
    //   if (controlName === 'data_inizio_validita' || controlName === 'data_fine_validita') {
    //     nomeForm = controlName;
    //     console.log("nomeForm:",nomeForm);
    //     if (!src.validity.valid || !regex.test(src.value)) {
    //       console.log(nomeForm);
    //       form.get(nomeForm).setValue(null)
    //       console.log("entrato");
    //     }
    //   }
    // })

    form.updateValueAndValidity()
  }

  checkTipoImpresa(event: any) {
    //console.log("valore: ", event.target.value);
    let valoreTipoImpresa = event.target.value;
    //Controllo per varie tipologie di tipo impresa 
    //Se è Pubblica Amministrazione
    this.mostraSDI = true
    if (valoreTipoImpresa === 'Z') {
      this.flagVerifica = true;
      this.formImpresa.controls['piva'].setValue(null);
      this.formImpresa.controls['cf'].setValue(null);
      this.formImpresa.controls['nome'].setValue(null);

      this.maxValue = 13; //Lunghezza massima codice fiscale
      this.formImpresa.get('nome')?.enable();
      this.formImpresa.get('piva')?.enable();
      this.formImpresa.get('sdi')?.enable();
      this.formImpresa.get('split_payement')?.disable();
      this.formImpresa.patchValue({
        split_payement: 'S',
        SDI: null
      })
      this.formImpresa.controls['piva'].addValidators([Validators.required]);
      this.formImpresa.controls['nome'].addValidators([Validators.required]);
      this.formImpresa.controls['cf'].clearValidators();
      this.formImpresa.controls['piva'].updateValueAndValidity();
      this.formImpresa.controls['nome'].updateValueAndValidity();
      this.formImpresa.controls['cf'].updateValueAndValidity();
      document.querySelectorAll('.addObb').forEach((elem: any) => {
        elem.style.display = 'none';
      });
      document.querySelectorAll('.removeObb').forEach((elem: any) => {
        elem.style.display = 'inline';
      })
      //nascondi SDI
      this.mostraSDI = false
    }
    //Se è Persona
    else if (valoreTipoImpresa === 'P') {
      this.formImpresa.controls['piva'].setValue(null);
      this.formImpresa.controls['cf'].setValue(null);
      this.formImpresa.controls['nome'].setValue(null);

      this.maxValue = 16; //Lunghezza massima codice fiscale
      // this.formImpresa.get('nome')?.disable();
      this.formImpresa.get('piva')?.disable();
      this.formImpresa.get('sdi')?.disable();
      this.formImpresa.get('split_payement')?.disable();
      this.formImpresa.patchValue({
        split_payement: 'N',
      })
      this.formImpresa.controls['cf'].addValidators([Validators.required])

      document.querySelectorAll('.addObb').forEach((elem: any) => {
        elem.style.display = 'inline';
      });
      document.querySelectorAll('.removeObb').forEach((elem: any) => {
        elem.style.display = 'none';
      })
      document.querySelectorAll('[formControlName="nome"]').forEach((elem: any) => {
        elem.setAttribute("disabled", true)
      })
      //this.formImpresa.controls['nome'].clearValidators();
      this.formImpresa.controls['nome'].addValidators([Validators.required]);
      this.formImpresa.controls['piva'].clearValidators();
      this.formImpresa.controls['cf'].updateValueAndValidity();
      this.formImpresa.controls['nome'].updateValueAndValidity();
      this.formImpresa.controls['piva'].updateValueAndValidity();

      this.checkCodiceFiscale(null, this.formImpresa)
    }
    //Se è Associazione o Società
    else if (valoreTipoImpresa === 'A' || valoreTipoImpresa === 'S') {
      this.flagVerifica = true;
      this.formImpresa.controls['piva'].setValue(null);
      this.formImpresa.controls['cf'].setValue(null);
      this.formImpresa.controls['nome'].setValue(null);

      this.maxValue = 13; //Lunghezza massima codice fiscale
      this.formImpresa.get('nome')?.enable();
      this.formImpresa.get('piva')?.enable();
      this.formImpresa.get('sdi')?.enable();
      this.formImpresa.get('split_payement')?.enable();
      this.formImpresa.patchValue({
        split_payement: null,
      })
      this.formImpresa.controls['piva'].addValidators([Validators.required]);
      this.formImpresa.controls['nome'].addValidators([Validators.required]);
      this.formImpresa.controls['cf'].clearValidators();
      this.formImpresa.controls['piva'].updateValueAndValidity();
      this.formImpresa.controls['nome'].updateValueAndValidity();
      this.formImpresa.controls['cf'].updateValueAndValidity();
      document.querySelectorAll('.addObb').forEach((elem: any) => {
        elem.style.display = 'none';
      });
      document.querySelectorAll('.removeObb').forEach((elem: any) => {
        elem.style.display = 'inline';
      })
    }
    //Se è Ditta Individuale
    else {
      this.formImpresa.controls['piva'].setValue(null);
      this.formImpresa.controls['cf'].setValue(null);
      this.formImpresa.controls['nome'].setValue(null);

      this.maxValue = 16; //Lunghezza massima codice fiscale
      this.formImpresa.get('nome')?.enable();
      this.formImpresa.get('piva')?.enable();
      this.formImpresa.get('sdi')?.enable();
      this.formImpresa.get('split_payement')?.enable();
      this.formImpresa.patchValue({
        split_payement: null,
      })
      this.formImpresa.controls['piva'].addValidators([Validators.required]);
      this.formImpresa.controls['nome'].addValidators([Validators.required]);
      this.formImpresa.controls['cf'].addValidators([Validators.required]);
      this.formImpresa.controls['piva'].updateValueAndValidity();
      this.formImpresa.controls['nome'].updateValueAndValidity();
      this.formImpresa.controls['cf'].updateValueAndValidity();
      document.querySelectorAll('.addObb').forEach((elem: any) => {
        elem.style.display = 'inline';
      });
      document.querySelectorAll('.removeObb').forEach((elem: any) => {
        elem.style.display = 'inline';
      })
    }

    if (this.parix_impresa) {
      this.formImpresa.patchValue({
        nome: valoreTipoImpresa === 'P' ? null : this.parix_impresa.ESTREMI_IMPRESA[0].DENOMINAZIONE[0],
        piva: valoreTipoImpresa === 'P' ? null : this.parix_impresa.ESTREMI_IMPRESA[0].PARTITA_IVA[0],
        cf: this.parix_impresa.ESTREMI_IMPRESA[0].CODICE_FISCALE[0],
        pec: this.parix_impresa.INFORMAZIONI_SEDE[0].INDIRIZZO[0].INDIRIZZO_PEC ? this.parix_impresa.INFORMAZIONI_SEDE[0].INDIRIZZO[0].INDIRIZZO_PEC[0] : ''
      })
    }

  }
  clearNomeImpresa() {
    this.formImpresa.controls['nome'].setValue(null);
    this.formImpresa.updateValueAndValidity();
  }
  //----------------------------------GETTER E SETTER--------------------------------
  get tipiImprese() { return this._tipiImprese; }
}
