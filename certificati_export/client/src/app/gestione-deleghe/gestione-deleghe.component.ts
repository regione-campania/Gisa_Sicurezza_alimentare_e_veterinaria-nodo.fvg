/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { GestioneDelegheService } from './gestione-deleghe.service';
import Swal from 'sweetalert2';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-gestione-deleghe',
  templateUrl: './gestione-deleghe.component.html',
  styleUrls: ['./gestione-deleghe.component.scss']
})
export class GestioneDelegheComponent implements OnInit {
  formDelega?: FormGroup;
  modalRef?: NgbModalRef;

  @ViewChild('templateNewDelega') templateNewDelega!: TemplateRef<any>;

  private _allContacts?: any;
  private _userData?: any;
  private _ui?: any;
  private _usersStabilimento: any[] = [];

  constructor(
    private gds: GestioneDelegheService,
    private modalEngine: NgbModal,
    private fb: FormBuilder,
    private ls: LoadingDialogService
  ) { }

  /**
   * Recupera più informazioni:
   *  - I dati dell'utente che ha effettuato l'accesso;
   *  - I dati delle varie deleghe;
   *  - I dati di tutti i possibili utenti che possono essere delegati;
   */
  ngOnInit(): void {
    this.ls.openDialog('Caricamento in corso');
    this.gds.getUser().subscribe((res_1: any) => {
      console.log("res_1:", res_1);
      this._userData = res_1;

      this.gds.getUtentiStabilimento(parseInt(this._userData?.id_stabilimento)).subscribe((res_2: any) => {
        this.ls.closeDialog();
        console.log("res_2:", res_2);
        this._usersStabilimento = res_2.info.dati;
        this._ui = res_2.info.ui;

        this._usersStabilimento.forEach((user: any, index: number) => {
          user.responsabile = `${user.nome_responsabile} ${user.cognome_responabile}`;
          user.delegato = `${user.nome_delegato} ${user.cognome_delegato}`;
          user.editMode = false;
          user.inputClass = `user_${index}`;
          user.superuser = user.superuser ? 'Sì' : 'No';
        });

        console.log("this._usersStabilimento:", this._usersStabilimento);
        console.log("this._ui:", this._ui);
      });
    });

    /*this.gds.getContacts().subscribe((contacts: any) => {
      this._allContacts = contacts.info;
      console.log("this._allContacts:", this._allContacts);
    });*/
  }

  /**
   * Apri la form per inserire i dati di una nuova delega
   */
  openNewDelegaForm(): void {
    this._initFormDelega();
    this.modalRef = this.modalEngine.open(this.templateNewDelega, {
      centered: true,
      modalDialogClass: 'xl',
      animation: true
    });
  }

  // Effettua la patch del delegato selezionato
  selectDelegato(delegato: any) { this.formDelega?.patchValue(delegato); }

