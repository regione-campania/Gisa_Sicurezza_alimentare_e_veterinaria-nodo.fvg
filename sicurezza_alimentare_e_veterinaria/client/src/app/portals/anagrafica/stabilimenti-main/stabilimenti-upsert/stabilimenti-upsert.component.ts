/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NotificationService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';
import { FormStabilimentiComponent } from '../form-stabilimenti/form-stabilimenti.component';
import { ImpreseMainComponent } from '../../imprese-main/imprese-main.component';
import { FormIndirizzoMainComponent } from '../../form-indirizzo-main/form-indirizzo-main.component';
import { Validators } from '@angular/forms';

@Component({
  selector: 'app-stabilimenti-upsert',
  templateUrl: './stabilimenti-upsert.component.html',
  styleUrls: ['./stabilimenti-upsert.component.scss']
})
export class StabilimentiUpsertComponent implements OnInit {
  //---------------------------------VARIABILI---------------------------

  parix_stabilimento: any
  abilita_parix: any = true
  mostra_parix: any = false

  labelBottone: any;
  mostraRicerca: boolean = false
  private _id_impresa: any;
  private _id_stabilimento: any;
  _flag_cod_regionale: any;
  public id_indirizzo_nuovo: any;
  flagStab: boolean = true;
  tipoImpresa: any;
  private cod_tipologia_struttura_preso: any;
  private stabPec: any;
  @ViewChild('formStabilimenti') _formStabilimenti?: FormStabilimentiComponent;
  @ViewChild('formIndirizzo') _formIndirizzo?: FormIndirizzoMainComponent
  @ViewChild('ricercaImpresa') ricercaImpresa?: ImpreseMainComponent;
  //-------------------------------COSTRUTTORE---------------------------
  constructor(
    private route: ActivatedRoute, //this.route.snapshot.url[0].path ritorna parte finale dell'url
    private router: Router,
    private ans: AnagraficaService,
    private notificationService: NotificationService,
  ) {
    //Per creare nuove proprietà dinamicamente al params
    interface params extends Record<string, any> {

    }
  }


