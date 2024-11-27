/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';
import { anagraficaUnicaService } from 'src/app/portals/controlli-ufficiali/services/anagraficaUnica.service';
import { Location } from '@angular/common';

@Component({
  selector: 'app-soggetti-anagrafica-assistiti',
  templateUrl: './soggetti-anagrafica-assistiti.component.html',
  styleUrls: ['./soggetti-anagrafica-assistiti.component.scss']
})
export class SoggettiAnagraficaAssistitiComponent {

  private _uiAnag: any
  private _retDatiAnag: any
  private _retDatiAnagTot: any
  private nome: any
  private cognome: any
  private cf: any

  constructor(
    private LoadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private aus: anagraficaUnicaService,
    private fb: FormBuilder,
    private ans: AnagraficaService,
    private router: Router,
    private route: ActivatedRoute,
    private location: Location
  ) { }

  ngOnInit() {
    this.route.queryParams.subscribe(params => {
      this.nome = params['nome']
      this.cognome = params['cognome']
      this.cf = params['cf']

      this.verificaAnagraficaAssistiti()
    });
  }

  verificaAnagraficaAssistiti() {
    this.LoadingService.openDialog();
    this._uiAnag = null;
    this._retDatiAnag = null;
    this._retDatiAnagTot = null;
    let params: any;

    //Ricerca per nome e cognome
    if (this.nome && this.cognome && !this.cf) {
      params = {
        nome: this.nome,
        cognome: this.cognome
      }
    }
    //Ricerca per codice fiscale
    else if (this.cf && !this.nome && !this.cognome) {
      params = {
        cf: this.cf
      }
    }
    //Ricerca per nome, cognome e codice fiscale
    else if (this.nome && this.cognome && this.cf) {
      params = {
        cf: this.cf,
        nome: this.nome,
        cognome: this.cognome
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
      //console.log(res);
      if (res.CodiceRitorno == "0") {
        this._uiAnag = res.info.ui;
        //Map per estrapolare l'array di oggetti dell'anagrafica
        this._retDatiAnagTot = res.info.dati
        this._retDatiAnag = res.info.dati.map((elem: any) => elem.Anagrafica);
        // console.log("dati Anagrafica Tot", this._retDatiAnagTot);
        // console.log("dati Anagrafica", this._retDatiAnag);
      }
      else if (res.CodiceRitorno == -1) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: "Persona non presente nell'anagrafica assistita"
        });
        // return;
        this.location.back()
      } else if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: "Servizio non disponibile."
        });
        // return;
        this.location.back()
      }
    })
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
    // console.log(params)

    this.ans.updSoggettoFisicoFromService(params).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      if (res.esito) {
        this.router.navigate(['portali/anagrafica/soggetti-fisici/dettaglio'], { queryParams: { id_soggetto_fisico: res.info.id_soggetto_fisico } })
      }
    })

  }

  get uiAnag() { return this._uiAnag; }
  get retDatiAnag() { return this._retDatiAnag; }
  get retDatiAnagTot() { return this._retDatiAnagTot; }
}
