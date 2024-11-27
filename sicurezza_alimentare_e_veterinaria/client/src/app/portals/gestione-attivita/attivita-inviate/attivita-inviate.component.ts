/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { ASmartTableComponent, BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';
import { AttivitaInviateService } from './attivita-inviate.service';
import { GestioneAttivitaService } from '../gestione-attivita.service';
import { SharedService } from 'src/app/shared/shared.service';
import { map } from 'rxjs';

@Component({
  selector: 'app-attivita-inviate',
  templateUrl: './attivita-inviate.component.html',
  styleUrls: ['./attivita-inviate.component.scss']
})
export class AttivitaInviateComponent implements OnInit {
  @ViewChild('tabellaAttInviate') tabella_att_inviate?: ASmartTableComponent;

  private _attSel: any[] = [];
  okButton: any;
  loadingAttivitaInviate = false;
  formConfig: any;

  constructor(
    private ais: AttivitaInviateService,
    private client: BackendCommunicationService,
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private changeDetector: ChangeDetectorRef,
    private router: Router,
    private gs: GestioneAttivitaService,
    private sharedService: SharedService,
  ) { }

  getTrfAttInviate : any;

  ngOnInit(): void {
    this.formConfig = this.sharedService
    .getFormDefinition('cu/', 'sel_lista_attivita_inviate')
    .pipe(
      map((res) => {
        let info = JSON.parse(res.info[0]['configurazione']);
        //Costruzione del limite dinamicamente per la data inizio e fine
        let dataCorrente = new Date();
        let annoCorrente = dataCorrente.getFullYear();
        info['controls'].find((c: any) => c.name == 'periodo_attivita').options.start.max = annoCorrente + '-12-31';
        info['controls'].find((c: any) => c.name == 'periodo_attivita').options.end.max = annoCorrente + '-12-31';
        info['controls'].find((c: any) => c.name == 'periodo_attivita').value.start = annoCorrente + '-01-01';
        info['controls'].find((c: any) => c.name == 'periodo_attivita_invio').value.start = annoCorrente + '-01-01';
        info['controls'].find((c: any) => c.name == 'periodo_attivita_invio').options.start.max = annoCorrente + '-12-31';
        info['controls'].find((c: any) => c.name == 'periodo_attivita_invio').options.end.max = annoCorrente + '-12-31';
        return { info: info };
      })
    );


    this.okButton = document.createElement('button');
    this.okButton.type = 'button';
    this.okButton.className = 'btn btn-primary d-block mb-3 mx-auto';
    this.okButton.innerText = 'OK';
    this.okButton.style.minWidth = '100px';
  }

  mostraUltimoStato(ar: any) {
    this.router.navigate(['portali', 'gestione-attivita', 'lista-attivita-inviate', 'lista-attivita-ultimo-stato'], { queryParams: { id_att_inviata: ar.id } })
  }
  //Invio attivita a SICER
  inviaAttivita() {
    this._attSel = [];
    if (this.tabella_att_inviate?.selectedData.length) {
      //Per prendere l'id dalle attivita selezionate utilizzo il foreach
      this.tabella_att_inviate.selectedData.forEach((elem: any) => {
        this._attSel.push(elem.id);
      })
      if (this._attSel.length > 0) {
        //Chiamata al servizio in cui passo l'id dell'attività
        //Utilizzo il ciclo perchè si possono inserire più di 1
        this.loadingService.openDialog('Invio attività in corso...');
       for (let i = 0; i < this._attSel.length; i++) {
          this.ais.inviaPrestazioniSicer({
            idPrestazione: this._attSel[i]
          }).subscribe((res: any) => {
            if (res.esito == false) {
              this.notificationService.push({
                notificationClass: 'error',
                content: res.info,
              });
              this.loadingService.closeDialog();
              return;
            } else {
              console.log("res lato client: ", res);
              //Per risolvere il problema del bottone vado a metterlo direttamente sull'ultima attività
              if(i == this._attSel.length - 1) {
                //Creazione loading dialog per quando l'attività è stata inviata
                this.loadingService.hideSpinner();
                this.loadingService.setMessage('Invio Completato!');
                //creo tasto OK
                this.okButton.addEventListener('click', () => {
                  this.loadingService.closeDialog();
                  window.location.reload()
                })
                this.loadingService.dialog.htmlElement.querySelector('.loading-dialog')?.append(this.okButton);
              }
            }
          })
        }

      }
    }
  }
  //Funzione che permette per le attività inviate non andate a buon fine di rigenerarle per poi re-inviarle
  rigeneraJSON() {
    this._attSel = [];
    if (this.tabella_att_inviate?.selectedData.length) {
      //Per prendere l'id dalle attivita selezionate utilizzo il foreach
      this.tabella_att_inviate.selectedData.forEach((elem: any) => {
        this._attSel.push(elem.id_trf_attivita);
      })
      if (this._attSel.length > 0) {
        this.loadingService.openDialog('Rigenerazione in corso...');
        this.client.updDati('upd_att_da_inviare', { id_trf_attivita: this._attSel }).subscribe((res: any) => {
          if (!res.esito) {
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Errore nella rigenerazione',
            });
            this.loadingService.closeDialog();
            return;
          } else {
            console.log("rigenerazione: ", res);
            this.loadingService.closeDialog();
            window.location.reload()
          }
        })
      }
    }
  }

  ricercaAttivitaInviate(params: any) {
    console.log(params);
    this.loadingAttivitaInviate = true;
    // this._ui_attivita = null;
    // this._attivita = null;
    console.log(params);
    this.getTrfAttInviate = this.gs.getTrfAttivitaInviateBySel(params)
  }

}
