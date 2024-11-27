/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { GestioneAttivitaService } from 'src/app/portals/gestione-attivita/gestione-attivita.service';
import { ATreeComponent, ATreeNodeComponent, LoadingDialogService, NotificationService, TreeNode, stretchToWindow, toTree } from '@us/utils';
import { formatDate } from '@angular/common';
import Swal from 'sweetalert2';

const TENYEARS: number = 3650;

@Component({
  selector: 'app-tariffe-forfettarie',
  templateUrl: './tariffe-forfettarie.component.html',
  styleUrls: ['./tariffe-forfettarie.component.scss']
})
export class TariffeForfettarieComponent implements OnInit {
  masterlist?: any;
  masterlistParsed?: TreeNode;
  formRow?: FormGroup;
  dataRow?: any;

  private _circularValue = 0;
  private _selectedVoice?: any;

  @ViewChild(ATreeComponent) tree?: ATreeComponent;

  constructor(
    private loadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private gs: GestioneAttivitaService,
    private fb: FormBuilder
  ) { }

  ngOnInit(): void {
    this.loadingService.openDialog();
    this.gs.getMasterlist().subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      this.masterlist = res.info;
      this.masterlistParsed = toTree(this.masterlist, node => {
        node.expanded = node.parent == null ? true : false;
        return node;
      }).root;

      setTimeout(() => {
        stretchToWindow(document.getElementById('tariffe-forfettarie-main-content')!);
      }, 0);
    })
  }

  // Seleziona la voce nell'albero
  selectVoice(node: ATreeNodeComponent): void {
    if (!node.isLeafNode()) return;
    this.loadingService.openDialog();
    this.selectedVoice = node;
    this.dataRow = undefined;

    this.gs.getTariffaML(node.data.id).subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      if (!res.info) return;
      this.dataRow = res.info;
      console.log("this.dataRow:", this.dataRow);
      this._initFormRow();
    });
  }

  // Inizializza la form della riga
  private _initFormRow(): void {
    this.formRow?.reset();
    this.formRow = this.fb.group({
      data_inizio: null,
      tariffe: this.fb.array([])
    });

    const livelli = this.dataRow.livelli;
    for (let i = 1; i <= 3; i++) {
      (this.formRow.controls['tariffe'] as FormArray).push(
        this.fb.group({
          livello: i,
          liv: livelli[i - 1],
          valore: 0
        })
      );
    }

    console.log("this.formRow:", this.formRow);
  }

  // Salva la riga tra le voci
  saveRowVoices(): void {
    if (!this.checkInputForm()) return;

    this.gs.updTariffaML(this.selectedVoice.data.id, this.formRow?.value).subscribe((res_1: any) => {
      console.log("res:", res_1);
      // Caso di errore
      if (!res_1.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore durante aggiornamento tariffa.'
        })
      }

      // Ricarica i dati per vedere l'aggiornamento
      this.gs.getTariffaML(this.selectedVoice.data.id).subscribe((res_2: any) => {
        if (!res_2.info) return;
        this.dataRow = res_2.info;
        this._initFormRow();
      });
    });
  }

  // Check Inputs prima di salvare
  private checkInputForm(): boolean {
    const form_data_inizio = this.formRow?.get('data_inizio')?.value;
    const form_tariffe = this.formRow?.get('tariffe')?.value;

    console.log("form_tariffe:", form_tariffe);

    // Check data exists
    if (
      form_data_inizio === null ||
      form_data_inizio.trim() === null ||
      form_data_inizio.trim() === ''
    ) {
      this.notificationService.push({
        notificationClass: 'info',
        content: "È necessario inserire la data prima di salvare."
      });
      return false;
    }

    // Check data maggiore della data dell'ultima voce
    if (this.dataRow && (new Date(form_data_inizio.trim()) <= new Date(this.dataRow.dati?.[0].valida_da.split('T')[0].trim()))) {
      this.notificationService.push({
        notificationClass: 'info',
        content: "È necessaria una data maggiore dell'inizio dell'ultima voce."
      });
      return false;
    }

    // Check valori in Tariffe
    if (form_tariffe.every((tariffa: any) => tariffa.valore === 0 || tariffa.valore === null)) {
      this.notificationService.push({
        notificationClass: 'info',
        content: "È necessario inserire almeno un valore diverso da 0."
      });
      return false;
    }

    return true;
  }

  // Cancella l'attuale voce dalla tariffa
  deleteRowVoice(): void {
    Swal.fire({
      title: 'Confermare?',
      icon: 'question',
      text: 'Sicuro di voler eliminare la seguente voce?',
      showConfirmButton: true,
      confirmButtonText: 'Si',
      showDenyButton: true,
      denyButtonText: 'No',
    }).then((result) => {
      if (result.isConfirmed) {
        this.gs.delTariffaML(this.getCurrentRow().id_tariffa_ml).subscribe((res_1: any) => {
          console.log("res:", res_1);
          if (!res_1.esito) return;
          this.gs.getTariffaML(this.selectedVoice.data.id).subscribe((res_2: any) => {
            console.log("res_2:", res_2);
            if (!res_2.info) return;
            this.dataRow = res_2.info;
          })
        });
      }
    });
  }

  // Ritorna riga attuale
  getCurrentRow(): any {
    return this.dataRow.dati?.[Math.abs(this._circularValue) % this.dataRow.dati?.length];
  }

  /**
   * Controlla che la data inserita rientra nel range [min, max]. Nel caso non
   * dovesse rientrare allora viene reimpostata quella minima, ma è possibile
   * impostare qualsiasi altra data.
   *
   * @param evt Evento che scatta
   */
  onBlur(evt: any): void {
    console.log("evt:", evt);

    // Recupera le info
    const id = evt.target.attributes.id.value;
    let DOMElem: HTMLInputElement = <HTMLInputElement>document.querySelector(`#${id}`);

    // Controlla che la stringa sia vuota
    if ((evt.target.value as string).length === 0) {
      evt.target.value = '';
      DOMElem.value = '';
    } else {
      // Controlla se l'anno inserito sia maggiore dell'anno massimo indicato
      const year = parseInt((evt.target.value as string).split('-')[0]);
      const yearMax = parseInt((evt.target.max as string).split('-')[0]);
      if (year && year > yearMax) {
        evt.target.value = evt.target.max;
        DOMElem.value = evt.target.max;
      }

      if (evt.target.min.trim() != '' && evt.target.value < evt.target.min) {
        // Caso data inserita minore della data minima
        evt.target.value = evt.target.min;
        DOMElem.value = evt.target.min;
      } else if (evt.target.max.trim() != '' && evt.target.value > evt.target.max) {
        // Caso data inserita maggiore della data massima
        evt.target.value = evt.target.max;
        DOMElem.value = evt.target.max;
      }
    }

    DOMElem.dispatchEvent(new Event('input'));
  }

  // Evita di avere il campo di input vuoto
  noBlank(evt: any): void {
    if (evt.target.value.trim() === '') {
      evt.target.value = 0;
    }
  }

  // Visualizza riga storica precedente.
  goBack(): void { this._circularValue--; }

  // Visualizza riga storica successiva.
  goAhead(): void { this._circularValue++; }

  // Accessors
  public get tariffe() { return this.formRow?.get('tariffe') as FormArray; }

  public get selectedVoice() { return this._selectedVoice; }

  public set selectedVoice(value) {
    this._selectedVoice?.htmlElement.classList.remove('selected');
    this._selectedVoice = value;
    this._selectedVoice?.htmlElement.classList.add('selected');
  }

  get currentStorico() { return (Math.abs(this._circularValue) % this.dataRow.dati?.length) + 1; }
  get isFirst() { return this.currentStorico === 1 ? true : false; }
  get isLast() { return this.currentStorico === this.totaleStorico ? true : false; }
  get totaleStorico() { return this.dataRow.dati?.length; }
  get tomorrow() {
    const tomorrow = new Date(new Date().setDate(new Date().getDate() + 1));
    return formatDate(tomorrow.setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
  }

  get maxDate() {
    const threeYearsAfter = new Date(new Date().setDate(new Date().getDate() + TENYEARS));
    return formatDate(threeYearsAfter.setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
  }
}
