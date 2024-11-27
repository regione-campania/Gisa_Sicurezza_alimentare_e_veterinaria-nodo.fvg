/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { formatDate } from '@angular/common';
import { Component, Input } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { LoadingDialogService } from '@us/utils';
import { AnagraficaService } from '../../../anagrafica.service';

@Component({
  selector: 'app-form-soggetti',
  templateUrl: './form-soggetti.component.html',
  styleUrls: ['./form-soggetti.component.scss']
})
export class FormSoggettiComponent {

  emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
  modifica: boolean = false;
  dataMax: any;
  formatDataMax: any;
  private _datiCodiciNascita: any;
  private _datoNascitaSoggetto: any;
  @Input() _id_soggetto_fisico_preso: any;
  _id_soggetto_fisico: any;

  constructor(
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private ans: AnagraficaService,
    private route: ActivatedRoute,
  ) { }

  formSoggetto = this.fb.group({
    nome: this.fb.control(null, [Validators.required]),
    cognome: this.fb.control(null, [Validators.required]),
    comune_nascita: this.fb.control(null, [Validators.required]),
    codice_fiscale: this.fb.control(null, [Validators.required]),
    sesso: this.fb.control(null, [Validators.required]),
    telefono: this.fb.control(null),
    email: this.fb.control(null, Validators.pattern(this.emailPattern)),
    pec: this.fb.control(null, [Validators.pattern(this.emailPattern)]),
    telefono2: this.fb.control(null),
    data_nascita: this.fb.control(null, [Validators.required]),
    documento_identita: this.fb.control(null),
  })


  ngOnInit() {
    this.LoadingService.openDialog()
    this._id_soggetto_fisico = 0;
    this.formSoggetto.controls['sesso'].disable();
    this.route.queryParams.subscribe((res: any) => {
      if (res['cf_utente']) {
        this.formSoggetto.controls.codice_fiscale.setValue(res['cf_utente'])
        this.checkCodiceFiscale(this.formSoggetto)
      }
    })
    if (this.route.snapshot.url[0].path === 'modifica') {
      this.modifica = true;
      this._id_soggetto_fisico = this._id_soggetto_fisico_preso;
      console.log(this._id_soggetto_fisico);
      this.formSoggetto.controls['codice_fiscale'].disable();
    }
    this.dataMax = new Date();
    this.formatDataMax = formatDate(this.dataMax, 'yyyy-MM-dd', 'en');
    this.LoadingService.closeDialog();
    this.ans.getCodiciNascita().subscribe((res: any) => {
      console.log(res);
      this._datiCodiciNascita = res.info.dati;
    })
  }

  checkDate(event: any, form: any) {
    const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
    let src = event.srcElement

    if (!src.validity.valid || !regex.test(src.value)) form.controls.data_nascita.setValue("")

    form.updateValueAndValidity()
  }

  checkCodiceFiscale(form: any) {
    console.log(form)
    if (form.controls.codice_fiscale.value == null || form.controls.codice_fiscale.value == '') {
      form.reset()
      return
    }
    let cf = form.controls.codice_fiscale.value
    console.log(cf)
    this.ans.checkEsisteCF({ cod_fis: cf, id_soggetto_fisico: parseInt(this._id_soggetto_fisico) }).subscribe((res: any) => {
      if (!res.esito) {
        //form.controls.codice_fiscale.setValue('')
        form.reset()
      }
      //Ritorno dei dati del soggetto che sono il sesso, comune di nascita e la data di nascita
      this._datoNascitaSoggetto = res.info;
      console.log(this._datoNascitaSoggetto);
      form.controls.sesso.setValue(this._datoNascitaSoggetto.sesso);
      //Suddivisione dell'anno, mese e giorno
      let annoNascita = this._datoNascitaSoggetto.nascita.substring(0, 2);
      let meseNascita = this._datoNascitaSoggetto.nascita.substring(2, 4);
      let giornoNascita = this._datoNascitaSoggetto.nascita.substring(4, 6);
      //Conversione in formato data
      let dataNascita = new Date(parseInt(annoNascita), parseInt(meseNascita) - 1, parseInt(giornoNascita));
      console.log(dataNascita);
      //Formattazione della data per il tipo input date
      let formatData = formatDate(dataNascita, 'yyyy-MM-dd', 'en');
      console.log(formatData);
      form.controls.data_nascita.setValue(formatData);
      //Estrapolazione del nome del comune in base al codice catastale.
      this.ans.getCodiciNascita().subscribe((res: any) => {
        this._datiCodiciNascita = res.info.dati;
        this._datoNascitaSoggetto = this._datiCodiciNascita.filter((elem: any) => elem.codcatastale == this._datoNascitaSoggetto.comune);
        console.log(this._datoNascitaSoggetto);
        form.controls.comune_nascita.setValue(this._datoNascitaSoggetto[0].denominazione_it);
      })
    });

  }



  patchValue(evt: Event, field: string): void {
    this.formSoggetto.get(field)?.setValue(evt);
  }

  get datiCodiciNascita() { return this._datiCodiciNascita; }
}
