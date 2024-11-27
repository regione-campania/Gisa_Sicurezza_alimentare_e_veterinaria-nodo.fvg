/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { ASmartTableComponent, BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';
import { GestioneAttivitaService } from 'src/app/portals/gestione-attivita/gestione-attivita.service';

@Component({
  selector: 'app-fatture',
  templateUrl: './lista-fatture.component.html',
  styleUrls: ['./lista-fatture.component.scss']
})
export class ListaFattureComponent implements OnInit {
  private _fatture?: any;
  private _ui?: any;
  private _fields: string[] = [];
  @ViewChild(ASmartTableComponent) tabella?: ASmartTableComponent;
  private attFattSelected?: any;

  constructor(
    private client: BackendCommunicationService,
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private router: Router,
  ) { }

  ngOnInit(): void {
    this.client.getDati('get_fatture', { id: 1 }).subscribe(res => {
      console.log(res);
      if (res.esito) {
        this._fatture = res.info.fatture;

        this._ui = res.info.ui;
        console.log("this._ui:", this._ui);

        this._fields = res.info.ui.colonne.map((field: any) => {
          return field.campo;
        });
        console.log("this._fields:", this._fields);
      } else {
        this.notificationService.push({
          notificationClass: 'warning',
          content: res.msg?.toLocaleUpperCase()
        });
        return;
      }
    });
  }
  generaFatture(): void {
    console.log(this.tabella?.selectedData);
   this.loadingService.openDialog('Caricamento Dati...');
   this.attFattSelected = this.tabella?.selectedData.map((attFatt: any) => attFatt.id);
   console.log("selezionato: ",this.attFattSelected);
    if (this.attFattSelected && this.attFattSelected.length != 0) {
      this.client.updDati('upd_genera_ft_periodiche', { id_fatture: this.attFattSelected }).subscribe((res) => {
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

  onClick(idFattura: any){

    this.router.navigate(["portali/gestione-attivita/scontrino"], {
      queryParams: {
        id: idFattura, tipo: 'id_trf_fattura', funzione: 'fattura'
      }
    });



  }

  public get fatture() { return this._fatture; }
  public get fields() { return this._fields; }
  public get ui() { return this._ui; }
}
