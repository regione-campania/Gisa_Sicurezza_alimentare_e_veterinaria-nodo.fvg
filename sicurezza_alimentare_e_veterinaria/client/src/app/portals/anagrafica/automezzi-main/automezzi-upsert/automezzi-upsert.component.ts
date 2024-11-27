/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, Output, ViewChild } from '@angular/core';
import { FormAutomezziComponent } from '../form-automezzi/form-automezzi.component';
import { ActivatedRoute, Router } from '@angular/router';
import { AnagraficaService } from '../../anagrafica.service';
import { NotificationService } from '@us/utils';
import { AutomezziMainComponent } from '../automezzi-main.component';

@Component({
  selector: 'app-automezzi-upsert',
  templateUrl: './automezzi-upsert.component.html',
  styleUrls: ['./automezzi-upsert.component.scss']
})
export class AutomezziUpsertComponent {
  labelBottone: any;
  @ViewChild('formAutomezzi') _formAutomezzi?: FormAutomezziComponent;
  private _id_automezzo: any;
  formPresa: any;
  constructor(
    private route: ActivatedRoute, //this.route.snapshot.url[0].path ritorna parte finale dell'url
    private router: Router,
    private cus: AnagraficaService,
    private notificationService: NotificationService,
  ) {
    //Per creare nuove proprietà dinamicamente al params
    interface params extends Record<string, any> {

    }
  }
  ngOnInit() {
    console.log(this.route.snapshot.url[0].path)
    this.route.queryParams.subscribe((res: any) => {
      if (this.route.snapshot.url[0].path === 'aggiungi') {
        this.labelBottone = 'Aggiungi';
      }
      else {
        this.labelBottone = 'Modifica';
        this._id_automezzo = +res['id_automezzo'];
        this.cus.getAutomezzoSingolo(this._id_automezzo).subscribe((res: any) => {
          if (res.esito) {
            this._formAutomezzi?.formAutomezzo.controls['marca'].setValue(res.info.dati[0].marca);
            this._formAutomezzi?.formAutomezzo.controls['modello'].setValue(res.info.dati[0].modello);
            this._formAutomezzi?.formAutomezzo.controls['targa'].setValue(res.info.dati[0].targa);
          }
        })

      }
    })
  }


  salvaAutomezzo() {
    const params = {
      marca: this._formAutomezzi?.formAutomezzo.value.marca,
      modello: this._formAutomezzi?.formAutomezzo.value.modello,
      targa: this._formAutomezzi?.formAutomezzo.value.targa,
      id_automezzo: 0,
      id_stabilimento_automezzo: 0
    }
    if(this.labelBottone == 'Aggiungi') {
      this.cus.insAutomezzo(params).subscribe((res: any) => {
        if (res.esito) {
          this._id_automezzo = res.info;
          this.router.navigate(['portali', 'anagrafica', 'automezzi', 'dettaglio'], { queryParams: { id_automezzo: +this._id_automezzo } })
        }
      })
    }
    else {
      this.formPresa = this._formAutomezzi?.formAutomezzo.getRawValue();
      params.targa = this.formPresa.targa;
      params.id_automezzo = this._id_automezzo;
      this.cus.updAutomezzo(params).subscribe((res: any) => {
        if (res.esito) {
          this.router.navigate(['portali', 'anagrafica', 'automezzi', 'dettaglio'], { queryParams: { id_automezzo: +this._id_automezzo } })
        }
      })
    }
  }
}
