/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, OnInit, TemplateRef, ViewChild, ViewContainerRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';
import * as bootstrap from 'bootstrap';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { AnagraficaService } from '../anagrafica.service';

@Component({
  selector: 'app-soggetti-fisici',
  templateUrl: './soggetti-fisici.component.html',
  styleUrls: ['./soggetti-fisici.component.scss']
})
export class SoggettiFisiciComponent implements OnInit {
  formRicercaSoggettiFisici: FormGroup;
  btnVisualizza: boolean = false;
  private _ui?: any;
  private _retDati?: any;
  private _uiAnag?: any
  private _retDatiAnag?: any;
  private _retDatiAnagTot?: any;
  private _modalAnagrafica?: bootstrap.Modal;
  formModificaSogg: FormGroup;
  formAggiungiSogg: FormGroup;
  formVisualizzaSogg: FormGroup;
  modaleModificaSogg?: NgbModalRef;
  @ViewChild('templateModaleModificaSogg') modificaSoggTemplate!: TemplateRef<any>;
  modaleVisualizzaSogg?: NgbModalRef;
  @ViewChild('messaggioNoSogg') messaggioNoSogg!: TemplateRef<any>;
  @ViewChild('templateModaleVisualizzaSogg') visualizzaSoggTemplate!: TemplateRef<any>;
  private _arAppSogg: any;
  emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
  constructor(private fb: FormBuilder,
    private router: Router,
    private aus: AnagraficaService,
    private ComunicazioneDB: BackendCommunicationService,
    private LoadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private vref: ViewContainerRef,
    private modalEngine: NgbModal) {
    this.formRicercaSoggettiFisici = this.fb.group({
      nome: this.fb.control(null, [Validators.required]),
      cognome: this.fb.control(null, [Validators.required]),
      cf: this.fb.control(null, [Validators.required]),
      comune_nascita: this.fb.control(null, [Validators.required]),
      data_nascita: this.fb.control(null, [Validators.required]),
      // sesso: this.fb.control(null, [Validators.required]),
    })
    this.formModificaSogg = this.fb.group({
      titolo: this.fb.control(null,),
      nome: this.fb.control(null, [Validators.required]),
      cognome: this.fb.control(null, [Validators.required]),
      comune_nascita: this.fb.control(null, [Validators.required]),
      codice_fiscale: this.fb.control(null, [Validators.required]),
      sesso: this.fb.control(null, [Validators.required]),
      telefono: this.fb.control(null, [Validators.required]),
      email: this.fb.control(null, Validators.pattern(this.emailPattern)),
      pec: this.fb.control(null, [Validators.required, Validators.pattern(this.emailPattern)]),
      telefono2: this.fb.control(null,),
      data_nascita: this.fb.control(null, [Validators.required]),
      documento_identita: this.fb.control(null, [Validators.required]),
    })
    this.formVisualizzaSogg = this.fb.group({
      titolo: this.fb.control(null, [Validators.required]),
      nome: this.fb.control(null, [Validators.required]),
      cognome: this.fb.control(null, [Validators.required]),
      comune_nascita: this.fb.control(null, [Validators.required]),
      codice_fiscale: this.fb.control(null, [Validators.required]),
      sesso: this.fb.control(null, [Validators.required]),
      telefono: this.fb.control(null, [Validators.required]),
      email: this.fb.control(null, [Validators.required]),
      pec: this.fb.control(null, [Validators.required]),
      telefono2: this.fb.control(null, [Validators.required]),
      data_nascita: this.fb.control(null, [Validators.required]),
      documento_identita: this.fb.control(null, [Validators.required]),
      indirizzo_luogo: this.fb.control(null, [Validators.required]),
      comune_testo: this.fb.control(null, [Validators.required]),
      nazione: this.fb.control(null, [Validators.required]),
    })
    this.formAggiungiSogg = this.fb.group({
      titolo: this.fb.control(null,),
      nome: this.fb.control(null, [Validators.required]),
      cognome: this.fb.control(null, [Validators.required]),
      comune_nascita: this.fb.control(null, [Validators.required]),
      codice_fiscale: this.fb.control(null, [Validators.required]),
      sesso: this.fb.control(null, [Validators.required]),
      telefono: this.fb.control(null, [Validators.required]),
      email: this.fb.control(null, Validators.pattern(this.emailPattern)),
      pec: this.fb.control(null, [Validators.required, Validators.pattern(this.emailPattern)]),
      telefono2: this.fb.control(null,),
      data_nascita: this.fb.control(null, [Validators.required]),
      documento_identita: this.fb.control(null, [Validators.required]),
    })
  }
  ngOnInit(): void {
    this._modalAnagrafica = new bootstrap.Modal('#anagraficaAssistiti');
  }
  //Ricerca utilizzando la funzione lato DB, quindi mostra lato nostro i dati
  filtraSoggettiFisici() {
    const params = {
      ...this.formRicercaSoggettiFisici.value
    }
    this.vref.clear();
    this.ComunicazioneDB.getDati('get_cu_soggetti_fisici_by_sel', params).subscribe((res: any) => {
      if (!res.info) {
        this._ui = null;
        this._retDati = null;
        this.vref.createEmbeddedView(this.messaggioNoSogg);
        return;
      }
      console.log("dati soggetti fisici per filtro", res);
      this._ui = res.info.ui
      this._retDati = res.info.dati
    })
  }
  //Routing per mostrare il dettaglio delle figure dal soggetto fisico
  mostraFigure(ar: any) {
    this.router.navigate(['portali', 'soggetti-fisici', 'dettaglio-stab', 'dettaglio-figure'], { queryParams: { id_soggetto_fisico: ar.id_soggetto_fisico, nome: ar.nome, cognome: ar.cognome, codice_fiscale: ar.codice_fiscale, indirizzo_completo: ar.indirizzo_completo, comune: ar.comune_testo } })
  }
  //Ricerca utilizzando il web service dell'anagrafiche del Friuli
  verificaAnagraficaAssistiti() {
    this.LoadingService.openDialog();
    this._uiAnag = null;
    this._retDatiAnag = null;
    this._retDatiAnagTot = null;
    let params: any;

    //Ricerca per nome e cognome
    if (this.formRicercaSoggettiFisici.get('nome')?.value && this.formRicercaSoggettiFisici.get('cognome')?.value && !this.formRicercaSoggettiFisici.get('cf')?.value) {
      params = {
        nome: this.formRicercaSoggettiFisici.get('nome')?.value,
        cognome: this.formRicercaSoggettiFisici.get('cognome')?.value
      }
    }
    //Ricerca per codice fiscale
    else if (this.formRicercaSoggettiFisici.get('cf')?.value && !this.formRicercaSoggettiFisici.get('nome')?.value && !this.formRicercaSoggettiFisici.get('cognome')?.value) {
      params = {
        cf: this.formRicercaSoggettiFisici.get('cf')?.value
      }
    }
    //Ricerca per nome, cognome e codice fiscale
    else if (this.formRicercaSoggettiFisici.get('nome')?.value && this.formRicercaSoggettiFisici.get('cognome')?.value && this.formRicercaSoggettiFisici.get('cf')?.value) {
      params = {
        cf: this.formRicercaSoggettiFisici.get('cf')?.value,
        nome: this.formRicercaSoggettiFisici.get('nome')?.value,
        cognome: this.formRicercaSoggettiFisici.get('cognome')?.value
      }
    }
    else {
      this.notificationService.push({
        notificationClass: 'warning',
        content: "La ricerca sul sistema regionale deve essere effettuata per nome e cognome oppure per codice fiscale."
      });
      this.LoadingService.closeDialog();
      return;
    }

    this.aus.ricercaAnagrafica(params).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      console.log(res);
      if (res.CodiceRitorno == "0") {
        this._uiAnag = res.info.ui;
        //Map per estrapolare l'array di oggetti dell'anagrafica
        this._retDatiAnagTot = res.info.dati
        this._retDatiAnag = res.info.dati.map((elem: any) => elem.Anagrafica);
        console.log("dati Anagrafica Tot", this._retDatiAnagTot);
        console.log("dati Anagrafica", this._retDatiAnag);
      }
      else if (res.CodiceRitorno == -1) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: "Persona non presente nell'anagrafica assistita"
        });
        return;
      }else if (!res.esito){
        this.notificationService.push({
          notificationClass: 'warning',
          content: "Servizio non disponibile."
        });
        return;
      }
      this._modalAnagrafica?.toggle();
    })
  }
  //----------------------------------------------------------------------------------------
  //funzione per aprire le modali
  openModal(content: any, size: string = 'lg') {
    return this.modalEngine.open(content, {
      modalDialogClass: 'modal-fade',
      size: size,
      centered: true
    });
  }
  //----------------------------------------------------------------------------------------
  //funzione che apre la modale per la modifica della sede
  apriModalModificaSogg(ar: any) {
    this.modaleModificaSogg = this.openModal(this.modificaSoggTemplate);
    this._arAppSogg = ar;
    console.log(ar);
    this.formModificaSogg.setValue({
      titolo: ar.titolo,
      nome: ar.nome,
      cognome: ar.cognome,
      comune_nascita: ar.comune_nascita_descr,
      codice_fiscale: ar.codice_fiscale,
      sesso: ar.sesso,
      telefono: ar.telefono,
      email: ar.email,
      pec: ar.pec,
      telefono2: ar.telefono2,
      data_nascita: ar.data_nascita,
      documento_identita: ar.documento_identita,
    });
    //this._datoIdPiano = ar.id_cu_piano;
  }
  //----------------------------------------------------------------------------------------
  //funzione che apre la modale per la modifica della sede
  apriModalVisualizzaSogg(ar: any) {
    this.modaleVisualizzaSogg = this.openModal(this.visualizzaSoggTemplate);
    this.formVisualizzaSogg.setValue({
      titolo: ar.titolo,
      nome: ar.nome,
      cognome: ar.cognome,
      comune_nascita: ar.comune_nascita_descr,
      codice_fiscale: ar.codice_fiscale,
      sesso: ar.sesso,
      telefono: ar.telefono,
      email: ar.email,
      pec: ar.pec,
      telefono2: ar.telefono2,
      data_nascita: ar.data_nascita,
      documento_identita: ar.documento_identita,
      indirizzo_luogo: ar.indirizzo_luogo,
      comune_testo: ar.comune_testo,
      nazione: ar.nazione,
    });
    //this._datoIdPiano = ar.id_cu_piano;
  }
  //----------------------------------------------------------------------------------------
  //Funzione che fa lato db la modifica della sede
  updSogg(ar: any) {
    if (!this.formModificaSogg.valid) {
      return
    }
    const params = {
      id_soggetto_fisico: +ar.id_soggetto_fisico,
      titolo: this.formModificaSogg.value.titolo,
      nome: this.formModificaSogg.value.nome,
      cognome: this.formModificaSogg.value.cognome,
      comune_nascita: this.formModificaSogg.value.comune_nascita,
      cf: this.formModificaSogg.value.codice_fiscale,
      sesso: this.formModificaSogg.value.sesso,
      telefono: this.formModificaSogg.value.telefono,
      email: this.formModificaSogg.value.email,
      pec: this.formModificaSogg.value.pec,
      telefono2: this.formModificaSogg.value.telefono2,
      data_nascita: this.formModificaSogg.value.data_nascita,
      documento_identita: this.formModificaSogg.value.documento_identita,
    }
    console.log("params: ", params);
    this.ComunicazioneDB.updDati('upd_cu_soggetti_fisici', params).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati upd sedi", res);
    })
    setTimeout(() => { window.location.reload(); }, 1500);
  }
  //----------------------------------------------------------------------------------------
  //Funzione che fa lato db l'aggiungi di un soggetto
  addSogg() {
    if (!this.formAggiungiSogg.valid) {
      return
    }
    const params = {
      titolo: this.formAggiungiSogg.value.titolo,
      nome: this.formAggiungiSogg.value.nome,
      cognome: this.formAggiungiSogg.value.cognome,
      comune_nascita: this.formAggiungiSogg.value.comune_nascita,
      cf: this.formAggiungiSogg.value.codice_fiscale,
      sesso: this.formAggiungiSogg.value.sesso,
      telefono: this.formAggiungiSogg.value.telefono,
      email: this.formAggiungiSogg.value.email,
      pec: this.formAggiungiSogg.value.pec,
      telefono2: this.formAggiungiSogg.value.telefono2,
      data_nascita: this.formAggiungiSogg.value.data_nascita,
      documento_identita: this.formAggiungiSogg.value.documento_identita,
    }
    console.log("params: ", params);
    this.ComunicazioneDB.updDati('upd_cu_add_soggetti_fisici', params).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati upd sedi", res);
    })
    setTimeout(() => { window.location.reload(); }, 1500);
  }

  aggiungiAssistito(ar: any) {
    this.LoadingService.openDialog();
    let params = {
      nome: ar.Anagrafica.Nome,
      cognome: ar.Anagrafica.Cognome,
      sesso: ar.Anagrafica.Sesso,
      comune_nascita: ar.Anagrafica.NascitaLuogo.Codice,
      data_nascita: ar.Anagrafica.NascitaData,
      cf: ar.Anagrafica.CodiceFiscale,
      titolo: "",
      pec: "",
      email: "",
      telefono: "",
      telefono2: "",
      documento_identita: "",
      indirizzo: {
        toponimo: ar?.Residenza?.ResidenzaItalia?.LuogoItaliaIndirizzo?.IndirizzoToponimo,
        descrizione: ar?.Residenza?.ResidenzaItalia?.LuogoItaliaIndirizzo?.IndirizzoDescrizione,
        civico: ar?.Residenza?.ResidenzaItalia?.LuogoItaliaIndirizzo?.IndirizzoNumeroCivico,
        codice_catastale: ar?.Residenza?.ResidenzaItalia?.LuogoItaliaComune?.Codice,
        cap: ar?.Residenza?.ResidenzaItalia?.LuogoItaliaCAP
      }
    }
    console.log(params)

    this.ComunicazioneDB.updDati('upd_cu_add_soggetti_fisici_from_service', params).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      this._modalAnagrafica?.hide()
    })

  }

  checkDate(event: any, form: any) {
    const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
    let src = event.srcElement

    if (!src.validity.valid || !regex.test(src.value)) form.controls.data_nascita.setValue("")

    form.updateValueAndValidity()
  }

  checkCodiceFiscale(form: any) {
    if (form.value.codice_fiscale == null || form.value.codice_fiscale == '')
      return
    this.ComunicazioneDB.getDati('check_esiste_cf', { cod_fis: form.value.codice_fiscale }).subscribe((res: any) => {
      if (!res.esito) {
        form.controls.codice_fiscale.setValue('')
      }
    });

  }

  get ui() { return this._ui }
  get retDati() { return this._retDati }
  get uiAnag() { return this._uiAnag; }
  get retDatiAnag() { return this._retDatiAnag; }
  get retDatiAnagTot() { return this._retDatiAnagTot; }
  get arAppSogg() { return this._arAppSogg; }
}
