/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Location } from '@angular/common';
import { NotificationService, LoadingDialogService } from '@us/utils';
import { AppService } from 'src/app/app.service';
import { BdnfvgService } from '../bdnfvg.service';

@Component({
  selector: 'app-interventi',
  templateUrl: './interventi.component.html',
  styleUrls: ['./interventi.component.scss']
})
export class InterventiComponent implements OnInit {
  private _interventi?: any;
  private _ui?: any;
  private _fromAllevamento: boolean = false;
  private _id_allevamento?: number | null;

  constructor(
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private _location: Location,
    private router: Router,
    private app: AppService,
    private bs: BdnfvgService
  ) { }

  ngOnInit(): void {
    this.app.getUser().subscribe((userInfo: any) => {
      this.loadingService.openDialog('Caricamento interventi');
      this.bs.getDati('get_interventi', {id_struttura_root: userInfo.idStrutturaRoot, livello: userInfo.livello, id_nominativo_struttura: userInfo.idNominativoStruttura}).subscribe((data: any) => {
        this.loadingService.closeDialog();
        console.log("data:", data);
        if (!data?.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Attenzione! Errore nel caricamento dei dati.'
          });
          return;
        }
        this._interventi = data?.info.dati;
        console.log("this._interventi:", this._interventi);

        this._ui = data?.info.ui;
        console.log("this._ui:", this._ui);
      });

      this.route.queryParams.subscribe((res: any) => {
        console.log("res:", res);
        if (!res) return;

        if (res['fromAll']) {
          this._fromAllevamento = res['fromAll'];
          console.log("this._fromAllevamento:", this._fromAllevamento);
        }

        // Recupera l'id allevamento se si passa per il riepilogo
        this._id_allevamento = Number.isNaN(parseInt(res['id_allevamento'])) ? null : parseInt(res['id_allevamento']);
        console.log("this._id_allevamento:", this._id_allevamento);
      });
    })
  }

  openIntervento(idIntervento: any) {
    this.router.navigate(['gestione-intervento'], {queryParams: {id_intervento: idIntervento}, relativeTo: this.route})
  }

  goBack(): void { this._location.back(); }

  get interventi() { return this._interventi; }
  get ui() { return this._ui; }
  get fromAll() { return this._fromAllevamento; }
  get id_allevamento() { return this._id_allevamento; }
}
