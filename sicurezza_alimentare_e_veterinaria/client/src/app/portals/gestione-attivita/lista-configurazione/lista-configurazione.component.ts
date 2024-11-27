/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ASmartTableComponent, BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-lista-configurazione',
  templateUrl: './lista-configurazione.component.html',
  styleUrls: ['./lista-configurazione.component.scss']
})
export class ListaConfigurazioneComponent implements OnInit {

  @ViewChild(ASmartTableComponent) tabella?: ASmartTableComponent;
  configurazione?: any;
  private _configurazioneSelezionate: any[] = [];
  private _ui?: any;

  constructor(
    private client: BackendCommunicationService,
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
  ) { }

  ngOnInit(): void {
    this.loadingService.openDialog('Caricamento Dati...');
    this.client.getDati('get_ag_conf', { id: 1 }).subscribe(res => {
      if (!res.esito) {
        this.loadingService.closeDialog();
        this.notificationService.push({
          notificationClass: 'warning',
          content: 'Non sono presenti dati.'
        });
        return;
      }
      console.log(res);
      this.configurazione = res.info.dati;

      this._ui = res.info.ui;
      console.log("this._ui:", this._ui);

      this.loadingService.closeDialog();
    });
  }


  // getter methods
  get configurazioneSelezionate() { return this._configurazioneSelezionate; }

  get ui() { return this._ui; }
}
