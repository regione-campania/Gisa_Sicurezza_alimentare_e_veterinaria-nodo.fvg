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

@Component({
  selector: 'app-verifica-evidenze-fu',
  templateUrl: './verifica-evidenze-fu.component.html',
  styleUrls: ['./verifica-evidenze-fu.component.scss']
})
export class VerificaEvidenzeFuComponent {

  private _id_cu: any;
  private _cu: any;
  private _id_provv_fu: any;
  private _ui: any;
  private _evidenze: any;

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
      this._id_provv_fu = +params['id_provv_fu'];
      this._id_cu = +params['id_cu'];

      this.cus.getCuSingolo(this._id_cu).subscribe((res: any) => {
        this._cu = res.info.dati[0]
      });
    });

    this.cus.getEvidenzeFU(this._id_provv_fu).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      this._evidenze = res.info.dati
      this._ui = res.info.ui
    });
  }

  get id_cu() { return this._id_cu }
  get cu() { return this._cu }
  get ui() { return this._ui }
  get evidenze() { return this._evidenze }
}
