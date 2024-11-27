/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { AnagraficaService } from '../../anagrafica.service';
import { NotificationService } from '@us/utils';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-automezzi-dettaglio',
  templateUrl: './automezzi-dettaglio.component.html',
  styleUrls: ['./automezzi-dettaglio.component.scss']
})
export class AutomezziDettaglioComponent {
  private _id_automezzo: any;
  private _automezzo: any;
  private _ui_automezzo: any;
  private _ui_stabilimenti_automezzi: any;
  private _stabilimenti_automezzi: any;
  disabilitaModificaAutomezzo: boolean = false
  disabilitaModificaStab: boolean = false
  disabilitaModificaEAggiungiStab: boolean = false
  constructor(
    private route: ActivatedRoute, //this.route.snapshot.url[0].path ritorna parte finale dell'url
    private router: Router,
    private cus: AnagraficaService,
    private notificationService: NotificationService,
  ) {
  }
  ngOnInit() {
    this.route.queryParams.subscribe((res : any) => {
      this._id_automezzo = +res['id_automezzo'];
      this.cus.getAutomezzoSingolo(this._id_automezzo).subscribe((res : any) => {
        this._automezzo = res.info.dati[0];
        this._ui_automezzo = res.info.ui;
        if (this._automezzo.automezzo_modificabile == false) {
          this.disabilitaModificaAutomezzo = this._automezzo.automezzo_modificabile;
          this.disabilitaModificaAutomezzo = !this.disabilitaModificaAutomezzo;
        }
        if (this._automezzo.stabilimento_modificabile == false) {
          this.disabilitaModificaEAggiungiStab = this._automezzo.stabilimento_modificabile;
          this.disabilitaModificaEAggiungiStab = !this.disabilitaModificaEAggiungiStab;
          this.disabilitaModificaStab = !this.disabilitaModificaStab;
          console.log(this.disabilitaModificaEAggiungiStab);
        }
      })
      this.cus.getStabilimentiAutomezzi(this._id_automezzo).subscribe((res : any) => {
        let cntStab = 0
        if(res.esito) {
          this._stabilimenti_automezzi = res.info.dati;
          this._ui_stabilimenti_automezzi = res.info.ui;
          this._stabilimenti_automezzi.forEach((elem : any) => {
            if(!elem.fine_validita_stab_automezzi) {
              cntStab ++;
            }
          })
        }
        console.log(cntStab);
        if (cntStab >= 1 || this._automezzo.stabilimento_modificabile == false)
          this.disabilitaModificaEAggiungiStab = true;
        else
          this.disabilitaModificaEAggiungiStab = false;
      })
    })
  }
  get automezzo() { return this._automezzo; }
  get ui_automezzo() { return this._ui_automezzo; }
  get stabilimenti_automezzi() { return this._stabilimenti_automezzi; }
  get ui_stabilimenti_automezzi() { return this._ui_stabilimenti_automezzi; }

  goToModifica() {
    this.router.navigate(['portali/anagrafica/automezzi/modifica'], {
      queryParams: { id_automezzo: +this._id_automezzo },
    });
  }

  goToAggiungiStabilimento() {
    this.router.navigate(['portali/anagrafica/automezzi/aggiungi-stabilimento'], {
      queryParams: { id_automezzo: +this._id_automezzo },
    });
  }

  goToModificaStabilimento(ar : any) {
    this.router.navigate(['portali/anagrafica/automezzi/modifica-stabilimento'], {
      queryParams: { id_stabilimento_automezzi: +ar.id_stabilimento_automezzi, id_automezzo: +this._id_automezzo},
    });
  }
}
