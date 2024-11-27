/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ValidaUtentiService } from './valida-utenti.service';
import { ASmartTableComponent, ExtendedNodeMappingFn, LoadingDialogService, NotificationService } from '@us/utils';
import Swal from 'sweetalert2';
import { CertificatiExportService } from '../../certificati-export.service';

@Component({
  selector: 'app-valida-utenti',
  templateUrl: './valida-utenti.component.html',
  styleUrls: ['./valida-utenti.component.scss']
})
export class ValidaUtentiComponent implements OnInit {
  @ViewChild('tableUsers') tableUsers?: ASmartTableComponent;
  private _users_da_validare?: any;
  private _ui?: any;
  private _disable: boolean = true;
  private _user_info?: any;

  constructor(
    private vus: ValidaUtentiService,
    private ces: CertificatiExportService,
    private loadingService: LoadingDialogService,
    private notificationService: NotificationService
  ) { }

  ngOnInit(): void {
    this.loadingService.openDialog('Caricamento in corso');
    this.vus.getUtentiDaValidare().subscribe((res: any) => {
      console.log("res:", res);
      this.loadingService.closeDialog();
      if (!res.esito) return;

      this._users_da_validare = res.info.dati;
      this._ui = res.info.ui;

      console.log("this._users_da_validare:", this._users_da_validare);
      console.log("this._ui:", this._ui);
    });

    this.ces.getUserInfo().subscribe((userInfo: any) => {
      console.log("userInfo:", userInfo);
      this._user_info = userInfo;
      console.log("this._user_info:", this._user_info);
    });
  }

  rifiutaUtenti(): void {
    Swal.fire({
      title: 'Sei sicuro?',
      text: "Confermi di voler rifiutare gli utenti?",
      icon: 'warning',
      confirmButtonText: 'Si',
      showCancelButton: true,
      cancelButtonColor: 'red',
      cancelButtonText: 'Annulla'
    }).then((result) => {
      if (result.isConfirmed) {
        console.log("this.tableUsers?.selectedData:", this.tableUsers?.selectedData);
        const params = {
          id_utenti_da_validare: this.tableUsers?.selectedData.map((sd: any) => sd.id),
          id_access_responsabile: parseInt(this._user_info.id),
          operazione: 'rifiuta'
        };
        console.log("params:", params);
        this.vus.updValidaUtenti(params).subscribe((res: any) => {
          console.log("res:", res);
          if (!res.esito) {
            Swal.fire({
              title: 'Errore',
              text: `Attenzione! Errore durante l'eliminazione`,
              icon: 'error',
              timer: 1500,
              timerProgressBar: true,
              allowOutsideClick: false
            });
            return;
          }else{
            window.location.reload();
          }
        })
      }
    })
  }

  validaUtenti(): void {
    Swal.fire({
      title: 'Sei sicuro?',
      text: "Confermi di voler validare gli utenti?",
      icon: 'warning',
      confirmButtonText: 'Si',
      showCancelButton: true,
      cancelButtonColor: 'red',
      cancelButtonText: 'Annulla'
    }).then((result) => {
      if (result.isConfirmed) {
        console.log("this.tableUsers?.selectedData:", this.tableUsers?.selectedData);
        const params = {
          id_utenti_da_validare: this.tableUsers?.selectedData.map((sd: any) => sd.id),
          id_access_responsabile: parseInt(this._user_info.id),
          operazione: 'valida'
        };
        console.log("params:", params);

        this.vus.updValidaUtenti(params).subscribe((res: any) => {
          console.log("res:", res);
          if (!res.esito) {
            Swal.fire({
              title: 'Errore',
              text: `Attenzione! Errore durante la validazione`,
              icon: 'error',
              timer: 1500,
              timerProgressBar: true,
              allowOutsideClick: false
            });
            /*
            this.notificationService.push({
              notificationClass: 'error',
              content: `Attenzione! Errore durante la validazione.`
            });
            */
            return;
          }
          /*
          this.notificationService.push({
            notificationClass: 'success',
            content: 'Validazione avvenuta con successo'
          });
          */

          Swal.fire({
            title: 'Risultato',
            text: 'Validazione avvenuta con successo.',
            icon: 'success',
            timer: 1500,
            timerProgressBar: true,
            allowOutsideClick: false
          }).then((result) => {
            if (result.dismiss === Swal.DismissReason.timer || result.isConfirmed) {
              // Recupera l'indirizzo email di tutti gli utenti validati e invia l'email
              const email_utenti_validati = this.tableUsers?.selectedData.map((sd: any) => sd.email);

              this.vus.spedisciEmail(email_utenti_validati!).subscribe((resEmail: any) => {
                if (!resEmail.esito) {
                  Swal.fire({
                    title: 'Errore',
                    text: `Attenzione! Errore durante l'invio dell'email.`,
                    icon: 'error',
                    timer: 1500,
                    timerProgressBar: true,
                    allowOutsideClick: false
                  });
                  return;
                }
                console.log("resEmail:", resEmail);
                Swal.fire({
                  title: 'Esito',
                  text: 'Invio email avvenuto con successo.',
                  icon: 'success',
                  timer: 1500,
                  timerProgressBar: true,
                  allowOutsideClick: false
                }).then((result) => {
                  if (result.dismiss === Swal.DismissReason.timer || result.isConfirmed) {
                    window.location.reload();
                  }
                })
              });
            }
          });
        });
      }
    })
  }

  disableButton(): void {
    this._disable = this.tableUsers?.selectedData.length === 0 ? true : false;
  }

  get users_da_validare() { return this._users_da_validare; }
  get ui() { return this._ui; }
  get disable() { return this._disable; }
}
