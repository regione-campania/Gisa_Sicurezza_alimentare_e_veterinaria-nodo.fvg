/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { AziendeService, CapiService } from '../services';

@Component({
  selector: 'app-capi',
  templateUrl: './capi.component.html',
  styleUrls: ['./capi.component.scss']
})
export class CapiComponent implements OnInit {
  private _capi?: any;
  private _ui?: any;

  private _aziende?: any;
  _aziendaSelezionata?: any;

  private _specie?: any;
  _specieSelezionata?: any;

  private _showNotice: boolean = false;

  form = this.fb.group({
    azienda: "",
    allevamento: "",
    marchio: "",
    specie: "",
    id_specie: ""
  });

  constructor(
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private fb: FormBuilder,
    private as: AziendeService,
    private cs: CapiService
  ) { }

  ngOnInit(): void {
    /*
    this.route.data.subscribe((data: any) => {
      this.loadingService.closeDialog();
      console.log("data:", data);
      if (!data.capi.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore nel caricamento dei dati.'
        });
        return;
      }
      this._capi = data.capi.info.dati;
      console.log("this._capi:", this._capi);

      this._ui = data.capi.info.ui;
      console.log("this._ui:", this._ui);
    })
    */

    // Recupero delle aziende
    this.as.getAziende('get_aziende').subscribe((az: any) => {
      this.loadingService.closeDialog();
      console.log("az:", az);
      if (!az.esito) return;

      this._aziende = az.info.dati;
      console.log("this._aziende:", this._aziende);
    });

    // Recupero delle specie
    this.cs.getSpecie().subscribe((sp: any) => {
      console.log("sp:", sp);
      if (!sp.esito) return;

      this._specie = sp.info.dati;
      console.log("this._specie:", this._specie);
    });
  }

  // Effettua il Patch e memorizza l'azienda selezionata
  selezionaAzienda(azienda: any): void {
    this._aziendaSelezionata = azienda;
    console.log("this._aziendaSelezionata:", this._aziendaSelezionata);

    this.form.patchValue({ azienda: azienda.cod_azienda });
    console.log("this.form.value:", this.form.value);
  }

  // Effettua il Patch e memorizza la specie selezionata
  selezionaSpecie(specie: any): void {
    this._specieSelezionata = specie;
    console.log("this._specieSelezionata:", this._specieSelezionata);

    this.form.patchValue({
      specie: specie.descrizione,
      id_specie: specie.id_specie
    });
    console.log("this.form.value:", this.form.value);
  }

  // Ricerca i capi in base ai filtri
  onSubmit(evt: any): void {
    this.loadingService.openDialog('Caricamento Capi...');
    console.log("this.form.value:", this.form.value);
    this.cs.getCapiFromFilter({
      azienda: this.form.controls['azienda'].value,
      allevamento: this.form.controls['allevamento'].value,
      marchio: this.form.controls['marchio'].value,
      specie: this.form.controls['specie'].value
    }).subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      this._capi = res.info.dati;
      console.log("this._capi:", this._capi);

      this._ui = res.info.ui;
      console.log("this._ui:", this._ui);

      this._showNotice = true;
    })
  }

  get capi() { return this._capi; }
  get ui() { return this._ui; }
  get aziende() { return this._aziende; }
  get specie() { return this._specie; }
  get showNotice() { return this._showNotice; }
}
