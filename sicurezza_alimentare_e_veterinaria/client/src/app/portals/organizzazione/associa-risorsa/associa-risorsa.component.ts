/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { ConfigurazioniService } from '../../configurazioni/configurazioni.service';
import { OrganizzazioneService } from '../organizzazione.service';

@Component({
  selector: 'app-associa-risorsa',
  templateUrl: './associa-risorsa.component.html',
  styleUrls: ['./associa-risorsa.component.scss']
})
export class AssociaRisorsaComponent {
  //-----------------VARIABILI------------------------------
  private _id_node: any;
  descr_asl: any
  private _ui: any;
  private _utenti: any;
  private _id_utente: any;
  flagCliccato: boolean = false;
  //------------------------COSTRUTTORE-------------------------------

  constructor(
    private og: OrganizzazioneService,
    private LoadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private router: Router,
    private route: ActivatedRoute,
  ) {  }

  ngOnInit() {
    this.route.queryParams.subscribe((res : any) => {
      // console.log(res);
      this._id_node = parseInt(res['id_node']);
      this.og.getStruttureAslSingolo({id_node: this._id_node}).subscribe((res : any) => {
        this.descr_asl = res.info[0].descrizione_breve;
        this.og.getUtentiForStruttura({id_struttura: this._id_node, id_asl: res.info[0].id_asl}).subscribe((res : any) => {
          this._ui = res.info.ui;
          this._utenti = res.info.dati;
        })
      })
    })
  }

  prendiRisorsa(event : any, ar: any) {
    let trUtente = document.querySelectorAll('.tr-Utente');
    trUtente.forEach((p: Element) => { (p as HTMLElement).classList.remove("cliccato") });
    (event.srcElement.parentElement as HTMLElement).classList.add('cliccato');
    this.flagCliccato = true;
    // console.log(ar);
    this._id_utente = ar.id_utente;
    // console.log(this._id_utente);
  }

  associaRisorsa() {
    const params = {
      id_node: this._id_node,
      id_utente: this._id_utente
    }
    console.log(params);
    this.og.insRisorsa(params).subscribe((res : any) => {
      console.log(res);
      if(res.esito) {
        this.router.navigate(['portali', 'organizzazione','organigramma-risorse']);
      }
    })
  }
  get ui() { return this._ui; }
  get utenti() { return this._utenti; }
}
