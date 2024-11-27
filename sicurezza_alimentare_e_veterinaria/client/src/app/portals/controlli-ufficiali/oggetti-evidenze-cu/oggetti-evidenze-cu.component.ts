/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, ElementRef, ViewChild } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NotificationService, LoadingDialogService, BackendCommunicationService, ASmartTableComponent, Utils } from '@us/utils';
import * as bootstrap from 'bootstrap';
import { allegaFileCU } from '../services/allegaFileCU.service';
import Swal from 'sweetalert2';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';

@Component({
  selector: 'app-oggetti-evidenze-cu',
  templateUrl: './oggetti-evidenze-cu.component.html',
  styleUrls: ['./oggetti-evidenze-cu.component.scss']
})
export class OggettiEvidenzeCuComponent {

  @ViewChild('tabella') tabella?: ASmartTableComponent;
  //Per prendere l'input type file
  @ViewChild('inputFile') nomeFileInput!: ElementRef;

  tipoModale: 'upd' | 'add' = 'add'

  private _id_cu: any;
  private _cu: any;
  private _id_cu_oggetto_cl: any;
  private _ui: any
  private _evidenze: any;
  private _chiuso: any;
  private file: any;

  private _linee_cu: any;
  private _classi_evidenze: any;
  private _gradi_evidenze: any;
  private _gradi_evidenze_selezionabili: any;

  private _cl_nuovi_stati: any;

  private form_ui: any
  btnMode: any

  btnSave: boolean = false;
  btnDelete: boolean = false;
  controllo_chiuso: boolean = false;
  follow_up: boolean = false;

  info: any;

  formNuovaEvidenza = this.fb.group({
    id_evidenza: this.fb.control(null),
    id_cu_linee: this.fb.control("", Validators.required),
    id_cu_classe_evidenza: this.fb.control("", Validators.required),
    id_cu_grado_evidenza: this.fb.control("", Validators.required),
    evidenza: this.fb.control("", Validators.required),
    //risultanza: this.fb.control("", Validators.required)
  });

  formNuovoStato = this.fb.group({
    id_stato_cl: this.fb.control("", Validators.required)
  });

  private evidenza: any;
  private _eleSelezionati: any;
  private modalAdd?: bootstrap.Modal;
  private lineeSel: any[] = [];
  // private modalChiudi?: bootstrap.Modal;
  private modalAllegati?: bootstrap.Modal;
  private pdf: any;
  private _nomeFilePreso: any[] = [];
  private _nomeFile: any;
  private _arApp: any;
  private _id_evidenza: any;

  constructor(
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private fb: FormBuilder,
    private LoadingService: LoadingDialogService,
    private changeDetector: ChangeDetectorRef,
    private client: BackendCommunicationService,
    private router: Router,
    private cc: allegaFileCU,
    private cus: ControlliUfficialiService
  ) { }

