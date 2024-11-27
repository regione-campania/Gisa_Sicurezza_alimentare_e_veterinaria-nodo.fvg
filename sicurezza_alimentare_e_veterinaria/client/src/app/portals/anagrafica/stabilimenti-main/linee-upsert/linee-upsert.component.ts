/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';
import { FormLineeComponent } from '../form-linee/form-linee.component';

@Component({
  selector: 'app-linee-upsert',
  templateUrl: './linee-upsert.component.html',
  styleUrls: ['./linee-upsert.component.scss']
})
export class LineeUpsertComponent implements OnInit {
  //---------------------------VARIABILI-----------------------------
  labelBottone: any;
  _id_stabilimento: any;
  _id_linea: any;
  @ViewChild('formLinee') _formLinee?: FormLineeComponent;
  //---------------------------COSTRUTTORE---------------------------
  constructor(private cus: AnagraficaService,
    private LoadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private router: Router,
    private fb: FormBuilder) {

  }
  //---------------------------------NGONINIT------------------------
  ngOnInit(): void {
    console.log(this.route.snapshot.url[0].path)
    if (this.route.snapshot.url[0].path === 'aggiungi') {
      this.labelBottone = 'Aggiungi';
    }
    else {
      this.labelBottone = 'Modifica';
    }
    this.route.queryParams.subscribe((res: any) => {
      if (res['id_stabilimento']) {
        this._id_stabilimento = res['id_stabilimento'];
      }
      if (res['id_linea']) {
        this._id_linea = res['id_linea'];
        this.cus.getStabilimentiLineeSingolo(this._id_linea).subscribe((res: any) => {
          this._id_stabilimento = res.info.dati[0].id_stabilimento;
          this._formLinee?.formLinea.patchValue({
            data_inizio_validita: res.info.dati[0].inizio_validita === null ? "" : (res.info.dati[0].inizio_validita).split('T')[0],
            data_fine_validita: res.info.dati[0].fine_validita === null ? "" : (res.info.dati[0].fine_validita).split('T')[0],
          })
        })
      }

    })
  }
  //--------------------FUNZIONI----------------------------------
  updLinea() {
    if (!this._formLinee?.formLinea.valid) {
      return
    }
    const params = {
      //linea_principale: this._formLinee.formLinea.value.valore === 'si' ? true : false,
      id_linea: 0,
      //data_ultima_visita: this.formLinea.value.data_ultima_visita,
      data_inizio_validita: this._formLinee.formLinea.value.data_inizio_validita,
      data_fine_validita: this._formLinee.formLinea.value.data_fine_validita,
      id_tipo_linea: 0,
      id_stabilimento: +this._id_stabilimento
    }
    if (this._id_linea) {
      params.id_linea = +this._id_linea;
      this.cus.updLinea(params).subscribe((res: any) => {
        if (!res.esito) {
          this.LoadingService.closeDialog();
          return;
        }
        console.log("dati upd linee", res);
        setTimeout(() => { this.router.navigate(['portali', 'anagrafica', 'stabilimenti','dettaglio'], { queryParams: { id_stabilimento: +this._id_stabilimento } }); }, 1500);
      })
    }
    else {
      if(!this._formLinee?.lineeTree?.nodes?.map(node => node.selected) || !this._formLinee.formLinea){
        return;
      }
      //Per prendere tutti i nodi foglia selezionati
      let selectedTipiLinea = this._formLinee.lineeTree?.leafNodes!.filter(n => n.selected).map(n => n.data.id);
      for(let i = 0; i < selectedTipiLinea.length; i ++) {
        params.id_tipo_linea = selectedTipiLinea[i];
        this.cus.addLinea(params).subscribe((res: any) => {
          if (!res.esito) {
            this.LoadingService.closeDialog();
            return;
          }
          console.log("dati upd linee", res);
          setTimeout(() => { this.router.navigate(['portali', 'anagrafica', 'stabilimenti', 'dettaglio'], { queryParams: { id_stabilimento: +this._id_stabilimento } }); }, 1500);
        })
      }
    }
  }
  //------------------GETTER E SETTER-----------------------------
}
