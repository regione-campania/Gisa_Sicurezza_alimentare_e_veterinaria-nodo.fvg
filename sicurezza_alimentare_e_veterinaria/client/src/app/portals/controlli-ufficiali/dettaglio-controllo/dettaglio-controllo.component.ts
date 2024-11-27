/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';
import { BackendCommunicationService, LoadingDialogService, NotificationService, Utils } from '@us/utils';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import * as bootstrap from 'bootstrap';
import { FormBuilder, Validators } from '@angular/forms';
import { VerbaliCUService } from '../services/verbali-cu.service';
import Swal from 'sweetalert2';
import { allegaFileCU } from '../services/allegaFileCU.service';

@Component({
  selector: 'app-dettaglio-controllo',
  templateUrl: './dettaglio-controllo.component.html',
  styleUrls: ['./dettaglio-controllo.component.scss'],
})
export class DettaglioControlloComponent {

  controllo: any;
  form_ui: any;
  controlloChiuso: boolean = false;
  gestioneControlloModalRef?: NgbModalRef;

  private modalChiudiCU?: bootstrap.Modal;
  private modalInfoCU?: bootstrap.Modal;
  private modalNoteVerbale?: bootstrap.Modal;
  private modalNoteCU?: bootstrap.Modal;

  //Per prendere l'input type file
  @ViewChild('inputFile') nomeFileInput!: ElementRef;

  private _nomeFile: any;
  private file: any;

  checkStabilimento: "none" | "block" = "none"
  checkStabilimentoTooltip: any
  checkNucleo: "none" | "block" = "none"
  checkNucleoTooltip: any
  checkLinee: "none" | "block" = "none"
  checkLineeTooltip: any
  checkPiani: "none" | "block" = "none"
  checkPianiTooltip: any
  checkOggetti: "none" | "block" = "none"
  checkOggettiTooltip: any
  checkProvvedimenti: "none" | "block" = "none"
  checkProvvedimentiTooltip: any
  checkProvvedimentiFU: "none" | "block" = "none"
  checkProvvedimentiTooltipFU: any
  checkProvvedimentiAS: "none" | "block" = "none"
  checkProvvedimentiTooltipAS: any
  checkCategoriaRischio: "none" | "block" = "none"
  checkCategoriaRischioTooltip: any
  checkTrasportatori: "none" | "block" = "none"
  checkTrasportatoriTooltip: any

  btnChiudi: boolean = false
  btnClose: boolean = false
  btnSave: boolean = false
  showPec: boolean = false
  showPreavviso: boolean = false

  allegatiPresenti: "none" | "block" = "none"

  private _id_cu: any;
  private _id_cu_app: any;
  private _id_cu_pdf: any;
  private _stati_cu: any;

  data_min: any //= "1900-01-01"
  ora_min: any
  data_min_periodo: any
  ora_min_periodo: any
  errore_data: boolean = false;

  emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/

  formInfo = this.fb.group({
    // azione: this.fb.control(""),
    id_cu: this.fb.control(0, Validators.required),
    rilievi: this.fb.control(false),
    preavviso: this.fb.control(false),
    dt_preavviso: this.fb.control(""),
    ora_preavviso: this.fb.control(""),
    mezzo_preavviso: this.fb.control(""),
    invia_pec: this.fb.control(false),
    pec: this.fb.control(null, Validators.pattern(this.emailPattern)),
    km_az: this.fb.control(null),
    km_pr: this.fb.control(null),
    // dt: this.fb.control("", Validators.required)
  });

  formChiusura = this.fb.group({
    id_stato: this.fb.control(0, Validators.required),
    dt: this.fb.control("", Validators.required),
    ora_chiusura: this.fb.control(null, Validators.required),
  });

  formNoteCu = this.fb.group({
    note: this.fb.control("",)
  });

  formNoteVerbale = this.fb.group({
    note: this.fb.control("",)
  });

