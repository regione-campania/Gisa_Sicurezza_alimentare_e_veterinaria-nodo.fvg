/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NotificationService, LoadingDialogService, BackendCommunicationService } from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'app-verifica-provvedimenti-fs',
  templateUrl: './verifica-provvedimenti-fs.component.html',
  styleUrls: ['./verifica-provvedimenti-fs.component.scss']
})
export class VerificaProvvedimentiFsComponent {

  btnMode: any
  private form_ui: any
  controllo_chiuso: boolean = false
  cu: any

  private modalRisoluzione?: bootstrap.Modal

  private _ui_provv: any
  private _provv: any
  private _id_provv: any

  constructor(
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private cus: ControlliUfficialiService,
    private fb: FormBuilder,
    private LoadingService: LoadingDialogService,
    private changeDetector: ChangeDetectorRef,
    private client: BackendCommunicationService,
    private router: Router
  ) { }

  ngOnInit() {

    this.route.queryParams.subscribe(params => {

      this.cus.getCuSingolo(+params['id_cu']).subscribe((res: any) => {
        this.cu = res.info.dati[0]
        this.controllo_chiuso = this.cu.chiuso
        this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
        this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'fsProvv')) ?? { mode: 'view' } //se non è definito
        this.btnMode = this.form_ui.mode == 'view'

        this.client.getDati("get_cu_provv_sopralluogo_fu", { id_cu: +this.cu.id_cu }).subscribe((res: any) => {
          if (res.info) {
            this._ui_provv = res.info.ui
            this._provv = res.info.dati
          }
        });
      });
    });

    this.modalRisoluzione = new bootstrap.Modal('#modal-risoluzione')

  }

  openModal(idProvv: any) {
    this.modalRisoluzione?.toggle()
    this._id_provv = idProvv;
  }

  updProvv(stato: boolean) {
    //console.log(this._id_provv + " " + stato);
    this.modalRisoluzione?.hide()
    this.client.updDati('upd_cu_provv_sopralluogo_fu_stato', { id_provv_fu: +this._id_provv, stato: stato }).subscribe((res: any) => {
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: 'Errore durante la rimozione.'
        });
      }
      //this.ngOnInit();
      window.location.reload()
    });

  }


  get provv() { return this._provv };
  get ui_provv() { return this._ui_provv };

}
