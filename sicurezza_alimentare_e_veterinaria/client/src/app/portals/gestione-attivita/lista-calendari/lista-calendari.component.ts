/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { GestioneAttivitaService } from 'src/app/portals/gestione-attivita/gestione-attivita.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { GeneratoreCalendarioService } from '../generatore-calendario/generatore-calendario.service';
import { BackendCommunicationService, NotificationService, LoadingDialogService } from '@us/utils';

@Component({
  selector: 'app-lista-calendari',
  templateUrl: './lista-calendari.component.html',
  styleUrls: ['./lista-calendari.component.scss'],
})
export class ListaCalendariComponent implements OnInit {
  calendari: any;
  showForm = false;

  addCalendarioForm = new FormGroup({
    descrizione: new FormControl(''),
    nota: new FormControl(''),
  });

  operazione = 'calendario';
  currCalendario = null;
  disableAddButton = false;

  constructor(
    private gs: GestioneAttivitaService,
    private client: BackendCommunicationService,
    private router: Router,
    private modalEngine: NgbModal,
    private notificationService: NotificationService,
    private generatoreService: GeneratoreCalendarioService,
    private loading: LoadingDialogService,
  ) { }

  ngOnInit(): void {
    this._initListaCalendari();
  }

  save(event: any) {
    event.preventDefault();
    const description: string = (<HTMLInputElement>document.getElementById('descrizione')).value;
    const note: string = (<HTMLInputElement>document.getElementById('nota')).value;

    if (description.trim() === "") {
      this.notificationService.push({
        notificationClass: 'error',
        content: `Attenzione! Inserire la descrizione.`
      });
      return;
    }

    let dataToSend = {
      descrizione: description,
      nota: note,
      id_calendario: this.currCalendario,
    };
    this.disableAddButton = true;
    this.client
      .updDati(`ins_${this.operazione}`, dataToSend)
      .subscribe((res: any) => {
        console.log(res);
        this.closePopup();
        this.addCalendarioForm.reset();
        this._initListaCalendari();
        this.disableAddButton = false;
      });
  }

  showElab(event: any, calendario: any) {
    event.preventDefault();
    this.calendari.forEach((cal: any) => {
      if (cal.id_calendario == calendario.id_calendario)
        cal.showElab = !cal.showElab;
    });
  }

  deleteElab(idElab: any) {
    this.client
      .updDati(`delete_elaborazione`, { id_elab: idElab })
      .subscribe((res: any) => {
        this._initListaCalendari();
      });
  }


  deleteCal(idCal: any) {
    this.client
      .updDati(`delete_calendario`, { id_calendario: idCal })
      .subscribe((res: any) => {
        this._initListaCalendari();
      });
  }

  openElab(elab: any) {
    this.router.navigate(['portali/gestione-attivita/lista-calendari/genera-calendario'], { queryParams: { elab: elab.id } });
  }

  openPopup(event: any, modalRef: any, op: string, idCalendario?: any) {
    event.preventDefault();
    event.stopPropagation();
    this.operazione = op;
    this.currCalendario = idCalendario;
    this.modalEngine.open(modalRef, { modalDialogClass: 'system-modal' });
  }

  closePopup() {
    this.modalEngine.dismissAll();
  }

  private _initListaCalendari() {
    this.loading.openDialog();
    this.gs.getListaCalendari().subscribe((res) => {
      this.loading.closeDialog();
      if (res.esito) {
        this.calendari = res.info;
        this.calendari?.forEach((cal: any) => {
          cal.eliminabile = true;
          cal.elabs?.forEach((el: any) => {
            if (el.bloccato)
              cal.eliminabile = false;
          })
        });
        this.gs.storage.setItem('calendari', this.calendari);
      }
    });
  }
}