  //--------------------------NGONINIT--------------------------------
  ngOnInit(): void {

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
      if (res['parix_stabilimento']) {
        this.parix_stabilimento = JSON.parse(res['parix_stabilimento'])
      }

      Promise.all([
        new Promise((resolve) => {
          //aggiungi
          if (res['id_impresa']) {
            this._id_impresa = res['id_impresa'];
            this.ans.getImpresaSingolo(this._id_impresa).subscribe((res: any) => {
              this.abilita_parix = false
              resolve(true)
              console.log(res);
              if (!res.esito) {
                return;
              }
              this.tipoImpresa = res.info.dati[0].cod_tipo_impresa;
              this._formStabilimenti?.formStabilimento.controls['pec'].setValue(res.info.dati[0].pec);
              if (this.tipoImpresa === 'Z') {
                this._formStabilimenti!.setMostraSDI = true
                this._formStabilimenti?.formStabilimento.controls['sdi'].addValidators([Validators.required]);
                this._formStabilimenti?.formStabilimento.controls['sdi'].updateValueAndValidity();
              }
              else {
                this._formStabilimenti!.setMostraSDI = false
                this._formStabilimenti?.formStabilimento.controls['sdi'].clearValidators();
                this._formStabilimenti?.formStabilimento.controls['sdi'].updateValueAndValidity();
              }
            })
          } else {
            resolve(true)
          }
        }),
        new Promise((resolve) => {
          //modifica
          if (res['id_stabilimento']) {
            this._id_stabilimento = res['id_stabilimento'];
            this.ans.getStabilimentoSingolo(this._id_stabilimento).subscribe((res: any) => {
              this.abilita_parix = false
              console.log("res:", res);
              this._id_impresa = res.info.dati[0].id_impresa;
              this.id_indirizzo_nuovo = res.info.dati[0].id_indirizzo;
              this.cod_tipologia_struttura_preso = res.info.dati[0].cod_tipologia_struttura;
              this.stabPec = res.info.dati[0].pec;
              this._formStabilimenti?.formStabilimento.patchValue({
                id_impresa: res.info.dati[0].id_impresa,
                id_stabilimento: res.info.dati[0].id_stabilimento,
                n_pratica: res.info.dati[0].n_pratica,
                nome: res.info.dati[0].nome,
                // sd_cod_regionale: res.info.dati[0].sd_cod_regionale,
                cod_nazionale: res.info.dati[0].cod_nazionale,
                cod_tipologia_struttura: res.info.dati[0].cod_tipologia_struttura,
                categoria_rischio: res.info.dati[0].categoria_rischio,
                pec: res.info.dati[0].pec,
                telefono: res.info.dati[0].telefono,
                data_inizio_validita: res.info.dati[0].inizio_validita === null ? "" : (res.info.dati[0].inizio_validita).split('T')[0],
                data_fine_validita: res.info.dati[0].fine_validita === null ? "" : (res.info.dati[0].fine_validita).split('T')[0],
                sdi: res.info.dati[0].sdi
                //id_asl: res.info.dati[0].id_asl_stabilimento,
              })

              //Mi serve per quando si tratta della modifica siccome non ho i dati salvati, devo rifare tutti i controlli
              //necessari per far uscire subito il codice regionale in base al codice tipologia struttura e valorizzare
              //l'id
              this.ans.getTipologiaStruttura().subscribe((res: any) => {
                if (res.info) {
                  for (let i = 0; i < res.info.dati.length; i++) {
                    if (res.info.dati[i].codice === this._formStabilimenti?.formStabilimento.value.cod_tipologia_struttura) {
                      // this._formStabilimenti!.descr_cod_regionale = res.info.dati[i].descr_cod_reg;
                      this._formStabilimenti!.descr_cod_nazionale = res.info.dati[i].descr_cod_naz;
                      this._formStabilimenti!.set_id_tipologia_struttura = res.info.dati[i].id_tipologia_struttura;
                      this._formStabilimenti!.set_richiede_codice_regionale = res.info.dati[i].richiede_codice_regionale;
                    }
                  }
                }
                // if (!this._formStabilimenti!.descr_cod_regionale) {
                //   this._formStabilimenti!.formStabilimento.controls['sd_cod_regionale'].clearValidators();
                // }
                // this._formStabilimenti!.formStabilimento.controls['sd_cod_regionale'].updateValueAndValidity();
                if (!this._formStabilimenti!.descr_cod_nazionale) {
                  this._formStabilimenti!.formStabilimento.controls['cod_nazionale'].clearValidators();
                }
                this._formStabilimenti!.formStabilimento.controls['cod_nazionale'].updateValueAndValidity();

                this.ans.getImpresaSingolo(this._id_impresa).subscribe((res: any) => {
                  resolve(true)
                  console.log(res);
                  if (!res.esito) {
                    return;
                  }
                  this.tipoImpresa = res.info.dati[0].cod_tipo_impresa;
                  if (this.stabPec == null) {
                    this._formStabilimenti?.formStabilimento.controls['pec'].setValue(res.info.dati[0].pec);
                  }
                  if (this.tipoImpresa === 'Z') {
                    // this._formStabilimenti?.formStabilimento.patchValue({
                    //   sdi: res.info.dati[0].sdi
                    // })
                    this._formStabilimenti!.setMostraSDI = true
                    this._formStabilimenti?.formStabilimento.controls['sdi'].addValidators([Validators.required]);
                    this._formStabilimenti?.formStabilimento.controls['sdi'].updateValueAndValidity();
                  }
                  else {
                    this._formStabilimenti!.setMostraSDI = false
                    // this._formStabilimenti?.formStabilimento.controls['sdi'].clearValidators();
                    this._formStabilimenti?.formStabilimento.controls['sdi'].clearValidators();
                    this._formStabilimenti?.formStabilimento.controls['sdi'].updateValueAndValidity();
                  }

                })
              })

            })
          } else {
            resolve(true)
          }
        })
      ]).then(() => {
        if (this.parix_stabilimento) {
          let indirizzo = this.parix_stabilimento
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

      })

      if (this.labelBottone === 'Aggiungi' && this._id_impresa === undefined) {
        this.mostraRicerca = true
      }

    })

  }
  //Serve siccome prende l'oggetto dal figlio, fa prima il rendering e quindi pon riesce a renderizzare l'oggetto figlio
  //Per questo si chiama questa funzione che permette di prendere l'oggetto e settarlo.
  ngAfterViewInit() {
    if (this._id_impresa) {
      this._formStabilimenti?.formStabilimento.patchValue({
        id_impresa: +this._id_impresa
      })
    }

    this.route.queryParams.subscribe((res: any) => {
      //aggiungi
      if (res['n_pratica']) {
        this._formStabilimenti?.formStabilimento.controls['n_pratica'].setValue(res['n_pratica'])
        this._formStabilimenti!.setNPraticaMode = true
      }
    })
  }
  //------------------------FUNZIONI------------------------------------
  // updStabilimento() {
  //   if (!this._formStabilimenti?.formStabilimento.valid) {
  //     return;
  //   }
  //   this._flag_cod_regionale = this._formStabilimenti?.richiede_codice_regionale;
  //   const params = {
  //     id_impresa: +this._formStabilimenti?.formStabilimento.value.id_impresa,
  //     id_stabilimento: 0,
  //     //id_asl: +this._formStabilimenti?.formStabilimento.value.id_asl,
  //     nome: this._formStabilimenti?.formStabilimento.value.nome,
  //     // sd_cod_regionale: this._formStabilimenti?.formStabilimento.value.sd_cod_regionale,
  //     cod_nazionale: this._formStabilimenti?.formStabilimento.value.cod_nazionale,
  //     pec: this._formStabilimenti?.formStabilimento.value.pec,
  //     telefono: this._formStabilimenti?.formStabilimento.value.telefono,
  //     cod_tipologia_struttura: this._formStabilimenti?.formStabilimento.value.cod_tipologia_struttura ? this._formStabilimenti?.formStabilimento.value.cod_tipologia_struttura : null,
  //     id_tipologia_struttura: this._formStabilimenti?.id_tipologia_struttura ? this._formStabilimenti?.id_tipologia_struttura : null,
  //     categoria_rischio: +this._formStabilimenti?.formStabilimento.value.categoria_rischio,
  //     data_inizio_validita: this._formStabilimenti?.formStabilimento.value.data_inizio_validita,
  //     data_fine_validita: this._formStabilimenti?.formStabilimento.value.data_fine_validita,
  //     sdi: this._formStabilimenti?.formStabilimento.value.sdi,
  //   }
  //   console.log(params)
  //   if (this._id_stabilimento) {
  //     params.id_impresa = +this._formStabilimenti?.formStabilimento.value.id_impresa;
  //     params.id_stabilimento = +this._id_stabilimento;

  //     this.ans.updStabilimento(params).subscribe((res: any) => {
  //       if (!res.esito) {
  //         return;
  //       }
  //       console.log("dati stabilimento", res);

  //       this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo);
  //     })
  //     //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
  //   }
  //   else {
  //     this.ans.addStabilimento(params).subscribe((res: any) => {
  //       if (!res.esito) {
  //         return;
  //       }
  //       if (!res.info) {
  //         return;
  //       }
  //       console.log("dati add stabilimento", res);
  //       this.id_indirizzo_nuovo = res.info.id_indirizzo;


  //       this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, params.id_impresa, null, res.info.id_stabilimento,null,null,null,null,this._flag_cod_regionale);
  //     })
  //     //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone  } }); }, 1500);
  //   }
  // }

  updStabilimento() {
    if (!this._formStabilimenti?.formStabilimento.valid) {
      return;
    }
    this._flag_cod_regionale = this._formStabilimenti?.richiede_codice_regionale;
    const params: Record<string, any> = {
      n_pratica: this._formStabilimenti.formStabilimento.value.n_pratica,
      id_impresa: +this._formStabilimenti?.formStabilimento.value.id_impresa,
      id_stabilimento: 0,
      //id_asl: +this._formStabilimenti?.formStabilimento.value.id_asl,
      nome: this._formStabilimenti?.formStabilimento.value.nome,
      // sd_cod_regionale: this._formStabilimenti?.formStabilimento.value.sd_cod_regionale,
      cod_nazionale: this._formStabilimenti?.formStabilimento.value.cod_nazionale,
      pec: this._formStabilimenti?.formStabilimento.value.pec,
      telefono: this._formStabilimenti?.formStabilimento.value.telefono,
      cod_tipologia_struttura: this._formStabilimenti?.formStabilimento.value.cod_tipologia_struttura ? this._formStabilimenti?.formStabilimento.value.cod_tipologia_struttura : this.cod_tipologia_struttura_preso,
      id_tipologia_struttura: this._formStabilimenti?.id_tipologia_struttura ? this._formStabilimenti?.id_tipologia_struttura : null,
      categoria_rischio: +this._formStabilimenti?.formStabilimento.value.categoria_rischio,
      data_inizio_validita: this._formStabilimenti?.formStabilimento.value.data_inizio_validita,
      data_fine_validita: this._formStabilimenti?.formStabilimento.value.data_fine_validita,
      sdi: this._formStabilimenti?.formStabilimento.value.sdi,
      nome_function: null,
    };

    if (this._id_stabilimento) {
      params['id_impresa'] = +this._formStabilimenti?.formStabilimento.value.id_impresa;
      params['id_stabilimento'] = +this._id_stabilimento;
      params['nome_function'] = 'upd_cu_stabilimenti';

      this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
      // })
      //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
    }
    else {
      params['nome_function'] = 'upd_cu_add_stabilimento';
      this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, this._flag_cod_regionale, params);
      // })
      //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone  } }); }, 1500);
    }
  }


  impresaSelezionata(id_impresa: any) {
    this._formStabilimenti?.formStabilimento.controls['id_impresa'].setValue(+id_impresa)
    this.abilita_parix = false
    this.ans.getImpresaSingolo(+id_impresa).subscribe((res: any) => {
      if (res.info) {
        if (res.info.dati[0].cod_tipo_impresa === 'Z') {
          this._formStabilimenti!.setMostraSDI = true
          this._formStabilimenti?.formStabilimento.controls['sdi'].addValidators([Validators.required]);
          this._formStabilimenti?.formStabilimento.controls['sdi'].updateValueAndValidity();
        }
        else {
          this._formStabilimenti!.setMostraSDI = false
          this._formStabilimenti?.formStabilimento.controls['sdi'].clearValidators();
          this._formStabilimenti?.formStabilimento.controls['sdi'].updateValueAndValidity();
        }
        this._formStabilimenti?.formStabilimento.controls['pec'].setValue(res.info.dati[0].pec);
      }
    })
  }

  goToPARIX() {
    this.ans.getImpresaSingolo(this._formStabilimenti?.formStabilimento.value.id_impresa).subscribe((res: any) => {
      if (res.info) {
        this.router.navigate(['portali/anagrafica/allineamento-parix/stabilimento'], { queryParams: { id_impresa: res.info.dati[0].id_impresa, id_stabilimento: this._id_stabilimento, piva: res.info.dati[0].piva ?? res.info.dati[0].cf } })
      }
    })
  }


  //----------------------------GETTER E SETTER--------------------------------
  get id_stabilimento() { return this._id_stabilimento; }
  get id_impresa() { return this._id_impresa; }
}
