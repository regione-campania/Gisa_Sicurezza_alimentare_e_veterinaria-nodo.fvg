/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { AnagraficaService } from 'src/app/portals/anagrafica/anagrafica.service';
import { FormSediComponent } from '../form-sedi/form-sedi.component';
import { FormIndirizzoMainComponent } from '../../form-indirizzo-main/form-indirizzo-main.component';

@Component({
  selector: 'app-sedi-upsert',
  templateUrl: './sedi-upsert.component.html',
  styleUrls: ['./sedi-upsert.component.scss']
})
export class SediUpsertComponent implements OnInit {
  //------------------------------VARIABILI-----------------------------
  labelBottone: any;
  sede: any;
  _id_stabilimento: any;
  _id_impresa: any;
  _id_sede: any;
  nome: any;
  public id_indirizzo_nuovo: any;
  @ViewChild('formSedi') _formSedi?: FormSediComponent;
  @ViewChild('formIndirizzo') _formIndirizzo?: FormIndirizzoMainComponent;

  mostra_parix: any = false
  parix_sede: any
  _id_impresa_parix: any
  _id_stabilimento_parix: any
  _id_sede_parix: any
  //----------------------------COSTRUTTORE-----------------------------
  constructor(
    private route: ActivatedRoute, //this.route.snapshot.url[0].path ritorna parte finale dell'url
    private router: Router,
    private ans: AnagraficaService,
    private notificationService: NotificationService,
    private LoadingService: LoadingDialogService,) {
    //Per creare nuove proprietà dinamicamente al params
    interface params extends Record<string, any> {

    }
  }
  //------------------------------NGONINIT-------------------------------
  ngOnInit(): void {
    //console.log(this.route.snapshot.url[0].path)
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
      //console.log(res);
      if (res['nome']) {
        this.nome = res['nome'];
      }
      if (res['id_stabilimento']) {
        this._id_stabilimento = res['id_stabilimento'];
        this.nome = res['nome'];
        this.sede = 'Domicilio Fiscale/Legale Stabilimento';
      }
      if (res['id_impresa']) {
        this._id_impresa = res['id_impresa'];
        this.nome = res['nome'];
        this.sede = 'Sede Fiscale/Legale Impresa';
      }
      if (res['id_sede_stabilimento']) {
        this._id_sede = res['id_sede_stabilimento'];
        this.ans.getStabilimentiSediSingolo(this._id_sede).subscribe((res: any) => {
          this.sede = 'Domicilio Fiscale/Legale Stabilimento';
          this.nome = res.info.dati[0].nome;
          this._id_stabilimento = res.info.dati[0].id_stabilimento;
          this.id_indirizzo_nuovo = res.info.dati[0].id_indirizzo;
          //console.log(res);
          this._formSedi?.formSede.patchValue({
            sede: res.info.dati[0].id_tipo_sede,
            descr_sede: res.info.dati[0].descr_tipo_sede,
            // piva: res.info.dati[0].piva,
            pec: res.info.dati[0].pec,
            email: res.info.dati[0].email,
            // sdi: res.info.dati[0].sdi,
            // split_payement: res.info.dati[0].split_payement,
            // cf: res.info.dati[0].cf,
            // cod_tipo_impresa: res.info.dati[0].cod_tipo_impresa,
            data_inizio_validita: res.info.dati[0].inizio_validita === null ? "" : (res.info.dati[0].inizio_validita).split('T')[0],
            data_fine_validita: res.info.dati[0].fine_validita === null ? "" : (res.info.dati[0].fine_validita).split('T')[0],
          })
        })
      } else if (res['id_sede_impresa']) {
        this._id_sede = res['id_sede_impresa'];
        this.ans.getImpreseSediSingolo(this._id_sede).subscribe((res: any) => {
          this.sede = 'Sede Fiscale/Legale Impresa';
          this.nome = res.info.dati[0].ragsoc;
          this._id_impresa = res.info.dati[0].id_impresa;
          this.id_indirizzo_nuovo = res.info.dati[0].id_indirizzo;
          //console.log(res);
          this._formSedi?.formSede.patchValue({
            sede: res.info.dati[0].id_tipo_sede,
            descr_sede: res.info.dati[0].descr_tipo_sede,
            // piva: res.info.dati[0].piva,
            pec: res.info.dati[0].pec,
            email: res.info.dati[0].email,
            // sdi: res.info.dati[0].sdi,
            // split_payement: res.info.dati[0].split_payement,
            // cf: res.info.dati[0].cf,
            // cod_tipo_impresa: res.info.dati[0].cod_tipo_impresa,
            data_inizio_validita: res.info.dati[0].inizio_validita === null ? "" : (res.info.dati[0].inizio_validita).split('T')[0],
            data_fine_validita: res.info.dati[0].fine_validita === null ? "" : (res.info.dati[0].fine_validita).split('T')[0],
          })
        })
      }

      if (res['parix_sede']) {
        this.parix_sede = JSON.parse(res['parix_sede'])
        if (res['id_impresa_parix']) {
          this.sede = 'Sede Fiscale/Legale Impresa';
          this._id_impresa_parix = +res['id_impresa_parix']
          this.ans.getTipiSediImpresa().subscribe((res: any) => {
            this._formSedi?.setTipiSedi(res.info.dati)
            this._formSedi?.setDisabilitaTipoSede(true)
            this._formSedi?.formSede.patchValue({
              sede: 1,
              descr_sede: 'Sede Legale',
              pec: this.parix_sede.INDIRIZZO[0].INDIRIZZO_PEC[0],
            })
          })
        }
        if (res['id_stabilimento_parix']) {
          this._id_stabilimento_parix = +res['id_stabilimento_parix']
          this.sede = 'Domicilio Fiscale/Legale Stabilimento';
        }
        if (res['id_sede_parix']) {
          this._id_sede_parix = +res['id_sede_parix']
          if (this._id_impresa_parix) {
            this.ans.getImpreseSediSingolo(this._id_sede_parix).subscribe((res: any) => {
              this.id_indirizzo_nuovo = res.info.dati[0].id_indirizzo;
              this.nome = res.info.dati[0].ragsoc;
              this._formSedi?.formSede.patchValue({
                email: res.info.dati[0].email,
                data_inizio_validita: res.info.dati[0].inizio_validita === null ? "" : (res.info.dati[0].inizio_validita).split('T')[0],
                data_fine_validita: res.info.dati[0].fine_validita === null ? "" : (res.info.dati[0].fine_validita).split('T')[0],
              })
              // this.ans.getTipiSediImpresa().subscribe((res: any) => {
              //   this._formSedi?.setTipiSedi(res.info.dati)
              //   this._formSedi?.setDisabilitaTipoSede(true)
              //   this._formSedi?.formSede.patchValue({
              //     sede: 1,
              //     descr_sede: 'Sede Legale',
              //     pec: this.parix_sede.INDIRIZZO[0].INDIRIZZO_PEC[0],
              //   })
              // })
            })
          } else if (this._id_stabilimento_parix) {
            this.ans.getStabilimentiSediSingolo(this._id_sede_parix).subscribe((res: any) => {
              this.id_indirizzo_nuovo = res.info.dati[0].id_indirizzo;
              this.nome = res.info.dati[0].ragsoc;
              this._formSedi?.formSede.patchValue({
                sede: res.info.dati[0].id_tipo_sede,
                descr_sede: res.info.dati[0].descr_tipo_sede,
                email: res.info.dati[0].email,
                data_inizio_validita: res.info.dati[0].inizio_validita === null ? "" : (res.info.dati[0].inizio_validita).split('T')[0],
                data_fine_validita: res.info.dati[0].fine_validita === null ? "" : (res.info.dati[0].fine_validita).split('T')[0],
              })
              this.ans.getTipiSedi().subscribe((res: any) => {
                this._formSedi?.setTipiSedi(res.info.dati)
                this._formSedi?.setDisabilitaTipoSede(true)
                this._formSedi?.formSede.patchValue({
                  pec: this.parix_sede.INDIRIZZO[0].INDIRIZZO_PEC[0],
                })
              })
            })
          }
        }
      }
    })

  }

  ngAfterViewInit() {
    if (this.parix_sede) {
      let indirizzo = this.parix_sede.INDIRIZZO[0]
      this._formIndirizzo?.checkValore({ target: { value: 'no' } })
      this._formIndirizzo?.formModificaIndirizzo.patchValue({
        valore: 'no',
        comune: indirizzo.COMUNE ? indirizzo.COMUNE[0] : null,
        toponimo: indirizzo.TOPONIMO ? indirizzo.TOPONIMO[0] : null,
        indirizzo: indirizzo.VIA ? indirizzo.VIA[0] : null,
        civico: indirizzo.N_CIVICO ? indirizzo.N_CIVICO[0] : null,
        cap: indirizzo.CAP ? indirizzo.CAP[0] : null,
        nazione: null,
        stato_provincia: null,
        latitudine: null,
        longitudine: null,

      })
    }
  }
  //---------------------------FUNZIONI-----------------------------
  // updSede() {
  //   if (!this._formSedi?.formSede.valid) {
  //     return;
  //   }
  //   const params = {
  //     id_impresa: 0,
  //     id_stabilimento: 0,
  //     id_stabilimento_sedi: 0,
  //     id_impresa_sedi: 0,
  //     sede: +this._formSedi?.formSede.value.sede,
  //     // piva: this._formSedi?.formSede.value.piva,
  //     pec: this._formSedi?.formSede.value.pec,
  //     email: this._formSedi?.formSede.value.email,
  //     // sdi: this._formSedi?.formSede.value.sdi,
  //     // split_payement: this._formSedi?.formSede.value.split_payement,
  //     // cf: this._formSedi?.formSede.value.cf,
  //     // cod_tipo_impresa: this._formSedi?.formSede.value.cod_tipo_impresa,
  //     data_inizio_validita: this._formSedi?.formSede.value.data_inizio_validita,
  //     data_fine_validita: this._formSedi?.formSede.value.data_fine_validita,
  //   }
  //   if (this._id_stabilimento) {
  //     params.id_stabilimento = +this._id_stabilimento;
  //     if (this._id_sede) {
  //       params.id_stabilimento_sedi = +this._id_sede;
  //       this.ans.updSede(params).subscribe((res: any) => {
  //         if (!res.esito) {
  //           this.LoadingService.closeDialog();
  //           return;
  //         }
  //         console.log("dati upd sedi", res);

  //         this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo);
  //       })
  //       //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
  //     }
  //     else {
  //       this.ans.addSede(params).subscribe((res: any) => {
  //         if (!res.esito) {
  //           this.LoadingService.closeDialog();
  //           return;
  //         }
  //         if (!res.info) {
  //           return;
  //         }
  //         console.log("dati tipi sede", res);
  //         this.id_indirizzo_nuovo = res.info.id_indirizzo;

  //         this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, null, null, null, null, null, res.info.id_stabilimento_sede);
  //       })
  //       //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
  //     }
  //   }
  //   if (this._id_impresa) {
  //     params.id_impresa = +this._id_impresa;
  //     if (this._id_sede) {
  //       params.id_impresa_sedi = +this._id_sede;
  //       this.ans.updSedeImpresa(params).subscribe((res: any) => {
  //         if (!res.esito) {
  //           this.LoadingService.closeDialog();
  //           return;
  //         }
  //         console.log("dati upd sedi", res);

  //         this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo);
  //       })
  //       //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
  //     }
  //     else {
  //       this.ans.addSedeImpresa(params).subscribe((res: any) => {
  //         if (!res.esito) {
  //           this.LoadingService.closeDialog();
  //           return;
  //         }
  //         if (!res.info) {
  //           return;
  //         }
  //         console.log("dati tipi sede", res);
  //         this.id_indirizzo_nuovo = res.info.id_indirizzo;

  //         this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, null, null, null, res.info.id_impresa_sede);
  //       })
  //       //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
  //     }
  //   }

  // }
  updSede() {
    if (!this._formSedi?.formSede.valid || !this._formIndirizzo?.formModificaIndirizzo?.valid) {
      console.log('formSedi non valido')
      return;
    }
    const params: Record<string, any> = {
      id_impresa: 0,
      id_stabilimento: 0,
      id_stabilimento_sedi: 0,
      id_impresa_sedi: 0,
      sede: +this._formSedi?.formSede.value.sede,
      // piva: this._formSedi?.formSede.value.piva,
      pec: this._formSedi?.formSede.value.pec,
      email: this._formSedi?.formSede.value.email,
      // sdi: this._formSedi?.formSede.value.sdi,
      // split_payement: this._formSedi?.formSede.value.split_payement,
      // cf: this._formSedi?.formSede.value.cf,
      // cod_tipo_impresa: this._formSedi?.formSede.value.cod_tipo_impresa,
      data_inizio_validita: this._formSedi?.formSede.value.data_inizio_validita,
      data_fine_validita: this._formSedi?.formSede.value.data_fine_validita,
      nome_function: null,
    }
    if (this._id_stabilimento) {
      params['id_stabilimento'] = +this._id_stabilimento;
      if (this._id_sede) {
        params['id_stabilimento_sedi'] = +this._id_sede;
        params['nome_function'] = 'upd_cu_upd_stabilimenti_sedi';
        this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
        //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
      }
      else {
        params['nome_function'] = 'upd_cu_add_stabilimenti_sedi';
        this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
        //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
      }
    }
    if (this._id_impresa) {
      params['id_impresa'] = +this._id_impresa;
      if (this._id_sede) {
        params['id_impresa_sedi'] = +this._id_sede;
        params['nome_function'] = 'upd_cu_upd_imprese_sedi';
        this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
        //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
      }
      else {
        params['nome_function'] = 'upd_cu_add_imprese_sedi';
        this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
        //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
      }
    }
    if (this._id_impresa_parix) {
      params['id_impresa'] = +this._id_impresa_parix;
      if (this._id_sede_parix) {
        params['id_impresa_sedi'] = +this._id_sede_parix;
        params['nome_function'] = 'upd_cu_upd_imprese_sedi';
        this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
        //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
      }
      else {
        params['nome_function'] = 'upd_cu_add_imprese_sedi';
        this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
        //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
      }
    }
    if (this._id_stabilimento_parix) {
      params['id_stabilimento'] = +this._id_stabilimento_parix;
      if (this._id_sede_parix) {
        params['id_stabilimento_sedi'] = +this._id_sede_parix;
        params['nome_function'] = 'upd_cu_upd_stabilimenti_sedi';
        console.log(params)
        this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
        //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
      }
      else {
        params['nome_function'] = 'upd_cu_add_stabilimenti_sedi';
        this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
        //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
      }
    }
  }

  goToPARIX() {
    let piva: any = null
    new Promise(resolve => {
      if (this._formSedi?.stabilimento) {
        piva = this._formSedi?.stabilimento.piva_impresa ?? this._formSedi?.stabilimento.cf_impresa
        resolve(true)
      } else if (this._id_stabilimento) {
        this.ans.getStabilimentoSingolo(this._id_stabilimento).subscribe(res => {
          resolve(true)
          if (res.info) {
            piva = res.info.dati[0].piva_impresa ?? res.info.dati[0].cf_impresa
          }
        })
      } else {
        resolve(true)
      }
    }).then(() => {
      this.router.navigate(['portali/anagrafica/allineamento-parix/sede'], { queryParams: { id_impresa: this._id_impresa, id_stabilimento: this._id_stabilimento, piva: piva, id_sede_stabilimento: this._id_sede } })
    })
  }
  //-----------------------GETTER E SETTER--------------------------
}
