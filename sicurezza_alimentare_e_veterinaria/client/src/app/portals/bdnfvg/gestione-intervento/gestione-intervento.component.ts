/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ASmartTableComponent, LoadingDialogService, NotificationService, Utils } from '@us/utils';
import { Location, formatDate } from '@angular/common';
import { InterventiService } from '../services';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { PreaccettazioniService } from '../services';
import * as bootstrap from 'bootstrap';
import { AppService } from 'src/app/app.service';

const THREEDAYS: number = 3;

@Component({
  selector: 'app-gestione-intervento',
  templateUrl: './gestione-intervento.component.html',
  styleUrls: ['./gestione-intervento.component.scss']
})
export class GestioneInterventoComponent implements OnInit {
  private _info?: any;
  private _info_intervento: any[] = [];
  private _info_preaccettazione?: any;
  private _list_info: any = {};
  private _tot_capi?: any;
  private _tot_capannoni?: any;
  private _at_least_one?: boolean;
  btnNuovaRaccolta?: boolean = true;
  isAperto: boolean = false;
  isDaAprire: boolean = false;
  private _giornate?: any;
  private _ui?: any;
  private _firstDate?: any;
  private _veterinari?: any;
  private _ui_veterinari?: any;
  // private _selectedVeterinari?: number[] = [];
  _vet_intervento?: string = '';
  // private _showVet: boolean = false;
  private _matrici_piano?: any;
  private _laboratori?: any;
  //private _tipi_matrice: any = [];
  private _tipi_metodo: any = [];
  private _noteSave: any;
  allevamenti: any[] = [];
  private userData: any;

  // modaleNuovaGiornataRef?: NgbModalRef;
  private modalNuovaGiornata?: bootstrap.Modal;

  showInputDate: boolean = false;
  _newDay = new FormControl('', Validators.required);
  _tipoMetodoForm = new FormControl(null);
  _tipoMatriceForm = new FormControl(null, Validators.required);
  allevamentoForm = new FormControl(null, Validators.required);

  oldDateValue?: string;
  currentDateValue?: string;

  formIntervento!: FormGroup;
  formInterventoNote!: FormGroup;

  @ViewChild('tableVeterinari') table_veterinari?: ASmartTableComponent;

  constructor(
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private _location: Location,
    private _is: InterventiService,
    private modalEngine: NgbModal,
    private fb: FormBuilder,
    private router: Router,
    private pas: PreaccettazioniService,
    private app: AppService
  ) {
    this._newDay.valueChanges.subscribe((v: any) => {
      this.currentDateValue = v;
      console.log("Valore Cambiato:", v);
    });

    this.formIntervento = this.fb.group({
      // id_matrice: this.fb.control(null, Validators.required),
      id_laboratorio: this.fb.control(null, Validators.required)
    });
    this.formInterventoNote = this.fb.group({
      note: this.fb.control(null),
      dataInizio: this.fb.control(null, Validators.required),
      dataFine: this.fb.control(null, Validators.required)
    });
  }