  pdf: any;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private fb: FormBuilder,
    private cus: ControlliUfficialiService,
    private loading: LoadingDialogService,
    private modalEngine: NgbModal,
    private notificationService: NotificationService,
    private changeDetector: ChangeDetectorRef,
    private vs: VerbaliCUService,
    private client: BackendCommunicationService,
    private cc: allegaFileCU,
  ) { }

  ngOnInit(): void {
    this.route.queryParams.subscribe(params => {
      let id = +params['id_cu'];
      this._id_cu = +id;
      if (!id) this.router.navigate(['../'], { relativeTo: this.route });
      else {
        this.loading.openDialog('Caricamento dettaglio...');
        this.cus.getCuInfo(id).subscribe(res => {
          this.controllo = res.info;
          this.form_ui = JSON.parse(this.controllo.cu_form_ui[0].str_conf)


          this.data_min_periodo = new Date(this.controllo.cu_periodo.cu_fine ? this.controllo.cu_periodo.cu_fine : this.controllo.cu.dt).toISOString().split('T')[0];
          this.ora_min_periodo = new Date(this.controllo.cu_periodo.cu_fine ? this.controllo.cu_periodo.cu_fine : this.controllo.cu.dt).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' })
          this.data_min = new Date(this.controllo.cu.dt).toISOString().split('T')[0];
          this.ora_min = new Date(this.controllo.cu.dt).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });

          this.checkAll() //chiude il dialog di caricamento
        });

        this.getAllegati();
      }
    })

    this.modalChiudiCU = new bootstrap.Modal('#modal-chiudi-cu');
    this.modalInfoCU = new bootstrap.Modal('#modal-info-cu');
    this.modalNoteVerbale = new bootstrap.Modal('#modal-note-verbale');
    this.modalNoteCU = new bootstrap.Modal('#modal-note-cu');
  }

  checkAll() {
    Promise.all([
      new Promise(resolve => {
        this.cus.checkStabilimentoCU(this._id_cu).subscribe(res => {
          resolve(true)
          if (!res.esito) {
            this.checkStabilimento = "block"
            this.checkStabilimentoTooltip = res.msg
          }
        })
      }),

      new Promise(resolve => {
        this.cus.checkNucleiCU(this._id_cu).subscribe(res => {
          resolve(true)
          if (!res.esito) {
            this.checkNucleo = "block"
            this.checkNucleoTooltip = res.msg
          }
        })
      }),

      new Promise(resolve => {
        this.cus.checkProvvedimentiCU(this._id_cu).subscribe(res => {
          resolve(true)
          if (!res.esito) {
            this.checkProvvedimenti = "block"
            this.checkProvvedimentiTooltip = res.msg
          }
        });
      }),

      new Promise(resolve => {
        if (this.controllo.cu.sigla_tecnica == 'CU' || this.controllo.cu.sigla_tecnica == 'CT') {
          this.cus.checkOggettiCU(this._id_cu).subscribe(res => {
            resolve(true)
            if (!res.esito) {
              this.checkOggetti = "block"
              this.checkOggettiTooltip = res.msg
            }
          });
        } else {
          resolve(true)
        }
      }),

      new Promise(resolve => {
        if (this.controllo.cu.sigla_tecnica == 'CU') {
          this.cus.checkCategoriaRischioCU(this._id_cu).subscribe(res => {
            resolve(true)
            if (!res.esito) {
              this.checkCategoriaRischio = "block"
              this.checkCategoriaRischioTooltip = res.msg
            }
          })
        } else {
          resolve(true)
        }
      }),

      new Promise(resolve => {
        if (this.controllo.cu.sigla_tecnica == 'FU') {
          this.cus.checkProvvedimentiFU(this._id_cu).subscribe(res => {
            resolve(true)
            if (!res.esito) {
              this.checkProvvedimentiFU = "block"
              this.checkProvvedimentiTooltipFU = res.msg
            }
          });
        } else {
          resolve(true)
        }
      }),

      new Promise(resolve => {
        if (this.controllo.cu.sigla_tecnica == 'CT') {
          this.cus.checkAutomezziCT(this._id_cu).subscribe(res => {
            resolve(true)
            if (!res.esito) {
              this.checkTrasportatori = "block"
              this.checkTrasportatoriTooltip = res.msg
            }
          });
        } else {
          resolve(true)
        }
      })


    ]).then(() => {
      this.loading.closeDialog()
    })

  }

  ngAfterViewChecked(): void {
    if (this.checkTrasportatori == "block" || this.checkCategoriaRischio == "block" || this.checkStabilimento == "block" || this.checkNucleo == "block" || this.checkOggetti == "block" || this.checkProvvedimenti == "block" || this.checkProvvedimentiFU == 'block')
      this.btnChiudi = false;
    else
      this.btnChiudi = true;


    this.formInfo.valid ? this.btnSave = true : this.btnSave = false;
    this.formChiusura.valid ? this.btnClose = true : this.btnClose = false;
    this.controlloChiuso = this.controllo?.cu.chiuso;
    this.changeDetector.detectChanges();
  }


  openGestioneControllo(template: any) {
    this.gestioneControlloModalRef = this.modalEngine.open(template, {
      modalDialogClass: "system-modal",
      size: 'md',
    })
  }

  closeGestioneControllo() {
    this.gestioneControlloModalRef?.close();
  }

  goToLinee() {
    this.router.navigate(['portali', 'controlli-ufficiali', 'dettaglio', 'linee'], { queryParams: { id_cu: 59 } });
  }

  saveCheck() {
    if (this.mode_sezione('cuInfo') == 'upd' || !this.controllo.cu.chiuso || this.btnSave == false) {
      return;
    }
    this.modalInfoCU?.hide()
    let info = {
      id_cu: this._id_cu,
      rilievi: this.formInfo.value.rilievi,
      preavviso: this.formInfo.value.preavviso,
      dt_preavviso: this.formInfo.value.dt_preavviso && this.formInfo.value.ora_preavviso ? this.formInfo.value.dt_preavviso + 'T' + this.formInfo.value.ora_preavviso : null,
      mezzo_preavviso: this.formInfo.value.mezzo_preavviso,
      invia_pec: this.formInfo.value.invia_pec,
      pec: this.formInfo.value.pec,
      km_az: this.formInfo.value.km_az != null ? +this.formInfo.value.km_az : null,
      km_pr: this.formInfo.value.km_pr != null ? +this.formInfo.value.km_pr : null
      //dt: this.formChiusura.value.dt
    }
    this.cus.updCuInfo(info).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit()
      }
    })
  }

  openModal() {
    if (this.btnChiudi == false && this.mode_sezione('cuInfo') == 'upd') {
      return;
    }
    this.formChiusura.setValue({
      id_stato: null,
      dt: "",
      ora_chiusura: null
    })
    this.formChiusura.updateValueAndValidity()

    this.cus.getStatiCU().subscribe((res: any) => {
      if (res.esito) {
        this._stati_cu = res.info.stati_cu
      }
    })
    this.modalChiudiCU?.toggle();
  }

  openModalInfo() {
    this.formInfo.setValue({
      id_cu: this._id_cu,
      rilievi: this.controllo.cu.rilievi,
      preavviso: this.controllo.cu.preavviso,
      dt_preavviso: this.controllo.cu.dt_preavviso ? new Date(this.controllo.cu.dt_preavviso).toISOString().split('T')[0] : "",
      ora_preavviso: this.controllo.cu.dt_preavviso ? new Date(this.controllo.cu.dt_preavviso).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' }) : "",
      mezzo_preavviso: this.controllo.cu.mezzo_preavviso,
      invia_pec: this.controllo.cu.pec != null && this.controllo.cu.pec != "" ? true : false,
      pec: this.controllo.cu.pec,
      km_az: this.controllo.cu.km_az,
      km_pr: this.controllo.cu.km_pr
    })
    this.controllo.cu.pec != null && this.controllo.cu.pec != "" ? this.showPec = true : this.showPec = false
    this.controllo.cu.preavviso ? this.showPreavviso = true : this.showPreavviso = false;
    this.modalInfoCU?.toggle();
  }

  openNoteVerbale() {
    this.formNoteVerbale.controls.note.setValue(this.controllo.cu.note_verbale);
    this.modalNoteVerbale?.toggle();
  }

  openNoteGenerali() {
    this.formNoteCu.controls.note.setValue(this.controllo.cu.note_generali);
    this.modalNoteCU?.toggle();
  }

  addNoteVerbale() {
    if (this.controllo.cu.chiuso || this.mode_sezione('cuNoteVerbale') == 'view') {
      return
    }
    this.modalNoteVerbale?.hide();
    this.cus.updNoteVerbale({ "id_cu": this._id_cu, "note": this.formNoteVerbale.value.note }).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
      }
    });
  }

  addNoteGenerali() {
    if (this.controllo.cu.chiuso || this.mode_sezione('cuNoteGenerali') == 'view') {
      return;
    }
    this.modalNoteCU?.hide();
    this.cus.updNoteGenerali({ "id_cu": this._id_cu, "note": this.formNoteCu.value.note }).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
      }
    });
  }

  togglePec() {
    if (this.showPec) {
      this.showPec = false
      //this.formInfo.controls.pec.setValue("");
    } else {
      this.showPec = true
    }
  }

  togglePreavviso() {
    if (this.showPreavviso) {
      this.showPreavviso = false
      this.formInfo.controls.dt_preavviso.setValue("");
      this.formInfo.controls.mezzo_preavviso.setValue("");
    } else {
      this.showPreavviso = true
    }
  }

  close() {
    if (this.btnClose == false) {
      return;
    }
    this.cus.chiudiCU({ "id_cu": this._id_cu, "dt": this.formChiusura.value.dt + 'T' + this.formChiusura.value.ora_chiusura, "id_stato_cu": this.formChiusura.value.id_stato }).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
      }
    })
    this.modalChiudiCU?.hide();
  }

  generaPDF() {
    if (this.btnChiudi == false) {
      return;
    }
    this.cus.getCuInfoPerVerbale(this._id_cu).subscribe((res: any) => {
      if (res.esito) {
        let cu = res.info;
        //chiamata x verbale
        if (cu.nuovoPdf == true) {
          Object.assign(
            cu
            , { isProvv: cu.cu_provv?.length > 0 ? true : false }
          )

          this.vs.downloadVerbaleCU(cu, cu.nuovoPdf, 'verbaleCU').subscribe((data) => {
            const url = URL.createObjectURL(data);
            const a = document.createElement('a');
            a.href = url;
            a.download = `verbale_cu_${this._id_cu}.pdf`;
            //upload file in documenti.pdf
            //new File([blob], nome_file)
            this.cc.AllegaPDF(new File([data], a.download), this._id_cu, "verbale_cu").subscribe()
            a.click();
            setTimeout(function () {
              a.remove();
              URL.revokeObjectURL(url);
            }, 100);
          })
        } else {
          this.cc.getPDFAllegati(this._id_cu, 'verbale_cu').subscribe(res => {
            if (res.esito) {
              this.downloadPDF(res.files[0].id)
            }
          })
        }
      }
    });

  }

  getAllegati() {
    this._nomeFile = [];
    //Funzione DB per andare a prendere i nomi dei file caricati per quel controllo
    this.cc.getPDFAllegati(this._id_cu, 'controllo_ufficiale').subscribe((res: any) => {
      this._nomeFile = res.files;

      if (res.files.length > 0)
        this.allegatiPresenti = 'block'
      else
        this.allegatiPresenti = 'none'
    })
    this._id_cu_app = this._id_cu;
  }

  allegaVerbaleDaConfigurare(event: any, id: any) {
    this._id_cu_pdf = id;
    if (event.target.files == 0) {
      return;
    }
    this.file = event.target.files;
  }

  uploadFile() {
    if (this.controllo.cu.chiuso || this.mode_sezione('cuInfo') == 'view') {
      return;
    }
    if (this.file) {
      for (let i = 0; i < this.file.length; i++) {
        this.pdf = this.file[i];
        this.checkPdfSize(this.pdf);
        //Funzione che manda il file al server
        this.cc.AllegaPDF(this.pdf, this._id_cu_pdf, "controllo_ufficiale").subscribe((res: any) => {
          if (!res.esito) {
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Errore nel caricamento del file',
            });
            return;
          }
          this.nomeFileInput.nativeElement.value = '';
          this.getAllegati();
        })
      }
    }
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

  delAllegato(id_allegato: any) {
    if (this.controllo.cu.chiuso || this.mode_sezione('cuInfo') == 'view') {
      return;
    }
    this.cc.EliminaPDF(id_allegato).subscribe((res: any) => {
      this.nomeFileInput.nativeElement.value = '';
      this.getAllegati();
    })
  }

  downloadPDF(id_allegato: any) {
    this.cc.DownloadPDF(id_allegato).subscribe((res: any) => {
      Utils.download(res.body, `${res.headers.get('content-disposition').split('filename="')[1].replaceAll('"', '')}`)
    })
  }

  checkNaN(event: any) {
    const regex = new RegExp('^[0-9]+$');
    if (!regex.test(event.key) && event.key != 'Backspace' && event.key != 'Tab')
      event.preventDefault();
  }

  resetKM(tipo: 'pr' | 'az') {
    if (tipo == 'az')
      this.formInfo.controls.km_pr.setValue(null)
    if (tipo == 'pr')
      this.formInfo.controls.km_az.setValue(null)

    this.formInfo.updateValueAndValidity();
  }

  selezionaStato(idStato: any) {
    let rows = document.querySelectorAll('button[id^="riga_"]');
    rows.forEach((el: any) => {
      if (el.selezionabile == false) {
        return;
      }
      if (el.id == 'riga_' + idStato) {
        el.className = "btn btn-primary ms-auto"
        el.innerHTML = '<i class="fa-regular fa-square-check"></i>'
      }
      else {
        el.className = "btn btn-secondary ms-auto"
        el.innerHTML = '<i class="fa-regular fa-square"></i>'
      }
    })
    this.formChiusura.controls.id_stato.setValue(+idStato)
  }

  display_sezione(nomeSezione: any) {
    let check: boolean;
    this.form_ui.find((ele: any) => ele.nome === nomeSezione) != undefined ? check = true : check = false

    if (check)
      return 'flex'
    else
      return 'none'
  }

  mode_sezione(nomeSezione: any) {
    if (!this.form_ui)
      return
    let sezione = (this.form_ui.find((ele: any) => ele.nome === nomeSezione)) ?? { mode: 'view' } //se non è definito
    return sezione.mode
  }

  checkDate(event: any, form: any) {
    this.errore_data = false
    const regex = /^(19|20)[0-9]{2}-\d{2}-\d{2}$/ //per data
    let src = event.srcElement
    //dt_preavviso todo
    if (src.getAttribute('formControlName') === 'dt') {
      if (!src.validity.valid || !regex.test(src.value)) {
        form.controls.dt.setValue("")
        this.errore_data = true
      }
      form.controls.ora_chiusura.setValue("")
    }

    if (src.getAttribute('formControlName') === 'ora_chiusura') {
      if (form.value.dt == "") {
        this.errore_data = true
        return
      }
      if (form.value.dt + 'T' + src.value < this.data_min_periodo + 'T' + this.ora_min_periodo) {
        form.controls.ora_chiusura.setValue("")
        this.errore_data = true
      }
    }

    if (src.getAttribute('formControlName') === 'dt_preavviso') {
      if (!src.validity.valid || !regex.test(src.value)) {
        form.controls.dt_preavviso.setValue("")
        this.errore_data = true
      }
      form.controls.ora_preavviso.setValue("")
    }

    if (src.getAttribute('formControlName') === 'ora_preavviso') {
      if (form.value.dt_preavviso == "") {
        this.errore_data = true
        return
      }
      if (form.value.dt_preavviso + 'T' + src.value > this.data_min + 'T' + this.ora_min) {
        form.controls.ora_preavviso.setValue("")
        this.errore_data = true
      }
    }




    form.updateValueAndValidity()
  }

  get id_cu() { return this._id_cu }
  get id_cu_app() { return this._id_cu_app; }
  get nomeFile() { return this._nomeFile; }
  get stati_cu() { return this._stati_cu }
}
