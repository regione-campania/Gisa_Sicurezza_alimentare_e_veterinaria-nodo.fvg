/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { Location } from '@angular/common';

@Component({
  selector: 'app-preaccettazioni-stati',
  templateUrl: './preaccettazioni-stati.component.html',
  styleUrls: ['./preaccettazioni-stati.component.scss']
})
export class PreaccettazioniStatiComponent implements OnInit {
  private _preaccettazioniStati?: any;
  private _ui?: any;

  constructor(
    private loadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private _location: Location,
    private route: ActivatedRoute
  ) { }

  ngOnInit(): void {
    this.loadingService.openDialog('Caricamento in corso');
    this.route.data.subscribe((data: any) => {
      this.loadingService.closeDialog();
      console.log("data:", data);
      if (!data.preaccettazioniStati.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore nel caricamento dei dati.'
        });
        return;
      }

      // Se la chiamata va a buon fine ma non vengono ritornati dati
      if (data.preaccettazioniStati.info === true) return;

      this._preaccettazioniStati = data.preaccettazioniStati.info.dati;
      console.log("this._preaccettazioniStati:", this._preaccettazioniStati);

      this._ui = data.preaccettazioniStati.info.ui;
      console.log("this.ui:", this._ui);
    })
  }

  // Accessors

  

  goBack(): void { this._location.back(); }
 

  get preaccettazioniStati() { return this._preaccettazioniStati; }
  get ui() { return this._ui; }

}
