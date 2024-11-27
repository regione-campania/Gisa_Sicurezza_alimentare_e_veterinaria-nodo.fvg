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
  selector: 'app-avvisi',
  templateUrl: './avvisi.component.html',
  styleUrls: ['./avvisi.component.scss']
})
export class AvvisiComponent {
  //----------------------VARIABILI------------------
  private _ui: any;
  private _avvisi: any;
  disabilitaAggAvviso: boolean = false;
  disabilitaModAvviso: boolean = false;
  id_asl: any;
  id_utente: any
  //---------------------COSTRUTTORE-----------------
  constructor(
    private ComunicazioneDB: BackendCommunicationService,
    private userService: UserService,
    private router: Router) { }
  //---------------------NGONINIT--------------------
  ngOnInit() {
    this.userService.getUser().subscribe((res: any) => {
      console.log(res.id_utente);
      this.id_utente = res.id_utente;
      this.id_asl = res.id_asl;
      if (this.id_asl == "-1") {
        this.id_asl = -1;
      }
      console.log(res)
      if (res.responsabile) {
        this.disabilitaAggAvviso = true;
      }
      else {
        this.disabilitaAggAvviso = false;
      }
      this.ComunicazioneDB.getDati('get_avvisi').subscribe((res: any) => {
        if (res.esito) {
          this._ui = res.info.ui;
          if (res.info.dati.length >= 1) {
            this._avvisi = res.info.dati;
            this.disabilitaAggAvviso = res.info.dati[0].aggiungi_avviso;
            for (let elem of res.info.dati) {
              if (elem.id_user_create == this.id_utente || this.id_asl != -1) {
                this.disabilitaModAvviso = false;
              }
              else {
                this.disabilitaModAvviso = true;
              }
            }
            console.log(res.info.dati[0].id_user_create);
            // if (this.id_utente == res.info.dati[0].id_user_create || this.id_asl != -1) {
            //   this.disabilitaModAvviso = false;
            // }
            // else {
            //   this.disabilitaModAvviso = true;
            // }
          }
        }
        else {
          this.disabilitaAggAvviso = true;
        }
      })
    })
  }
  get ui() { return this._ui; }
  get avvisi() { return this._avvisi; }

  goToAggiungi() {
    if (this.disabilitaAggAvviso == false) {
      return;
    }
    this.router.navigate(['avvisi', 'aggiungi-avvisi']);
  }

  goToModifica(ar: any) {
    if (this.disabilitaModAvviso == true) {
      return;
    }
    this.router.navigate(['avvisi', 'modifica-avvisi'], { queryParams: { id_avviso: +ar.id } });
  }

}
