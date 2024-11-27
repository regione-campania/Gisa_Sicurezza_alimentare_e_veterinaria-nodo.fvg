/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ASmartTableComponent, BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-genera-fatture',
  templateUrl: './genera-fatture.component.html',
  styleUrls: ['./genera-fatture.component.scss']
})
export class GeneraFattureComponent implements OnInit {

  @ViewChild(ASmartTableComponent) tabella?: ASmartTableComponent;
  private attFatturabili?: any;
  private attFattSelected?: any;
  private _ui?: any;
  private _fields: string[] = [];

  constructor(
    private client: BackendCommunicationService,
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
  ) { }

  ngOnInit(): void {
    this.loadingService.openDialog('Caricamento Dati...');
    this.client.getDati('get_attivita_fatturabili', {id: 1}).subscribe(res => {
      this.loadingService.closeDialog();
      if (res.info) {
        this.attFatturabili = res.info.dati;
        console.log("this.attFatturabili:", this.attFatturabili);
        this._ui = res.info.ui;
        console.log("this._ui:", this._ui);
        this._fields = res.info.ui.colonne.map((field: any) => {
          return field.campo;
        });
        console.log("this._fields:", this._fields);
      }

    })
  }

  generaFatture(): void {
    console.log(this.tabella?.selectedData);
    this.loadingService.openDialog('Caricamento Dati...');
    this.attFattSelected = this.tabella?.selectedData.map((attFatt: any) => attFatt.id);
    if (this.attFattSelected && this.attFattSelected.length != 0) {
      this.client.updDati('upd_genera_fatture', { id_attivita: this.attFattSelected }).subscribe((res) => {
        console.log("res", res);
        this.loadingService.closeDialog();
        if (res.esito) {
          this.notificationService.push({
            notificationClass: 'success',
            content: 'Generazione fatture avvenuta con successo.'
          });
        } else {
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Attenzione! Errore durante la generazione delle fatture.'
          });
        }
        this.ngOnInit();
      })
    } else if (this.attFattSelected.length == 0) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: 'Attenzione! Non hai selezionato nessuna attività.'
      });
      this.loadingService.closeDialog();
    }
  }

  // getter methods
  public get getAttFatturabili() {
    return this.attFatturabili;
  }

  public get getAttFattSelected() {
    return this.attFattSelected;
  }

  public get fields() {
    return this._fields;
  }

  public get ui() {
    return this._ui;
  }
}
