/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { AgendaOperatoriService } from '../agenda-operatori.service';

@Component({
  selector: 'app-lista-nominativi-carico',
  templateUrl: './lista-nominativi-carico.component.html',
  styleUrls: ['./lista-nominativi-carico.component.scss']
})
export class ListaNominativiCaricoComponent {
  private _ui: any;
  private _nominativi: any;
  constructor(
    private as: AgendaOperatoriService,
    private notification: NotificationService,
    private loading: LoadingDialogService,
    private router: Router
  ) { }
  ngOnInit() {
    this.as.getNominativiCarico().subscribe((res: any) => {
      console.log(res);
      if (res.esito) {
        console.log("dati:",res.info.dati);
        this._ui = res.info.ui;
        this._nominativi = res.info.dati;
      }
    })
  }

  gotoCalendar(resouceId: string) {
    sessionStorage.setItem('risorsa', resouceId);
    this.router.navigate(["portali/agenda-operatori/calendario"], { queryParams: { id: resouceId } });
  }


  get ui() { return this._ui; }
  get nominativi() { return this._nominativi; }
}
