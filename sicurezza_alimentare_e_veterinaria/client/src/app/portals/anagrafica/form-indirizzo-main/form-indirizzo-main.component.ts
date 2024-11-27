/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import {
  BackendCommunicationService,
  LoadingDialogService,
  NotificationService,
} from '@us/utils';
import { AnagraficaService } from '../anagrafica.service';

@Component({
  selector: 'app-form-indirizzo-main',
  templateUrl: './form-indirizzo-main.component.html',
  styleUrls: ['./form-indirizzo-main.component.scss'],
})
export class FormIndirizzoMainComponent implements OnInit {
  //---------------------VARIABILI------------------------------------
  private _id_preso?: any;
  labelBottone?: string;
  _id_stabilimento?: any;
  _id_impresa?: any;
  _id_soggetto_fisico?: any;
  @Input() _id_indirizzo_preso?: any;
  @Input() _labelBottone?: string;
  @Input() _id_stabilimento_preso?: any;
  @Input() _id_impresa_preso?: any;
  @Input() _id_soggetto_fisico_preso?: any;
  @Input() _id_cu_trasportatori_preso?: any;
  @Input() _flag: boolean = false;
  @Input() showButton: boolean = true;
  @Output() valueEmitted = new EventEmitter<any>();
  formModificaIndirizzo: FormGroup;
  private datiIndirizzo: any;
  private valoreEstero?: any;
  private _datiComuni?: any;
  private _datiNazioni?: any;
  private _datiToponimi?: any;
  private _istatComune?: any;
  private _datiIndirizzi?: any;
  flagCap: boolean = false;
  private _caps?: any;
  private comuneModifica: any;
  private toponimoModifica: any;
  //_--------------------------COSTRUTTORE----------------------------
  constructor(
    private fb: FormBuilder,
    private ComunicazioneDB: BackendCommunicationService,
    private LoadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private route: ActivatedRoute, //this.route.snapshot.url[0].path ritorna parte finale dell'url
    private router: Router,
    private cus: AnagraficaService
  ) {
    this.formModificaIndirizzo = this.fb.group({
      valore: this.fb.control(null, [Validators.required]),
      nazione: this.fb.control(null, [Validators.required]),
      stato_provincia: this.fb.control(null),
      comune: this.fb.control(null, [Validators.required]),
      comune_estero: this.fb.control(null),
      toponimo_estero: this.fb.control(null),
      indirizzo_estero: this.fb.control(null),
      civico_estero: this.fb.control(null),
      cap_estero: this.fb.control(null),
      toponimo: this.fb.control(null, [Validators.required]),
      indirizzo: this.fb.control(null, [Validators.required]),
      civico: this.fb.control(null, [Validators.required]),
      cap: this.fb.control(null, [Validators.required]),
      latitudine: this.fb.control(null),
      longitudine: this.fb.control(null),
    });
  }
  //--------------------------------------NGONINIT----------------------------
  ngOnInit(): void {
    //this.route.queryParams.subscribe((res : any) => {
    //console.log("res:",res);
    this.LoadingService.openDialog('Caricamento comuni...');
    // console.log(this.valoreResidenza);
    // this.labelBottone = res['labelBottone'];
    // this._id_preso = res['id_indirizzo'];
    this.labelBottone = this._labelBottone;
    this._id_preso = this._id_indirizzo_preso;
    // if(res['id_stabilimento']){
    //   this._id_stabilimento = res['id_stabilimento'];
    // }
    if (this._id_stabilimento_preso) {
      this._id_stabilimento = this._id_stabilimento_preso;
    }
    if (this._id_impresa_preso) {
      this._id_impresa = this._id_impresa_preso;
    }
    if (this._id_soggetto_fisico_preso) {
      this._id_soggetto_fisico = this._id_soggetto_fisico_preso;
    }
    console.log('id indirizzo', this._id_preso);
    console.log('label bottone', this.labelBottone);
    console.log('id_stabilimento', this._id_stabilimento);
    console.log('id_impresa', this._id_impresa_preso);
    console.log(this._flag);
    if (this._flag) {
      this.cus.getToponimi().subscribe((res: any) => {
        console.log(res);
        this._datiToponimi = res.info.dati;
      });
      this.cus.getComuniAssociati().subscribe((res: any) => {
        this._datiComuni = res.info.dati;
        if (!res.esito) {
          this.LoadingService.closeDialog();
          this.notificationService.push({
            notificationClass: 'warning',
            content: res.msg?.toLocaleUpperCase(),
          });
          return;
        }
        this.LoadingService.closeDialog();
        // this.formModificaIndirizzo.controls['comune_estero'].clearValidators();
        // this.formModificaIndirizzo.controls['toponimo_estero'].clearValidators();
        // this.formModificaIndirizzo.controls['indirizzo_estero'].clearValidators();
        // this.formModificaIndirizzo.controls['civico_estero'].clearValidators();
        // this.formModificaIndirizzo.controls['cap_estero'].clearValidators();
        this.formModificaIndirizzo.controls['valore'].clearValidators();
        this.formModificaIndirizzo.controls['nazione'].clearValidators();

        // this.formModificaIndirizzo.controls['comune_estero'].updateValueAndValidity();
        // this.formModificaIndirizzo.controls['toponimo_estero'].updateValueAndValidity();
        // this.formModificaIndirizzo.controls['indirizzo_estero'].updateValueAndValidity();
        // this.formModificaIndirizzo.controls['civico_estero'].updateValueAndValidity();
        // this.formModificaIndirizzo.controls['cap_estero'].updateValueAndValidity();
        this.formModificaIndirizzo.controls['valore'].updateValueAndValidity();
        this.formModificaIndirizzo.controls['nazione'].updateValueAndValidity();
        console.log('res comuni associati', res);
        this.ComunicazioneDB.getDati('get_cu_indirizzi', {
          id_indirizzo: parseInt(this._id_preso),
        }).subscribe((res: any) => {
          if (!res.esito) {
            return;
          }
          console.log('res indirizzi associati', res);
          this.datiIndirizzo = res.info.dati;
          //Setting del comune in base alla scelta dell'estero ed è nella fase di modifica, quindi che ho già tutti i dati
          //Settaggio dei validators
          this.formModificaIndirizzo.patchValue({
            comune:
              this.datiIndirizzo[0].comune != null
                ? this.datiIndirizzo[0].comune
                : null,
            toponimo:
              this.datiIndirizzo[0].toponimo != null
                ? this.datiIndirizzo[0].toponimo
                : null,
            indirizzo:
              this.datiIndirizzo[0].indirizzo != null
                ? this.datiIndirizzo[0].indirizzo
                : null,
            civico:
              this.datiIndirizzo[0].civico != null
                ? this.datiIndirizzo[0].civico
                : null,
            cap:
              this.datiIndirizzo[0].cap != null
                ? this.datiIndirizzo[0].cap
                : null,
            nazione: null,
            stato_provincia: null,
            latitudine:
              this.datiIndirizzo[0].latitudine != null
                ? this.datiIndirizzo[0].latitudine
                : null,
            longitudine:
              this.datiIndirizzo[0].longitudine != null
                ? this.datiIndirizzo[0].longitudine
                : null,
          });
          this.comuneModifica = this.datiComuni.filter((elem: any) => {
            return (
              elem.denominazione_it.toUpperCase() ===
              this.formModificaIndirizzo.value.comune.toUpperCase()
            );
          });
          this.toponimoModifica = this.datiToponimi.filter((elem: any) => {
            return (
              elem.descrizione ===
              this.formModificaIndirizzo.value.toponimo.toUpperCase()
            );
          });
          this.cus
            .getIndirizziPerComune({
              codice_istat: this.comuneModifica[0].codice_istat,
              toponimo: this.toponimoModifica[0].descrizione,
            })
            .subscribe((res: any) => {
              this._datiIndirizzi = res.info.dati;
            });
          if (this.comuneModifica[0].caps.length === 1) {
            this.flagCap = false;
            this.formModificaIndirizzo.controls['cap'].setValue(
              this.comuneModifica[0].caps[0]
            );
          } else {
            this.flagCap = true;
            this._caps = this.comuneModifica[0].caps;
          }
        });
      });
    } else {
      this.cus.getComuni().subscribe((res: any) => {
        if (!res.esito) {
          this.LoadingService.closeDialog();
          this.notificationService.push({
            notificationClass: 'warning',
            content: res.msg?.toLocaleUpperCase(),
          });
          return;
        }
        this.cus.getToponimi().subscribe((res: any) => {
          console.log(res);
          this._datiToponimi = res.info.dati;
        });
        this.cus.getNazioni().subscribe((res: any) => {
          console.log(res);
          this._datiNazioni = res.info.dati;
        });
        this.LoadingService.closeDialog();
        console.log('risultato comuni', res);
        this._datiComuni = res.info.calendari.dati;
        this.ComunicazioneDB.getDati('get_cu_indirizzi', {
          id_indirizzo: parseInt(this._id_preso),
        }).subscribe((res: any) => {
          if (!res.esito) {
            return;
          }
          console.log('res indirizzi', res);
          this.datiIndirizzo = res.info.dati;
          //Si va a fare la stessa cosa, nel secondo caso si prende lato DB direttamente il valore se è estero o meno.
          // this.formModificaIndirizzo.patchValue({
          //   valore: this.datiIndirizzo[0].istat_comune !== null ? 'no' : 'si',
          // })
          this.formModificaIndirizzo.patchValue({
            valore: this.datiIndirizzo[0].estero == false ? 'no' : 'si',
          });

          this.valoreEstero = this.formModificaIndirizzo?.value.valore;
          //Setting del comune in base alla scelta dell'estero ed è nella fase di modifica, quindi che ho già tutti i dati
          if (this.valoreEstero === 'si') {
            //Settaggio dei validators
            this.formModificaIndirizzo.controls['comune'].clearValidators();
            this.formModificaIndirizzo.controls['toponimo'].clearValidators();
            this.formModificaIndirizzo.controls['indirizzo'].clearValidators();
            this.formModificaIndirizzo.controls['civico'].clearValidators();
            this.formModificaIndirizzo.controls['cap'].clearValidators();
            this.formModificaIndirizzo.patchValue({
              comune_estero:
                this.datiIndirizzo[0].comune != null
                  ? this.datiIndirizzo[0].comune
                  : null,
              toponimo_estero:
                this.datiIndirizzo[0].toponimo != null
                  ? this.datiIndirizzo[0].toponimo
                  : null,
              indirizzo_estero:
                this.datiIndirizzo[0].indirizzo != null
                  ? this.datiIndirizzo[0].indirizzo
                  : null,
              civico_estero:
                this.datiIndirizzo[0].civico != null
                  ? this.datiIndirizzo[0].civico
                  : null,
              cap_estero:
                this.datiIndirizzo[0].cap != null
                  ? this.datiIndirizzo[0].cap
                  : null,
              nazione:
                this.datiIndirizzo[0].nazione != null
                  ? this.datiIndirizzo[0].nazione
                  : null,
              stato_provincia:
                this.datiIndirizzo[0].stato_prov != null
                  ? this.datiIndirizzo[0].stato_prov
                  : null,
            });
            this.formModificaIndirizzo.controls[
              'comune'
            ].updateValueAndValidity();
            this.formModificaIndirizzo.controls[
              'toponimo'
            ].updateValueAndValidity();
            this.formModificaIndirizzo.controls[
              'indirizzo'
            ].updateValueAndValidity();
            this.formModificaIndirizzo.controls[
              'civico'
            ].updateValueAndValidity();
            this.formModificaIndirizzo.controls['cap'].updateValueAndValidity();
          } else {
            //Settaggio dei validators
            // this.formModificaIndirizzo.controls['comune_estero'].clearValidators();
            // this.formModificaIndirizzo.controls['toponimo_estero'].clearValidators();
            // this.formModificaIndirizzo.controls['indirizzo_estero'].clearValidators();
            // this.formModificaIndirizzo.controls['civico_estero'].clearValidators();
            // this.formModificaIndirizzo.controls['cap_estero'].clearValidators();
            this.formModificaIndirizzo.controls['nazione'].clearValidators();
            this.formModificaIndirizzo.patchValue({
              comune:
                this.datiIndirizzo[0].comune != null
                  ? this.datiIndirizzo[0].comune
                  : null,
              toponimo:
                this.datiIndirizzo[0].toponimo != null
                  ? this.datiIndirizzo[0].toponimo
                  : null,
              indirizzo:
                this.datiIndirizzo[0].indirizzo != null
                  ? this.datiIndirizzo[0].indirizzo
                  : null,
              civico:
                this.datiIndirizzo[0].civico != null
                  ? this.datiIndirizzo[0].civico
                  : null,
              cap:
                this.datiIndirizzo[0].cap != null
                  ? this.datiIndirizzo[0].cap
                  : null,
              nazione: null,
              stato_provincia: null,
              latitudine:
                this.datiIndirizzo[0].latitudine != null
                  ? this.datiIndirizzo[0].latitudine
                  : null,
              longitudine:
                this.datiIndirizzo[0].longitudine != null
                  ? this.datiIndirizzo[0].longitudine
                  : null,
            });
            // this.formModificaIndirizzo.controls['comune_estero'].updateValueAndValidity();
            // this.formModificaIndirizzo.controls['toponimo_estero'].updateValueAndValidity();
            // this.formModificaIndirizzo.controls['indirizzo_estero'].updateValueAndValidity();
            // this.formModificaIndirizzo.controls['civico_estero'].updateValueAndValidity();
            // this.formModificaIndirizzo.controls['cap_estero'].updateValueAndValidity();
            this.formModificaIndirizzo.controls[
              'nazione'
            ].updateValueAndValidity();
            this.comuneModifica = this.datiComuni.filter((elem: any) => {
              return (
                elem.denominazione_it.toUpperCase() ===
                this.formModificaIndirizzo.value.comune.toUpperCase()
              );
            });
            this.toponimoModifica = this.datiToponimi.filter((elem: any) => {
              return (
                elem.descrizione ===
                this.formModificaIndirizzo.value.toponimo.toUpperCase()
              );
            });
            this.cus
              .getIndirizziPerComune({
                codice_istat: this.comuneModifica[0].codice_istat,
                toponimo: this.toponimoModifica[0].descrizione,
              })
              .subscribe((res: any) => {
                this._datiIndirizzi = res.info.dati;
              });
            if (this.comuneModifica[0].caps.length === 1) {
              this.flagCap = false;
              this.formModificaIndirizzo.controls['cap'].setValue(
                this.comuneModifica[0].caps[0]
              );
            } else {
              this.flagCap = true;
              this._caps = this.comuneModifica[0].caps;
            }
          }
        });
      });
    }
    // })
  }
  //------------------------------------FUNZIONI-----------------------------
  //Funzione che prende il valore della checkbox
  checkValore(evt: any) {
    this.valoreEstero = evt.target.value;
    //console.log("valore della checkbox", this.valoreEstero);
    //Per settare i validator in base alla scelta dell'estero e mi serve nella situazione iniziale, ovvero che è un indirizzo nuovo
    if (this.valoreEstero === 'no') {
      //Settaggio dei validators se non è estero
      // this.formModificaIndirizzo.controls['comune_estero'].clearValidators();
      // this.formModificaIndirizzo.controls['toponimo_estero'].clearValidators();
      // this.formModificaIndirizzo.controls['indirizzo_estero'].clearValidators();
      // this.formModificaIndirizzo.controls['civico_estero'].clearValidators();
      // this.formModificaIndirizzo.controls['cap_estero'].clearValidators();
      this.formModificaIndirizzo.controls['nazione'].clearValidators();
      this.formModificaIndirizzo.controls['comune'].setValidators([
        Validators.required,
      ]);
      this.formModificaIndirizzo.controls['toponimo'].setValidators([
        Validators.required,
      ]);
      this.formModificaIndirizzo.controls['indirizzo'].setValidators([
        Validators.required,
      ]);
      this.formModificaIndirizzo.controls['civico'].setValidators([
        Validators.required,
      ]);
      this.formModificaIndirizzo.controls['cap'].setValidators([
        Validators.required,
      ]);
    }
    // this.formModificaIndirizzo.controls['comune_estero'].updateValueAndValidity();
    // this.formModificaIndirizzo.controls['toponimo_estero'].updateValueAndValidity();
    // this.formModificaIndirizzo.controls['indirizzo_estero'].updateValueAndValidity();
    // this.formModificaIndirizzo.controls['civico_estero'].updateValueAndValidity();
    // this.formModificaIndirizzo.controls['cap_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['nazione'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['comune'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['toponimo'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['indirizzo'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['civico'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['cap'].updateValueAndValidity();
    if (this.valoreEstero === 'si') {
      //settaggio dei validators se è estero
      this.formModificaIndirizzo.controls['comune'].clearValidators();
      this.formModificaIndirizzo.controls['toponimo'].clearValidators();
      this.formModificaIndirizzo.controls['indirizzo'].clearValidators();
      this.formModificaIndirizzo.controls['civico'].clearValidators();
      this.formModificaIndirizzo.controls['cap'].clearValidators();
      // this.formModificaIndirizzo.controls['comune_estero'].setValidators([Validators.required]);
      // this.formModificaIndirizzo.controls['toponimo_estero'].setValidators([Validators.required]);
      // this.formModificaIndirizzo.controls['indirizzo_estero'].setValidators([Validators.required]);
      // this.formModificaIndirizzo.controls['civico_estero'].setValidators([Validators.required]);
      // this.formModificaIndirizzo.controls['cap_estero'].setValidators([Validators.required]);
      this.formModificaIndirizzo.controls['nazione'].setValidators([
        Validators.required,
      ]);
    }
    // this.formModificaIndirizzo.controls['comune_estero'].updateValueAndValidity();
    // this.formModificaIndirizzo.controls['toponimo_estero'].updateValueAndValidity();
    // this.formModificaIndirizzo.controls['indirizzo_estero'].updateValueAndValidity();
    // this.formModificaIndirizzo.controls['civico_estero'].updateValueAndValidity();
    // this.formModificaIndirizzo.controls['cap_estero'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['nazione'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['comune'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['toponimo'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['indirizzo'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['civico'].updateValueAndValidity();
    this.formModificaIndirizzo.controls['cap'].updateValueAndValidity();
    this.valueEmitted.emit(this.valoreEstero);
  }

