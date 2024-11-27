/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Location, formatDate } from '@angular/common';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-scarti-import',
  templateUrl: './scarti-import.component.html',
  styleUrls: ['./scarti-import.component.scss']
})
export class ScartiImportComponent implements OnInit {
  private _scartiImport?: any;
  private _ui?: any;

  constructor(
    private client: BackendCommunicationService,
    private loadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private _location: Location,
    private route: ActivatedRoute
  ) { }

  ngOnInit(): void {
    this.loadingService.openDialog('Caricamento in corso');
    //this.client.getDati('get_dettaglio_scarto_aziende').subscribe((res: any) => {
    this.route.queryParams.subscribe((param: any) => {
      let flussoScelta = param.flusso;
      console.log("flussoScelta:", flussoScelta);

      let funzioneDaChiamare='get_dettaglio_scarto_aziende';
      
      if(flussoScelta=='Persone')     {
        
        funzioneDaChiamare='get_dettaglio_scarto_persone';
      }
      if(flussoScelta=='Aziende' ||flussoScelta=='Aziende Importate')     {
        
        funzioneDaChiamare='get_dettaglio_scarto_aziende';
      }

      this.client.getDati(funzioneDaChiamare, { flusso: flussoScelta }).subscribe((data: any) => {
        console.log("funzioneDaChiamare:", funzioneDaChiamare);
        this.loadingService.closeDialog();
        console.log("data:", data);

        if (!data.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Attenzione! Errore nel caricamento dei dati.'
          });
          return;
        }

        console.log("data.info.dati:", data.info.dati);

        this._scartiImport = data.info.dati;
        console.log("this._scartiImport:", this._scartiImport);

        this._ui = data.info.ui;
        console.log("this.ui:", this._ui);
        this.loadingService.closeDialog();
      })
    })
  }

 


  goBack(): void { this._location.back(); }


  get scartiImport() { return this._scartiImport; }
  get ui() { return this._ui; }

}
