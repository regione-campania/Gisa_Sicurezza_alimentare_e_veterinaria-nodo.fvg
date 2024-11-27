/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Location } from '@angular/common';
import { LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-sottoscrizioni-elaborazioni',
  templateUrl: './sottoscrizioni-elaborazioni.component.html',
  styleUrls: ['./sottoscrizioni-elaborazioni.component.scss']
})
export class SottoscrizioniElaborazioniComponent implements OnInit {
  private _sottoscrizioniElaborazioni?: any;
  private _ui?: any;
  _idSottoscrizione: any;
  _descrSottoscrizione: any;


  constructor(
    private loadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private _location: Location,
    private route: ActivatedRoute
  ) { }

  ngOnInit(): void {
    this.loadingService.openDialog('Caricamento in corso');
    this.route.queryParams.subscribe(params =>  {
      console.log("parms", params['id_sottoscrizione']);
      this._idSottoscrizione = params['id_sottoscrizione'];
      this._descrSottoscrizione = params['_descrSottoscrizione'];
    })
    this.route.data.subscribe((data: any) => {
      this.loadingService.closeDialog();
      console.log("data:", data);
      if (!data.sottoscrizioniElaborazioni.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore nel caricamento dei dati.'
        });
        return;
      }

      // Se la chiamata va a buon fine ma non vengono ritornati dati
      if (data.sottoscrizioniElaborazioni.info === true) return;

      this._sottoscrizioniElaborazioni = data.sottoscrizioniElaborazioni.info.dati;
      
      console.log("this._sottoscrizioniElaborazioni:", this._sottoscrizioniElaborazioni);

      this._ui = data.sottoscrizioniElaborazioni.info.ui;
      console.log("this.ui:", this._ui);
    })
  }
  goBack(): void { this._location.back(); }

  // Accessors


 

  get sottoscrizioniElaborazioni() { return this._sottoscrizioniElaborazioni; }
  get ui() { return this._ui; }

}
