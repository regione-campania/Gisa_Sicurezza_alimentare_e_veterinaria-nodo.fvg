/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { NotificationService } from '@us/utils';
import { PianiService } from '../../services';


@Component({
  selector: 'form-piano',
  templateUrl: './form-piano.component.html',
  styleUrls: ['./form-piano.component.scss']
})
export class FormPianoComponent implements OnInit {
  formPiano: FormGroup;
  private _combos?: any;
  private _hasMarchio?: boolean = false;
  private _notMarchioMethods?: any;

  constructor(
    private ps: PianiService,
    private fb: FormBuilder,
    private notificationService: NotificationService
  ) {
    this.formPiano = this.fb.group({
      malattia: this.fb.control(null, Validators.required),
      codice_malattia: this.fb.control(null, Validators.required),
      id_gruppo_specie: this.fb.control(null, Validators.required),
      zoonosi: this.fb.control(null), //Validators.required),
      //id_tipo_metodo: this.fb.control(null, Validators.required),
      // id_tipo_campione: this.fb.control(null, Validators.required),
      eta_in: this.fb.control(null),
      eta_fin: this.fb.control(null),
      n_provette_min: this.fb.control(1),// Validators.required),
      n_provette_max: this.fb.control(null),// Validators.required),
      n_capi_min: this.fb.control(1),// Validators.required),
      n_capi_max: this.fb.control(null),// Validators.required),
      rilevare_sito: this.fb.control(null),// Validators.required),
      note: this.fb.control(null),
      laboratorio: this.fb.control(null),// Validators.required),
      invio_esiti: this.fb.control(null),// Validators.required),
      giornate_max: this.fb.control(1), // Validators.required),
      matrici: this.fb.array([]),
      dl32: this.fb.control(null, Validators.required)
    });
  }

  ngOnInit(): void {
    if (this._combos) return;
    this.ps.getCombos().subscribe((res: any) => {
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore durante il caricamento dei dati.'
        });
        return;
      }
      this._combos = res.info.dati;
      console.log("this._combos:", this._combos);

      // Crea l'array dei metodi senza il Pool per le specie che non producono latte
      this._notMarchioMethods = this._combos?.tipi_metodo.filter((tm: any) => {
        return tm.descr !== "Pool";
      });
      console.log("this._notMarchioMethods:", this._notMarchioMethods);

      // const arr = this._combos.matrici.map(() => this.fb.control(false));
      const arr = this._combos.matrici.map((cm: any) => {
        return this.fb.group({
          id_matrice: cm.id_matrice,
          descr: cm.descr,
          selected: false
        });
      });
      this.setMatrici = arr;

      console.log("arr:", arr);
    });
  }

  // Reimposta la form quando chiude e riapre la modale
  resetForm(): void {
    this.formPiano.reset();
    this.formPiano.controls['n_provette_min'].setValue(1);
    this.formPiano.controls['n_capi_min'].setValue(1);
    this.formPiano.controls['giornate_max'].setValue(1);
    // const arr = this._combos.matrici.map(() => this.fb.control(false));
    const arr = this._combos.matrici.map((cm: any) => {
      return this.fb.group({
        id_matrice: cm.id_matrice,
        descr: cm.descr,
        selected: false
      });
    });
    this.setMatrici = arr;
  }

  // Recupera gli id delle matrici
  get_id_matrici(): any[] | null {
    /*
    console.log("this.formPiano.get('matrici')?.value:", this.formPiano.get('matrici')?.value);
    
    const idxs: number[] | null = this.getAllIndexes(this.formPiano.get('matrici')?.value, true);
    console.log("indexes:", idxs);

    const elems: any[] | null = this.getIndexedElems(this._combos.matrici, idxs);
    console.log("elems:", elems);

    return elems;
    */

    return this.formPiano.get('matrici')?.value.filter((m: any) => m.selected).map((m: any) => m.id_matrice);
  }

  // onChange sul gruppo specie
  onChange(evt: any): void {
    console.log("evt:", evt);
    if(!evt || evt == 'null'){
      if(this.formPiano.get('id_gruppo_specie')?.value)
        this.formPiano.get('id_gruppo_specie')?.setValue(null);
    }else{
      const found_gs: any = this.gruppi_specie.find((obj: any) => {
        return parseInt(obj.grspe_id) === parseInt(evt);
      });

      this._hasMarchio = found_gs?.tipo_dettaglio == 'CAPO' ? true : false;
      console.log("this._hasMarchio:", this._hasMarchio);
    }
  }

  onLetterListChange(matriciSelezionate: any) {
    console.log(matriciSelezionate);
  }

  /**
   * Evita all'utente di inserire valori numerici in un campo di input text
   * @param event Input dell'utente
   * @returns ritorna vero o falso in base a cosa viene inserito dall'utente
   */
  onlyText(event: any): boolean {
    const charCode = (event.which) ? event.which : event.keyCode;
    if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123)) {
      return true;
    }
    return false;
  }

  /**
   * Il metodo ritorna l'indice di tutte le occorrenze che verificano
   * la condizione.
   * @param arr Array dove controllare gli elementi
   * @param val Il valore per cui vale la condizione
   * @returns Array di indici
   */
  private getAllIndexes(arr: any[], val: any): number[] | null {
    if (!arr || !val) return null;
    let indexes: number[] = [];
    for (let i = 0; i < arr.length; i++) {
      if (arr[i] === val) indexes.push(i);
    }
    return indexes;
  }

  /**
   * Il metodo ritorna l'array degli elementi in base agli indici.
   * @param arr Array dal quale recuperare gli elementi
   * @param arr_idx Array di indici posizionali
   * @returns Array di elementi selezionati
   */
  private getIndexedElems(arr: any[], arr_idx: number[] | null): any[] | null {
    if (!arr || !arr_idx) return null;
    let res: any[] = [];
    arr_idx.forEach((i: number) => { res.push(arr[i]); });
    return res;
  }

  /******************************** ACCESSORS *********************************/
  get matriciFormArray() { return this.formPiano.get('matrici') as FormArray }
  get combos() { return this._combos; }
  get gruppi_specie() { return this._combos?.gruppo_specie; }
  get laboratori() { return this._combos?.laboratorio; }
  get invio_esiti() { return this._combos?.invio_esiti; }
  get tipi_metodo() {
    return this._hasMarchio ?
      this._combos?.tipi_metodo : this._notMarchioMethods;
  }
  get tipi_campione() { return this._combos?.tipi_campione; }
  get matrici() { return this._combos?.matrici; }
  get hasMarchio() { return this._hasMarchio; }
  set setMatrici(arr: any) {
    // this.formPiano.controls['matrici'] = this.fb.array(arr);
    this.formPiano.setControl('matrici', this.fb.array(arr));
  }

  set setHasMarchio(val: boolean) { this._hasMarchio = val; }
  /****************************************************************************/

}