  updIndirizzo(
    id_indirizzo?: number,
    flag_cod_regionale?: boolean | null,
    params?: any | null
  ) {
    if (!this.formModificaIndirizzo) {
      return;
    }
    if (id_indirizzo) {
      this._id_preso = id_indirizzo;
    }

    console.log('parametri presi', params);
    if (this._flag) {
      // if ((!this._datiComuni.map((elem: any) => elem.denominazione_it).includes(this.formModificaIndirizzo.value.comune.toUpperCase())) || (!this._datiToponimi.map((elem: any) => elem.descrizione).includes(this.formModificaIndirizzo.value.toponimo.toUpperCase()))) {
      //   this.notificationService.push({
      //     notificationClass: 'warning',
      //     content: "Attenzione! Comune o Toponimo non inserito correttamente."
      //   });
      //   return;
      // }
      if (
        !this._datiComuni
          .map((elem: any) => elem.denominazione_it)
          .includes(this.formModificaIndirizzo.value.comune.toUpperCase())
      ) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: 'Attenzione! Comune non inserito correttamente.',
        });
        return;
      } else if (
        !this._datiToponimi
          .map((elem: any) => elem.descrizione)
          .includes(this.formModificaIndirizzo.value.toponimo.toUpperCase())
      ) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: 'Attenzione! Toponimo non inserito correttamente.',
        });
        return;
      } else {
        //Utilizzo il filter per andare a prendere il comune corrispondente inserito per estrapolare successivamente il codistat
        this._istatComune = this._datiComuni.filter((elem: any) => {
          return (
            elem.denominazione_it.toUpperCase() ===
            this.formModificaIndirizzo.value.comune.toUpperCase()
          );
        });
        console.log(this._istatComune);
        params.comune = this.formModificaIndirizzo.value.comune.toUpperCase();
        params.toponimo = this.formModificaIndirizzo.value.toponimo;
        params.indirizzo = this.formModificaIndirizzo.value.indirizzo;
        params.civico = this.formModificaIndirizzo.value.civico;
        params.cap = this.formModificaIndirizzo.value.cap;
        params.istat_comune =
          this._istatComune[0].codice_istat != null
            ? this._istatComune[0].codice_istat
            : null;
        params.latitudine = this.formModificaIndirizzo.value.latitudine;
        params.longitudine = this.formModificaIndirizzo.value.longitudine;

        console.log('parametri finali:', params);
        if (params['nome_function'] === 'upd_cu_add_stabilimento') {
          this.cus.addStabilimento(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            this._id_stabilimento = res.info.id_stabilimento;
            if (flag_cod_regionale) {
              this.cus
                .updSetCodiceStabilimento(this._id_stabilimento)
                .subscribe((res: any) => {
                  console.log(res);
                });
            }
            if (this._id_stabilimento) {
              console.log('valorizzato: ', this._id_stabilimento);
              setTimeout(() => {
                this.router.navigate(
                  ['portali', 'anagrafica', 'stabilimenti', 'dettaglio'],
                  { queryParams: { id_stabilimento: +this._id_stabilimento } }
                );
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_stabilimenti') {
          params.id_indirizzo = this._id_preso;
          this.cus.updStabilimento(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_stabilimento) {
              console.log('valorizzato: ', this._id_stabilimento);
              setTimeout(() => {
                this.router.navigate(
                  ['portali', 'anagrafica', 'stabilimenti', 'dettaglio'],
                  { queryParams: { id_stabilimento: +this._id_stabilimento } }
                );
              }, 1500);
            }
          });
        }

        if (params['nome_function'] === 'upd_add_indirizzi_trasportatori') {
          this.cus.addIndirizziTrasportatori(params).subscribe((res) => {
            if (res.esito) {
              window.location.reload();
            }
          });
        }
        if (params['nome_function'] === 'upd_upd_indirizzi_trasportatori') {
          params.id_indirizzo = this._id_preso;
          this.cus.addIndirizziTrasportatori(params).subscribe((res) => {
            if (res.esito) {
              window.location.reload();
            }
          });
        }
      }
    } else {
      if (this.valoreEstero === 'no') {
        if (
          !this._datiComuni
            .map((elem: any) => elem.denominazione_it)
            .includes(this.formModificaIndirizzo.value.comune.toUpperCase())
        ) {
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Attenzione! Comune non inserito correttamente.',
          });
          return;
        }
        if (
          !this._datiToponimi
            .map((elem: any) => elem.descrizione)
            .includes(this.formModificaIndirizzo.value.toponimo.toUpperCase())
        ) {
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Attenzione! Toponimo non inserito correttamente.',
          });
          return;
        }
        this._istatComune = this._datiComuni.filter((elem: any) => {
          return (
            elem.denominazione_it.toUpperCase() ===
            this.formModificaIndirizzo.value.comune.toUpperCase()
          );
        });
        console.log(this._istatComune);
        params.comune = this.formModificaIndirizzo.value.comune.toUpperCase();
        params.toponimo = this.formModificaIndirizzo.value.toponimo;
        params.indirizzo = this.formModificaIndirizzo.value.indirizzo;
        params.civico = this.formModificaIndirizzo.value.civico;
        params.cap = this.formModificaIndirizzo.value.cap;
        params.istat_comune =
          this._istatComune[0].codice_istat != null
            ? this._istatComune[0].codice_istat
            : null;
        params.latitudine = this.formModificaIndirizzo.value.latitudine;
        params.longitudine = this.formModificaIndirizzo.value.longitudine;

        if (params['nome_function'] === 'upd_cu_upd_stabilimenti_sedi') {
          params.id_indirizzo = this._id_preso;
          this.cus.updSede(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_stabilimento) {
              console.log('valorizzato: ', this._id_stabilimento);
              setTimeout(() => {
                this.router.navigate(
                  ['portali', 'anagrafica', 'stabilimenti', 'dettaglio'],
                  { queryParams: { id_stabilimento: +this._id_stabilimento } }
                );
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_add_stabilimenti_sedi') {
          this.cus.addSede(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_stabilimento) {
              console.log('valorizzato: ', this._id_stabilimento);
              setTimeout(() => {
                this.router.navigate(
                  ['portali', 'anagrafica', 'stabilimenti', 'dettaglio'],
                  { queryParams: { id_stabilimento: +this._id_stabilimento } }
                );
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_upd_stabilimenti_figure') {
          params.id_indirizzo = this._id_preso;
          this.cus.updFigura(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_stabilimento) {
              console.log('valorizzato: ', this._id_stabilimento);
              setTimeout(() => {
                this.router.navigate(
                  ['portali', 'anagrafica', 'stabilimenti', 'dettaglio'],
                  { queryParams: { id_stabilimento: +this._id_stabilimento } }
                );
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_add_stabilimenti_figure') {
          this.cus.addFigura(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_stabilimento) {
              console.log('valorizzato: ', this._id_stabilimento);
              setTimeout(() => {
                this.router.navigate(
                  ['portali', 'anagrafica', 'stabilimenti', 'dettaglio'],
                  { queryParams: { id_stabilimento: +this._id_stabilimento } }
                );
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_upd_imprese_sedi') {
          params.id_indirizzo = this._id_preso;
          this.cus.updSedeImpresa(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_impresa) {
              console.log('valorizzato: ', this._id_impresa);
              setTimeout(() => {
                this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], {
                  queryParams: { id_impresa: +this._id_impresa },
                });
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_add_imprese_sedi') {
          console.log('upd_cu_add_imprese_sedi');
          this.cus.addSedeImpresa(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_impresa) {
              console.log('valorizzato: ', this._id_impresa);
              setTimeout(() => {
                this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], {
                  queryParams: { id_impresa: +this._id_impresa },
                });
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_upd_imprese_figure') {
          params.id_indirizzo = this._id_preso;
          this.cus.updFiguraImpresa(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_impresa) {
              console.log('valorizzato: ', this._id_impresa);
              setTimeout(() => {
                this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], {
                  queryParams: { id_impresa: +this._id_impresa },
                });
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_add_imprese_figure') {
          this.cus.addFiguraImpresa(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_impresa) {
              console.log('valorizzato: ', this._id_impresa);
              setTimeout(() => {
                this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], {
                  queryParams: { id_impresa: +this._id_impresa },
                });
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_soggetti_fisici') {
          params.id_indirizzo = this._id_preso;
          this.cus.updSoggettoFisico(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_soggetto_fisico) {
              console.log('valorizzato: ', this._id_soggetto_fisico);
              if (params.id_impresa_parix) {
                if (params.id_figura_parix) {
                  //modifica figura
                  setTimeout(() => {
                    this.router.navigate(
                      ['portali/anagrafica/allineamento-parix/figura/modifica'],
                      {
                        queryParams: {
                          id_impresa_figura: params.id_figura_parix,
                          parix_soggetto: JSON.stringify(params.parix_soggetto),
                        },
                      }
                    );
                  }, 1500);
                } else {
                  //aggiungi figura
                  setTimeout(() => {
                    this.router.navigate(
                      ['portali/anagrafica/allineamento-parix/figura/aggiungi'],
                      {
                        queryParams: {
                          id_impresa: params.id_impresa_parix,
                          parix_soggetto: JSON.stringify(params.parix_soggetto),
                        },
                      }
                    );
                  }, 1500);
                }
              } else {
                setTimeout(() => {
                  this.router.navigate(
                    ['portali', 'anagrafica', 'soggetti-fisici', 'dettaglio'],
                    {
                      queryParams: {
                        id_soggetto_fisico: +this._id_soggetto_fisico,
                      },
                    }
                  );
                }, 1500);
              }
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_add_soggetti_fisici') {
          this.cus.addSoggettoFisico(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            this._id_soggetto_fisico = res.info.id_soggetto_fisico;
            if (this._id_soggetto_fisico) {
              console.log('valorizzato: ', this._id_soggetto_fisico);
              if (params.id_impresa_parix || params.id_stabilimento_parix) {
                setTimeout(() => {
                  this.router.navigate(
                    ['portali/anagrafica/allineamento-parix/figura/aggiungi'],
                    {
                      queryParams: {
                        id_stabilimento: params.id_stabilimento_parix,
                        id_impresa: params.id_impresa_parix,
                        parix_soggetto: JSON.stringify(params.parix_soggetto),
                      },
                    }
                  );
                }, 1500);
              } else if (params['returnTo']) {
                //returnTo - url costruito in soggetti-upsert.component.ts
                console.log('returnTo', params['returnTo'])
                this.router.navigateByUrl(params['returnTo'])
              } else {
                setTimeout(() => {
                  this.router.navigate(
                    ['portali', 'anagrafica', 'soggetti-fisici', 'dettaglio'],
                    {
                      queryParams: {
                        id_soggetto_fisico: +this._id_soggetto_fisico,
                      },
                    }
                  );
                }, 1500);
              }
            }
          });
        }
      } else {
        // || (!this._datiToponimi.map((elem: any) => elem.descrizione).includes(this.formModificaIndirizzo.value.toponimo_estero.toUpperCase()))
        if (
          !this._datiNazioni
            .map((elem: any) => elem.descrizione_upper)
            .includes(this.formModificaIndirizzo.value.nazione.toUpperCase())
        ) {
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Attenzione! Nazione non inserita correttamente.',
          });
          return;
        }
        params.nazione = this.formModificaIndirizzo.value.nazione;
        params.stato_provincia =
          this.formModificaIndirizzo.value.stato_provincia;
        params.comune =
          this.formModificaIndirizzo.value.comune_estero?.toUpperCase();
        params.toponimo = this.formModificaIndirizzo.value.toponimo_estero;
        params.indirizzo = this.formModificaIndirizzo.value.indirizzo_estero;
        params.civico = this.formModificaIndirizzo.value.civico_estero;
        params.cap = this.formModificaIndirizzo.value.cap_estero;
        params.istat_comune = null;
        if (params['nome_function'] === 'upd_cu_upd_stabilimenti_sedi') {
          params.id_indirizzo = this._id_preso;
          this.cus.updSede(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_stabilimento) {
              console.log('valorizzato: ', this._id_stabilimento);
              setTimeout(() => {
                this.router.navigate(
                  ['portali', 'anagrafica', 'stabilimenti', 'dettaglio'],
                  { queryParams: { id_stabilimento: +this._id_stabilimento } }
                );
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_add_stabilimenti_sedi') {
          this.cus.addSede(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_stabilimento) {
              console.log('valorizzato: ', this._id_stabilimento);
              setTimeout(() => {
                this.router.navigate(
                  ['portali', 'anagrafica', 'stabilimenti', 'dettaglio'],
                  { queryParams: { id_stabilimento: +this._id_stabilimento } }
                );
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_upd_imprese_sedi') {
          params.id_indirizzo = this._id_preso;
          this.cus.updSedeImpresa(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_impresa) {
              console.log('valorizzato: ', this._id_impresa);
              setTimeout(() => {
                this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], {
                  queryParams: { id_impresa: +this._id_impresa },
                });
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_add_imprese_sedi') {
          this.cus.addSedeImpresa(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_impresa) {
              console.log('valorizzato: ', this._id_impresa);
              setTimeout(() => {
                this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], {
                  queryParams: { id_impresa: +this._id_impresa },
                });
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_upd_imprese_figure') {
          params.id_indirizzo = this._id_preso;
          this.cus.updFiguraImpresa(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_impresa) {
              console.log('valorizzato: ', this._id_impresa);
              setTimeout(() => {
                this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], {
                  queryParams: { id_impresa: +this._id_impresa },
                });
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_add_imprese_figure') {
          this.cus.addFiguraImpresa(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_impresa) {
              console.log('valorizzato: ', this._id_impresa);
              setTimeout(() => {
                this.router.navigate(['portali', 'anagrafica', 'imprese', 'dettaglio'], {
                  queryParams: { id_impresa: +this._id_impresa },
                });
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_upd_stabilimenti_figure') {
          params.id_indirizzo = this._id_preso;
          this.cus.updFigura(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_stabilimento) {
              console.log('valorizzato: ', this._id_stabilimento);
              setTimeout(() => {
                this.router.navigate(
                  ['portali', 'anagrafica', 'stabilimenti', 'dettaglio'],
                  { queryParams: { id_stabilimento: +this._id_stabilimento } }
                );
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_add_stabilimenti_figure') {
          this.cus.addFigura(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_stabilimento) {
              console.log('valorizzato: ', this._id_stabilimento);
              setTimeout(() => {
                this.router.navigate(
                  ['portali', 'anagrafica', 'stabilimenti', 'dettaglio'],
                  { queryParams: { id_stabilimento: +this._id_stabilimento } }
                );
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_soggetti_fisici') {
          params.id_indirizzo = this._id_preso;
          this.cus.updSoggettoFisico(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            if (this._id_soggetto_fisico) {
              console.log('valorizzato: ', this._id_soggetto_fisico);
              setTimeout(() => {
                this.router.navigate(
                  ['portali', 'anagrafica', 'soggetti-fisici', 'dettaglio'],
                  {
                    queryParams: {
                      id_soggetto_fisico: +this._id_soggetto_fisico,
                    },
                  }
                );
              }, 1500);
            }
          });
        }
        if (params['nome_function'] === 'upd_cu_add_soggetti_fisici') {
          this.cus.addSoggettoFisico(params).subscribe((res: any) => {
            console.log(res);
            if (!res.esito) {
              return;
            }
            setTimeout(() => {
              this.router.navigate(['portali', 'anagrafica', 'soggetti-fisici']);
            }, 1500);
          });
        }
      }
    }
  }

  patchValue(evt: Event, field: string): void {
    this.formModificaIndirizzo.get(field)?.setValue(evt);
    let toponimo = [];
    if (!this.formModificaIndirizzo.value.comune) {
      return;
    }
    let comune = this.datiComuni.filter((elem: any) => {
      return (
        elem.denominazione_it.toUpperCase() ===
        this.formModificaIndirizzo.value.comune.toUpperCase()
      );
    });
    if (this.formModificaIndirizzo.value.toponimo) {
      toponimo = this._datiToponimi.filter((elem: any) => {
        return (
          elem.descrizione ===
          this.formModificaIndirizzo.value.toponimo.toUpperCase()
        );
      });
    }
    if (field == 'comune') {
      if (comune[0].caps.length === 1) {
        this.flagCap = false;
        this.formModificaIndirizzo.controls['cap'].setValue(comune[0].caps[0]);
      } else {
        this.flagCap = true;
        this._caps = comune[0].caps;
      }
    }
    this.cus
      .getIndirizziPerComune({
        codice_istat: comune[0].codice_istat,
        toponimo: toponimo[0].descrizione,
      })
      .subscribe((res: any) => {
        this._datiIndirizzi = res.info.dati;
      });
  }

  geoLocalizzazione() {
    if (!this.formModificaIndirizzo.valid) {
      return;
    }
    const params = {
      comune: this.formModificaIndirizzo.value.comune.toUpperCase(),
      toponimo: this.formModificaIndirizzo.value.toponimo,
      indirizzo: this.formModificaIndirizzo.value.indirizzo,
      civico: this.formModificaIndirizzo.value.civico,
      cap: this.formModificaIndirizzo.value.cap,
    };
    this.cus.geolocalizzaIndirizzo(params).subscribe((res: any) => {
      console.log('risposta client', res);
      if (res.esito) {
        this.formModificaIndirizzo.controls['latitudine'].setValue(res.data[0]);
        this.formModificaIndirizzo.controls['longitudine'].setValue(
          res.data[1]
        );
      }
    });
  }

  //------------------------------GETTER E SETTER-------------------------------------
  get valoreCheckbox() {
    return this.valoreEstero;
  }
  get datiComuni() {
    return this._datiComuni;
  }
  get datiNazioni() {
    return this._datiNazioni;
  }
  get datiToponimi() {
    return this._datiToponimi;
  }
  get datiIndirizzi() {
    return this._datiIndirizzi;
  }
  get caps() {
    return this._caps;
  }
}
