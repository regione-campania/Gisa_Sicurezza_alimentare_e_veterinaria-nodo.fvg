/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';

@Component({
  selector: 'app-form-indirizzo',
  templateUrl: './form-indirizzo.component.html',
  styleUrls: ['./form-indirizzo.component.scss']
})
export class FormIndirizzoComponent implements OnInit {
  @Input() _id_preso?: any;
  @Input() labelBottone?: string;
  formModificaIndirizzo: FormGroup;
  private datiIndirizzo: any;
  private valoreEstero?: any;
  private _datiComuni?: any;
  private _istatComune?: any;
  constructor(private fb: FormBuilder,
    private ComunicazioneDB: BackendCommunicationService,
    private LoadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private cu: ControlliUfficialiService,) {
    this.formModificaIndirizzo = this.fb.group({
      valore: this.fb.control(null, [Validators.required]),
      nazione: this.fb.control(null),
      stato_provincia: this.fb.control(null),
      comune: this.fb.control(null, [Validators.required]),
      comune_estero: this.fb.control(null, [Validators.required]),
      toponimo_estero: this.fb.control(null, [Validators.required]),
      indirizzo_estero: this.fb.control(null, [Validators.required]),
      civico_estero: this.fb.control(null, [Validators.required]),
      cap_estero: this.fb.control(null, [Validators.required]),
      toponimo: this.fb.control(null, [Validators.required]),
      indirizzo: this.fb.control(null, [Validators.required]),
      civico: this.fb.control(null, [Validators.required]),
      cap: this.fb.control(null, [Validators.required]),
    })
  }
  ngOnInit(): void {
    this.LoadingService.openDialog('Caricamento comuni...');
    if (!this.labelBottone) {
      this.labelBottone = 'Modifica';
    }
    this.cu.getComuni().subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        this.notificationService.push({
          notificationClass: 'warning',
          content: res.msg?.toLocaleUpperCase()
        });
        return;
      }
      this.LoadingService.closeDialog();
      console.log("risultato comuni", res);
      this._datiComuni = res.info.calendari.dati;
    })
    this.ComunicazioneDB.getDati('get_cu_indirizzi', { id_indirizzo: this._id_preso }).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      console.log("res indirizzi", res);
      this.datiIndirizzo = res.info.dati;
      this.formModificaIndirizzo.patchValue({
        valore: this.datiIndirizzo[0].istat_comune !== null ? 'no' : 'si',
      })
      this.valoreEstero = this.formModificaIndirizzo?.value.valore;
      console.log("valoreEstero nella get_cu_indirizzi", this.valoreEstero);
      //Setting del comune in base alla scelta dell'estero ed è nella fase di modifica, quindi che ho già tutti i dati
      if (this.valoreEstero === 'si') {
        //Settaggio dei validators
        this.formModificaIndirizzo.controls['comune'].clearValidators();
        this.formModificaIndirizzo.controls['toponimo'].clearValidators();
        this.formModificaIndirizzo.controls['indirizzo'].clearValidators();
        this.formModificaIndirizzo.controls['civico'].clearValidators();
        this.formModificaIndirizzo.controls['cap'].clearValidators();
        this.formModificaIndirizzo.patchValue({
          comune_estero: this.datiIndirizzo[0].comune != null ? this.datiIndirizzo[0].comune : null,
          toponimo_estero: this.datiIndirizzo[0].toponimo != null ? this.datiIndirizzo[0].toponimo : null,
          indirizzo_estero: this.datiIndirizzo[0].indirizzo != null ? this.datiIndirizzo[0].indirizzo : null,
          civico_estero: this.datiIndirizzo[0].civico != null ? this.datiIndirizzo[0].civico : null,
          cap_estero: this.datiIndirizzo[0].cap != null ? this.datiIndirizzo[0].cap : null,
          nazione: this.datiIndirizzo[0].nazione != null ? this.datiIndirizzo[0].nazione : null,
          stato_provincia: this.datiIndirizzo[0].stato_prov != null ? this.datiIndirizzo[0].stato_prov : null,
        })
        this.formModificaIndirizzo.controls['comune'].updateValueAndValidity();
        this.formModificaIndirizzo.controls['toponimo'].updateValueAndValidity();
        this.formModificaIndirizzo.controls['indirizzo'].updateValueAndValidity();
        this.formModificaIndirizzo.controls['civico'].updateValueAndValidity();
        this.formModificaIndirizzo.controls['cap'].updateValueAndValidity();
      }
      else {
        //Settaggio dei validators
        this.formModificaIndirizzo.controls['comune_estero'].clearValidators();
        this.formModificaIndirizzo.controls['toponimo_estero'].clearValidators();
        this.formModificaIndirizzo.controls['indirizzo_estero'].clearValidators();
        this.formModificaIndirizzo.controls['civico_estero'].clearValidators();
        this.formModificaIndirizzo.controls['cap_estero'].clearValidators();
        this.formModificaIndirizzo.patchValue({
          comune: this.datiIndirizzo[0].comune != null ? this.datiIndirizzo[0].comune : null,
          toponimo: this.datiIndirizzo[0].toponimo != null ? this.datiIndirizzo[0].toponimo : null,
          indirizzo: this.datiIndirizzo[0].indirizzo != null ? this.datiIndirizzo[0].indirizzo : null,
          civico: this.datiIndirizzo[0].civico != null ? this.datiIndirizzo[0].civico : null,
          cap: this.datiIndirizzo[0].cap != null ? this.datiIndirizzo[0].cap : null,
          nazione: null,
          stato_provincia: null,
        })
        this.formModificaIndirizzo.controls['comune_estero'].updateValueAndValidity();
        this.formModificaIndirizzo.controls['toponimo_estero'].updateValueAndValidity();
        this.formModificaIndirizzo.controls['indirizzo_estero'].updateValueAndValidity();
        this.formModificaIndirizzo.controls['civico_estero'].updateValueAndValidity();
        this.formModificaIndirizzo.controls['cap_estero'].updateValueAndValidity();
      }
    })

  }
  //Funzione che prende il valore della checkbox
  checkValore(evt: any) {
    this.valoreEstero = evt.target.value;
    console.log("valore della checkbox", this.valoreEstero);
    //Per settare i validator in base alla scelta dell'estero e mi serve nella situazione iniziale, ovvero che è un indirizzo nuovo
    if (this.valoreEstero === 'no') {
      //Settaggio dei validators se non è estero
      this.formModificaIndirizzo.controls['comune_estero'].clearValidators();
      this.formModificaIndirizzo.controls['toponimo_estero'].clearValidators();
      this.formModificaIndirizzo.controls['indirizzo_estero'].clearValidators();
      this.formModificaIndirizzo.controls['civico_estero'].clearValidators();
      this.formModificaIndirizzo.controls['cap_estero'].clearValidators();
      this.formModificaIndirizzo.controls['comune'].setValidators([Validators.required]);
      this.formModificaIndirizzo.controls['toponimo'].setValidators([Validators.required]);
      this.formModificaIndirizzo.controls['indirizzo'].setValidators([Validators.required]);
      this.formModificaIndirizzo.controls['civico'].setValidators([Validators.required]);
      this.formModificaIndirizzo.controls['cap'].setValidators([Validators.required]);
    }
    this.formModificaIndirizzo.controls['comune_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['toponimo_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['indirizzo_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['civico_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['cap_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['comune'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['toponimo'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['indirizzo'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['civico'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['cap'].updateValueAndValidity();
    if (this.valoreEstero === 'si') {
      //settaggio dei validators se è estero
      this.formModificaIndirizzo.controls['comune'].clearValidators();
      this.formModificaIndirizzo.controls['toponimo'].clearValidators();
      this.formModificaIndirizzo.controls['indirizzo'].clearValidators();
      this.formModificaIndirizzo.controls['civico'].clearValidators();
      this.formModificaIndirizzo.controls['cap'].clearValidators();
      this.formModificaIndirizzo.controls['comune_estero'].setValidators([Validators.required]);
      this.formModificaIndirizzo.controls['toponimo_estero'].setValidators([Validators.required]);
      this.formModificaIndirizzo.controls['indirizzo_estero'].setValidators([Validators.required]);
      this.formModificaIndirizzo.controls['civico_estero'].setValidators([Validators.required]);
      this.formModificaIndirizzo.controls['cap_estero'].setValidators([Validators.required]);
    }
    this.formModificaIndirizzo.controls['comune_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['toponimo_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['indirizzo_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['civico_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['cap_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['comune'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['toponimo'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['indirizzo'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['civico'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['cap'].updateValueAndValidity();
  }
  //Funzione per la modifica dell'indirizzo
  updIndirizzo() {
    if (!this.formModificaIndirizzo) {
      return
    }
    //Se l'utente valorizza no come stato estero allora va a prendere i comuni e controlla
    //altrimenti è a testo libero e non c'è bisogno di nessun controllo sul comune
    if (this.valoreEstero === 'no') {
      if (!this._datiComuni.map((elem: any) => elem.denominazione_it).includes(this.formModificaIndirizzo.value.comune.toUpperCase())) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: "Attenzione! Comune non inserito correttamente."
        });
        return;
      }
      else {
        //Utilizzo il filter per andare a prendere il comune corrispondente inserito per estrapolare successivamente il codistat
        this._istatComune = this._datiComuni.filter((elem: any) => { return elem.denominazione_it.toUpperCase() === this.formModificaIndirizzo.value.comune.toUpperCase() });
        console.log(this._istatComune);
        const params = {
          id_indirizzo: this._id_preso,
          // nazione: this.formModificaIndirizzo.value.nazione,
          // stato_provincia: this.formModificaIndirizzo.value.stato_provincia,
          comune: this.formModificaIndirizzo.value.comune.toUpperCase(),
          toponimo: this.formModificaIndirizzo.value.toponimo,
          indirizzo: this.formModificaIndirizzo.value.indirizzo,
          civico: this.formModificaIndirizzo.value.civico,
          cap: this.formModificaIndirizzo.value.cap,
          istat_comune: this._istatComune[0].codistat != null ? +this._istatComune[0].codistat : null
        }
        console.log(params);
        this.ComunicazioneDB.updDati('upd_cu_indirizzi', params).subscribe((res: any) => {
          console.log("res upd:", res);
        })
        setTimeout(() => { window.location.reload(); }, 1500);
      }
    }
    else {
      const params = {
        id_indirizzo: this._id_preso,
        nazione: this.formModificaIndirizzo.value.nazione,
        stato_provincia: this.formModificaIndirizzo.value.stato_provincia,
        comune: this.formModificaIndirizzo.value.comune_estero.toUpperCase(),
        toponimo: this.formModificaIndirizzo.value.toponimo_estero,
        indirizzo: this.formModificaIndirizzo.value.indirizzo_estero,
        civico: this.formModificaIndirizzo.value.civico_estero,
        cap: this.formModificaIndirizzo.value.cap_estero,
        istat_comune: null
      }
      console.log(params);
      this.ComunicazioneDB.updDati('upd_cu_indirizzi', params).subscribe((res: any) => {
        console.log("res upd:", res);
      })
      setTimeout(() => { window.location.reload(); }, 1500);
    }
  }

  patchValue(evt: Event, field: string): void {
    this.formModificaIndirizzo.get(field)?.setValue(evt);
  }

  get valoreCheckbox() { return this.valoreEstero; }
  get datiComuni() { return this._datiComuni; }
}