  /**
   * Recupera info intervento e le giornate di quell'intervento
   */
  ngOnInit(): void {
    // Istanzia l'oggetto della modal
    this.loadingService.openDialog('Caricamento intervento');
    this.route.queryParams.subscribe((params: any) => {
      this._is.getInfoIntervento(parseInt(params['id_intervento'])).subscribe((data: any) => {
        console.log("data:", data);
  
        this._info = data.info;
        console.log("this._info:", this._info);
  
        this._info_intervento = data.info.dati_info;
        console.log("this._info_intervento:", this._info_intervento);
        setTimeout(() => {
          this.modalNuovaGiornata = new bootstrap.Modal('#nuova-giornata-modal');
        }, 100)

        this._info_preaccettazione = data.info.preaccettazione;
        console.log("this._info_preaccettazione:", this._info_preaccettazione);
  
        this.isAperto = true;
        this.isDaAprire = false;
        if(this._info_intervento[0].descr_stato !== 'In corso'){
          this.btnNuovaRaccolta = false;
          this.isAperto = false;
        }
  
        if(this._info_intervento[0].descr_stato == 'Programmato'){
          this.isDaAprire = true;
        }
  
        console.log("isAperto", this.isAperto)
        console.log("isDaAprire", this.isDaAprire)
  
        if(this._info_intervento[0].descr_stato === 'Chiuso'){
          this.btnNuovaRaccolta = false;
        }
  
        this._vet_intervento = data.info.vet_intervento_nomi;
        
        this._tot_capi = data.info.tot;
        console.log("_tot_capi:", this._tot_capi);
  
        this._tot_capannoni = data.info.tot_capannoni;
        console.log("this._tot_capannoni:", this._tot_capannoni);
  
        this._at_least_one = data.info.at_least_one;
        console.log("this._at_least_one:", this._at_least_one);
  
        this._matrici_piano = data.info.piano_matrici;
        console.log("this._matrici_piano:", this._matrici_piano);
  
        if (!this._info_intervento[0]?.id_intervento) return;
  
        const isNull = (currentValue: any) => currentValue == null;
        if (!this._info_intervento.every(isNull)) {
          this._list_info['Esito Risultati'] = this._info_intervento.map((i: any) => i.descr_esito).join('; ');
        }
  
        this._list_info = {
          'Stato': this._info_intervento[0].descr_stato,
          'Piano': [...new Set(this._info_intervento.map((i: any) => i.piano))].join('; '),
          'Data Programmata': formatDate(this._info_intervento[0].dt, 'dd/MM/yyyy', 'en'),
          'Indirizzo': this._info_intervento[0].indirizzo_azienda,
          'Località': this._info_intervento[0].localita,
          // 'Esito Risultati': this._info_intervento.map((i: any) => i.descr_esito).join('; '),
          'CUN': this._info_intervento[0].account_number,
          //'Orientamento Produttivo': this._info_intervento[0].orientamento_prod,
          'Totale Capi': this._tot_capi,
          'Totale Capannoni': this._tot_capannoni,
          'Laboratorio': this._info_intervento[0].descr_laboratorio
        };
  
        console.log("this._list_info:", this._list_info);
  
        this._tipi_metodo = [];
        let _tipi_metodo_tmp: any[] = [];
  
        for (const ii of this._info_intervento) {
          console.log("ii", ii);
          if (_tipi_metodo_tmp.indexOf(JSON.stringify({
            id_tipo_metodo: ii.id_tipo_metodo,
            //descr_metodo: ii.descr_metodo
            descr_metodo: ii.descr_metodo_piano
          })) < 0) {
            _tipi_metodo_tmp.push(JSON.stringify({
              id_tipo_metodo: ii.id_tipo_metodo,
              // descr_metodo: ii.descr_metodo
              descr_metodo: ii.descr_metodo_piano
            }));
            this._tipi_metodo.push({
              id_tipo_metodo: ii.id_tipo_metodo,
              // descr_metodo: ii.descr_metodo
              descr_metodo: ii.descr_metodo_piano
            });
          }
        }
  
        console.log("this._tipi_metodo:", this._tipi_metodo);
  
        this.allevamenti = this._info.rt_allevamenti;
  
        console.log("this.allevamenti:", this.allevamenti);
  
        // Giornate dell'intervento
        this._is.getGiornate(parseInt(this._info_intervento[0].id_intervento)).subscribe((res: any) => {
          this.loadingService.closeDialog();
          console.log("res:", res);
          if (!res.esito) {
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Attenzione! Errore nel caricamento dei dati.'
            });
            return;
          }
  
          if (res.info && res.info !== true) {
            this._giornate = res.info.dati;
            //console.log("giornate prese:", this._giornate);
            if(this._giornate){
              console.log("this._giornate:", this._giornate);
              
              const _dates: any = this._giornate.map((d: any) => new Date(d.dt).setHours(0, 0, 0, 0));
              console.log("_dates:", _dates);
              
              const first: number = Math.min(..._dates);
              this._firstDate = formatDate(new Date(first).setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
              console.log("this._firstDate:", this._firstDate);
              
              this._ui = res.info.ui;
              console.log("this._ui:", this._ui);
              
              if (this._info_intervento[0].descr_metodo != 'Pool') {
                this._ui.colonne = this._ui.colonne.filter((obj: any) => {
                  return obj.campo !== 'n_pool';
                });
              }
            }
            else {
              this._giornate = null;
              //console.log("giornata se non è valorizzato:",this._giornate);
            }
          }
        });
  
        // Recupera Laboratori
        this._is.getLaboratori().subscribe((res: any) => {
          console.log("res:", res);
          if (!res.esito) return;
          this._laboratori = res.info;
        })
        // Per andare a prendere le note inserite nell'intervento
        this._is.getInterventiNote(parseInt(this._info_intervento[0].id_intervento)).subscribe((res: any) => {
          if (!res.esito) return;
          if (!res.info) return;
          console.log("res get note:", res);
          this._noteSave = res.info.dati.map((elem : any) => elem.note);
         // console.log("note prese: ",this._noteSave);
  
          this.formInterventoNote.setValue({note: this._noteSave[0], dataInizio: this._info_intervento[0].dt, dataFine: this._info_intervento[0].dt_fine})
        })
  
      })
    });
    // Info Intervento
  }

  /**
   * Cambia lo stato dell'intervento da "Programmato" a "In corso" e chiama
   * nuovamente le informazioni dell'intervento per visualizzare l'aggiornamento
   * dello stato.
   */
  apriIntervento(): void {
    console.log(this.formIntervento.value);
    if(!this.formIntervento.value.id_laboratorio || this.formIntervento.value.id_laboratorio === "null"){
      this.notificationService.push({
        notificationClass: 'warning',
        content: "Attenzione! Inserire il laboratorio."
      });
      return;
    }
    const params = {
      id_intervento: parseInt(this._info_intervento[0].id_intervento),
      ...this.formIntervento.value
    };

    console.log("params:", params);
    this.loadingService.openDialog('Apertura intervento');
    this._is.updInterventoApri(params).subscribe((res: any) => {
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: "Attenzione! Errore durante apertura."
        });
        this.loadingService.closeDialog();
        return;
      }
      window.location.reload();
    })
  }

  // Invia id intervento per creare codice preaccettazione
  sendData(): void {
    //const filename: string = `scheda_accompagnamento_campioni_${this.info_intervento[0].id_intervento}.pdf`;

    console.log("this._vet_intervento:", this._vet_intervento);
    console.log("this._giornate:", this._giornate);
    const vetRaccolte: any = [];
    for (const g of this._giornate) {
      vetRaccolte.push({
        raccolta: g.id_giornata,
        vet: this.vet_intervento
      });
    }

    const params: any = {
      id_intervento: this.info_intervento[0].id_intervento,
      vet_intervento: [this._vet_intervento],
      vet_raccolte: vetRaccolte,
      //filename: filename,
      note: this._noteSave
    };

    console.log("\nparams:", params);

    this.loadingService.openDialog('Invio dei dati in corso...');
    this.pas.creaPreaccettazione(this._info_intervento[0].id_intervento).subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: res.msg
        });
        return;
      }
      /*this.notificationService.push({
        notificationClass: 'success',
        content: 'Invio dati avvenuto con successo.'
      });*/

      /*this.loadingService.openDialog('Preaccettazione in corso...');
      this._is.callIZSVEJob().subscribe((res: any) => {
        this.loadingService.closeDialog();
        console.log("res:", res);
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: `Attenzione! Errore durante la preaccetazione`
          });
          return;
        }*/
        this.notificationService.push({
          notificationClass: 'success',
          content: `Preaccettazione avvenuta con successo`
        });

        this.loadingService.openDialog('Caricamento PDF in corso...');
        this._is.generaRiepilogoIntervento(params).subscribe((res: any) => {
          console.log("res:", res);
          this.loadingService.closeDialog();

          
          /*if (!res.esito) {
            this.notificationService.push({
              notificationClass: 'error',
              content: `Attenzione! ${res.msg}`
            });
            return;
          }*/
          

          this._is.getPDFFromDB({ //filename: filename,
             id_intervento: parseInt(this._info_intervento[0].id_intervento) }).subscribe((data: any) => {
            Utils.download(data.body, `${data.headers.get('content-disposition').split('filename="')[1].replaceAll('"', '')}`)
            window.location.reload();
          });
        });

      //});
    });
  }

  downloadPDF(){
   // const filename: string = `scheda_accompagnamento_campioni_${this.info_intervento[0].id_intervento}.pdf`;
    this.loadingService.openDialog('Download PDF in corso...');
    this._is.getPDFFromDB({ //filename: filename, 
      id_intervento: parseInt(this._info_intervento[0].id_intervento) }).subscribe((data: any) => {
      Utils.download(data.body, `${data.headers.get('content-disposition').split('filename="')[1].replaceAll('"', '')}`)
    console.log("dati da db per il pdf:", data.body);
    this.loadingService.closeDialog();
   });
   
  }
  
  // Inserisce una nuova raccolta
  onSubmit(): void {
    console.log("this._tipoMetodoForm.value:", this._tipoMatriceForm.value);
    console.log("this._tipoMetodoForm.value:", this._tipoMetodoForm.value);
    console.log("this.allevamentoForm.value:", this.allevamentoForm.value);
    if (!this._newDay.valid || !this._tipoMatriceForm.valid || !this._tipoMetodoForm.valid || !this.allevamentoForm.valid) return;
    console.log("this._newDay.value", this._newDay.value);

    // Recupera i veterinari dalla tabella
    /*
    console.log("this.table_veterinari:", this.table_veterinari);
    this._selectedVeterinari = this.table_veterinari?.selectedData.map((v: any) => v.id);
    console.log("this._selectedVeterinari:", this._selectedVeterinari);
    */
    this.loadingService.openDialog('Inserimento in corso...');
    this._is.insGiornata(this._info_intervento[0].id_intervento, this._newDay.value, this._tipoMetodoForm.value!, this._tipoMatriceForm.value!, this.allevamentoForm.value!).subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: "Attenzione! Errore durante l'inserimento della giornata."
        });
        return;
      }
      /* this.notificationService.push({
        notificationClass: 'success',
        content: 'Giornata inserita con successo.'
      }); */
      // this.closeModal(this.modaleNuovaGiornataRef);
      this.modalNuovaGiornata?.hide();
      // this.ngOnInit();

      this._is.getGiornate(parseInt(this._info_intervento[0].id_intervento)).subscribe((res: any) => {
        console.log("res:", res);
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Attenzione! Errore nel caricamento dei dati.'
          });
          return;
        }

        if (res.info && res.info !== true) {
          this._giornate = res.info.dati;
          console.log("this._giornate:", this._giornate);

          const _dates: any = this._giornate.map((d: any) => new Date(d.dt).setHours(0, 0, 0, 0));
          console.log("_dates:", _dates);

          const first: number = Math.min(..._dates);
          this._firstDate = formatDate(new Date(first).setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
          console.log("this._firstDate:", this._firstDate);

          this._ui = res.info.ui;
          console.log("this._ui:", this._ui);

          if (this._info_intervento[0].descr_metodo != 'Pool') {
            this._ui.colonne = this._ui.colonne.filter((obj: any) => {
              return obj.campo !== 'n_pool';
            });
          }
        }
      });
    });
  }

  resetNuovaRaccoltaModal(): void {
    this._tipoMatriceForm.reset();
    this._tipoMetodoForm.reset();
    this._newDay.reset();
    // this.changeShowVet = false;
  }

  /**
   * Controlla che la data inserita rientri nel range [min, max]. Nel caso non
   * dovesse rientrare allora viene impostata quella minima, ma è possibile
   * impostare qualsiasi altra data.
   *
   * @param evt Evento che scatta
   */
  onBlur(evt: any): void {
    if (
      evt.target.min.trim() != '' &&
      evt.target.max.trim() != '' &&
      (evt.target.value < evt.target.min || evt.target.value > evt.target.max)
    ) {
      evt.target.value = evt.target.min;
      const id = evt.target.attributes.id.value;
      let DOMElem: HTMLInputElement = <HTMLInputElement>document.querySelector(`#${id}`);
      DOMElem.value = evt.target.min;
      DOMElem.dispatchEvent(new Event('input'));
      // this.reloadVet();
    } else {
      if (this.isValidDate(evt.target.value) && this.oldDateValue !== this.currentDateValue) {
        // this.reloadVet();
      }
    }

    // this.oldDateValue = evt.target.value;
  }

  /*
  // Quando cambia la data
  onChange(evt: any): void {
    // if (this.isValidDate(evt.target.value)) this.reloadVet();
    console.log("\nonInput\n");
  }
  */

  /**
   * Verifica che la stringa data in input sia una data valida e che l'anno
   * inserito sia a 4 cifre.
   * @param s stringa da convertire in data
   * @returns valore true o false
   */
  private isValidDate(s: string): boolean {
    const date: Date = new Date(s);
    const year: string = date.getFullYear().toString();

    if (isNaN(date.getTime()) || year.length !== 4) return false;
    return true;
  }

  /*
  private reloadVet(): void {
    this.getVet(this._newDay.value!);
    setTimeout(() => { this.changeShowVet = true; }, 2000);
  }
  */

  openModal(content: any, size: string = 'lg') {
    return this.modalEngine.open(content, {
      modalDialogClass: 'system-modal',
      size: size
    });
  }

  closeModal(modalRef?: NgbModalRef) { modalRef?.close(); }



  //Funzione che salva le note
  saveNote() {
    const params = {
      id_intervento: parseInt(this._info_intervento[0].id_intervento),
      note: this.formInterventoNote.get('note')?.value,
      dataInizio: this.formInterventoNote.get('dataInizio')?.value,
      dataFine: this.formInterventoNote.get('dataFine')?.value,
    }
    console.log(params);
    if(!this.formInterventoNote.valid){
      this.notificationService.push({
        notificationClass: 'error',
        content: 'Attenzione! Valorizzare i campi obbligatori'
      })
      return;
    }
    if(params.dataFine < params.dataInizio){
      this.notificationService.push({
        notificationClass: 'error',
        content: 'Attenzione! La data fine deve essere successiva alla data inizio'
      })
      return;
    }
    this._is.updInterventoNote(params).subscribe((res: any) => {
      if (!res.esito) return;
      if (!res.info) return;
      console.log("res note: ", res);
    })
  }

  //Funzione che chiude l'intervento
  closeIntervento() {
    const params = {
      id_intervento: parseInt(this._info_intervento[0].id_intervento)
    }
    this.loadingService.openDialog('Chiusura intervento');
    this._is.chiudiIntervento(params).subscribe((res : any) => {
      this.loadingService.closeDialog();
      if (!res.esito) return;
      console.log("res chiudi intervento: ", res);
      window.location.reload();
    })
  }
  delIntervento(){
    const params = {
      id_intervento: parseInt(this._info_intervento[0].id_intervento)
    }
    this._is.deleteIntervento(params).subscribe((res : any) => {
      if (!res.esito) return;
      console.log("res elimina intervento: ", res);
      this.router.navigate(['portali', 'bdnfvg','interventi']);
    })
  }
  goBack(): void { this._location.back(); }

  get info_intervento() { return this._info_intervento; }
  get list_info() { return this._list_info; }
  get tot_capi() { return this._tot_capi; }
  get tot_capannoni() { return this._tot_capannoni; }
  get at_least_one() { return this._at_least_one; }
  get giornate() { return this._giornate; }
  get ui() { return this._ui; }
  // get tipi_matrice() { return this._tipi_matrice; }
  get tipi_metodo() { return this._tipi_metodo; }
  get veterinari() { return this._veterinari; }
  get ui_veterinari() { return this._ui_veterinari; }
  get currentDate() {
    return formatDate(
      new Date().setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en'
    );
  }

  /**
   * Ritorna la data minima da poter inserire per una nuova giornata. Se non
   * sono presenti già delle giornate, allora ritorna come data minima quella
   * odierna.
   */
  get minDate() {
    let _min: any;

    _min = new Date(this._info_intervento[0].dt);

    return formatDate(_min.setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
  }

  /**
   * Ritorna la data massima da poter inserire per una nuova giornata
   */
  get maxDate() {
    const fourdaysafter = new Date(
      new Date(this.minDate).setDate(new Date(this.minDate).getDate() + this._info_intervento[0].giornate_max)
    );
    return formatDate(
      fourdaysafter.setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en'
    );
  }

  get vet_intervento() { return this._vet_intervento; }
  // get showVet() { return this._showVet; }

  get matrici_piano() { return this._matrici_piano; }
  get laboratori() { return this._laboratori; }

  // set changeShowVet(val: boolean) { this._showVet = val; }
  get info_preaccettazione() { return this._info_preaccettazione; }
  get idInteventoCollegato() { return this._info_intervento[0].id_intervento_collegato; }

}
