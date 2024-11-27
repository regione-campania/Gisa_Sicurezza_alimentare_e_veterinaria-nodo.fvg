/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, Output, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AnagraficaService } from '../../anagrafica.service';
import { NotificationService } from '@us/utils';
import { AutomezziMainComponent } from '../automezzi-main.component';

@Component({
  selector: 'app-stabilimenti-automezzi-upsert',
  templateUrl: './stabilimenti-automezzi-upsert.component.html',
  styleUrls: ['./stabilimenti-automezzi-upsert.component.scss']
})
export class StabilimentiAutomezziUpsertComponent {
  mostraRicerca: boolean = true;
  @Output() valueEmitted = new EventEmitter<string>();
  selezionaStab: any = true;
  @ViewChild('formDataStab') _formDataStab?: AutomezziMainComponent;
  private _id_automezzo: any;
  private _id_stabilimento_automezzi: any;
  operazione: any;
  constructor(
    private route: ActivatedRoute, //this.route.snapshot.url[0].path ritorna parte finale dell'url
    private router: Router,
    private cus: AnagraficaService,
    private notificationService: NotificationService,
  ) {
  }
  ngOnInit() {
    this.route.queryParams.subscribe((res : any) => {
      if(this.route.snapshot.url[0].path == 'aggiungi-stabilimento') {
        this._id_automezzo = +res['id_automezzo'];
        this.operazione = 'Aggiungi';
      }
      else {
        this.operazione = 'Modifica';
        this._id_automezzo = +res['id_automezzo'];
        this._id_stabilimento_automezzi = +res['id_stabilimento_automezzi'];
        this.cus.getAutomezzoStabilimentoSingolo(this._id_stabilimento_automezzi).subscribe((res : any) => {
          this._formDataStab?.formDataStab.controls['data_inizio_validita'].setValue((res.info.dati[0].inizio_validita_stab_automezzi).split('T')[0]);
          this._formDataStab?.formDataStab.controls['data_fine_validita'].setValue(res.info.dati[0].fine_validita_stab_automezzi ? (res.info.dati[0].fine_validita_stab_automezzi).split('T')[0] : null);
        })
      }
    })
  }
  ngAfterViewInit() {
    if(this.route.snapshot.url[0].path == 'aggiungi-stabilimento') {
      this.operazione = 'Aggiungi';
      this._formDataStab!.setOperazione = this.operazione;
    }
    else {
      this.operazione = 'Modifica';
      this._formDataStab!.setOperazione = this.operazione;
      this._formDataStab?.formDataStab.controls['id_stabilimento'].clearValidators();
      this._formDataStab?.formDataStab.controls['id_stabilimento'].updateValueAndValidity();
    }
  }

  stabSelezionato(id_stabilimento: any) {
    console.log(id_stabilimento)
    this._formDataStab?.formDataStab.controls['id_stabilimento'].setValue(+id_stabilimento);
  }

  agganciaStabilimento() {
    const params = {
      id_automezzo: this._id_automezzo ? this._id_automezzo : null,
      id_stabilimento: this._formDataStab?.formDataStab.value.id_stabilimento,
      data_inizio_validita: this._formDataStab?.formDataStab.value.data_inizio_validita,
      data_fine_validita: this._formDataStab?.formDataStab.value.data_fine_validita,
      id_stabilimento_automezzi: 0
    }
    console.log(params);
    if(this.operazione == 'Aggiungi') {
      this.cus.insStabilimentiAutomezzi(params).subscribe((res : any) => {
        if(res.esito) {
          this.router.navigate(['portali', 'anagrafica', 'automezzi', 'dettaglio'], { queryParams: { id_automezzo: +this._id_automezzo } })
        }
      })
    }
    else {
      console.log('modifica');
      params.id_stabilimento_automezzi = this._id_stabilimento_automezzi;
      console.log(params)
      this.cus.updStabilimentiAutomezzi(params).subscribe((res : any) => {
        if(res.esito) {
          this.router.navigate(['portali', 'anagrafica', 'automezzi', 'dettaglio'], { queryParams: { id_automezzo: +this._id_automezzo } })
        }
      })
    }
  }
}