  ngOnInit() {
    this.LoadingService.openDialog()

    this.route.queryParams.subscribe(params => {
      this._id_cu = parseInt(params['id_cu']);
      this._id_cu_oggetto_cl = parseInt(params['id_cu_oggetto_cl']);

      this.cus.getCuSingolo(this._id_cu).subscribe((res: any) => {
        this._cu = res.info.dati[0]
        this.follow_up = this._cu.sigla_tecnica == 'FU' || this._cu.sigla_tecnica == 'FS'
        this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
        this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'cuOggetti')) ?? { mode: 'view' } //se non è definito
        this.btnMode = this.form_ui.mode == 'view'

      });

      this.client.getDati('get_cu_evidenze', { id_cu_oggetto_cl: this._id_cu_oggetto_cl }).subscribe((res: any) => {
        //this.LoadingService.closeDialog();
        //console.log(res);
        if (res.esito && res.info != null) {
          this._ui = res.info.ui;
          this._evidenze = res.info.dati;
          this._chiuso = res.info.chiuso;
          this.controllo_chiuso = res.info.controllo_chiuso;
          this.follow_up = res.info.follow_up;
          this.info = res.info.oggetto_cl;
        } else {
          this._evidenze = [];
        }
        this.client.getDati('get_cu_classe_evidenze', { id_tipo_oggetto: this.info.id_tipo_oggetto }).subscribe((res: any) => {
          if (res.esito) {
            this._classi_evidenze = res.info.dati;

            this.client.getDati('get_cu_grado_evidenze').subscribe((res: any) => {
              if (res.esito) {
                this._gradi_evidenze = res.info.dati;

                this.client.getDati('get_cu_linee_associate', { id_cu: this._id_cu }).subscribe((res: any) => {
                  if (res.esito) {
                    this._linee_cu = res.info.dati;
                    //this.modalAdd?.toggle();
                    this.LoadingService.closeDialog()
                  }
                });
              }
            });
          }
        });
      });


    });

    this.modalAdd = new bootstrap.Modal('#modal-add');
    //this.modalChiudi = new bootstrap.Modal('#modal-chiudi');
    this.modalAllegati = new bootstrap.Modal('#modal-allegati-evidenza');
  }

  ngAfterViewChecked(): void {
    if (this.tabella?.selectedData.length != 0 && !this.btnMode) this.btnDelete = true; else this.btnDelete = false;
    this.changeDetector.detectChanges();
  }

  checkClasse(event: any) {
    if (event.target.selectedOptions[0].value != null) {
      this._classi_evidenze.forEach((ele: any) => {
        if (ele.id_cu_classe_evidenza == event.target.selectedOptions[0].value) {
          //if (ele.sigla == 'C' || ele.sigla == 'S' || ele.sigla == 'NA') {
          if (new Set(['C', 'S', 'NA']).has(ele.sigla)) {
            this.formNuovaEvidenza.controls.evidenza.clearValidators();
            this.formNuovaEvidenza.controls.id_cu_grado_evidenza.clearValidators();
          } else {
            this.formNuovaEvidenza.controls.evidenza.setValidators([Validators.required]);
            this.formNuovaEvidenza.controls.id_cu_grado_evidenza.setValidators([Validators.required]);
          }
          //aggiorna valutazioni selezionabili
          this.aggiornaValutazioni(ele.sigla);
        }
      });
    }
    this.formNuovaEvidenza.controls.evidenza.setValue(this.formNuovaEvidenza.value.evidenza ? this.formNuovaEvidenza.value.evidenza : null);
    this.formNuovaEvidenza.controls.id_cu_grado_evidenza.setValue(null);
    this.formNuovaEvidenza.updateValueAndValidity();
  }

  aggiornaValutazioni(sigla: 'nc' | 'NC' | 'S' | 'C') {
    this._gradi_evidenze_selezionabili = []
    if (sigla == 'C') {
      this._gradi_evidenze.forEach((ele: any) => {
        if (ele.sigla == 'R') this._gradi_evidenze_selezionabili.push(ele)
      })
    }
    if (sigla == 'nc' || sigla == 'NC') {
      this._gradi_evidenze.forEach((ele: any) => {
        if (ele.sigla == 'I' || ele.sigla == 'N') this._gradi_evidenze_selezionabili.push(ele)
      })
    }
  }

  openModal(mode: 'add' | 'upd', ar: any) {
    this.resetLinee()
    this.tipoModale = mode
    this.formNuovaEvidenza.reset();
    this.lineeSel = [];
    if (mode == 'upd') {
      if (this.btnMode == true || this.controllo_chiuso == true || this.chiuso == null) {
        return;
      }
      if (ar.sigla_classe_evidenza == 'C' || ar.sigla_classe_evidenza == 'S') {
        this.formNuovaEvidenza.controls.evidenza.clearValidators();
        this.formNuovaEvidenza.controls.id_cu_grado_evidenza.clearValidators();
      } else {
        this.formNuovaEvidenza.controls.evidenza.setValidators([Validators.required]);
        this.formNuovaEvidenza.controls.id_cu_grado_evidenza.setValidators([Validators.required]);
      }
      this.aggiornaValutazioni(ar.sigla_classe_evidenza);
      this.formNuovaEvidenza.controls.id_evidenza.setValue(ar.id_evidenza)
      this.formNuovaEvidenza.controls.evidenza.setValue(ar.evidenza)
      //this.formNuovaEvidenza.controls.id_cu_linee.setValue(ar.lista_linee)
      //this.lineeSel = ar.lista_linee
      ar.lista_linee.forEach((linea: any) => {
        this.selezionaLinea(linea)
      })
      this.formNuovaEvidenza.controls.id_cu_grado_evidenza.setValue(ar.id_cu_grado_evidenza)
      this.formNuovaEvidenza.controls.id_cu_classe_evidenza.setValue(ar.id_cu_classe_evidenza)
      //console.log(this.formNuovaEvidenza.value)
    }
    else {
      if (this.btnMode == true || this.controllo_chiuso == true || this.chiuso == true || this.follow_up == true) {
        return;
      }
    }

    this.modalAdd?.toggle()
  }

  insert() {
    if (!this.formNuovaEvidenza.valid) {
      return;
    }
    this.modalAdd?.hide();
    this.LoadingService.openDialog();
    //parse int dei campi
    if (this.formNuovaEvidenza.value) {
      this.evidenza = {
        id_cu_oggetto_cl: this._id_cu_oggetto_cl,
        id_cu_linee: this.lineeSel,
        id_cu_classe_evidenza: this.formNuovaEvidenza.value.id_cu_classe_evidenza != null ? +this.formNuovaEvidenza.value.id_cu_classe_evidenza : null,
        id_cu_grado_evidenza: this.formNuovaEvidenza.value.id_cu_grado_evidenza != null ? +this.formNuovaEvidenza.value.id_cu_grado_evidenza : null,
        evidenza: this.formNuovaEvidenza.value.evidenza,
        risultanza: null //this.formNuovaEvidenza.value.risultanza
      }
    }
    this.client.updDati('upd_cu_add_evidenza', this.evidenza).subscribe((res: any) => {
      if (res.esito) {
        //this.ngOnInit();
        window.location.reload()
      }
    });
  }

  update() {
    if (!this.formNuovaEvidenza.valid) {
      return;
    }
    this.modalAdd?.hide();
    this.LoadingService.openDialog();
    //parse int dei campi
    if (this.formNuovaEvidenza.value) {
      this.evidenza = {
        id_evidenza: this.formNuovaEvidenza.value.id_evidenza != null ? +this.formNuovaEvidenza.value.id_evidenza : null,
        id_cu_oggetto_cl: this._id_cu_oggetto_cl,
        id_cu_linee: this.lineeSel,
        id_cu_classe_evidenza: this.formNuovaEvidenza.value.id_cu_classe_evidenza != null ? +this.formNuovaEvidenza.value.id_cu_classe_evidenza : null,
        id_cu_grado_evidenza: this.formNuovaEvidenza.value.id_cu_grado_evidenza != null ? +this.formNuovaEvidenza.value.id_cu_grado_evidenza : null,
        evidenza: this.formNuovaEvidenza.value.evidenza,
        risultanza: null //this.formNuovaEvidenza.value.risultanza
      }
    }
    this.client.updDati('upd_cu_upd_evidenza', this.evidenza).subscribe((res: any) => {
      if (res.esito) {
        //this.ngOnInit();
        window.location.reload()
      }
    });
  }

  delete() {
    if (!this.chiuso && this.btnDelete == false) {
      return;
    }
    this.LoadingService.openDialog();
    this._eleSelezionati = [];
    this.tabella?.selectedData.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id_evidenza);
    });

    this.client.updDati('upd_cu_del_evidenze', { "id_cu_evidenze": this._eleSelezionati }).subscribe((res: any) => {
      if (res.esito) {
        //this.ngOnInit();
        window.location.reload()
      }
    });
  }

  /*chiudi() {
    this.modalChiudi?.toggle();

    this.client.getDati('get_cu_cl_nuovi_stati', { "id_cu_oggetto_cl": this._id_cu_oggetto_cl }).subscribe((res: any) => {
      if (res.esito) {
        this._cl_nuovi_stati = res.info.nuovi_stati;
        if (this._cl_nuovi_stati.length == 1)
          this.formNuovoStato.setValue({ id_stato_cl: this._cl_nuovi_stati[0].id_stato_cl })
      }
    });
  }*/

  //obs
  toggleLinee(event: any) {
    if (event.target.checked && !this.lineeSel.includes(+event.target.value)) {
      this.lineeSel.push(+event.target.value);
    } else {
      this.lineeSel = this.lineeSel.filter((item) => item !== +event.target.value);
    }

    if (this.lineeSel.length == 0) {
      this.formNuovaEvidenza.controls['id_cu_linee'].setErrors({ 'incorrect': true })
    }
  }

  resetLinee() {
    let rows = document.querySelectorAll('button[id^="riga_"]');
    rows.forEach((el: any) => {
      el.className = "btn btn-secondary ms-auto"
      el.innerHTML = '<i class="fa-regular fa-square"></i>'
      //el.innerText = "Seleziona"
    })
  }

  selezionaLinea(id_linea: any) {
    let rows = document.querySelectorAll('button[id^="riga_"]');
    rows.forEach((el: any) => {
      if (el.id == 'riga_' + id_linea) {
        if (el.className == "btn btn-secondary ms-auto") {
          el.className = "btn btn-primary ms-auto"
          el.innerHTML = '<i class="fa-solid fa-square-check"></i>'
          //el.innerText = "Selezionato"
          this.lineeSel.push(id_linea)
        } else {
          el.className = "btn btn-secondary ms-auto"
          el.innerHTML = '<i class="fa-regular fa-square"></i>'
          //el.innerText = "Seleziona"
          this.lineeSel = this.lineeSel.filter((item) => item !== id_linea)
        }
      }
    })

    if (this.lineeSel.length == 0) {
      this.formNuovaEvidenza.controls['id_cu_linee'].setErrors({ 'incorrect': true })
    } else {
      this.formNuovaEvidenza.controls['id_cu_linee'].setValue('true')
    }

  }

  //Funzione che apre la modale per inserire i file
  openAllegati(ar: any) {
    this.modalAllegati?.toggle()
    console.log(this.modalAllegati?.toggle());
    this._nomeFile = [];
    //console.log("Caricamento allegati evidenza id: " + ar.id_evidenza + " ...")
    //Funzione che va a prendere i nomi dei file presenti per quell'evidenza
    this.cc.getPDFAllegati(ar.id_evidenza, 'evidenza').subscribe((res: any) => {
      console.log(res);
      this._nomeFile = res.files
    })
    this._arApp = ar;
  }

  getAllegati(id_evidenza: any) {
    this._nomeFile = [];
    //console.log("Caricamento allegati evidenza id: " + id_evidenza + " ...")
    //Funzione che va a prendere i nomi dei file presenti per quell'evidenza
    // this.client.getDati('get_cu_nomi_pdf_evidenze', { id_modulo: +id_evidenza }).subscribe((res: any) => {
    //   if (!res.esito) {
    //     return;
    //   }
    //   if (!res.info) {
    //     return;
    //   }
    //   this._nomeFile = res.info.dati;
    // })
    this.cc.getPDFAllegati(id_evidenza, 'evidenza').subscribe((res: any) => {
      this._nomeFile = res.files;
    })
  }


  allegaVerbaleDaConfigurare(event: any, ar: any) {
    this._id_evidenza = ar.id_evidenza
    if (event.target.files == 0) {
      return;
    }
    this.file = event.target.files;
    //console.log(this.file);
  }

  uploadFile() {
    if (this.btnMode == true || this.controllo_chiuso == true || this.chiuso == null) {
      return;
    }
    if (this.file) {
      for (let i = 0; i < this.file.length; i++) {
        this.pdf = this.file[i];
        this.checkPdfSize(this.pdf);
        //Funzione che manda il file al server
        this.cc.AllegaPDF(this.pdf, this._id_evidenza, "evidenza").subscribe((res: any) => {
          if (!res.esito) {
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Errore nel caricamento del file',
            });
            return;
          }
          this.nomeFileInput.nativeElement.value = '';
          this.getAllegati(this._id_evidenza);
        })
      }
    }
  }

  delAllegato(id_allegato: any, ar: any) {
    //console.log("id allegato", id_allegato);
    if (this.btnMode == true || this.controllo_chiuso == true || this.chiuso == null) {
      return;
    }
    this.cc.EliminaPDF(id_allegato).subscribe((res: any) => {
      //console.log(res);
      this.nomeFileInput.nativeElement.value = '';
      this.getAllegati(ar.id_evidenza);
    })
  }

  downloadPDF(id_allegato: any) {
    this.cc.DownloadPDF(id_allegato).subscribe((res: any) => {
      Utils.download(res.body, `${res.headers.get('content-disposition').split('filename="')[1].replaceAll('"', '')}`)
    })
  }

  checkPdfSize(file: any) {
    if (file.size / 1024 / 1024 > 20) {
      Swal.fire({
        text: 'Il pdf non può superare i 20mb',
        icon: 'warning'
      })
      return;
    }
  }


  get id_cu() { return this._id_cu; }
  get cu() { return this._cu; }
  get ui() { return this._ui; }
  get evidenze() { return this._evidenze; }
  get chiuso() { return this._chiuso; }
  get linee_cu() { return this._linee_cu; }
  get classi_evidenze() { return this._classi_evidenze; }
  get gradi_evidenze() { return this._gradi_evidenze_selezionabili; }
  get cl_nuovi_stati() { return this._cl_nuovi_stati; }
  get nomeFilePreso() { return this._nomeFilePreso; }
  get nomeFile() { return this._nomeFile; }
  get arApp() { return this._arApp; }
}
