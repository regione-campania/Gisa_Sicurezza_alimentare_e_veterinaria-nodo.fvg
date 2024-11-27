/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-sottoscrizioni',
  templateUrl: './sottoscrizioni.component.html',
  styleUrls: ['./sottoscrizioni.component.scss']
})
export class SottoscrizioniComponent implements OnInit {
  private _sottoscrizioni?: any;
  private _ui?: any;

  constructor(
    private loadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private route: ActivatedRoute
  ) { }

  ngOnInit(): void {
    this.route.data.subscribe((data: any) => {
      this.loadingService.closeDialog();
      console.log("data:", data);
      if (!data.sottoscrizioni.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore nel caricamento dei dati.'
        });
        return;
      }

      // Se la chiamata va a buon fine ma non vengono ritornati dati
      if (data.sottoscrizioni.info === true) return;

      this._sottoscrizioni = data.sottoscrizioni.info.dati;
      console.log("this._sottoscrizioni:", this._sottoscrizioni);

      this._ui = data.sottoscrizioni.info.ui;
      console.log("this.ui:", this._ui);
    })
  }

  // Accessors
  get sottoscrizioni() { return this._sottoscrizioni; }
  get ui() { return this._ui; }

}
