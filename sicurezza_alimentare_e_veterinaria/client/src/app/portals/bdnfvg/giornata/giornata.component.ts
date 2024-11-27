/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { NotificationService, LoadingDialogService, ASmartTableComponent, Utils } from '@us/utils';
import { Location, formatDate } from '@angular/common'
import { CapannoniService, InterventiService } from '../services';
import { baseUri } from 'src/environments/environment';
import * as XLSX from 'xlsx';
import Swal from 'sweetalert2';
import * as bootstrap from 'bootstrap';

declare var require: any;
const JsBarcode = require('jsbarcode');

@Component({
  selector: 'app-giornata',
  templateUrl: './giornata.component.html',
  styleUrls: ['./giornata.component.scss']
})
export class GiornataComponent implements OnInit, AfterViewInit {
  private _capiGiornata?: any;
  private _poolGiornata?: any;
  private _capiModal?: any;
  private _capiInPool?: any;
  private _selectPianiButton?: any;

  private _ui?: any;
  private _ui_pool?: any;
  private _uiModal?: any;
  private _uiCapiPool?: any;

  private _fields: string[] = [];
  private _dayInfo?: any;
  private _dataFromFile?: any[];
  private _marchi?: string[] = [];
  private _codici_pool?: string[] = [];
  private _allSamples?: string[] = [];
  private _selectedPool?: any;
  private _tipo_dettaglio?: any;

  private _matrici?: any;
  private _piani?: any;
  private _matriciIntervento?: any;
  private _capannoniAllevamento?: any;

  private _stato?: any;
  private _capiGiornataModal?: bootstrap.Modal;
  private _capannoneModal?: bootstrap.Modal;
  private _poolModal?: bootstrap.Modal;
  private _capiGiornataModal2?: bootstrap.Modal;

  private _checkAll: boolean = true;
  private _mapPiani = new Map();
  private _mapMatrici = new Map();
  private _mapPool = new Map();
  private _oldInputValue?: number;

  isPool: boolean = false;
  isNoProvetta: boolean = false;

  codice_pool: FormControl = new FormControl('', Validators.required);
  formNuovoCapo: FormGroup;
  formCapannone: FormGroup;

  @ViewChild('capiTable') tabella?: ASmartTableComponent;
  @ViewChild('tabModalCapi') tabModalCapi?: ASmartTableComponent;
  @ViewChild('poolTable') poolTable?: ASmartTableComponent;
  btnAggiungi?: boolean = true;

  constructor(
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private fb: FormBuilder,
    private _location: Location,
    private _is: InterventiService,
    private _cs: CapannoniService
  ) {
    this.formNuovoCapo = this.fb.group({
      marchio: this.fb.control(null, Validators.required),
      note: this.fb.control(null),
      num_capi: this.fb.control(1, Validators.required)
    });

    this.formCapannone = this.fb.group({
      capannone: this.fb.control(null, Validators.required),
      note: this.fb.control(null)
    });
  }

