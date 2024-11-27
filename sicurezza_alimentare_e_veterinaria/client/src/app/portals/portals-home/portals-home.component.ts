/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { formatDate } from '@angular/common';
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { DESKTOP_BREAKPOINT } from 'src/app/conf';
import { PromptService } from 'src/app/services/prompt.service';
import { gisaEnv } from 'src/environments/environment';
import { AppService } from 'src/app/app.service';
import packageInfo from '../../../../package.json';
import Swal from 'sweetalert2';
import { Utils } from '@us/utils';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-portals-home',
  templateUrl: './portals-home.component.html',
  styleUrls: ['./portals-home.component.scss'],
})
export class PortalsHomeComponent {
  appVersion = packageInfo.version;

  manuali: any;
  messaggi: any;
  userInfo: any
  private _portals: any;
  get portals() {
    return this._portals;
  }

  constructor(private app: AppService, private router: Router, private route: ActivatedRoute, private prompt: PromptService, private userService: UserService) {
    this._portals = this.route.snapshot.data['portals'];
    //ad hoc per bloccare bdn con hideProfilassi true
    this.userService.getUser().subscribe(res => { this.userInfo = res })
    if (this.userInfo.hideProfilassi == true) {
      let tmp: any[] = []
      this._portals.forEach((portale: any) => {
        if (portale.cod != 'bdn') tmp.push(portale)
      });
      this._portals = tmp
    }
    console.log('portals', this.portals);
  }

  ngOnInit() {
    this.prompt.getAvvisiForRisorsa().subscribe( //async
      (res: any) => {
        this.messaggi = res.info.dati;
        this.showMessages(0);
        //   tableMessaggi =  tableMessaggi + `
        //       ${res.info.dati.map((elem : any) => `<tr style = "border: 1px solid black; "><td style = "border: 1px solid black;">${elem.descrizione}</td></tr>`).join('')}
        // </table> ` ;
        //   Swal.fire({
        //     titleText: 'Avvisi',
        //     html: tableMessaggi
        //    // icon: res.info.dati[0].icona,
        //    // background: res.info.dati[0].colore,
        //    // showConfirmButton: true,
        //    // confirmButtonText: 'Ok',
        //    // showDenyButton: true,
        //  })
        // Messaggi mostrati con delay di 2 secondi

        // await new Promise(r => setTimeout(r, 2000));

      })
  }

  goToPortal(portal: string) {
    this.router.navigate(['portali', portal]);
  }

  goToMatrix() {
    let host = location.host;
    let protocol = location.protocol;
    if (host.startsWith('localhost')) host = gisaEnv.host;
    window.location.href = `${protocol}//${host}/matrix/gisa_route.php?token=${localStorage.getItem('token')}`;
  }

  goToMatrixFormule() {
    let host = location.host;
    let protocol = location.protocol;
    if (host.startsWith('localhost')) host = gisaEnv.host;
    window.location.href = `${protocol}//${host}/matrix/gisa_route.php?called_url=formulematrix.fvg.it&token=${localStorage.getItem('token')}`;
  }

  goToRA() {
    let host = location.host;
    let protocol = location.protocol;
    if (host.startsWith('localhost')) host = gisaEnv.host;
    window.location.href = `${protocol}//${host}/matrix/ra/grid.php?token=${localStorage.getItem('token')}`;
  }

  showMessages(i: number) {
    if (i < this.messaggi.length) {
      // if(this.messaggi[i].visualizzabile && !this.messaggi[i].dt_prima_visualizzazione) {
      Swal.fire({
        title: this.messaggi[i].descr_livello,
        text: this.messaggi[i].descrizione,
        icon: this.messaggi[i].icona,
        background: this.messaggi[i].colore,
        showConfirmButton: true,
        confirmButtonText: 'Visualizza in seguito',
        showDenyButton: true,
        denyButtonText: 'Non visualizzare più',
        allowOutsideClick: false,
        allowEscapeKey: false
      }).then((result) => {
        this.showMessages(i + 1);
        this.prompt.updVisualizzazioneAvviso(result.value, this.messaggi[i].id_avviso_risorsa, formatDate(new Date(), 'yyyy-MM-dd HH:mm:ss', 'en')).subscribe((res: any) => {

        })
        // if (result.isConfirmed) {
        //   this.showMessages(i + 1);
        //   this.prompt.updVisualizzazioneAvviso(result.value, this.messaggi[i].id_avviso_risorsa, formatDate(new Date(), 'yyyy-MM-dd HH:mm:ss', 'en')).subscribe((res: any) => {

        //   })
        // }
        // else {
        //   this.showMessages(i + 1);
        //   this.prompt.updVisualizzazioneAvviso(result.value, this.messaggi[i].id_avviso_risorsa, formatDate(new Date(), 'yyyy-MM-dd HH:mm:ss', 'en')).subscribe((res: any) => {

        //   })
        // }
      });
      // }
      // else {
      //   this.showMessages(i + 1);
      // }
    }
  }

  isDesktopView() {
    return window.innerWidth > DESKTOP_BREAKPOINT;
  }

  selectManuali() {
    this.app.getManuali().subscribe((res: any) => {
      console.log(res.info.dati);
      this.manuali = {};
      for (let r of res.info.dati) {
        this.manuali[r.file] = r.descr;
      }
      Swal.fire({
        title: 'Seleziona manuale',
        input: 'select',
        inputOptions: this.manuali,
        inputPlaceholder: 'Seleziona...',
        confirmButtonText: 'OK',
      }).then((risultato: any) => {
        console.log(risultato)
        if (risultato.value) {
          this.app.downloadManuale(risultato.value).subscribe((data: any) => {
            Utils.download(data.body, risultato.value);
          })
        }
      });
    })
  }

  goToUnitaDiCrisi() {
    this.router.navigate(['unita-di-crisi']);
  }
  goToAvvisi() {
    this.router.navigate(['avvisi']);
  }

}
