/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { Location } from '@angular/common';
import { CapannoniService } from '../services';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-capannoni',
  templateUrl: './capannoni.component.html',
  styleUrls: ['./capannoni.component.scss']
})
export class CapannoniComponent implements OnInit {
  private _all_info?: any;
  private _capannoni?: any;
  private _ui?: any;

  constructor(
    private notificaitonService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private _location: Location,
    private cs: CapannoniService
  ) { }

  ngOnInit(): void {
    this.route.data.subscribe((data: any) => {
      this.loadingService.closeDialog();
      console.log("data:", data);
      if (!data.capannoni.esito) {
        this.notificaitonService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore nel caricamento dei dati.'
        });
        return;
      }

      // Ritorna se non ci sono dati
      if (data.capannoni.info === true) return;

      this._capannoni = data.capannoni.info.dati;
      console.log("this._capannoni:", this._capannoni);

      this._ui = data.capannoni.info.ui;
      console.log("this._ui:", this._ui);
    });

    this.route.queryParams.subscribe((all: any) => {
      this._all_info = {
        'Partita IVA': all['partita_iva'].trim(),
        'Nome': all['name'],
        'Codice Azienda': all['account_number']
      };

      console.log("this._all_info:", this._all_info);
    });
  }

  goBack() { this._location.back(); }

  // Accessors
  get capannoni() { return this._capannoni; }
  get ui() { return this._ui; }
  get all_info() { return this._all_info; }
}