  ngOnInit(): void {
    this.route.queryParams.subscribe((dataQ: any) => {
      this._dayInfo = dataQ;
      console.log("this._dayInfo:", this._dayInfo);
    });

    // Per prendere lo stato dell'intervento all'interno della giornata in modo tale da non poter aggiungere
    // nuovi capi, capannoni o pool
    this.loadingService.openDialog('Caricamento');
    this._is.getInfoIntervento(parseInt(this._dayInfo.id_intervento)).subscribe((res: any) => {
      console.log("res interventi: ", res);
      if (!res.esito) return;
      this._stato = res.info.dati_info[0].descr_stato;
      if (this._stato !== 'In corso') {
        this.btnAggiungi = false;
      }


      // Recupera il tipo dettaglio che può essere CAPO, CAPANNONE, MANUALE
      this._is.getMatriceGiornata(this._dayInfo.id_giornata).subscribe((res: any) => {
        console.log("res matrice giornata:", res);
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Attenzione! Errore durante il caricamento dei dati.'
          });
          return;
        }
        this.isPool = res.info.dati[0].pool;
        this.isNoProvetta = res.info.dati[0].no_provetta;
        console.log("this.isPool:", this.isPool);

        // Recupera il tipo dettaglio che può essere CAPO, CAPANNONE, MANUALE
        this._is.getTipoDettaglio(this._dayInfo.id_giornata).subscribe((res: any) => {
          console.log("res:", res);
          if (!res.esito) {
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Attenzione! Errore durante il caricamento dei dati.'
            });
            return;
          }
          this._tipo_dettaglio = res.info.dati[0].tipo_dettaglio;
          console.log("this._tipo_dettaglio:", this._tipo_dettaglio);

          if (this.isPool) {
            this._is.getPoolGiornata(this.id_giornata, this.id_intervento).subscribe((res: any) => {
              this.loadingService.closeDialog();
              console.log("res:", res);
              if (!res.esito) {
                this.notificationService.push({
                  notificationClass: 'error',
                  content: `Attenzione! Errore durante il recupero dei dati.`
                })
                return;
              }
              this._poolGiornata = res.info?.dati;
              console.log("this._poolGiornata:", this._poolGiornata);

              this._allSamples = res.info?.all_samples;

              this._ui_pool = res.info?.ui;
              console.log("this._ui_pool:", this._ui_pool);

              this._codici_pool = this._poolGiornata?.map((pg: any) => pg.codice_pool);
              console.log("this._codici_pool:", this._codici_pool);

              // Dopo il rendering, seleziona automaticamente i checkbox
              setTimeout(() => {
                for (const [i, pg] of this._poolGiornata.entries()) {
                  console.log("pg:", pg);
                  if (pg.n_sample) {
                    for (const p of pg.id_piani) {
                      console.log(`#piano_${p}_${i}`);
                      console.log(
                        document.querySelector(`#piano_${p}_${i}`)
                      )
                      if (document.querySelector(`#piano_${p}_${i}`)) {
                        (document.querySelector(`#piano_${p}_${i}`) as HTMLInputElement).checked = true;

                        // Gestisci la map dei piani dei pool
                        if (!this._mapPool?.get(pg.pool)) this._mapPool?.set(pg.pool, []);
                        this._mapPool?.get(pg.pool).push(p);
                        console.log("this._mapPool:", this._mapPool);
                      }
                    }
                  }
                  (document.querySelector(`#note_${pg.pool}`) as HTMLTextAreaElement).value = pg.note;
                }

                // this._poolGiornata?.forEach((pg: any, i: number) => {
                //   console.log("pg:", pg);
                //   if (pg.n_sample) {
                //     pg.id_piani?.forEach((p: any) => {
                //       console.log(`#piano_${p}_${i}`);
                //       console.log(
                //         document.querySelector(`#piano_${p}_${i}`)
                //       )
                //       if (document.querySelector(`#piano_${p}_${i}`)) {
                //         (document.querySelector(`#piano_${p}_${i}`) as HTMLInputElement).checked = true;

                //         // Gestisci la map dei piani dei pool
                //         if (!this._mapPool?.get(pg.pool)) this._mapPool?.set(pg.pool, []);
                //         this._mapPool?.get(pg.pool).push(p);
                //         console.log("this._mapPool:", this._mapPool);
                //       }
                //     });
                //   }
                //   (document.querySelector(`#note_${pg.pool}`) as HTMLTextAreaElement).value = pg.note;
                // });
              }, 500);
            });
          } else {

            this._is.getCapiGiornata(this.id_intervento, this.id_giornata).subscribe((res: any) => {
              this.loadingService.closeDialog();
              console.log("res:", res);
              //console.log("stato preso:",this._stato);
              if (!res.esito) {
                this.notificationService.push({
                  notificationClass: 'error',
                  content: 'Attenzione! Errore durante il caricamento dei dati.'
                });
                return;
              }

              this._capiGiornata = res.info.dati ?? null;
              this._capiGiornata?.forEach((capo: any) => {
                if (this._stato !== "In corso") capo.selezionabile = false;
                else capo.selezionabile = true;
              });
              console.log("this._capiGiornata:", this._capiGiornata);

              this._ui = res.info.ui;
              console.log("this._ui:", this._ui);

              // Se tutti i capi non hanno il campo sesso allora non mostrare la colonna
              if (this._capiGiornata?.every((cg: any) => cg['sesso'] == null)) {
                this._ui.colonne = this._ui.colonne.filter((obj: any) => {
                  return obj.campo != 'sesso'
                });
              }

              // Se tutti i capi non hanno il campo nascita allora non mostrare la colonna
              if (this._capiGiornata?.every((cg: any) => cg['dt_nascita'] == null)) {
                this._ui.colonne = this._ui.colonne.filter((obj: any) => {
                  return obj.campo != 'dt_nascita'
                });
              }

              console.log("this._ui:", this._ui);

              this._allSamples = res.info.all_samples;
              if (!this._allSamples || this._allSamples?.length === 0) this._allSamples = [];
              console.log("this._allSamples:", this._allSamples);

              setTimeout(() => {
                this._capiGiornata?.forEach((c: any, i: number) => {
                  if (c.id_matrice) {
                    c.id_piani?.forEach((p: any) => {
                      if (document.querySelector(`#piano_${p}_${i}`)) {
                        (document.querySelector(`#piano_${p}_${i}`) as HTMLInputElement).checked = true;

                        // Gestisci la map dei piani
                        if (!this._mapPiani?.get(c.id_capo)) this._mapPiani?.set(c.id_capo, []);
                        this._mapPiani?.get(c.id_capo).push(p);
                        // console.log("this._mapPiani:", this._mapPiani);
                      }
                    });
                  }
                  if (c.note && document.querySelector(`#note_${c.id_capo}_${c.marchio}`)) {
                    (document.querySelector(`#note_${c.id_capo}_${c.marchio}`) as HTMLTextAreaElement).value = c.note;
                  }
                });
              }, 0);

              // Recupera i capannoni per la combo nella modale
            if (this.tipo_dettaglio === 'CAPANNONE') {
              this._cs.getCapannoni({ id_allevamento: this._dayInfo.id_allevamento }).subscribe((res: any) => {
                this.loadingService.closeDialog();
                console.log("getCapannoni res:", res);
                if (!res.esito) {
                  this.notificationService.push({
                    notificationClass: 'error',
                    content: 'Attenzione! Errore durante il caricamento dei capannoni.'
                  });
                  return;
                }
                this._capannoniAllevamento = res.info.dati;
                console.log("Capannoni Allevamento:", this._capannoniAllevamento);
              });
            }

            });
          }

        });

      });



      // Carica le matrici per ogni capo
      this._is.getMatriciIntervento(this._dayInfo.id_intervento, this.dayInfo.id_giornata).subscribe((res: any) => {
        console.log("res:", res);
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Attenzione! Errore durante il caricamento delle matrici.'
          });
          return;
        }

        this._matriciIntervento = res.info.dati;

        this._matrici = [...new Set(res.info.dati.map((m: any) => (JSON.stringify({
          id_matrice: m.id_matrice,
          descr_matrice: m.descr_matrice
        }))))];

        this._matrici.forEach((m: any, i: number) => { this._matrici[i] = JSON.parse(m) });

        this._piani = [...new Set(res.info.dati.map((p: any) => (JSON.stringify({
          id_piano: p.id_piano,
          descr_piano: p.malattia
        }))))];

        this._piani.forEach((p: any, i: number) => { this._piani[i] = JSON.parse(p) });

        console.log("this._matriciIntervento:", this._matriciIntervento);
        console.log("this._matrici:", this._matrici);
        console.log("this._piani:", this._piani);
      });

      this._capiGiornataModal = new bootstrap.Modal('#nuovo-capo-modal', { focus: false });
      this._capannoneModal = new bootstrap.Modal('#add-capannone-modal', { focus: false });
      this._poolModal = new bootstrap.Modal('#pool-modal', { focus: false });
      this._capiGiornataModal2 = new bootstrap.Modal('#capi-giornata-modal', { focus: false });
    });

  }

  ngAfterViewInit(): void {
    this._selectPianiButton = new bootstrap.Button(document.querySelector('#selectPianiButton')!);
    console.log("_selectPianiButton:", this._selectPianiButton);
  }

  // Recupera i capi per la modale
  getCapiModal(): void {
    this.loadingService.openDialog("Caricamento Capi...");
    this._is.getCapiGiornata(this.id_intervento, this.id_giornata).subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: `Attenzione! Errore durante recupero dati.`
        });
        return;
      }
      this._capiModal = res.info.dati?.filter((cm: any) => cm.selezionabile);
      console.log("this._capiModal:", this._capiModal);

      this._uiModal = res.info.ui;
      console.log("this._uiModal:", this._uiModal);
    });
  }

  // Crea il nuovo pool
  updPool(): void {
    console.log("this.codice_pool.value:", this.codice_pool.value);
    console.log("this.codice_pool.valid:", this.codice_pool.valid);

    if (
      !this.codice_pool.valid ||
      this.codice_pool.value === null // ||
      //this.codice_pool.value.trim() === ''
    ) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: `Il codice Pool deve essere un numero positivo.`
      });
      return;
    }

    // Recupera dati dalla tabella
    console.log("this.tabModalCapi?.selectedData:", this.tabModalCapi?.selectedData);
    const id_capi = this.tabModalCapi?.selectedData.map((c: any) => c.id_capo);
    console.log("id_capi:", id_capi);

    // Controlla se sono stati selezionati capi
    if (id_capi === undefined || id_capi?.length === 0) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: 'Attenzione! È necessario selezionare almeno un capo per creare un pool.'
      });
      return;
    }

    const params: any = {
      id_giornata: this.id_giornata,
      id_intervento: this.id_intervento,
      id_capi: id_capi,
      codice_pool: this.codice_pool.value,
    }

    this.loadingService.openDialog('Creazione in corso...');
    this._is.updPool(params).subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: `Attenzione! Errore durante la creazione del pool.`
        });
        return;
      }
      this.notificationService.push({
        notificationClass: 'success',
        content: `Creazione del pool avvenuta con successo.`
      });
    });

    setTimeout(() => {
      this._capiGiornataModal?.hide();
      window.location.reload();
    }, 1500);
  }

  updPoolPiani(): void {
    console.log('this._matrici:', this._matrici);
    console.log('this.poolTable?.data:', this.poolTable?.data);
    console.log('this._mapPool:', this._mapPool);

    let params = {
      id_giornata: parseInt(this._dayInfo.id_giornata),
      id_matrice: parseInt(this._matrici[0].id_matrice),
      dati: [] as any[],
    };



    let no_selected = false;
    
     /*   Swal.fire({
          title: 'Attenzione!',
          icon: 'warning',
          text: `Attenzione! Per il pool ${codPool} devi selezionare almeno un piano.`,
          timer: 2000,
          timerProgressBar: true,
          allowOutsideClick: false,
        });
        no_selected = true;
      }*/
     

    let poolNoPiani: string[] = [];
    this.poolTable?.data.forEach((p: any) => {
      console.log('this._mapPool.get(p.pool):', this._mapPool.get(p.pool));

      if(!this._mapPool.get(p.pool) || !this._mapPool.get(p.pool).length){
        poolNoPiani.push(p.codice_pool);
      }

      if(poolNoPiani.length){
        Swal.fire({
          title: 'Attenzione!',
          icon: 'warning',
          text: `Attenzione! Per il/i pool ${poolNoPiani.join(', ')} devi selezionare almeno un piano.`,
          timer: 2000,
          timerProgressBar: true,
          allowOutsideClick: false,
        });
        no_selected = true;
        return;
      }

      if(no_selected)
          return;

      if (this._mapPool.get(p.pool) !== undefined) {
        params.dati.push({
          pool: p.pool,
          piani: this._mapPool.get(p.pool) ?? null,
          codice_provetta: p.codice_pool ?? null,
          note: (document.querySelector(`#note_${p.pool}`) as HTMLTextAreaElement).value ?? null
        });
      }
    });

    console.log("params:", params);

    let provetteAttuali = params.dati.map((el: any) => {return el.codice_provetta});

    // Trova le provette già esistenti nelle altre raccolte
    const provetteDuplicateEsterne = this.findCommonElements(provetteAttuali!, this._allSamples!);
    console.log("provetteDuplicateEsterne:", provetteDuplicateEsterne);

    // Trova le provette che sono duplicate fra loro
    const provetteDuplicate = this.findDuplicates(provetteAttuali!);
    console.log("provetteDuplicate:", provetteDuplicate);

    // Unisci gli array delle provette
    const valoriDuplicati = Array.from(new Set(provetteDuplicateEsterne.concat(provetteDuplicate)));
    console.log("valoriDuplicati:", valoriDuplicati);

    let textToShow = `
      Provetta/e ${valoriDuplicati.join(', ')} già utilizzata/e.
    `;

    if (valoriDuplicati.length > 0 && !this.isNoProvetta) {
      Swal.fire({
        title: 'Attenzione',
        icon: 'warning',
        text: textToShow,
        showDenyButton: false,
        showCancelButton: false,
        showConfirmButton: true,
        confirmButtonText: 'OK',
        allowOutsideClick: false
      });
      return;
    }

    this.loadingService.openDialog('Aggiornamento in corso...');
    this._is.updPoolPiani(params).subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: `Attenzione! Errore durante l'aggiornamento dei dati.`
        });
        return;
      }
      this.notificationService.push({
        notificationClass: 'success',
        content: 'Aggiornamento avvenuto con successo.'
      });
      setTimeout(() => { window.location.reload() }, 1500);
    });

  }

  // Rimuove un pool
  deletePool(pool: any): void {
    console.log("pool:", pool);
    Swal.fire({
      title: 'Sei sicuro?',
      text: "Sicuro di voler eliminare " + pool.codice_pool + "?",
      icon: 'warning',
      confirmButtonText: 'Si',
      showCancelButton: true,
      cancelButtonText: 'No',
      allowOutsideClick: false
    }).then((result) => {
      if (result.isConfirmed) {
        this.loadingService.openDialog('Eliminazione in corso...');
        this._is.deletePool(pool.codice_pool, this.id_giornata).subscribe((res: any) => {
          this.loadingService.closeDialog();
          console.log("res:", res);
          if (!res.esito) {
            this.notificationService.push({
              notificationClass: 'error',
              content: `Attenzione! Errore durante l'eliminazione del pool.`
            });
            return;
          }
          this.notificationService.push({
            notificationClass: 'success',
            content: 'Eliminazione avvenuta con sucesso.'
          });

          setTimeout(() => { window.location.reload() }, 1500);
        });
      }
    })
  }

  private findMissingNumbers(arr: number[]): number[] {
    let max = Math.max(...arr);
    return Array.from({ length: max }, (_, i) => i + 1).filter(i => !arr.includes(i));
  }

  /**
   * Il metodo ricerca i valori duplicati all'interno di un array e ritorna
   * l'array con tutti i duplicati.
   * @param arr Array dal quale trovare i duplicati
   * @returns Array che contiene i valori duplicati
   */
  private findDuplicates(arr: string[]): string[] {
    return arr.sort()
      .filter((item, index, array) =>
        item == array[index - 1] && item != array[index + 1]
      );
  }

  /**
   * Il metodo trova tutti gli elementi che hanno i due array in comune e li
   * restituisce.
   * @param arr1 Array dal quale rimuovere i duplicati
   * @param arr2 Array dal quale cercare i valori duplicati
   * @returns
   */
  private findCommonElements(arr1: string[], arr2: string[]): string[] {
    return Array.from(new Set(arr1.filter(element => arr2.includes(element))));
  }

  /**
   * Effettua i vari controlli e carica i dati lato DB.
   * @returns Promise<void>
   */
  async checkSelected(): Promise<void> {
    let dati: any = [];
    let isDenied: boolean = true;
    let p_selezionati: any;
    let no_selected: boolean = false;
    let note: string | null = null;

    if (this.selectedData && this.selectedDataLength > 0) {
      // Dati selezionati manualmente
      console.log("this.tabella?.selectedData:", this.tabella?.selectedData);

      // TODO: Aggiungere controllo dei duplicati
      console.log("_allSamples:", this._allSamples);

      // Recupera i valori delle provette attuali
      const provetteAttuali = this.tabella?.selectedData.map((r: any) => {
        return (this.getCodProvetta(r.id_capo, r.pos));
      });
      console.log("provetteAttuali:", provetteAttuali);

      if(provetteAttuali!.indexOf('') > -1){
        Swal.fire({
          title: 'Attenzione!',
          icon: 'warning',
          text: `Attenzione! Inserire la sequenza provetta per tutti i campioni selezionati`,
          timer: 2000,
          timerProgressBar: true,
          allowOutsideClick: false
        });
        return;
      }

      if(provetteAttuali){
        let buchi = this.trovaBuchi(provetteAttuali);
        if (buchi?.length) {
          let risultato = await Swal.fire({
              icon: 'question',
              text: `Nella sequenza provette mancano le provette: ${buchi.join(', ')}. Continuare?`,
              showDenyButton: true,
              confirmButtonText: `Sì`,
              denyButtonText: `No`,
              allowOutsideClick: false
          });
         if (risultato.isDenied)
              return;
        }
      }

      // Trova le provette già esistenti nelle altre raccolte
      const provetteDuplicateEsterne = this.findCommonElements(provetteAttuali!, this._allSamples!);
      console.log("provetteDuplicateEsterne:", provetteDuplicateEsterne);

      // Trova le provette che sono duplicate fra loro
      const provetteDuplicate = this.findDuplicates(provetteAttuali!);
      console.log("provetteDuplicate:", provetteDuplicate);

      // Unisci gli array delle provette
      const valoriDuplicati = Array.from(new Set(provetteDuplicateEsterne.concat(provetteDuplicate)));
      console.log("valoriDuplicati:", valoriDuplicati);

      let textToShow = `
        Provetta/e ${valoriDuplicati.join(', ')} già utilizzata/e.
      `;

      if (valoriDuplicati.length > 0 && !this.isNoProvetta) {
        Swal.fire({
          title: 'Attenzione',
          icon: 'warning',
          text: textToShow,
          showDenyButton: false,
          showCancelButton: false,
          showConfirmButton: true,
          confirmButtonText: 'OK',
          allowOutsideClick: false
        });
        return;
      }

      let capiNoPiani: string[] = []

      this.tabella?.selectedData.forEach((riga: any) => {
        const cod_provetta = this.getCodProvetta(riga.id_capo, riga.pos) ? this.getCodProvetta(riga.id_capo, riga.pos) : null;

        // Recupera l'id_matrice e i piani selezionati
        console.log("riga.id_capo:", riga.id_capo);

        // const id_matrice: string = this._mapMatrici.get(riga.id_capo);
        // console.log("id_matrice:", id_matrice);

        // if (id_matrice != null) {
        // Controlla che vengano selezionati per ogni riga almeno un piano
        if (this._matrici[0].id_matrice != null) {
          p_selezionati = this._mapPiani.get(riga.id_capo);
          console.log("p_selezionati:", p_selezionati);
          if (p_selezionati == undefined || p_selezionati.length === 0) {
            capiNoPiani.push(riga.marchio);
          }
        }

        if(capiNoPiani.length) {
          Swal.fire({
            title: 'Attenzione!',
            icon: 'warning',
            text: `Attenzione! Per il/i capo/capi ${capiNoPiani.join(', ')} devi selezionare almeno un piano.`,
            timer: 2000,
            timerProgressBar: true,
            allowOutsideClick: false,
          });
          no_selected = true;
          return;
        }

        // Recupera le note del campo
        // this._dayInfo.descr_specie === 'SUINI'
        if (
          document.querySelector(`#note_${riga.id_capo}_${riga.marchio}`)
        ) {
          note = (
            document.querySelector(
              `#note_${riga.id_capo}_${riga.marchio}`
            ) as HTMLTextAreaElement
          ).value;
        }

        console.log("note:", note);

        dati.push({
          id_capo: riga.id_capo,
          codice_provetta: cod_provetta?.trim(),
          // id_matrice: id_matrice,
          id_matrice: this._matrici[0].id_matrice,
          piani: p_selezionati ?? null,
          marchio: riga.marchio,
          note: note ?? null
        });
      });

      console.log("dati:", dati);

      if (no_selected) {
        dati = [];
        return;
      }
    } else if (this._dataFromFile) {
      // Caso dati da file
      let sovrascritti: string[] = [];

      // Trova i marchi del file tra i capi della giornata
      this._dataFromFile.forEach((singleData: any) => {
        const foundElem = this._capiGiornata.find(
          (capo: any) => capo.marchio.trim() === singleData.marchio.trim()
        );

        if (foundElem) {
          dati.push({
            id_capo: foundElem.id_capo,
            codice_provetta: singleData.codice_provetta
          });
          if (foundElem.n_sample) { sovrascritti.push(foundElem.marchio); }
        }
      });

      // Capi inseriti nel file non presenti in tabella
      if (dati.length === 0) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: 'Attenzione! Nel file non sono stati inseriti capi presenti in allevamento'
        });
        return;
      }

      // Accetta di sovrascrivere i dati
      if (sovrascritti.length > 0) {
        await Swal.fire({
          title: 'Conferma?',
          text: `I valori dei seguenti marchi (${sovrascritti}) verranno sovrascritti`,
          showConfirmButton: true,
          showDenyButton: true,
          confirmButtonText: 'Si',
          denyButtonText: 'No',
          allowOutsideClick: false,
        }).then((result) => { if (result.isDenied) { isDenied = false; } });
      }

    } else {
      // Caso in cui non sono presenti dati selezionati
      this.notificationService.push(({
        notificationClass: 'warning',
        content: 'Attenzione! È necessario selezionare i dati'
      }));
      return;
    }

    const codProvettaNegativi = dati.filter((d: any) => d.codice_provetta < 1);
    console.log("codProvettaNegativi:", codProvettaNegativi);

    if (codProvettaNegativi.length > 0 && !this.isNoProvetta) {
      Swal.fire({
        title: 'Elementi con provette negative',
        icon: 'warning',
        text: `
          Ai seguenti elementi: ${codProvettaNegativi.map((ncp: any) => ncp.marchio).join(', ')}
          è stato assegnato un codice provetta minore di zero!
        `,
        confirmButtonText: 'Ok',
        allowOutsideClick: true
      })
      return;
    }

    const noCodProvetta = dati.filter((d: any) => d.codice_provetta === undefined);
    console.log("noCodProvetta:", noCodProvetta);

    if (noCodProvetta.length > 0) {
      await Swal.fire({
        title: 'Elementi senza codice',
        icon: 'error',
        text: `
          Ai seguenti elementi: ${noCodProvetta.map((ncp: any) => ncp.marchio).join(', ')}
          non è stato assegnato un codice provetta!
        `,
        confirmButtonText: 'Ok',
        allowOutsideClick: true
      })
      return;
    }

    if (!isDenied) return;

    dati = dati.filter((d: any) => d.codice_provetta !== undefined);
    console.log("dati:", dati);
    // Carica i valori di sequenza dele provette
    this.loadingService.openDialog('Aggiornamento in corso...');
    this._is.updGiornate(
      this._tipo_dettaglio,
      parseInt(this._dayInfo.id_intervento),
      parseInt(this._dayInfo.id_giornata),
      formatDate(this._dayInfo.dt, 'dd-MM-yyyy', 'en'),
      dati
    ).subscribe((res: any) => {
      console.log("res:", res);
      this.loadingService.closeDialog();
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: "Attenzione! Errore durante l'aggiornamento dei dati."
        });
        return;
      }
      this.notificationService.push({
        notificationClass: 'success',
        content: 'Aggiornamento avvenuto con successo.'
      });
      window.location.reload();
      // Aggiorna la pagina dopo aver effettuato correttamente l'aggiornamento
      // setTimeout(() => { window.location.reload(); }, 1500);
    })
  }

  // Mostra la modale con il pool selezionato
  showPool(pool: any): void {
    console.log("pool:", pool);
    this._selectedPool = pool.pool;
    this.loadingService.openDialog('Caricamento Capi Pool...');
    this._is.getCapiPool(this._selectedPool).subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: `Attenzione! Errore durante il recupero dei dati.`
        });
        return;
      }
      this._capiInPool = res.info.dati;
      console.log("this._capiInPool:", this._capiInPool);

      this._uiCapiPool = res.info.ui;
      console.log("this._uiCapiPool:", this._uiCapiPool);
    });

    this._poolModal?.toggle();
  }

  // Reimposta la modale per la selezione dei capi per il pool
  resetModalNewPool(): void {
    this.codice_pool.reset();
    this.tabModalCapi?.unselectAll();
  }

  // Reimposta le variabili per la selezione del pool
  resetCapiPool(): void {
    this._capiInPool = null;
    this._uiCapiPool = null;
    this._selectedPool = null;
  }

  // Genera i codici a barre dei capi analizzati
  getBarcodes() {
    if (this._codici_pool && this._codici_pool.length > 0) {
      this.makeBarcodes(this._codici_pool, 'svg-container-pool', `giornata_${this.dayInfo.dt}_pool.pdf`);
    } else {
      /*Swal.fire({
        title: 'Sei sicuro?',
        text: 'Una volta stampati i codici a barre non sarà possibile modificare le sequenze provette.',
        icon: 'warning',
        showDenyButton: true,
        denyButtonText: 'Annulla',
        showConfirmButton: true,
        confirmButtonText: 'Sì',
      }).then((result: any) => {
        if (result.isConfirmed) {*/
      let onlySampled: any[] = this._capiGiornata.filter((c: any) => c.n_sample != null);
      this._marchi = [];
      this._marchi = onlySampled.map((oc: any) => oc.marchio);
      console.log("marchi:", this._marchi);

      if (this._marchi?.length === 0) {
        Swal.fire({
          title: 'Attenzione!',
          text: 'Non è stata inserita nessuna sequenza di provetta',
          icon: 'error',
          showConfirmButton: false,
          timer: 1500,
          allowOutsideClick: false
        });
        return;
      }

      this.makeBarcodes(this._marchi, 'svg-container', 'barcodes.pdf');

      // Disabilita i capi che sono stati stampati
      /*let id_capi: number[] = onlySampled.map((os: any) => os.id_capo);
      console.log("_id_capi:", id_capi);
      this.loadingService.openDialog('Aggiornamento in corso...');
      this._is.updPrinted(id_capi).subscribe((res: any) => {
        this.loadingService.closeDialog();
        console.log("res:", res);
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: `Attenzione! Errore durante l'aggiornamento dei dati.`
          })
          return;
        }
        this.notificationService.push({
          notificationClass: 'success',
          content: `Aggiornamento avvenuto con successo.`
        });

        setTimeout(() => { window.location.reload(); }, 2000);
      });*/
      //}
      //})
    }
  }

  private makeBarcodes(arr: string[], svg_container: string, filename: string): void {
    window.setTimeout(() => {
      // Crea i codici a barre
      arr?.forEach((el: string) => {
        JsBarcode('#barcode_' + el, el, {
          margin: 20,
          width: 4,
          height: 100
        });
      });

      // Seleziona il container con i codici e stampa
      const svgContainer = document.querySelector(`#${svg_container}`)?.innerHTML;
      let win = window.open('', '_blank', 'height=' + 720 + ', width=' + 1280);

      win?.document.write('<html><head>');
      win?.document.write(`<title> ${filename} </title>`); // <title> FOR PDF HEADER.
      win?.document.write('</head><body style="pointer-events: none;">');
      win?.document.write(svgContainer!); // THE TABLE CONTENTS INSIDE THE BODY TAG.
      win?.document.write('</body></html>');

      win?.document.close(); // CLOSE THE CURRENT WINDOW.

      win?.setInterval(function () { win?.focus(); }, 100);

      // Stampa il contenuto
      win?.addEventListener('load', function () {
        win?.print();
        win?.close();
      }, false)
    }, 1000);
  }

  /**
   * Stampa il resoconto della giornata. Stampa tutti i capi presenti nella
   * giornata selezionata, indipendentemente se sono stati già analizzati o
   * meno.
   */
  PrintGiornata(): void {
    const giornata: string = formatDate(this._dayInfo.dt, 'dd-MM-yyyy', 'en').toString();

    let headers: any[] = [];
    this._ui.colonne.forEach((c: any) => {
      headers.push({
        label: c.intestazione,
        property: c.campo,
        width: 512 / (this._ui.colonne.length + 1)
      });
    })

    headers.push({
      label: 'Seq. Prov.',
      property: 'n_sample',
      width: 512 / (this._ui.colonne.length + 1)
    });

    console.log("headers:", headers);

    let selectedData: any[] = [];
    this._capiGiornata.forEach((cg: any) => {
      selectedData.push({
        marchio: cg.marchio ?? '',
        sesso: cg.sesso ?? '',
        dt_nascita: cg.dt_nascita ?? '',
        dt: formatDate(cg.dt, 'dd-MM-yyyy', 'en').toString() ?? '',
        n_sample: cg.n_sample ?? ''
      });
    });

    console.log("selectedData:", selectedData);

    // Crea la tabella da stampare sul PDF
    const tablejson = {
      headers: headers,
      datas: selectedData,
      options: {
        width: 512
      }
    }

    // Definisce altro testo per il PDF
    const filename: string = 'giornata_' + giornata + '.pdf';
    const title: any = { text: 'Giornata ' + giornata, dim: 25 };
    const other_text: any[] = [];

    other_text.push({
      text: 'Elenco Capi',
      dim: 22
    });

    // Compone il pacchetto dati da stampare prima della tabella
    const previous_data: any = {
      filename: filename,
      title: title,
      other_text: other_text
    }

    console.log("tablejson:", tablejson);
    console.log("previous_data:", previous_data);

    this._is.PDFGiornaliero({ previous_data: previous_data, tablejson: JSON.stringify(tablejson) }).subscribe((res: any) => {
      console.log("res:", res);
      if (res.ok == true) {
        const filename: string = 'giornata_' + formatDate(this._dayInfo.dt, 'dd-MM-yyyy', 'en').toString() + '.pdf';
        this._is.getPDF({ filename: filename }).subscribe((data: any) => {
          Utils.download(data.body, `${data.headers.get('content-disposition').split('filename="')[1].replaceAll('"', '')}`)
        });
      }
    });
  }

  /**
   * Aggiunge il file excel da caricare.
   * @param event Evento quando cambia il file
   */
  addFile(event: any): void {
    let arrayBuffer: any;
    const file = event.target.files[0];
    const fileReader = new FileReader();

    fileReader.readAsArrayBuffer(file);
    fileReader.onload = (_) => {
      arrayBuffer = fileReader.result;
      const data = new Uint8Array(arrayBuffer);
      const arr = new Array();
      for (let i = 0; i != data.length; ++i) arr[i] = String.fromCharCode(data[i]);
      const bstr = arr.join("");
      const workbook = XLSX.read(bstr, { type: "binary" });
      const first_sheet_name = workbook.SheetNames[0];
      const worksheet = workbook.Sheets[first_sheet_name];
      this._dataFromFile = XLSX.utils.sheet_to_json(worksheet, { raw: true });
      console.log("this._dataFromFile:", this._dataFromFile);
    }
  }

  /**
   * Scarica il file template da caricare poi dopo aver effettuato i test della
   * giornata.
   */
  async downloadTemplateXLSX() {
    const filename: string = 'template.xlsx';
    const pathfile: string = 'excel\\template.xlsx';

    // Effettua il download del certificato
    console.log("baseUri + this._pathFile:", baseUri + pathfile);
    let blob = await fetch(baseUri + pathfile).then(r => r.blob());
    let link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = filename!;
    link.click();
    link.remove();
    URL.revokeObjectURL(baseUri + pathfile);
  }

  getCodProvetta(id_capo: string, marchio: string): string {
    if(this.isNoProvetta)
      return '-1';
    return (<HTMLInputElement>document.querySelector(`#provetta_${id_capo}_${marchio}`)).value;
  }

  onChange(evt: any, index: number): void {
    const id_capo: number = parseInt(evt.target.attributes.id_capo.value);

    if (evt.target.value == 'null') {
      this._mapMatrici.delete(id_capo);
    } else {
      this._mapMatrici.set(id_capo, evt.target.value);
    }

    (document.querySelectorAll(`[row='${index}']`)).forEach((el: any) => {
      el.setAttribute('disabled', 'true');
      el.checked = false;
    });

    this._matriciIntervento.forEach((mi: any) => {
      // console.log("mi.id_matrice: " + mi.id_matrice + ", evt.target.value: " + evt.target.value);
      if (mi.id_matrice == evt.target.value) {
        (document.querySelector(`#piano_${mi.id_piano}_${index}`) as HTMLInputElement).removeAttribute('disabled');
      }
    });
  }

  /**
   * Aggiunge un capo manualmente. Il metodo viene utilizzato principalmente
   * per la specie animale "SUINI".
   * @returns void
   */
  addCapoManuale(): void {
    this.formNuovoCapo.updateValueAndValidity();
    console.log("this.formNuovoCapo.value:", this.formNuovoCapo.value);

    if (this.formNuovoCapo.invalid) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: 'Attenzione! È necessario compilare prima i campi obbligatori.'
      });
      return;
    }

    /*
    this._is.insCapoManuale(params).subscribe((res: any) => {
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: `Attenzione! Errore durante l'aggiornamento dei dati.`
        });
        return;
      }
    });
    */

    if (!this._capiGiornata) this._capiGiornata = [];
    //necessario per far visualizzare i nuovi dati inseriti in tabella
    let oldRef = this._capiGiornata;
    for(let i=0; i < this.formNuovoCapo.get('num_capi')?.value; i++){
      let params = {
        id_capo: this._capiGiornata ? this._capiGiornata.length : 0,
        marchio: this.formNuovoCapo.get('marchio')?.value.replaceAll(' ', '_'),
        note: this.formNuovoCapo.get('note')?.value,
        pos: this._capiGiornata ? this._capiGiornata.length : 0,
        sesso: null,
        dt_nascita: null,
        dt: null,
        selectable: false,
        selected: true,
        selezionabile: true,
        selezionato: false,
        n_sample: null
      };
      params.id_capo += i;
      params.pos += i;
      console.log(params.pos);
      oldRef.push(params);
    }
    this._capiGiornata = [...oldRef];
    console.log("this._capiGiornata:", this._capiGiornata);
    setTimeout(() => {
      this._capiGiornata.forEach((params: any) => {
        console.log("cerco nota", `#note_${params.id_capo}_${params.marchio}`);
        if (document.querySelector(`#note_${params.id_capo}_${params.marchio}`)) {
          console.log("trovata nota", `#note_${params.id_capo}_${params.marchio}`);
          (document.querySelector(`#note_${params.id_capo}_${params.marchio}`) as HTMLTextAreaElement).value = params.note
        }
      })
    }, 0);
  }

  /**
   * Aggiunge il capannone alla lista già presente
   */
  addCapannone(): void {
    this.formCapannone.updateValueAndValidity();
    if (this.formCapannone.invalid) return;

    console.log("formCapannone.value:", this.formCapannone.value);
    console.log("Capi Giornata:", this._capiGiornata);

    const params = {
      id_capo: this.formCapannone.get('capannone')?.value.id,
      marchio: this.formCapannone.get('capannone')?.value.identificativo,
      note: this.formCapannone.get('note')?.value,
      pos: this._capiGiornata ? this._capiGiornata.length : 0,
      sesso: null,
      dt_nascita: null,
      dt: this.formCapannone.get('capannone')?.value.dt,
      selectable: false,
      selected: true,
      selezionabile: true,
      selezionato: false
    };

    if (!this._capiGiornata) this._capiGiornata = [];
    let oldRef = this._capiGiornata;
    oldRef.push(params);
    this._capiGiornata = [...oldRef];
    console.log("Capi Giornata:", this._capiGiornata);
  }

  // Gestisce la map per i piani per ogni capo
  managePiani(evt: any, id_piano: number, i: number): void {
    const id_capo: number = parseInt(evt.target.attributes.id_capo.value);

    // Se il capo non ha già una voce nella map allora viene creata
    if (!this._mapPiani?.get(id_capo)) this._mapPiani?.set(id_capo, []);

    // Se il checkbox viene selezionato allora viene aggiunto l'id
    if (evt.target.checked === true) {
      this._mapPiani?.get(id_capo).push(id_piano);
    }
    else {
      let idx: number = this._mapPiani?.get(id_capo).indexOf(id_piano);
      if (idx !== -1) {
        this._mapPiani?.get(id_capo).splice(idx, 1);
      }
    }
    console.log("this._mapPiani:", this._mapPiani);
  }

  // Gestisce la map per i piani per ogni pool
  managePool(evt: any, id_piano: number, i: number): void {
    const pool: number = parseInt(evt.target.attributes.pool.value);
    console.log("pool:", pool);

    // Se il pool non ha già una voce nella map allora viene creata
    if (!this._mapPool?.get(pool)) this._mapPool.set(pool, []);

    // Se il checkbox viene selezionato allora viene aggiunto l'id
    if (evt.target.checked === true) {
      this._mapPool?.get(pool).push(id_piano);
    }
    else {
      let idx: number = this._mapPool?.get(pool).indexOf(id_piano);
      if (idx !== -1) {
        this._mapPool?.get(pool).splice(idx, 1);
      }
    }
    console.log("this._mapPool:", this._mapPool);
  }

  selectCapo(evt: any, c: any): void {
    console.log("evt:", evt);
    const DOMInput = (document.querySelectorAll(`input[id_capo='${c.id_capo}']`));
    const DOMSelect = (document.querySelector(`select[id_capo='${c.id_capo}']`));
    console.log("DOMInput:", DOMInput);
    console.log("DOMSelect:", DOMSelect);

    if (evt.target.checked) {
      DOMSelect?.removeAttribute('disabled');
      DOMInput.forEach((el: Element) => {
        el.removeAttribute('disabled');
      })
    } else {
      DOMSelect?.setAttribute('disabled', 'true');
      DOMInput.forEach((el: Element) => {
        el.setAttribute('disabled', 'true');
      })
    }
  }


  /**
   * Recupera il valore attuale della casella di input per rimuoverlo da tutti
   * i numeri di provetta. In questo modo è possibile evitare che non venga
   * considerato come valore libero se viene modificato.
   * @param evt focus della casella di input
   */
  saveOldValue(evt: Event): void {
    const inputelement = <HTMLInputElement>evt.target;
    console.log("inputelement.value:", inputelement.value);
    this._oldInputValue = parseInt(inputelement.value);
  }

  /**
   * Seleziona tutti i piani per tutti i capi/pool attivi.
   * Nel codice mcp sta per "Marchio_Capo_Piano"
   */
  selectAllPiani(): void {
    if (!this.isPool) {

      if (this.tabella?.selectedData.length === 0) { return; }
      // this._selectPianiButton.toggle();

      this.tabella?.selectedData.forEach((r: any, i: number) => {
        this._piani.forEach((p: any) => {
          let checkboxes = document.querySelectorAll(`[mcp='${r.marchio}_${r.id_capo}_${p.id_piano}']`);
          for (let i = 0; i < checkboxes.length; i++) {
            let checkbox = checkboxes[i] as HTMLInputElement;
            checkbox.checked = this._checkAll;

            // Gestisci la map dei piani
            if (this._checkAll === true) {
              if (!this._mapPiani?.get(r.id_capo)) this._mapPiani?.set(r.id_capo, []);
              this._mapPiani?.get(r.id_capo).push(p.id_piano);
            } else {
              this._mapPiani?.set(r.id_capo, []);
            }
          }


          /*
          if (document.querySelector(`[mcp='${r.marchio}_${r.id_capo}_${p.id_piano}']`)) {
            (document.querySelector(`[mcp='${r.marchio}_${r.id_capo}_${p.id_piano}']`) as HTMLInputElement).checked = this._checkAll;

            // Gestisci la map dei piani
            if (this._checkAll === true) {
              if (!this._mapPiani?.get(r.id_capo)) this._mapPiani?.set(r.id_capo, []);
              this._mapPiani?.get(r.id_capo).push(p.id_piano);
            } else {
              this._mapPiani?.set(r.id_capo, []);
            }
          }
          */
        });
      });
      console.log("this._mapPiani:", this._mapPiani);
    } else {
      this._poolGiornata.forEach((pg: any) => {
        this._piani.forEach((p: any) => {
          if (document.querySelector(`[pool_piano='${pg.pool}_${p.id_piano}']`)) {
            (document.querySelector(`[pool_piano='${pg.pool}_${p.id_piano}']`) as HTMLInputElement).checked = this._checkAll;

            // Gestisci la map dei piani
            if (this._checkAll === true) {
              if (!this._mapPool?.get(pg.pool)) this._mapPool.set(pg.pool, []);
              this._mapPool?.get(pg.pool).push(p.id_piano);
            } else {
              this._mapPool.set(pg.pool, []);
            }
          }
        })
      })
      console.log("this._mapPool:", this._mapPool);
    }

    this._checkAll = !this._checkAll;
  }

  // Scegli la modale da aprire
  openModal(): void {
    console.log('openModal')
    if (this.tipo_dettaglio == 'MANUALE') {
      this._capiGiornataModal?.toggle();
      return;
    }
    if (this.tipo_dettaglio === 'CAPANNONE') {
      this._capannoneModal?.toggle();
    } else {
      this._capiGiornataModal?.toggle();
    }
  }

  checkInputProvetta(event: Event) {
    let target = event.target as HTMLInputElement;
    let value = target.value;
    if (+value < 1) target.value = '1';
  }

  goBack(): void { this._location.back(); }
  idMarchio(marchio: string) { return 'barcode_' + marchio; }

  get capiGiornata() { return this._capiGiornata; }
  get poolGiornata() { return this._poolGiornata; }
  get capiInPool() { return this._capiInPool; }
  get ui() { return this._ui; }
  get ui_pool() { return this._ui_pool; }
  get matrici() { return this._matrici; }
  get piani() { return this._piani; }
  get uiCapiPool() { return this._uiCapiPool; }
  get capiModal() { return this._capiModal; }
  get uiModal() { return this._uiModal; }
  get fields() { return this._fields; }
  get dayInfo() { return this._dayInfo; }
  get marchi() { return this._marchi; }
  get codici_pool() { return this._codici_pool; }
  get dataFromFile() { return this._dataFromFile; }
  get selectedData() { return this.tabella?.selectedData; }
  get selectedPool() { return this._selectedPool; }
  get dataFromFileLength() { return this._dataFromFile!.length!; }
  get selectedDataLength() {
    return this.tabella?.selectedData ? this.tabella?.selectedData?.length : 0;
  }
  get tipo_dettaglio() { return this._tipo_dettaglio; }
  get capannoniAllevamento() { return this._capannoniAllevamento; }
  private get id_intervento() { return parseInt(this.dayInfo?.id_intervento); }
  private get id_giornata() { return parseInt(this.dayInfo?.id_giornata); }

  trovaBuchi(arrayInput: string[]) {

    let array: number[] = [];
    arrayInput.forEach((el: any) => {
      array.push(parseInt(el));
    });
    array.sort(function (a, b) {  return a - b;  })

    let buchi = [];
    for(let i = 0; i < array.length - 1; i++) {
        // Se l'elemento successivo non è consecutivo, allora c'è un "buco"
        if((array[i]) + 1 !== (array[i + 1])) {
            // Aggiungi tutti i numeri mancanti al array dei "buchi"
            for(let j = (array[i]) + 1; j < (array[i + 1]); j++) {
                buchi.push(j);
            }
        }
    }

    return buchi;
  }


}
