/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { AfterContentInit, AfterViewInit, Component, NgZone, OnInit, ViewChild, ViewChildren } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';
import { FormFigureComponent } from '../form-figure/form-figure.component';
import { FormIndirizzoMainComponent } from '../../form-indirizzo-main/form-indirizzo-main.component';
import { FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-figure-upsert',
  templateUrl: './figure-upsert.component.html',
  styleUrls: ['./figure-upsert.component.scss']
})
export class FigureUpsertComponent implements OnInit {
  labelBottone: any;
  
  mostra_parix: any = false
  parix_soggetto: any;

  _id_stabilimento: any;
  _id_impresa: any;
  _id_figura: any;
  tipoFigura: any;
  public id_indirizzo_nuovo: any;
  valoreResidenza: any;
  valoreEstero: any;
  @ViewChild('formFigure') _formFigure?: FormFigureComponent;
  @ViewChild('formIndirizzo') _formIndirizzo?: FormIndirizzoMainComponent;
  //----------------------------COSTRUTTORE-----------------------------
  constructor(
    private route: ActivatedRoute, //this.route.snapshot.url[0].path ritorna parte finale dell'url
    private router: Router,
    private ans: AnagraficaService,
    private notificationService: NotificationService,
    private LoadingService: LoadingDialogService,
    private ComunicazioneDB: BackendCommunicationService,) {
    //Per creare nuove proprietà dinamicamente al params
    interface params extends Record<string, any> {

    }
  }
  //------------------------------NGONINIT-------------------------------
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
      console.log(res);
      if (res['parix_soggetto']) {
        this.parix_soggetto = JSON.parse(res['parix_soggetto'])
      }
      if (res['id_stabilimento']) {
        this._id_stabilimento = res['id_stabilimento'];
        this.tipoFigura = 'Stabilimento';
      }
      if (res['id_impresa']) {
        this._id_impresa = res['id_impresa'];
        this.tipoFigura = 'Impresa'
      }
      if (res['id_stabilimento_figura']) {
        this._id_figura = res['id_stabilimento_figura'];
        this.tipoFigura = 'Stabilimento';
        this.ans.getStabilimentiFigureSingolo(this._id_figura).subscribe((res: any) => {
          this._id_stabilimento = res.info.dati[0].id_stabilimento;
          this.id_indirizzo_nuovo = res.info.dati[0].id_indirizzo;
          console.log(res);
          this._formFigure?.formFigura.patchValue({
            figura: res.info.dati[0].id_tipo_figura,
            nome: res.info.dati[0].nome_figura,
            cognome: res.info.dati[0].cognome_figura,
            cf: res.info.dati[0].cf,
            data_inizio_validita: res.info.dati[0].inizio_validita === null ? "" : (res.info.dati[0].inizio_validita).split('T')[0],
            data_fine_validita: res.info.dati[0].fine_validita === null ? "" : (res.info.dati[0].fine_validita).split('T')[0],
            valore: res.info.dati[0].domicilio == false ? 'si' : 'no'
          })
          console.log("indirizzo id:", this.id_indirizzo_nuovo);
          //Settaggio del valore di controllo
          this._formFigure?.setValoreResidenza(this._formFigure?.formFigura.value.valore);
          console.log("valore residenza modifica:", this._formFigure?.valoreResidenza);
          this.ComunicazioneDB.getDati('get_cu_indirizzi', { id_indirizzo: parseInt(this.id_indirizzo_nuovo) }).subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            this.valoreEstero = res.info.dati[0].estero ? 'si' : 'no';
            const fields = ['nazione', 'comune', 'toponimo', 'indirizzo', 'civico', 'cap', 'valore'];
            // 'comune_estero', 'toponimo_estero', 'indirizzo_estero', 'civico_estero', 'cap_estero',
            if (this._formFigure?.valoreResidenza == 'si') {
              console.log("entrato controllo del valore residenza si");
              console.log("form dopo value:", this._formIndirizzo?.formModificaIndirizzo);
              for (let field of fields) {
                this._formIndirizzo?.formModificaIndirizzo.controls[field].clearValidators();
                this._formIndirizzo?.formModificaIndirizzo.controls[field].updateValueAndValidity();
              }
            }
            else {
              const estero = ['nazione'];
              const no_estero = ['comune', 'toponimo', 'indirizzo', 'civico', 'cap']
              console.log("form dopo value:", this._formIndirizzo?.formModificaIndirizzo);
              if (this.valoreEstero == 'si') {
                for (let field of no_estero) {
                  this._formIndirizzo?.formModificaIndirizzo.controls[field].clearValidators();
                }
                for (let field of estero) {
                  this._formIndirizzo?.formModificaIndirizzo.controls[field].setValidators([Validators.required]);
                }
              }
              if (this.valoreEstero == 'no') {
                console.log("entrato nel no");
                console.log("form dopo value:", this._formIndirizzo?.formModificaIndirizzo);
                for (let field of estero) {
                  this._formIndirizzo?.formModificaIndirizzo.controls[field].clearValidators();
                }
                for (let field of no_estero) {
                  this._formIndirizzo?.formModificaIndirizzo.controls[field].setValidators([Validators.required]);
                }
              }
              for (let field of fields) {
                this._formIndirizzo?.formModificaIndirizzo.controls[field].updateValueAndValidity();
              }
            }
          })
          this.ComunicazioneDB.getDati('get_cu_soggetti_fisici_by_sel', { cf: this._formFigure?.formFigura.value.cf }).subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            if (!res.info) {
              this.notificationService.push({
                notificationClass: 'error',
                content: "Codice fiscale inesistente"
              });
              return;
            }
            this._formFigure!.idIndirizzoSoggetto = res.info.dati[0].indirizzo_id;
            this.ComunicazioneDB.getDati('get_cu_indirizzi', { id_indirizzo: parseInt(this._formFigure!.idIndirizzoSoggetto) }).subscribe((res: any) => {
              this._formFigure!.set_uiInd = res.info.ui;
              this._formFigure!.set_indirizzo = res.info.dati[0];
            })
          })

        })
      }
      //&& !this.parix_soggetto
      if (res['id_impresa_figura']) {
        this._id_figura = res['id_impresa_figura'];
        this.tipoFigura = 'Impresa';
        this.ans.getImpreseFigureSingolo(this._id_figura).subscribe((res: any) => {
          this._id_impresa = res.info.dati[0].id_impresa;
          this.id_indirizzo_nuovo = res.info.dati[0].id_indirizzo;
          console.log(res);
          this._formFigure?.formFigura.patchValue({
            figura: res.info.dati[0].id_tipo_figura,
            nome: res.info.dati[0].nome_figura,
            cognome: res.info.dati[0].cognome_figura,
            cf: res.info.dati[0].cf_figura,
            data_inizio_validita: res.info.dati[0].inizio_validita === null ? "" : (res.info.dati[0].inizio_validita).split('T')[0],
            data_fine_validita: res.info.dati[0].fine_validita === null ? "" : (res.info.dati[0].fine_validita).split('T')[0],
            valore: res.info.dati[0].domicilio == false ? 'si' : 'no'
          })
          console.log("indirizzo id:", this.id_indirizzo_nuovo);
          //Settaggio del valore di controllo
          this._formFigure?.setValoreResidenza(this._formFigure?.formFigura.value.valore);
          console.log("valore residenza modifica:", this._formFigure?.valoreResidenza);
          this.ComunicazioneDB.getDati('get_cu_indirizzi', { id_indirizzo: parseInt(this.id_indirizzo_nuovo) }).subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            this.valoreEstero = res.info.dati[0].estero ? 'si' : 'no';
            const fields = ['nazione', 'comune', 'toponimo', 'indirizzo', 'civico', 'cap', 'valore'];

            // 'comune_estero', 'toponimo_estero', 'indirizzo_estero', 'civico_estero', 'cap_estero'

            if (this._formFigure?.valoreResidenza == 'si') {
              console.log("entrato controllo del valore residenza si");
              console.log("form dopo value:", this._formIndirizzo?.formModificaIndirizzo);
              for (let field of fields) {
                this._formIndirizzo?.formModificaIndirizzo.controls[field].clearValidators();
                this._formIndirizzo?.formModificaIndirizzo.controls[field].updateValueAndValidity();
              }
            }
            else {
              const estero = ['nazione'];
              const no_estero = ['comune', 'toponimo', 'indirizzo', 'civico', 'cap']
              console.log("form dopo value:", this._formIndirizzo?.formModificaIndirizzo);
              if (this.valoreEstero == 'si') {
                for (let field of no_estero) {
                  this._formIndirizzo?.formModificaIndirizzo.controls[field].clearValidators();
                }
                for (let field of estero) {
                  this._formIndirizzo?.formModificaIndirizzo.controls[field].setValidators([Validators.required]);
                }
              }
              if (this.valoreEstero == 'no') {
                console.log("entrato nel no");
                console.log("form dopo value:", this._formIndirizzo?.formModificaIndirizzo);
                for (let field of estero) {
                  this._formIndirizzo?.formModificaIndirizzo.controls[field].clearValidators();
                }
                for (let field of no_estero) {
                  this._formIndirizzo?.formModificaIndirizzo.controls[field].setValidators([Validators.required]);
                }
              }
              for (let field of fields) {
                this._formIndirizzo?.formModificaIndirizzo.controls[field].updateValueAndValidity();
              }
            }
          })
          this.ComunicazioneDB.getDati('get_cu_soggetti_fisici_by_sel', { cf: this._formFigure?.formFigura.value.cf }).subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            if (!res.info) {
              this.notificationService.push({
                notificationClass: 'error',
                content: "Codice fiscale inesistente"
              });
              return;
            }
            this._formFigure!.idIndirizzoSoggetto = res.info.dati[0].indirizzo_id;
            this.ComunicazioneDB.getDati('get_cu_indirizzi', { id_indirizzo: parseInt(this._formFigure!.idIndirizzoSoggetto) }).subscribe((res: any) => {
              this._formFigure!.set_uiInd = res.info.ui;
              this._formFigure!.set_indirizzo = res.info.dati[0];
            })
          })

        })
      }
    })
  }

  //---------------------------FUNZIONI-----------------------------
  // updFigura() {
  //   if (!this._formFigure?.formFigura.valid) {
  //     return;
  //   }
  //   const params = {
  //     id_impresa: 0,
  //     id_stabilimento: 0,
  //     id_stabilimento_figura: 0,
  //     id_impresa_figura: 0,
  //     figura: +this._formFigure?.formFigura.value.figura,
  //     nome: this._formFigure?.formFigura.value.nome,
  //     cognome: this._formFigure?.formFigura.value.cognome,
  //     cf: this._formFigure?.formFigura.value.cf,
  //     data_inizio_validita: this._formFigure?.formFigura.value.data_inizio_validita,
  //     data_fine_validita: this._formFigure?.formFigura.value.data_fine_validita,
  //   }
  //   if (this._id_stabilimento) {
  //     params.id_stabilimento = +this._id_stabilimento;
  //     if (this._id_figura) {
  //       params.id_stabilimento_figura = +this._id_figura;
  //       this.ans.updFigura(params).subscribe((res: any) => {
  //         if (!res.esito) {
  //           this.LoadingService.closeDialog();
  //           return;
  //         }
  //         console.log("dati upd figura", res);

  //         this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo);
  //       })
  //       //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
  //     }
  //     else {
  //       this.ans.addFigura(params).subscribe((res: any) => {
  //         if (!res.esito) {
  //           this.LoadingService.closeDialog();
  //           return;
  //         }
  //         if (!res.info) {
  //           return;
  //         }
  //         console.log("dati figura", res);
  //         this.id_indirizzo_nuovo = res.info.id_indirizzo;

  //         this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, null, null, null, null, res.info.id_stabilimento_figura);
  //       })
  //       //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
  //     }
  //   }
  //   if (this._id_impresa) {
  //     params.id_impresa = +this._id_impresa;
  //     if (this._id_figura) {
  //       params.id_impresa_figura = +this._id_figura;
  //       this.ans.updFiguraImpresa(params).subscribe((res: any) => {
  //         if (!res.esito) {
  //           this.LoadingService.closeDialog();
  //           return;
  //         }
  //         console.log("dati upd figura", res);

  //         this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo);
  //       })
  //       //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
  //     }
  //     else {
  //       this.ans.addFiguraImpresa(params).subscribe((res: any) => {
  //         if (!res.esito) {
  //           this.LoadingService.closeDialog();
  //           return;
  //         }
  //         if (!res.info) {
  //           return;
  //         }
  //         console.log("dati figura", res);
  //         this.id_indirizzo_nuovo = res.info.id_indirizzo;

  //         this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, null, null, res.info.id_impresa_figura);
  //       })
  //       //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
  //     }
  //   }

  // }
  updFigura() {
    if (!this._formFigure?.formFigura.valid || !this._formIndirizzo?.formModificaIndirizzo?.valid) {
      return;
    }
    const params: Record<string, any> = {
      id_impresa: 0,
      id_stabilimento: 0,
      id_stabilimento_figura: 0,
      id_impresa_figura: 0,
      figura: +this._formFigure?.formFigura.value.figura,
      nome: this._formFigure?.formFigura.value.nome,
      cognome: this._formFigure?.formFigura.value.cognome,
      cf: this._formFigure?.formFigura.value.cf,
      data_inizio_validita: this._formFigure?.formFigura.value.data_inizio_validita,
      data_fine_validita: this._formFigure?.formFigura.value.data_fine_validita,
      nome_function: null,
    }
    if (this._id_stabilimento) {
      params['id_stabilimento'] = +this._id_stabilimento;
      if (this._id_figura) {
        params['id_stabilimento_figura'] = +this._id_figura;
        if (this._formFigure.valoreResidenza == 'si') {
          params['domicilio'] = this._formFigure.valoreResidenza;
          params['id_indirizzo_soggetto'] = this._formFigure.idIndirizzoSoggetto;
          params['id_indirizzo'] = this.id_indirizzo_nuovo;
          console.log("id indirizzo soggetto", params['id_indirizzo_soggetto']);
          console.log("id indirizzo", params['id_indirizzo']);
          this.ans.updFigura(params).subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            setTimeout(() => { this.router.navigate(['portali', 'anagrafica', 'stabilimenti', 'dettaglio'], { queryParams: { id_stabilimento: +this._id_stabilimento } }); }, 1500);
          })
        }
        else {
          params['nome_function'] = 'upd_cu_upd_stabilimenti_figure';
          params['domicilio'] = this._formFigure.valoreResidenza;
          // console.log("parametri:",params)
          // console.log("parametri:",this.id_indirizzo_nuovo)
          this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
          //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
        }
      }
      else {
        if (this._formFigure.valoreResidenza == 'si') {
          params['id_indirizzo'] = this._formFigure.idIndirizzoSoggetto;
          // console.log(params);
          // console.log("entrato e valore indirizzo id:", this._formFigure.idIndirizzoSoggetto);
          this.ans.addFigura(params).subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            setTimeout(() => { this.router.navigate(['portali', 'anagrafica', 'stabilimenti', 'dettaglio'], { queryParams: { id_stabilimento: +this._id_stabilimento } }); }, 1500);
          })
        }
        else {
          params['nome_function'] = 'upd_cu_add_stabilimenti_figure';
          this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
        }
        //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
      }
    }
    if (this._id_impresa) {
      params['id_impresa'] = +this._id_impresa;
      if (this.parix_soggetto) params['parix'] = true
      else params['parix'] = false
      if (this._id_figura) {
        params['id_impresa_figura'] = +this._id_figura;
        if (this._formFigure.valoreResidenza == 'si') {
          params['domicilio'] = this._formFigure.valoreResidenza;
          params['id_indirizzo_soggetto'] = this._formFigure.idIndirizzoSoggetto;
          params['id_indirizzo'] = this.id_indirizzo_nuovo;
          console.log("id indirizzo soggetto", params['id_indirizzo_soggetto']);
          console.log("id indirizzo", params['id_indirizzo']);
          this.ans.updFiguraImpresa(params).subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            setTimeout(() => { this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], { queryParams: { id_impresa: +this._id_impresa } }) }, 1500);
          })
        }
        else {
          params['nome_function'] = 'upd_cu_upd_imprese_figure';
          params['domicilio'] = this._formFigure.valoreResidenza;
          this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
          //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
        }
      }
      else {
        if (this._formFigure.valoreResidenza == 'si') {
          params['id_indirizzo'] = this._formFigure.idIndirizzoSoggetto;
          // console.log(params);
          // console.log("entrato e valore indirizzo id:", this._formFigure.idIndirizzoSoggetto);
          this.ans.addFiguraImpresa(params).subscribe((res: any) => {
            if (!res.esito) {
              return;
            }
            setTimeout(() => { this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], { queryParams: { id_impresa: +this._id_impresa } }) }, 1500);
          })
        }
        else {
          params['nome_function'] = 'upd_cu_add_imprese_figure';
          this._formIndirizzo?.updIndirizzo(this.id_indirizzo_nuovo, null, params);
          //setTimeout(() => { this.router.navigate(['portali', 'controlli-ufficiali', 'anagrafica', 'form-indirizzo'], { queryParams: { id_stabilimento: +this._id_stabilimento, id_indirizzo: +this.id_indirizzo_nuovo, labelBottone: this.labelBottone } }); }, 1500);
        }
      }
    }

  }
  //Funzione che prende l'evento dell'onchange della checkbox che controlla la residenza dal componet formFigure
  //Il valore valoreEstero è preso dal component figlio tramite l'event emitter poichè prende il valore dall'evento
  //dell'onchange e cambia ogni volta e bisogna controllarlo ogni volta.
  prendiValoreResidenza(event: any) {
    this.valoreResidenza = event;
    console.log("residenza passata al padre", this.valoreResidenza);
    const fields = ['nazione', 'comune', 'toponimo', 'indirizzo', 'civico', 'cap', 'valore'];

    // ,'comune_estero', 'toponimo_estero', 'indirizzo_estero', 'civico_estero', 'cap_estero',

    if (this.valoreResidenza == 'si') {
      for (let field of fields) {
        this._formIndirizzo?.formModificaIndirizzo.controls[field].clearValidators();
        this._formIndirizzo?.formModificaIndirizzo.controls[field].updateValueAndValidity();
      }
    } else {
      const estero = ['nazione'];
      const no_estero = ['comune', 'toponimo', 'indirizzo', 'civico', 'cap']
      console.log(this._formIndirizzo?.valoreCheckbox);
      if (this._formIndirizzo?.valoreCheckbox == 'si') {
        for (let field of no_estero) {
          this._formIndirizzo?.formModificaIndirizzo.controls[field].clearValidators();
        }
        for (let field of estero) {
          this._formIndirizzo?.formModificaIndirizzo.controls[field].setValidators([Validators.required]);
        }
      }
      if (this._formIndirizzo?.valoreCheckbox == 'no') {
        for (let field of estero) {
          this._formIndirizzo?.formModificaIndirizzo.controls[field].clearValidators();
        }
        for (let field of no_estero) {
          this._formIndirizzo?.formModificaIndirizzo.controls[field].setValidators([Validators.required]);
        }
      }
      for (let field of fields) {
        this._formIndirizzo?.formModificaIndirizzo.controls[field].updateValueAndValidity();
      }
      if (!this._formIndirizzo?.valoreCheckbox) {
        //console.log("entrato: ",this._formIndirizzo?.valoreCheckbox);
        for (let field of fields) {
          this._formIndirizzo?.formModificaIndirizzo.controls[field].setValidators([Validators.required]);
          this._formIndirizzo?.formModificaIndirizzo.controls[field].updateValueAndValidity();
        }
      }
    }
  }

  //Funzione che prende dall'evento dell'onchange il valore del checkbox Estero dal component formIndirizzoMain
  //questo perchè il valore cambia ogni volta e devo controllarlo da qui per il problema della residenza
  prendiValoreEstero(event: any) {
    this.valoreEstero = event;
    console.log("estero passato al padre", this.valoreEstero);
  }

  ngAfterViewInit() {
    if (this.parix_soggetto) {
      this._formFigure?.formFigura.patchValue({
        cf: this.parix_soggetto.PERSONA_FISICA[0].CODICE_FISCALE[0]
      })
      this._formFigure?.checkCodiceFiscale({ target: { value: this.parix_soggetto.PERSONA_FISICA[0].CODICE_FISCALE[0] } }, this._formFigure.formFigura)
    }
  }

  goToPARIX() {
    let piva: any = null
    new Promise(resolve => {
      if (this._formFigure?.stabilimento) {
        piva = this._formFigure?.stabilimento.piva_impresa ?? this._formFigure?.stabilimento.cf_impresa
        resolve(true)
      } else if (this._id_stabilimento) {
        this.ans.getStabilimentoSingolo(this._id_stabilimento).subscribe(res => {
          resolve(true)
          if (res.info) {
            piva = res.info.dati[0].piva_impresa ?? res.info.dati[0].stabilimento.cf_impresa
          }
        })
      } else {
        resolve(true)
      }
    }).then(() => {
      if (this._id_impresa) {
        this._id_figura = null
      }
      this.router.navigate(['portali/anagrafica/allineamento-parix/figura'], { queryParams: { id_impresa: this._id_impresa, id_stabilimento: this._id_stabilimento, piva: piva, id_stabilimento_figura: this._id_figura } })
    })
  }
  //-----------------------GETTER E SETTER--------------------------
}

