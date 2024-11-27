/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ElementRef, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService, NotificationService, Utils } from '@us/utils';
import { AppService } from 'src/app/app.service';
import { AnagraficaService } from '../../anagrafica.service';
import { PdfRiepilogoService } from '../../services/pdf-riepilogo.service';
import { allegaFileCU } from 'src/app/portals/controlli-ufficiali/services/allegaFileCU.service';
import * as bootstrap from 'bootstrap';
import Swal from 'sweetalert2';
import { SharedDataService } from 'src/app/services/shared-data.service';

@Component({
  selector: 'app-pratiche-dettaglio',
  templateUrl: './pratiche-dettaglio.component.html',
  styleUrls: ['./pratiche-dettaglio.component.scss']
})
export class PraticheDettaglioComponent {

  disabilitaModifica: boolean = true

  private id_utente: any
  private _id_pratica: any
  private _pratica: any
  private _ui_pratica: any

  private _allegati: any
  private _ui_allegati: any

  private _storico: any
  private _ui_storico: any

  private modalAllegati?: bootstrap.Modal
  @ViewChild('inputFile') nomeFileInput!: ElementRef;
  private file: any;
  private pdf: any;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private notificationService: NotificationService,
    private ans: AnagraficaService,
    private ap: AppService,
    private cc: allegaFileCU,
    private LoadingService: LoadingDialogService,
    private rs: PdfRiepilogoService,
    private sharedData: SharedDataService,
    private app: AppService
  ) { }

  ngOnInit() {

    this.disabilitaModifica = this.sharedData.get('activeMenuItem').modality == 'lettura'
    console.log('disabilitaModifica', this.disabilitaModifica)
    this.ap.getUser().subscribe((res: any) => {
      this.id_utente = res.id_utente
    })

    this.route.queryParams.subscribe(params => {
      this._id_pratica = +params['id_pratica']

      this.ans.getPraticaSingolo(+this._id_pratica).subscribe((res: any) => {
        this._pratica = res.info.dati[0]
        this._ui_pratica = res.info.ui

        //get allegati
        this.getAllegati()
        //get storico
        this.ans.getPraticaStorico(+this._id_pratica).subscribe((res: any) => {
          if (res.info) {
            this._storico = res.info.dati
            this._ui_storico = res.info.ui
          }
        })
      })
    })

    this.modalAllegati = new bootstrap.Modal('#modal-allegati-evidenza');
  }

  goToModifica() {
    if(this.disabilitaModifica) return
    if (!this.pratica.pratica_modificabile || this.pratica.descr_stato_pratica !== 'Creato') {
      return;
    }
    this.router.navigate(['portali/anagrafica/pratiche/modifica'], { queryParams: { id_pratica: this._id_pratica } })
  }

  updStatoPratica() {
    if (this.disabilitaModifica) return
    if (this.pratica.descr_stato_pratica == 'Chiuso' || this.pratica.descr_stato_pratica == 'Creato') {
      if (!this.pratica.pratica_modificabile) {
        return;
      }
    }
    if (this.pratica.descr_stato_pratica == 'Aperto') {
      if (!this.pratica.pratica_modificabile || this.pratica.id_stabilimento == null) {
        return;
      }
    }
    this.ans.updStatoPratica({ "id_pratica": +this._id_pratica, "id_utente": +this.id_utente }).subscribe((res: any) => {
      this.ngOnInit()
    })
  }

  getAllegati() {
    this._allegati = []
    this.cc.getPDFAllegati(this._id_pratica, 'pratiche').subscribe((res: any) => {
      this._allegati = res.files;
      this._ui_allegati = { "colonne": [{ "campo": "filename", "intestazione": "Nome", "tipo": "text", "editabile": false }, { "campo": "dt", "intestazione": "Data Caricamento", "tipo": "date", "editabile": false }] };
    })
  }

  openAllegati() {
    if(this.disabilitaModifica) return
    if (!this.pratica.pratica_modificabile || this.pratica.descr_stato_pratica !== 'Aperto') {
      return;
    }
    this.nomeFileInput.nativeElement.value = '';
    this.modalAllegati?.toggle()
  }

  allegaVerbaleDaConfigurare(event: any) {
    if (event.target.files == 0) {
      return;
    }
    this.file = event.target.files;
    //console.log(this.file);
  }

  checkPdfSize(file: any) {
    if (file.size / 1024 / 1024 > 20) {
      Swal.fire({
        text: 'Il pdf non può superare i 20mb',
        icon: 'warning'
      })
      return;
    }
  }

  uploadAllegati() {
    if (this.file) {
      for (let i = 0; i < this.file.length; i++) {
        this.pdf = this.file[i];
        this.checkPdfSize(this.pdf);
        //Funzione che manda il file al server
        this.cc.AllegaPDF(this.pdf, +this._id_pratica, "pratiche").subscribe((res: any) => {
          if (!res.esito) {
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Errore nel caricamento del file',
            });
            return;
          }
          this.modalAllegati?.toggle()
          this.file = null
          this.getAllegati()
        })
      }
    }
  }

  downloadAllegati(id_pdf: any) {
    this.cc.DownloadPDF(id_pdf).subscribe((res: any) => {
      Utils.download(res.body, `${res.headers.get('content-disposition').split('filename="')[1].replaceAll('"', '')}`)
    })
  }

  delAllegati(id_pdf: any) {
    this.cc.EliminaPDF(id_pdf).subscribe((res: any) => {
      this.getAllegati();
    })
  }

  goTo(x: any) {
    if (x === 'dettaglio') {
      this.router.navigate(['portali/anagrafica/stabilimenti/dettaglio'], { queryParams: { id_stabilimento: this.pratica.id_stabilimento } })
    }

    if (x === 'aggiungi') {
      if (!this.pratica.pratica_modificabile || this.pratica.descr_stato_pratica !== 'Aperto') {
        return;
      }
      this.router.navigate(['portali/anagrafica/stabilimenti/aggiungi'], { queryParams: { n_pratica: this.pratica.n_pratica, id_impresa: null } })
    }
  }

  get pratica() { return this._pratica }
  get ui_pratica() { return this._ui_pratica }
  get allegati() { return this._allegati }
  get ui_allegati() { return this._ui_allegati }
  get storico() { return this._storico }
  get ui_storico() { return this._ui_storico }
}
