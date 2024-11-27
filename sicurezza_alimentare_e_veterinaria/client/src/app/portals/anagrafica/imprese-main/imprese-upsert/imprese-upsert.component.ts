/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FormImpreseComponent } from '../form-imprese/form-imprese.component';
import { AnagraficaService } from '../../anagrafica.service';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { Validators } from '@angular/forms';

@Component({
  selector: 'app-imprese-upsert',
  templateUrl: './imprese-upsert.component.html',
  styleUrls: ['./imprese-upsert.component.scss']
})
export class ImpreseUpsertComponent {
  //---------------------------------VARIABILI---------------------------
  labelBottone: any;
  private _id_impresa: any;
  private cod_tipo_impresa: any;
  @ViewChild('formImprese') _formImprese?: FormImpreseComponent;

  parix_impresa: any
  abilita_parix: any
  mostra_parix: any = false
  //-------------------------------COSTRUTTORE---------------------------
  constructor(
    private route: ActivatedRoute, //this.route.snapshot.url[0].path ritorna parte finale dell'url
    private router: Router,
    private ans: AnagraficaService,
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService
  ) { }

  //--------------------------NGONINIT--------------------------------
  ngOnInit() {
    this.loadingService.openDialog()
    console.log(this.route.snapshot.url[0].path)
    if (this.route.snapshot.url[0].path === 'aggiungi') {
      this.labelBottone = 'Aggiungi';
    }
    else {
      this.labelBottone = 'Modifica';
    }
    this.route.queryParams.subscribe((res: any) => {
      this.ans.getMenu('anagrafica').subscribe((res: any) => {
        if (res.info) {
          let menu = res.info
          menu.forEach((voce: any) => {
            if (voce.cod == 'allineamento-parix' && voce.modality == 'modifica') {
              this.mostra_parix = true;
            }
          });
        }
      })
      console.log("res:", res);
      //Se è presente un id_impresa vuol dire che è un modifica
      new Promise((resolve: any) => {
        if (res['id_impresa']) {
          this._id_impresa = res['id_impresa'];
          console.log("id impresa per la modifica", this._id_impresa);
          //Chiamata per prendere i dati dell'impresa e metterli nella form di modifica
          this.ans.getImpresaSingolo(this._id_impresa).subscribe((res: any) => {
            resolve(true)
            console.log("res chiamata", res);
            this._formImprese?.formImpresa.setValue({
              nome: res.info.dati[0].nome,
              piva: res.info.dati[0].piva,
              pec: res.info.dati[0].pec,
              email: res.info.dati[0].email,
              sdi: res.info.dati[0].sdi,
              split_payement: res.info.dati[0].split_payement,
              cf: res.info.dati[0].cf,
              cod_tipo_impresa: res.info.dati[0].cod_tipo_impresa,
              data_inizio_validita: res.info.dati[0].inizio_validita === null ? "" : (res.info.dati[0].inizio_validita).split('T')[0],
              data_fine_validita: res.info.dati[0].fine_validita === null ? "" : (res.info.dati[0].fine_validita).split('T')[0],
            })
            this._formImprese!.mostraSDI = true;
            //Controllo per varie tipologie di tipo impresa
            //Utilizzo il rawValue per prendere anche il tipo impresa visto che è disabilitato e non riesce a prenderlo
            //Successivamente mi prendo solo il codice tipo impresa e effettuo i controlli necessari
            let params = this._formImprese?.formImpresa.getRawValue();
            this.cod_tipo_impresa = params.cod_tipo_impresa
            //Se è Pubblica Amministrazione
            // if (this._formImprese?.formImpresa.value.cod_tipo_impresa === 'Z') {
            if (this.cod_tipo_impresa === 'Z') {
              this._formImprese!.maxValue = 13;
              this._formImprese?.formImpresa.get('nome')?.enable();
              this._formImprese?.formImpresa.get('piva')?.enable();
              this._formImprese?.formImpresa.get('sdi')?.enable();
              this._formImprese?.formImpresa.get('split_payement')?.disable();
              this._formImprese?.formImpresa.patchValue({
                split_payement: 'S',
                SDI: null
              })
              this._formImprese?.formImpresa.controls['piva'].addValidators([Validators.required]);
              this._formImprese?.formImpresa.controls['nome'].addValidators([Validators.required]);
              this._formImprese?.formImpresa.controls['cf'].clearValidators();
              this._formImprese?.formImpresa.controls['piva'].updateValueAndValidity();
              this._formImprese?.formImpresa.controls['nome'].updateValueAndValidity();
              this._formImprese?.formImpresa.controls['cf'].updateValueAndValidity();
              document.querySelectorAll('.addObb').forEach((elem: any) => {
                elem.style.display = 'none';
              });
              document.querySelectorAll('.removeObb').forEach((elem: any) => {
                elem.style.display = 'inline';
              })
              //nascondi SDI
              this._formImprese!.mostraSDI = false
            }
            //Se è Persona
            // else if (this._formImprese?.formImpresa.value.cod_tipo_impresa === 'P') {
            else if (this.cod_tipo_impresa === 'P') {
              this._formImprese!.maxValue = 16;
              this._formImprese?.formImpresa.get('nome')?.disable();
              this._formImprese?.formImpresa.get('piva')?.disable();
              this._formImprese?.formImpresa.get('sdi')?.disable();
              this._formImprese?.formImpresa.get('split_payement')?.disable();
              this._formImprese?.formImpresa.patchValue({
                split_payement: 'N',
              })

              this._formImprese?.formImpresa.controls['piva'].clearValidators();
              this._formImprese?.formImpresa.controls['nome'].addValidators([Validators.required]);
              this._formImprese?.formImpresa.controls['cf'].addValidators([Validators.required]);
              this._formImprese?.formImpresa.controls['piva'].updateValueAndValidity();
              this._formImprese?.formImpresa.controls['nome'].updateValueAndValidity();
              this._formImprese?.formImpresa.controls['cf'].updateValueAndValidity();
              document.querySelectorAll('.addObb').forEach((elem: any) => {
                elem.style.display = 'inline';
              });
              document.querySelectorAll('.removeObb').forEach((elem: any) => {
                elem.style.display = 'none';
              })
            }
            //Se è Associazione o Società
            // else if (this._formImprese?.formImpresa.value.cod_tipo_impresa === 'A' || this._formImprese?.formImpresa.value.cod_tipo_impresa === 'S') {
            else if (this.cod_tipo_impresa === 'A' || this.cod_tipo_impresa === 'S') {
              this._formImprese!.maxValue = 13;
              this._formImprese?.formImpresa.get('nome')?.enable();
              this._formImprese?.formImpresa.get('piva')?.enable();
              this._formImprese?.formImpresa.get('sdi')?.enable();
              this._formImprese?.formImpresa.get('split_payement')?.enable();
              this._formImprese?.formImpresa.patchValue({
                split_payement: null,
              })
              this._formImprese?.formImpresa.controls['piva'].addValidators([Validators.required]);
              this._formImprese?.formImpresa.controls['nome'].addValidators([Validators.required]);
              this._formImprese?.formImpresa.controls['cf'].clearValidators();
              this._formImprese?.formImpresa.controls['piva'].updateValueAndValidity();
              this._formImprese?.formImpresa.controls['nome'].updateValueAndValidity();
              this._formImprese?.formImpresa.controls['cf'].updateValueAndValidity();
              document.querySelectorAll('.addObb').forEach((elem: any) => {
                elem.style.display = 'none';
              });
              document.querySelectorAll('.removeObb').forEach((elem: any) => {
                elem.style.display = 'inline';
              })
            }
            //Se è Ditta Individuale
            else {
              this._formImprese!.maxValue = 16;
              this._formImprese?.formImpresa.get('nome')?.enable();
              this._formImprese?.formImpresa.get('piva')?.enable();
              this._formImprese?.formImpresa.get('sdi')?.enable();
              this._formImprese?.formImpresa.get('split_payement')?.enable();
              this._formImprese?.formImpresa.patchValue({
                split_payement: null,
              })
              this._formImprese?.formImpresa.controls['piva'].addValidators([Validators.required]);
              this._formImprese?.formImpresa.controls['nome'].addValidators([Validators.required]);
              this._formImprese?.formImpresa.controls['cf'].clearValidators();
              this._formImprese?.formImpresa.controls['piva'].updateValueAndValidity();
              this._formImprese?.formImpresa.controls['nome'].updateValueAndValidity();
              this._formImprese?.formImpresa.controls['cf'].updateValueAndValidity();
              document.querySelectorAll('.addObb').forEach((elem: any) => {
                elem.style.display = 'none';
              });
              document.querySelectorAll('.removeObb').forEach((elem: any) => {
                elem.style.display = 'inline';
              })
            }
          });
        } else {
          resolve(true)
        }
      }).then(() => {
        this.loadingService.closeDialog()
        if (res['parix_impresa']) {
          this.parix_impresa = JSON.parse(res['parix_impresa'])
          this._formImprese?.formImpresa.patchValue({
            nome: this.parix_impresa.ESTREMI_IMPRESA[0].DENOMINAZIONE[0],
            piva: this.cod_tipo_impresa === 'P' ? null : this.parix_impresa.ESTREMI_IMPRESA[0].PARTITA_IVA[0],
            cf: this.parix_impresa.ESTREMI_IMPRESA[0].CODICE_FISCALE[0],
            pec: this.parix_impresa.INFORMAZIONI_SEDE[0].INDIRIZZO[0].INDIRIZZO_PEC ? this.parix_impresa.INFORMAZIONI_SEDE[0].INDIRIZZO[0].INDIRIZZO_PEC[0] : ''
          })
          console.log(this._formImprese?.formImpresa.value)
          this.mostra_parix = false
        }
      })


    })
  }
  //-------------------FUNZIONI-------------------------
  updImpresa() {
    if (!this._formImprese?.formImpresa.valid) {
      this.notificationService.push({
        notificationClass: 'info',
        content: `Attenzione! È necessario prima compilare tutti i campi`
      });
      return;
    }
    const params = {
      ...this._formImprese?.formImpresa.getRawValue()
    }
    console.log(params);
    if (this._id_impresa) {
      params.id_impresa = +this._id_impresa;
      this.ans.updImpresa(params).subscribe((res: any) => {
        if (!res.esito) {
          return;
        }
        console.log("dati impresa", res);
        setTimeout(() => { this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], { queryParams: { id_impresa: this._id_impresa } }); }, 1500);
      })
    }
    else {
      console.log("aggiungi del'impresa")
      params.fonte = 'GISA-FVG'
      this.ans.addImpresa(params).subscribe((res: any) => {
        if (!res.esito) {
          return;
        }
        console.log("dati add impresa", res);
        this._id_impresa = res.info;
        setTimeout(() => { this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], { queryParams: { id_impresa: this._id_impresa } }); }, 1500);
      })
    }
  }

  ngAfterViewChecked() {
    this.abilita_parix = !((this._formImprese?.formImpresa?.value.piva != null && this._formImprese?.formImpresa?.value.piva != '') || (this._formImprese?.formImpresa?.value.cf != null && this._formImprese?.formImpresa?.value.cf != ''))
  }

  goToPARIX() {
    // console.log(this._formImprese?.formImpresa?.value.piva ?? this._formImprese?.formImpresa?.value.cf)
    this.router.navigate(['portali/anagrafica/allineamento-parix/impresa'], { queryParams: { id_impresa: this._id_impresa, piva: this._formImprese?.formImpresa?.value.piva ?? this._formImprese?.formImpresa?.value.cf } })
  }

  get id_impresa() { return this._id_impresa; }
}
