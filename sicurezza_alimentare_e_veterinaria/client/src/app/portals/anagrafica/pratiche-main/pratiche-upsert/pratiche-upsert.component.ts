/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { FormPraticheComponent } from '../form-pratiche/form-pratiche.component';
import { ActivatedRoute, Router } from '@angular/router';
import { NotificationService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';
import { StabilimentiMainComponent } from '../../stabilimenti-main/stabilimenti-main.component';
import { AppService } from 'src/app/app.service';

@Component({
  selector: 'app-pratiche-upsert',
  templateUrl: './pratiche-upsert.component.html',
  styleUrls: ['./pratiche-upsert.component.scss']
})
export class PraticheUpsertComponent {

  @ViewChild('formPratiche') _formPratiche?: FormPraticheComponent;
  @ViewChild('ricercaStabilimenti') ricercaStabilimenti?: StabilimentiMainComponent;
  labelBottone: any;
  selezionaStab: any

  private id_utente: any

  private _id_pratica: any
  private _pratica: any

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private cus: AnagraficaService,
    private ap: AppService,
    private notificationService: NotificationService,
  ) { }

  ngOnInit() {
    //console.log(this.route.snapshot.url[0].path)

    this.ap.getUser().subscribe((res: any) => {
      this.id_utente = +res.id_utente
      this.route.snapshot.url[0].path === 'aggiungi' ? this.labelBottone = 'Aggiungi' : this.labelBottone = 'Modifica'

      this.route.queryParams.subscribe((res: any) => {
        if (res['id_pratica']) {
          this._id_pratica = +res['id_pratica']
          this.cus.getPraticaSingolo(this._id_pratica).subscribe((res: any) => {
            if (res.info) {
              this._pratica = res.info.dati[0]
              this._formPratiche?.formPratiche.setValue({
                id_utente: this.id_utente,
                id_pratica: this._id_pratica,
                id_tipo_pratica: this._pratica.id_tipo_pratica,
                descr_tipo_pratica: this._pratica.descr_tipo_pratica,
                n_pratica: this._pratica.n_pratica,
                data_pratica: this._pratica.dt_pratica != null ? this._pratica.dt_pratica.split('T')[0] : "",
                data_autorizzazione: this._pratica.dt_autorizzazione != null ? this._pratica.dt_autorizzazione.split('T')[0] : "",
                id_stabilimento: this._pratica.id_stabilimento
              })
            }
            this._formPratiche?.checkTipoPratica(1)
          })
        }
      })
    })
  }

  updSelStab(flag: any) {
    this.selezionaStab = flag
  }

  stabSelezionato(id_stabilimento: any) {
    this._formPratiche?.formPratiche.controls.id_stabilimento.setValue(id_stabilimento)
  }

  upsert() {
    if (this._formPratiche?.formPratiche?.invalid) {
      return;
    }
    const params = {
      ...this._formPratiche?.formPratiche.getRawValue()
    }

    //console.log(params)
    if (this._id_pratica) {
      this.cus.updPratica(params).subscribe((res: any) => {
        if (res.info) {
          this.router.navigate(['portali/anagrafica/pratiche/dettaglio'], {
            queryParams: { id_pratica: res.info.id_pratica }
          });
        }
      })
    } else {
      this.cus.addPratica(params).subscribe((res: any) => {
        if (res.info) {
          this.router.navigate(['portali/anagrafica/pratiche/dettaglio'], {
            queryParams: { id_pratica: res.info.id_pratica }
          });
        }
      })
    }
  }

  get pratica() { return this._pratica }
}
