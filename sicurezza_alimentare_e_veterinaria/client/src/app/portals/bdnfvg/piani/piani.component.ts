/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NotificationService, LoadingDialogService } from '@us/utils';
import { PianiService } from '../services';
import * as bootstrap from 'bootstrap';
import { FormPianoComponent } from './form-piano/form-piano.component';
import { FormBuilder } from '@angular/forms';

@Component({
  selector: 'app-piani',
  templateUrl: './piani.component.html',
  styleUrls: ['./piani.component.scss']
})
export class PianiComponent implements OnInit {
  @ViewChild('formPianoInfo') _formPianoInfo?: FormPianoComponent;
  @ViewChild('formPianoNew') _formPianoNew?: FormPianoComponent;

  private _piani?: any;
  private _ui?: any;
  private _selectedPiano?: any;
  private _matrice: any[] = [];

  private _modalNewPiano?: bootstrap.Modal;

  constructor(
    private ps: PianiService,
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private fb: FormBuilder
  ) { }

  // Recupera Piani
  ngOnInit(): void {
    this.route.data.subscribe((data: any) => {
      this.loadingService.closeDialog();
      console.log("data:", data);
      if (!data.piani.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore nel caricamento dei dati.'
        });
        return;
      }
      this._piani = data.piani.info.dati;
      console.log("this._piani:", this._piani);

      this._ui = data.piani.info.ui;
      console.log("this._ui:", this._ui);
    });

    this._modalNewPiano = new bootstrap.Modal('#new-piano');
  }

  // Seleziona il piano e recupera le matrici di quel piano
  selezionaPiano(piano: any, event: any, formC: any): void {
    console.log("piano:", piano);
    this._selectedPiano = piano;
    this._formPianoInfo = formC;

    if (!piano) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: `Attenzione! Nessun piano selezionato`
      });
      return;
    };

    let trPiani = document.querySelectorAll('.tr-piani');
    trPiani.forEach((p: Element) => { (p as HTMLElement).classList.remove('cliccato') });
    (event.srcElement.parentElement as HTMLElement).classList.add('cliccato');

    setTimeout(() => {
      for (let [key, value] of Object.entries(this._selectedPiano)) {
        if (value === false) value = 'false';
        if (value === true) value = 'true';
        this._formPianoInfo?.formPiano.controls[key]?.patchValue(value);

        if (key === 'tipo_dettaglio' && value === 'CAPO')
          this._formPianoInfo!.setHasMarchio = true;
      }
    }, 0);

    console.log("this._formPianoC?.formPiano.value:", this._formPianoInfo?.formPiano.value);

    this.ps.getPianoMatrici({ id_piano: piano.id_piano }).subscribe((res: any) => {
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore durante il recupero della matrice.'
        });
        return;
      }
      this._matrice = res.info.dati;
      console.log("this._matrice:", this._matrice);

      setTimeout(() => {
        // const arr = this._matrice.map(x => x.selected);
        const arr = this._matrice.map((m: any) => {
          return this.fb.group({
            id_matrice: m.id_matrice,
            descr: m.descr,
            selected: m.selected
          });
        });
        console.log("arr:", arr);

        this._formPianoInfo!.setMatrici = arr;
      }, 0);
    });
  }

  // Aggiorna il piano selezionato
  updPianoMatrice(eliminazione?: boolean): void {
    if(eliminazione){
      var params: any = {
        operazione: 'delete',
        id_piano: this.selectedPiano.id_piano,
      };
    }else{
      this._formPianoInfo?.formPiano.updateValueAndValidity();
      console.log(this._formPianoInfo?.formPiano.value);
      if (!this._formPianoInfo?.formPiano.valid) {
        this.notificationService.push({
          notificationClass: 'info',
          content: `Attenzione! È necessario prima compilare tutti i campi`
        });
        return;
      }

      const elems = this._formPianoInfo?.get_id_matrici();
      console.log("elems:", elems);
    
      if(!elems?.length){
        this.notificationService.push({
          notificationClass: 'info',
          content: `Attenzione! È necessario selezionare almeno una matrice`
        });
        return;
      }

      var params: any = {
        operazione: 'update',
        id_piano: this.selectedPiano.id_piano,
        // id_matrice: elems?.map(el => el.id_matrice),
        id_matrice: elems,
        piano: this._formPianoInfo?.formPiano.value
      };
    }

    console.log("params:", params);
    this.ps.updPianoMatrice(params).subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: `Attenzione! Errore durante l'aggiornamento dei dati.`
        });
        return;
      }
      this.notificationService.push({
        notificationClass: 'success',
        content: 'Aggiornamento avvenuto con successo.'
      });
      setTimeout(() => { window.location.reload(); }, 2000);
    });
  }

  // Apri modale per creare un nuovo piano
  createNewPiano(): void {
    this._formPianoNew?.formPiano.updateValueAndValidity();
    console.log(this._formPianoNew?.formPiano.value);

    if (!this._formPianoNew?.formPiano.valid) {
      this.notificationService.push({
        notificationClass: 'info',
        content: `Attenzione! È necessario prima compilare tutti i campi`
      });
      return;
    }

    const elems = this._formPianoNew.get_id_matrici();
    console.log("elems:", elems);

    if(!elems?.length){
      this.notificationService.push({
        notificationClass: 'info',
        content: `Attenzione! È necessario selezionare almeno una matrice`
      });
      return;
    }

    const params: any = {
      ...this._formPianoNew.formPiano.value,
      // id_matrice: elems?.map(el => el.id)
      id_matrice: elems
    };

    console.log("params:", params);

    this.ps.insPiano(params).subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: `Attenzione! Errore durante l'aggiornamento dei dati.`
        });
        return;
      }
      this._modalNewPiano?.hide();
      setTimeout(() => { window.location.reload(); }, 2000);
    });
  }

  // Reimposta tutti i parametri
  closeInfo(): void {
    this._selectedPiano = null;
    let trPiani = document.querySelectorAll('.tr-piani');
    trPiani.forEach((p: Element) => { (p as HTMLElement).classList.remove('cliccato') });
    this._matrice = [];
    this._formPianoInfo?.resetForm();
    this._formPianoNew?.resetForm();
  }

  /******************************** ACCESSORS *********************************/
  get piani() { return this._piani; }
  get ui() { return this._ui; }
  get selectedPiano() { return this._selectedPiano; }
  /****************************************************************************/
}
