/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { BackendCommunicationService } from '@us/utils';
import { HOME_URL } from 'src/app/conf';
import { UserService } from 'src/app/services/user.service';


@Component({
  selector: 'app-unita-di-crisi',
  templateUrl: './unita-di-crisi.component.html',
  styleUrls: ['./unita-di-crisi.component.scss']
})
export class UnitaDiCrisiComponent {
  private _unita_di_crisi: any;
  private _ui: any;

  id_asl: any;
  id_asl_utente: any;
  livello: any;
  mostraUiFvg: boolean = false;
  mostraUiAsu_fc: boolean = false;
  mostraUiAs_fo: boolean = false;
  mostraUiAsu_gi: boolean = false;
  disabilitaAgg: boolean = false;
  constructor(
    private ComunicazioneDB: BackendCommunicationService,
    private userService: UserService,
    private router: Router,
  ) { }

  ngOnInit() {
    console.log("entrato");
    this.userService.getUser().subscribe((res: any) => {
      this.id_asl_utente = res.id_asl;
      this.livello = res.livello;
      if (this.id_asl_utente == null) {
        this.id_asl_utente = -1;
      }
      if (res.responsabile) {
        this.disabilitaAgg = true;
      }
      else {
        this.disabilitaAgg = false;
      }
    })
    this.ComunicazioneDB.getDati('get_unita_di_crisi').subscribe((res: any) => {
      if (res.esito) {
        this._unita_di_crisi = res.info.dati;
        //Controllo per mostrare le varie ui
        for (let elem of this._unita_di_crisi) {
          if (elem.id_asl == 205 || elem.livello == 0) {
            this.mostraUiAs_fo = true;
          }
          if (elem.id_asl == 206 || elem.livello == 0) {
            this.mostraUiAsu_fc = true;
          }
          if (elem.id_asl == 207 || elem.livello == 0) {
            this.mostraUiAsu_gi = true;
          }
          if(elem.id_asl == -1 || elem.livello == 0) {
            this.mostraUiFvg = true;
          }
        }
        this._ui = res.info.ui
        this.disabilitaAgg = res.info.dati[0].aggiungi_unita_di_crisi;
        this.id_asl = res.info.dati[0].id_asl
      }
    })
  }

  goToAggiungi(stringa: string) {
    if (this.disabilitaAgg == false) {
      return;
    }
    this.router.navigate(['unita-di-crisi', 'aggiungi-unita-di-crisi'], { queryParams: { tipo: stringa } });
  }

  goToModifica(ar: any, stringa: string) {
    if (this.disabilitaAgg == false) {
      return;
    }
    this.router.navigate(['unita-di-crisi', 'modifica-unita-di-crisi'], { queryParams: { id: ar.id, tipo: stringa } });
  }

  delUnitaDiCrisi(ar: any, tipo: string) {
    if (this.disabilitaAgg == false) {
      return;
    }
    this.ComunicazioneDB.updDati('upd_del_unita_di_crisi', { id_unita: ar.id, tipo: tipo }).subscribe((res: any) => {
      if (res.esito) {
        window.location.reload()
      }
    })
  }

  get unita_di_crisi() { return this._unita_di_crisi; }
  get ui() { return this._ui; }
}
