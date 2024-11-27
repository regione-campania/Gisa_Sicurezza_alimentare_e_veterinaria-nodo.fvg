/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-lista-fatture-periodiche',
  templateUrl: './lista-fatture-periodiche.component.html',
  styleUrls: ['./lista-fatture-periodiche.component.scss']
})
export class ListaFatturePeriodicheComponent implements OnInit {
  private _ui?: any;
  private _fatture_periodiche?: any;
  constructor(
    private client: BackendCommunicationService,
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
  ) { }
    ngOnInit(): void {
      this.client.getDati('get_trf_ft_periodiche').subscribe((res : any) => {
        console.log("dati fatture periodiche: ", res);
        this._ui = res.info.ui;
        this._fatture_periodiche = res.info.fatture_periodiche
      })
    }
    get ui() { return this._ui; }
    get fatture_periodiche() {return this._fatture_periodiche; }
}
