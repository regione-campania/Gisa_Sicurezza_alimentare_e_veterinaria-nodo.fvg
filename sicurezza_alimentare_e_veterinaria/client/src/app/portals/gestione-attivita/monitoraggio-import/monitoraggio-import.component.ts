/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ASmartTableComponent, BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';


@Component({
  selector: 'app-monitoraggio-import',
  templateUrl: './monitoraggio-import.component.html',
  styleUrls: ['./monitoraggio-import.component.scss']
})
export class MonitoraggioImportComponent implements OnInit {

  @ViewChild(ASmartTableComponent) tabella?: ASmartTableComponent;
  monitoraggioImport?: any;
  private _monitoraggioImport: any[] = [];
  private _ui?: any;

  constructor(
    private client: BackendCommunicationService,
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.loadingService.openDialog('Caricamento Dati...');
    this.client.getDati('get_monitoraggio_flusso_import', { id: 1 }).subscribe(res => {
      if (!res.esito) {
        this.loadingService.closeDialog();
        this.notificationService.push({
          notificationClass: 'warning',
          content: 'Non sono presenti dati.'
        });
        return;
      }
      console.log("res:",res);
      this.monitoraggioImport = res.info.dati;
      console.log("res.info.dati:",res.info.dati);
      this._ui = res.info.ui;
      console.log("this._ui:", this._ui);

      this.loadingService.closeDialog();
    });
  }


  onClick(att:any): void {
    console.log("onclick");
    console.log("att:", att);

 /*    if (att.flusso) {
      this.router.navigate(["/scontrino"], {
        queryParams: {
          flusso: att.id_trf_attivita,
          tipo: 'id_trf_attivita',
          funzione: 'rilevazione_attivita',
          isClosed: att.closed
        }
      });
    } */

    if (att.scarti!=0 &&  (att.flusso=='Aziende' || att.flusso=='Aziende Importate'))  {

      this.router.navigate(
        ["./scarti"],
        {relativeTo: this.route, queryParams:  { flusso: att.flusso }}
      );
    }
    if (att.scarti!=0 &&  (att.flusso=='Persone'))  {
      this.router.navigate(
        ["./scarti"],
        {relativeTo: this.route, queryParams:  { flusso: att.flusso }}
      );
    }

  }




  // getter methods
  get monitoraggioImportSelezionate() { return this._monitoraggioImport; }

  get ui() { return this._ui; }
}
