/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { BackendCommunicationService, LoadingDialogService } from '@us/utils';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Location } from '@angular/common';

@Component({
  selector: 'app-unita-di-crisi-upsert',
  templateUrl: './unita-di-crisi-upsert.component.html',
  styleUrls: ['./unita-di-crisi-upsert.component.scss']
})
export class UnitaDiCrisiUpsertComponent {
  formUnitaDiCrisi: FormGroup;
  operazione: any;
  tipo: any;
  tipoTitolo: any;
  emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
  id_unita: any;
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private ComunicazioneDB: BackendCommunicationService,
    private location: Location,
  ) {
    this.formUnitaDiCrisi = this.fb.group({
      ruolo: this.fb.control(null, [Validators.required]),
      nome: this.fb.control(null, [Validators.required]),
      cognome: this.fb.control(null, [Validators.required]),
      email: this.fb.control(null, [Validators.required, Validators.pattern(this.emailPattern)]),
      telefono: this.fb.control(null, [Validators.minLength(10)]),
      cellulare: this.fb.control(null, [Validators.required, Validators.minLength(10)]),
    })
  }
  ngOnInit() {
    console.log(this.route.snapshot.url[0].path)
    this.route.queryParams.subscribe((res: any) => {
      if (this.route.snapshot.url[0].path == 'aggiungi-unita-di-crisi') {
        this.operazione = 'Aggiungi';
        if (res['tipo']) {
          console.log(res['tipo']);
          this.tipo = res['tipo'];
          if (res['tipo'] == 'as_fo')
            this.tipoTitolo = 'as fo';
          else if (res['tipo'] == 'asu_gi')
            this.tipoTitolo = 'asu gi';
          else if (res['tipo'] == 'asu_fc')
            this.tipoTitolo = 'asu fc';
          else
            this.tipoTitolo = res['tipo']
        }
      }
      else {
        this.operazione = 'Modifica';
        if (res['tipo']) {
          console.log(res['tipo']);
          console.log(res['id']);
          this.tipo = res['tipo'];
          if (res['tipo'] == 'as_fo')
            this.tipoTitolo = 'as fo';
          else if (res['tipo'] == 'asu_gi')
            this.tipoTitolo = 'asu gi';
          else if (res['tipo'] == 'asu_fc')
            this.tipoTitolo = 'asu fc';
          else
            this.tipoTitolo = res['tipo']
          this.id_unita = res['id'];
          this.ComunicazioneDB.getDati('get_unita_di_crisi_singolo', { tipo: this.tipo, id_unita: parseInt(this.id_unita) }).subscribe((res: any) => {
            if (res.esito) {
              this.formUnitaDiCrisi.patchValue({
                ruolo: res.info.dati[0].ruolo,
                nome: res.info.dati[0].responsabile_nome,
                cognome: res.info.dati[0].responsabile_cognome,
                email: res.info.dati[0].email,
                telefono: res.info.dati[0].telefono,
                cellulare: res.info.dati[0].cellulare,
              })
            }
          })
        }
      }
    })
  }

  updUnitaDiCrisi() {
    if (!this.formUnitaDiCrisi.valid) {
      return;
    }
    const params = {
      id_unita: 0,
      tipo: this.tipo,
      ruolo: this.formUnitaDiCrisi.value.ruolo,
      nome: this.formUnitaDiCrisi.value.nome,
      cognome: this.formUnitaDiCrisi.value.cognome,
      email: this.formUnitaDiCrisi.value.email,
      telefono: this.formUnitaDiCrisi.value.telefono,
      cellulare: this.formUnitaDiCrisi.value.cellulare,
    }
    if (this.operazione == 'Aggiungi') {
      console.log(this.operazione);
      console.log(params);
      this.ComunicazioneDB.updDati('ins_unita_di_crisi', params).subscribe((res: any) => {
        if (res.esito) {
          this.router.navigate(['unita-di-crisi']);
        }
      })
    }
    else {
      params.id_unita = this.id_unita;
      console.log(this.operazione);
      console.log(params);
      this.ComunicazioneDB.updDati('upd_unita_di_crisi', params).subscribe((res: any) => {
        if (res.esito) {
          this.router.navigate(['unita-di-crisi']);
        }
      })
    }
  }


  checkIsNumber(event: any) {
    // console.log(event.target.value);
    let num = event.target.value;
    // console.log(event.target.attributes);
    const id: string = event.target.attributes.id.value;
    let DOMElem: HTMLInputElement = <HTMLInputElement>document.querySelector(`#${id}`);
    if (Number.isNaN(parseInt(num)) || parseInt(num) < 0) {
      event.target.value = null;
      DOMElem.value = '';
      DOMElem.dispatchEvent(new Event('input'));
    }
  }

  goBack() { this.location.back(); }

}
