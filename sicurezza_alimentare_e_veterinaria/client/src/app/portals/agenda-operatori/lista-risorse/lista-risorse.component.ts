/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { ActivatedRoute, Router } from '@angular/router';
import { AgendaOperatoriService } from '../agenda-operatori.service';

@Component({
  selector: 'lista-risorse',
  templateUrl: './lista-risorse.component.html',
  styleUrls: ['./lista-risorse.component.scss']
})
export class ListaRisorseComponent implements OnInit {

  infoCalendari: any

  constructor(
    private as: AgendaOperatoriService,
    private notification: NotificationService,
    private loading: LoadingDialogService,
    private router: Router,
    private route: ActivatedRoute
  ) { }

  ngOnInit(): void {
    //if (!(this.infoCalendari = this.as.storage.getItem('infoCalendari'))) {} cache momentaneamente sospesa
    this.initCalendari();
  }

  initCalendari() {
    this.loading.openDialog('Caricamento risorse in corso...');
    this.as.getCalendari().subscribe(res => {
      this.loading.closeDialog();
      if (!res.esito) {
        this.notification.push({
          notificationClass: 'error',
          content: 'Errore! Risorse non trovate'
        });
      } else {
        this.infoCalendari = res.info;
        //this.as.storage.setItem('infoCalendari', this.infoCalendari); cache momentaneamente sospesa
      }
    });
  }

  gotoCalendar(resouceId: string) {
    sessionStorage.setItem('risorsa', resouceId);
    this.router.navigate(["calendario"], { relativeTo: this.route, queryParams: { id: resouceId } });
  }

  parsePercent(n: any) {
    return parseFloat(n) / parseFloat('100');
  }

}