  /**
   * Aggiunge una nuova delega.
   * @returns
   */
  addDelega(): void {
    if (!this.formDelega?.valid) return;

    const data_da = this.formDelega.get('data_da')?.value;
    const data_a = this.formDelega.get('data_a')?.value;

    if (new Date(data_da) >= new Date('2099-12-31') || new Date(data_a) >= new Date('2099-12-31')) {
      Swal.fire({
        icon: 'warning',
        title: 'Attenzione',
        text: 'Data supera limite consentito',
        width: 600,
        allowOutsideClick: false
      });
      return;
    }

    if (data_da && data_a && (new Date(data_da) >= new Date(data_a))) {
      Swal.fire({
        icon: 'warning',
        title: 'Attenzione',
        text: 'La data inizio deve essere minore della data fine.',
        width: 600,
        allowOutsideClick: false
      });
      return;
    }

    const dati = {
      ...this.formDelega?.value,
      id_stabilimento: parseInt(this._userData.id_stabilimento),
      id_responsabile: parseInt(this._userData.id_access)
    };

    dati.nome = dati.nome.trim().toUpperCase();
    dati.cognome = dati.cognome.trim().toUpperCase();

    console.log("dati:", dati);
    this.ls.openDialog('Caricamento in corso');
    this.gds.insAccessStabilimento(dati).subscribe((res: any) => {
      this.ls.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        Swal.fire({
          icon: 'error',
          title: 'Errore',
          text: "Si è verificato un errore durante l'inserimento.",
          allowOutsideClick: false
        });
        return;
      }
      this.modalRef?.close();
      Swal.fire({
        icon: 'success',
        title: 'Successo',
        text: "L'inserimento è avvenuto con successo.",
        allowOutsideClick: false
      }).then((_) => {
        this.loadDeleghe();
      })
    })
  }

  // Abilita e disabilita la modalità di modifica
  enableAndDisableEditMode(user: any) { user.editMode = !user.editMode; }

  editDelegato(user: any): void {
    console.log("user:", user);

    const values = Array.from(document.querySelectorAll(`.${user['inputClass']}`));
    console.log("values:", values);

    if (!values.every((input: any) => input.value != null && input.value.trim() != '')) {
      Swal.fire({
        icon: 'warning',
        title: 'Inserisci data',
        text: 'È necessario inserire una data per salvare le modifiche',
        allowOutsideClick: false
      });
      return;
    };

    const valido_da = (<HTMLInputElement>values.find(({ id }) => id === 'valido_da')).value;
    const valido_a = (<HTMLInputElement>values.find(({ id }) => id === 'valido_a')).value;
    const cf = (<HTMLInputElement>values.find(({ id }) => id === 'codice_fiscale')).value;
    const nome = (<HTMLInputElement>values.find(({ id }) => id === 'nome_delegato')).value;
    const cognome = (<HTMLInputElement>values.find(({ id }) => id === 'cognome_delegato')).value;

    console.log("valido_da:", valido_da);
    console.log("valido_a:", valido_a);
    console.log("codice_fiscale:", cf);
    console.log("nome:", nome);
    console.log("cognome:", cognome);

    if (new Date(valido_da) >= new Date('2099-12-31') || new Date(valido_a) >= new Date('2099-12-31')) {
      Swal.fire({
        icon: 'warning',
        title: 'Attenzione',
        text: 'Data supera limite consentito',
        width: 600,
        allowOutsideClick: false
      });
      return;
    }

    if (new Date(valido_da) >= new Date(valido_a)) {
      Swal.fire({
        icon: 'warning',
        title: 'Attenzione',
        text: 'La data inizio deve essere minore della data fine.',
        width: 600,
        allowOutsideClick: false
      });
      return;
    }

    this.ls.openDialog('Caricamento in corso');
    this.gds.updAccessStabilimento(
      parseInt(user.id_access_stabilimento),
      valido_da,
      valido_a, 
      cf,
      nome,
      cognome
    ).subscribe((res: any) => {
      this.ls.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        Swal.fire({
          icon: 'error',
          title: 'Errore',
          text: 'Si è verificato un errore durante il salvataggio.',
          allowOutsideClick: false
        });
        return;
      }
      Swal.fire({
        icon: 'success',
        title: 'Successo',
        text: 'La modifica è avvenuta con successo',
        allowOutsideClick: false
      }).then(() => {
        this.loadDeleghe();
      });
    });

    this.enableAndDisableEditMode(user);
  }

  deleteDelegato(user: any, evt: Event): void {
    console.log("user:", user);

    Swal.fire({
      icon: 'question',
      title: 'Conferma?',
      text: 'Sei sicuro di voler eliminare questo utente?',
      showConfirmButton: true,
      confirmButtonText: 'Si',
      showDenyButton: true,
      denyButtonText: 'No',
      allowOutsideClick: false
    }).then((result: any) => {
      if (result.isConfirmed) {
        this.ls.openDialog('Caricamento in corso');
        this.gds.delAccessStabilimento(parseInt(user.id_access_stabilimento)).subscribe((res: any) => {
          this.ls.closeDialog();
          console.log("res:", res);
          if (!res.esito) {
            Swal.fire({
              icon: 'error',
              title: 'Errore',
              text: 'Si è verificato un errore durante la cancellazione.',
              allowOutsideClick: false
            });
            return;
          }
          Swal.fire({
            icon: 'success',
            title: 'Successo',
            text: 'La cancellazione è avvenuta con successo',
            allowOutsideClick: false
          }).then((_) => {
            this.loadDeleghe();
          })
        })
      }
    })
  }

  // Controlla se la data inserita sia maggiore della data odierna
  dateGTToday(date: string) {
    return new Date(date).getTime() > new Date().getTime() ? true : false;
  }

  // Carica le deleghe connesse all'utente
  private loadDeleghe(): void {
    this.ls.openDialog('Caricamento in corso');
    this.gds.getUtentiStabilimento(parseInt(this._userData?.id_stabilimento)).subscribe((res_2: any) => {
      this.ls.closeDialog();
      this._usersStabilimento = res_2.info.dati;

      this._usersStabilimento.forEach((user: any, index: number) => {
        user.responsabile = `${user.nome_responsabile} ${user.cognome_responabile}`;
        user.delegato = `${user.nome_delegato} ${user.cognome_delegato}`;
        user.editMode = false;
        user.inputClass = `user_${index}`;
        user.superuser = user.superuser ? 'Sì' : 'No';
      });
    });
  }

  // Inzializza la form per inserire la delega
  private _initFormDelega() {
    this.formDelega?.reset();
    this.formDelega = this.fb.group({
      nome: [null, Validators.required],
      cognome: [null, Validators.required],
      codice_fiscale: [null, Validators.required],
      data_da: [null, Validators.required],
      data_a: [null, Validators.required],
      superuser: false,
      id_access: null
    });
  }

  public get userData() { return this._userData; }

  public get usersStabilimento() { return this._usersStabilimento; }

  public get ui() { return this._ui; }

  public get allContacts() { return this._allContacts; }

  public get formDelegaControls() { return this.formDelega!.controls }
}
