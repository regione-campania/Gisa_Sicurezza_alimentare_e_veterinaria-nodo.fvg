/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-form-stabilimenti',
  templateUrl: './form-stabilimenti.component.html',
  styleUrls: ['./form-stabilimenti.component.scss']
})
export class FormStabilimentiComponent implements OnInit {
  //----------------------VARIABILI-----------------------------
  dataMin: any;
  formStabilimento: FormGroup;
  private _tipiStruttura?: any;
  private _tipiRischio?: any;
  private _id_tipologia_struttura?: any;
  private _richiede_codice_regionale?: any;
  descr_cod_regionale: any;
  descr_cod_nazionale: any;
  private _strutture_asl: any
  emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
  tipoOperazione: any;
  mostraSDI: boolean = false
  nPraticaMode: boolean = false
  //-------------------COSTRUTTORE------------------------------
  constructor(
    private ComunicazioneDB: BackendCommunicationService,
    private LoadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private router: Router,
    private fb: FormBuilder,
    private notificationService: NotificationService
  ) {
    this.formStabilimento = this.fb.group({
      id_stabilimento: this.fb.control(null),
      id_impresa: this.fb.control(null, [Validators.required]),
      n_pratica: this.fb.control(null, [Validators.required]),
      nome: this.fb.control(null, [Validators.required]),
      // sd_cod_regionale: this.fb.control(null, [Validators.required]),
      pec: this.fb.control(null, [Validators.pattern(this.emailPattern)]),
      telefono: this.fb.control(null),
      cod_nazionale: this.fb.control(null, [Validators.required]),
      cod_tipologia_struttura: this.fb.control(null, [Validators.required]),
      categoria_rischio: this.fb.control(null),
      data_inizio_validita: this.fb.control(null, [Validators.required]),
      data_fine_validita: this.fb.control(null),
      sdi: this.fb.control(null),
      //id_asl: this.fb.control(0, [Validators.required]),
    })
  }
  //----------------------------NGONINIT--------------------------------
  ngOnInit(): void {
    console.log(this.route.snapshot.url[0].path)
    this.tipoOperazione = this.route.snapshot.url[0].path;
    if (this.tipoOperazione === 'modifica') {
      this.formStabilimento.get('cod_tipologia_struttura')?.disable();
    }
    this.ComunicazioneDB.getDati('get_categorie_rischio').subscribe((res: any) => {
      console.log("res tipologia rischio", res);
      this._tipiRischio = res.info.dati;
    })
    this.ComunicazioneDB.getDati('get_tipologie_struttura').subscribe((res: any) => {
      console.log("res tipologia struttura", res);
      this._tipiStruttura = res.info.dati;
    })
    this.ComunicazioneDB.getDati('get_strutture_asl').subscribe((res: any) => {
      this._strutture_asl = res.info.dati
    });
  }
  //------------------------FUNZIONI---------------------------
  checkDate(event: any, form: any) {
    const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
    let src = event.srcElement as HTMLInputElement;
    let nomeForm = null;
    nomeForm = src.getAttribute('formControlName');
    if (!src.validity.valid || !regex.test(src.value)) form.get(nomeForm).setValue("")


    // Object.keys(form.controls).forEach((controlName) => {
    //   if (controlName === 'data_inizio_validita' || controlName === 'data_fine_validita') {
    //     nomeForm = controlName;
    //     console.log("nomeForm:",nomeForm);
    //     if (!src.validity.valid || !regex.test(src.value)) {
    //       console.log(nomeForm);
    //       form.get(nomeForm).setValue("")
    //       console.log("entrato");
    //     }
    //   }
    // })

  }

  checkPratica() {
    this.formStabilimento.controls['n_pratica'].setValue(this.formStabilimento.value.n_pratica.trim())
    if (this.formStabilimento.value.n_pratica == '')
      return
    this.ComunicazioneDB.getDati('check_pratica', { id_stabilimento: this.formStabilimento.value.id_stabilimento, n_pratica: this.formStabilimento.value.n_pratica }).subscribe((res: any) => {
      if (!res.esito) {
        this.formStabilimento.controls['n_pratica'].setValue('')
      }
    })
  }

  prendiValoreCod(event: any) {
    console.log(event.target.value);
    this.descr_cod_nazionale = null;
    this.descr_cod_regionale = null;
    if (this._tipiStruttura) {
      for (let i = 0; i < this._tipiStruttura.length; i++) {
        if (this._tipiStruttura[i].codice === event.target.value) {
          // this.descr_cod_regionale = this._tipiStruttura[i].descr_cod_reg;
          this.descr_cod_nazionale = this._tipiStruttura[i].descr_cod_naz;
          this._id_tipologia_struttura = this._tipiStruttura[i].id_tipologia_struttura;
          this._richiede_codice_regionale = this._tipiStruttura[i].richiede_codice_regionale;
        }
      }
    }
    // if (!this.descr_cod_regionale) {
    //   this.formStabilimento.controls['sd_cod_regionale'].clearValidators();
    // }
    // this.formStabilimento.controls['sd_cod_regionale'].updateValueAndValidity();
    if (!this.descr_cod_nazionale) {
      this.formStabilimento.controls['cod_nazionale'].clearValidators();
    }
    this.formStabilimento.controls['cod_nazionale'].updateValueAndValidity();
    // console.log(this.descr_cod_regionale);
    // console.log(this.descr_cod_nazionale);
    console.log(this._id_tipologia_struttura);
    console.log(this._richiede_codice_regionale)
  }
  //------------------------------GET E SETTER----------------------------
  get tipiStruttura() { return this._tipiStruttura; }
  get tipiRischio() { return this._tipiRischio; }
  get strutture_asl() { return this._strutture_asl }
  get richiede_codice_regionale() { return this._richiede_codice_regionale; }
  set set_richiede_codice_regionale(flag: any) { this._richiede_codice_regionale = flag }
  //Passato il dato tramite il getter, visto che è presente qui lo posso prendere tranquillamente nell'altro component
  get id_tipologia_struttura() { return this._id_tipologia_struttura; }
  set set_id_tipologia_struttura(id: any) { this._id_tipologia_struttura = id; }

  set setMostraSDI(x: any) { this.mostraSDI = x }
  set setNPraticaMode(x: any) { this.nPraticaMode = x }
}
