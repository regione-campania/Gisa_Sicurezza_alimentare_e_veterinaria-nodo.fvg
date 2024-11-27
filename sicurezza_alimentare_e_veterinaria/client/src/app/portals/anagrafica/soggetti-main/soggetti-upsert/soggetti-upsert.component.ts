/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { FormSoggettiComponent } from './form-soggetti/form-soggetti.component';
import { FormIndirizzoMainComponent } from '../../form-indirizzo-main/form-indirizzo-main.component';
import { FormBuilder } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';

@Component({
  selector: 'app-soggetti-upsert',
  templateUrl: './soggetti-upsert.component.html',
  styleUrls: ['./soggetti-upsert.component.scss']
})
export class SoggettiUpsertComponent implements OnInit {
  //-------------------VARIABILI----------------------------------------
  private _id_soggetto_fisico: any;
  public id_indirizzo_nuovo: any;
  labelBottone: any;
  @ViewChild('formSoggetto') formSoggetto?: FormSoggettiComponent; //prima era any
  @ViewChild('formIndirizzo') formIndirizzo?: FormIndirizzoMainComponent;
  private codCatastale: any;

  parix_soggetto: any
  _id_soggetto_parix: any
  _id_impresa_parix: any
  _id_stabilimento_parix: any
  _id_figura_parix: any

  //x ritorno configurazioni/utente/aggiungi
  _returnTo: any
  cf_utente: any

  //------------------------COSTRUTTORE---------------------------------
  constructor(
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private ans: AnagraficaService,
    private router: Router,
    private route: ActivatedRoute,
    private notificationService: NotificationService,
  ) {
    //Per creare nuove proprietà dinamicamente al params
    interface params extends Record<string, any> {

    }
  }

  //---------------------------NGONINIT---------------------------------
  ngOnInit() {
    if (this.route.snapshot.url[0].path === 'aggiungi') {
      this.labelBottone = 'Aggiungi';
    }
    else {
      this.labelBottone = 'Modifica';
    }
    this.route.queryParams.subscribe((res: any) => {
      console.log(res);
      if (res['cf_utente']) {
        this.cf_utente = res['cf_utente']
        this._returnTo = 'portali/configurazioni/utenti/aggiungi?cf_utente=' + this.cf_utente
      }
      if (res['id_soggetto_fisico']) {
        this._id_soggetto_fisico = res['id_soggetto_fisico']
        this.ans.getSoggettoSingolo(this._id_soggetto_fisico).subscribe((res: any) => {
          console.log("dati soggetto", res);
          this.id_indirizzo_nuovo = res.info.dati[0].indirizzo_id;
          this.formSoggetto?.formSoggetto.patchValue({
            nome: res.info.dati[0].nome,
            cognome: res.info.dati[0].cognome,
            comune_nascita: res.info.dati[0].comune_nascita_descr,
            codice_fiscale: res.info.dati[0].codice_fiscale,
            sesso: res.info.dati[0].sesso,
            telefono: res.info.dati[0].telefono,
            email: res.info.dati[0].email,
            pec: res.info.dati[0].pec,
            telefono2: res.info.dati[0].telefono2,
            data_nascita: (res.info.dati[0].data_nascita).split('T')[0],
            documento_identita: res.info.dati[0].documento_identita
          })
        })
      }

      if (res['parix_soggetto']) {
        this.parix_soggetto = JSON.parse(res['parix_soggetto'])
        this._id_impresa_parix = res['id_impresa_parix'] ?? null
        this._id_stabilimento_parix = res['id_stabilimento_parix'] ?? null
        this._id_figura_parix = res['id_figura_parix'] ?? null
        console.log(this.parix_soggetto)
        new Promise(resolve => {
          if (res['id_soggetto_parix']) {
            this._id_soggetto_parix = res['id_soggetto_parix']
            this.ans.getSoggettoSingolo(this._id_soggetto_parix).subscribe((res: any) => {
              this.id_indirizzo_nuovo = res.info.dati[0].indirizzo_id;
              resolve(true)
              this.formSoggetto?.formSoggetto.patchValue({
                //sesso: res.info.dati[0].sesso,
                telefono: res.info.dati[0].telefono,
                email: res.info.dati[0].email,
                pec: res.info.dati[0].pec,
                telefono2: res.info.dati[0].telefono2,
                documento_identita: res.info.dati[0].documento_identita
              })
            })
          } else {
            resolve(true)
          }
        }).then(() => {
          this.formSoggetto?.formSoggetto.patchValue({
            nome: this.parix_soggetto.PERSONA_FISICA[0].NOME[0],
            cognome: this.parix_soggetto.PERSONA_FISICA[0].COGNOME[0],
            codice_fiscale: this.parix_soggetto.PERSONA_FISICA[0].CODICE_FISCALE[0],
            //comune_nascita: this.parix_soggetto.PERSONA_FISICA[0].ESTREMI_NASCITA[0].COMUNE[0],
            //data_nascita: this.parix_soggetto.PERSONA_FISICA[0].ESTREMI_NASCITA[0].DATA[0],
          })

          this.formSoggetto?.formSoggetto.updateValueAndValidity()
          this.formSoggetto?.checkCodiceFiscale(this.formSoggetto?.formSoggetto)
        })

      }
    })
  }

