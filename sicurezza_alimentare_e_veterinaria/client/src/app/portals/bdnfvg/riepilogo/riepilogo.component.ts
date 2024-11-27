/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-riepilogo',
  templateUrl: './riepilogo.component.html',
  styleUrls: ['./riepilogo.component.scss']
})
export class RiepilogoComponent implements OnInit {
  private _allev_riep?: any;
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

      if (!data.riepilogo.esito) {
        return;
      }

      this._allev_riep = data.riepilogo.info.dati;
      console.log("this._allev_riep:", this._allev_riep);

      this._ui = data.riepilogo.info.ui;
      console.log("this._ui:", this._ui);
    })
  }

  // Accessors
  get allev_riep() { return this._allev_riep; }
  get ui() { return this._ui; }
}
