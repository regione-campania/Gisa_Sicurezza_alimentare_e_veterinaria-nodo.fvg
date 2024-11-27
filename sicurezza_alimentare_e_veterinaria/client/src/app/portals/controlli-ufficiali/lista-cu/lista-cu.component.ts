/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewContainerRef } from '@angular/core';
import { Router } from '@angular/router';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { LoadingDialogService, BackendCommunicationService, NotificationService } from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';

@Component({
  selector: 'app-lista-cu',
  templateUrl: './lista-cu.component.html',
  styleUrls: ['./lista-cu.component.scss']
})
export class ListaCuComponent {

  private _ui: any;
  private _lista_cu: any;

  constructor(
    public viewContainer: ViewContainerRef,
    public modalService: NgbModal,
    private LoadingService: LoadingDialogService,
    private client: BackendCommunicationService,
    private notification: NotificationService,
    private router: Router,
    private cs: ControlliUfficialiService,
  ) { }

  ngOnInit() {
    this.cs.getCu().subscribe((res: any) => {
      this.LoadingService.closeDialog();
      console.log(res);
      this._ui = res.info.ui;
      this._lista_cu = res.info.dati;
    });
  }

  dettaglioCu(id_cu: any) {
    this.router.navigate(["portali/controlli-ufficiali/lista/dettaglio"], { queryParams: { id_cu: id_cu } });
  }

  get ui() { return this._ui };
  get lista_cu() { return this._lista_cu };

}