  ngAfterViewInit() {
    if (this.parix_soggetto) {
      let indirizzo = this.parix_soggetto.PERSONA_FISICA[0].INDIRIZZO[0]
      this.formIndirizzo?.checkValore({ target: { value: 'no' } })
      this.formIndirizzo?.formModificaIndirizzo.patchValue({
        valore: 'no',
        comune: indirizzo.COMUNE ? indirizzo.COMUNE[0] : null,
        toponimo: indirizzo.TOPONIMO ? indirizzo.TOPONIMO[0] : null,
        indirizzo: indirizzo.VIA ? indirizzo.VIA[0] : null,
        civico: indirizzo.N_CIVICO ? indirizzo.N_CIVICO[0] : null,
        cap: indirizzo.CAP ? indirizzo.CAP[0] : null,
        nazione: null,
        stato_provincia: null,
        latitudine: null,
        longitudine: null,

      })
    }
  }

  //------------------------FUNZIONI------------------------------------
  //ho creato già i metodi che devi usare per upd/add aggiungi la parte degli indirizzi
  updSoggetto() {
    if (!this.formSoggetto?.formSoggetto?.valid || !this.formIndirizzo?.formModificaIndirizzo?.valid) {
      return;
    }
    if (!this.formSoggetto?.datiCodiciNascita.map((elem: any) => elem.denominazione_it).includes((this.formSoggetto?.formSoggetto.value['comune_nascita'] ?? '').toUpperCase())) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: "Attenzione! Comune di nascita non inserito correttamente."
      });
      return;
    }
    this.codCatastale = this.formSoggetto?.datiCodiciNascita.filter((elem: any) => { return elem.denominazione_it.toUpperCase() === (this.formSoggetto?.formSoggetto.value.comune_nascita ?? '').toUpperCase() });
    //console.log(this.codCatastale);
    let formPresa = this.formSoggetto.formSoggetto.getRawValue();
    console.log(formPresa);
    const params: Record<string, any> = {
      returnTo: this._returnTo,
      parix_soggetto: this.parix_soggetto,
      id_impresa_parix: this._id_impresa_parix,
      id_stabilimento_parix: this._id_stabilimento_parix,
      id_figura_parix: this._id_figura_parix,
      id_soggetto_fisico: 0,
      nome: formPresa.nome,
      cognome: formPresa.cognome,
      comune_nascita: this.codCatastale[0].codcatastale,
      cf: formPresa.codice_fiscale,
      sesso: formPresa.sesso,
      telefono: formPresa.telefono,
      email: formPresa.email,
      pec: formPresa.pec,
      telefono2: formPresa.telefono2,
      data_nascita: formPresa.data_nascita,
      documento_identita: formPresa.documento_identita,
      nome_function: null
    }
    console.log("params: ", params);
    if (this.route.snapshot.url[0].path === 'aggiungi') {
      this.labelBottone = 'Aggiungi';
      params['nome_function'] = 'upd_cu_add_soggetti_fisici'
      this.formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
    }

    if (this.route.snapshot.url[0].path === 'modifica') {
      this.labelBottone = 'Modifica';
      params['id_soggetto_fisico'] = +(this._id_soggetto_fisico ?? this._id_soggetto_parix);
      params['nome_function'] = 'upd_cu_soggetti_fisici'
      this.formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
    }
  }
  //-----------------------GETTER E SETTER------------------------------
  get id_soggetto_fisico() { return this._id_soggetto_fisico; }
}
