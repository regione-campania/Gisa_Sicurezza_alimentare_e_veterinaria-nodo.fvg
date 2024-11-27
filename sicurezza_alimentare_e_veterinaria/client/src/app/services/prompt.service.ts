/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core';

import Swal from 'sweetalert2';
import { LoginService } from './login.service';
import { NavigationService } from './navigation.service';
import { Router } from '@angular/router';
import { HOME_URL } from '../conf';
import { ManualiService } from './manuali.service';
import { BackendCommunicationService } from '@us/utils';

@Injectable({
  providedIn: 'root',
})
export class PromptService {
  constructor(
    private navigation: NavigationService,
    private loginService: LoginService,
    private router: Router,
    private manualiService: ManualiService,
    private be: BackendCommunicationService,
  ) {}

  /** Metodo che wrappa Swal.fire con alert di tipo 'question' */
  ask(question: string, title: string) {
    return Swal.fire({
      titleText: title,
      icon: 'question',
      text: question,
      showConfirmButton: true,
      confirmButtonText: 'Si',
      showDenyButton: true,
      denyButtonText: 'No',
    });
  }

  requestLogout() {
    Swal.fire({
      titleText: 'Logout',
      icon: 'question',
      text: 'Sei sicuro di voler uscire?\nLe modifiche non salvate andranno perse.',
      showConfirmButton: true,
      confirmButtonText: 'Si',
      showDenyButton: true,
      denyButtonText: 'No',
    }).then((res) => {
      if (res.isConfirmed) {
        this.navigation.reset();
        this.loginService.logout();
      }
    });
  }

  requestGoHome() {
    if (this.router.url != '/portali') {
      Swal.fire({
        titleText: 'Home',
        icon: 'question',
        text: 'Sei sicuro di voler tornare alla Home?\nLe modifiche non salvate andranno perse.',
        showConfirmButton: true,
        confirmButtonText: 'Si',
        showDenyButton: true,
        denyButtonText: 'No',
      }).then((res) => {
        if (res.isConfirmed) {
          this.router.navigateByUrl(HOME_URL);
        }
      });
    }
  }

  requestDownloadManuale(): void {
    this.manualiService.getManuali().subscribe((res) => {
      let manuali: any = {};
      for (let r of res.info.dati) {
        manuali[r.file] = r.descr;
      }
      Swal.fire({
        title: 'Seleziona manuale',
        input: 'select',
        inputOptions: manuali,
        inputPlaceholder: 'Seleziona...',
        confirmButtonText: 'OK',
      }).then((risultato: any) => {
        console.log(risultato);
        if (risultato.value) {
          this.manualiService.downloadManuale(risultato.value).subscribe();
        }
      });
    });
  }

  getAvvisiForRisorsa() {
    return this.be.getDati('get_avvisi_for_risorsa');
  }

  updVisualizzazioneAvviso(visualizzabile: boolean | null, id_avviso_risorsa: number, data_prima_visualizzazione: any) {
    return this.be.updDati('upd_visualizzazione_avviso', {visualizzabile: visualizzabile, id_avviso_risorsa: id_avviso_risorsa, data_prima_visualizzazione: data_prima_visualizzazione})
  }

}
