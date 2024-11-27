/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, ViewChild } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { ATreeComponent, ATreeNodeComponent, BackendCommunicationService, LoadingDialogService, NotificationService, toTree } from '@us/utils';
import { AppService } from 'src/app/app.service';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';
import { anagraficaUnicaService } from '../services/anagraficaUnica.service';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'app-nucleo-ispettivo-cu-refactoring',
  templateUrl: './nucleo-ispettivo-cu-refactoring.component.html',
  styleUrls: ['./nucleo-ispettivo-cu-refactoring.component.scss']
})
export class NucleoIspettivoCuRefactoringComponent {

  //@ViewChild(ASmartTableComponent) table?: ASmartTableComponent;
  @ViewChild('risorseTree') risorseTree?: ATreeComponent;


  private form_ui: any
  private _id_cu: any
  private _cu: any
  private _nucleo: any
  private _ui_nucleo: any
  private _personale: any
  private _ui_personale: any
  private _esterni: any
  private _ui_esterni: any
  private _piani: any
  private _ui_piani: any

  private _anag: any
  private _anag_tot: any
  private _ui_anag: any
  private _soggetti: any
  private _ui_soggetti: any

  tipoVerificaAnagrafica: 'soggetti' | 'assistiti' = 'soggetti'

  data_min: any //= "1900-01-01"
  ora_min: any

  data_max: any
  ora_max: any

  private _risorseTree: any
  private _ruoli_nucleo: any
  private _ruoli_personale: any
  private _ruoli_personale_selezionabili: any = []

  private modalNucleo?: bootstrap.Modal;
  private modalPersonale?: bootstrap.Modal;
  private modalEsterni?: bootstrap.Modal;

  private modalAnagraficaAssistiti?: bootstrap.Modal;
  private modalDichiarazioni?: bootstrap.Modal;

  private _dichiarazioni: any;
  private _id_cu_nucleo: any;
  private dichiarazione: any;
  private _datiCodiciNascita: any;

  maggiorenne: any
  btnMode: any
  controllo_chiuso: boolean = false;
  tipoModale: "add" | "upd" | 'view' = "add";
  errore_data: boolean = true;
  errore_data_nascita: boolean = false;

  formNucleo = this.fb.group({
    id_nucleo_periodo: this.fb.control(""),
    id_nominativo: this.fb.control("", Validators.required),
    id_struttura: this.fb.control("", Validators.required),
    id_cu_piano: this.fb.control("", Validators.required),
    id_tipo_isp: this.fb.control("", Validators.required),
    inizio: this.fb.control("", Validators.required),
    ora_ini: this.fb.control("", Validators.required),
    fine: this.fb.control("", Validators.required),
    ora_fin: this.fb.control("", Validators.required)
  })

  formPersonale: any = this.fb.group({
    id_cu_nucleo: this.fb.control(""),
    nome: this.fb.control(null, [Validators.required]),
    cognome: this.fb.control(null, [Validators.required]),
    dt_nascita: this.fb.control(null, [Validators.required]),
    comune_nascita: this.fb.control(null, [Validators.required]),
    cf: this.fb.control(null,),
    ruolo: this.fb.control("", Validators.required),
    inizio: this.fb.control("", Validators.required),
    ora_ini: this.fb.control("", Validators.required),
    fine: this.fb.control("", Validators.required),
    ora_fin: this.fb.control("", Validators.required)
  })

  formEsterni: any = this.fb.group({
    id_cu_nucleo: this.fb.control(""),
    nome: this.fb.control(null, [Validators.required]),
    cognome: this.fb.control(null, [Validators.required]),
    dt_nascita: this.fb.control(null,),
    comune_nascita: this.fb.control(null,),
    cf: this.fb.control(null,),
    ruolo: this.fb.control("", [Validators.required]),
    inizio: this.fb.control("", Validators.required),
    ora_ini: this.fb.control("", Validators.required),
    fine: this.fb.control("", Validators.required),
    ora_fin: this.fb.control("", Validators.required)
  })

  formNuovaDichiarazione = this.fb.group({
    dichiarazione: this.fb.control("", Validators.required)
  });

  constructor(
    private ComunicazioneDB: BackendCommunicationService,
    private LoadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private app: AppService,
    private fb: FormBuilder,
    private notificationService: NotificationService,
    private changeDetector: ChangeDetectorRef,
    private aus: anagraficaUnicaService,
    private cus: ControlliUfficialiService
  ) { }

  ngOnInit() {
    this.LoadingService.openDialog()

    const data: any = new Date()
    this.maggiorenne = (data.getFullYear() - 18).toString() + '-' + data.getMonth().toString() + '-' + data.getDay().toString();
    this.maggiorenne = new Date(this.maggiorenne).toISOString().split('T')[0];

    this.route.queryParams.subscribe((res: any) => {
      this.cus.getCodiciNascita().subscribe((res: any) => {
        //console.log(res);
        this._datiCodiciNascita = res.info.dati;
      })
      this._id_cu = res['id_cu']

      this.cus.getNucleoCU(+this._id_cu).subscribe((res: any) => {
        this._ui_nucleo = res.info.ui;
        this._nucleo = res.info.dati;
        this.controllo_chiuso = res.info.controllo_chiuso

        this.cus.getCuSingolo(this._id_cu).subscribe((res: any) => {
          this._cu = res.info.dati[0]
          this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
          this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'cuNucleo')) ?? { mode: 'view' } //se non è definito
          this.btnMode = this.form_ui.mode == 'view'

          this.data_min = new Date(this._cu.data_min).toISOString().split('T')[0];
          this.ora_min = new Date(this._cu.data_min).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });
          this.data_max = new Date(this._cu.data_max).toISOString().split('T')[0];
          this.ora_max = new Date(this._cu.data_max).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });
        });

        this.cus.getPersonaleCU(+this._id_cu).subscribe((res: any) => {
          this._ui_personale = res.info.ui;
          this._personale = res.info.dati;

          this.cus.getEsterniCU(+this._id_cu).subscribe((res: any) => {
            this._ui_esterni = res.info.ui;
            this._esterni = res.info.dati;

            this.cus.getTipiPersonale().subscribe(res => {
              if (res.esito)
                this._ruoli_personale = res.info.dati;
            });
            this.LoadingService.closeDialog();
          })
        })

      })

      this.cus.getTipiIspettori(this._id_cu).subscribe(res => {
        if (res.esito) {
          this._ruoli_nucleo = res.info.dati;
          this.ComunicazioneDB.getDati('get_cu_piani', { id_cu: parseInt(this._id_cu) }).subscribe((res: any) => {
            if (res.esito) {
              this._piani = res.info.dati;
              this._ui_piani = res.info.ui;
            }
          });
        }
      });

    })
    this.modalNucleo = new bootstrap.Modal('#modal-nucleo');
    this.modalPersonale = new bootstrap.Modal('#modal-personale');
    this.modalEsterni = new bootstrap.Modal('#modal-esterni');
    this.modalDichiarazioni = new bootstrap.Modal('#modal-dichiarazioni');
    this.modalAnagraficaAssistiti = new bootstrap.Modal('#modal-anagrafica-assistiti');

  }

  setDateDefault() {
    if (this._cu.cu_inizio == null || this._cu.cu_fine == null)
      return

    let dateI = new Date(this._cu.cu_inizio).toISOString().split('T')[0];
    let timeI = new Date(this._cu.cu_inizio).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });
    let dateF = new Date(this._cu.cu_fine).toISOString().split('T')[0];
    let timeF = new Date(this._cu.cu_fine).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });

    this.formNucleo.controls['inizio'].setValue(dateI);
    this.formNucleo.controls['ora_ini'].setValue(timeI);
    this.formNucleo.controls['fine'].setValue(dateF);
    this.formNucleo.controls['ora_fin'].setValue(timeF);

    this.formEsterni.controls['inizio'].setValue(dateI);
    this.formEsterni.controls['ora_ini'].setValue(timeI);
    this.formEsterni.controls['fine'].setValue(dateF);
    this.formEsterni.controls['ora_fin'].setValue(timeF);

    this.formPersonale.controls['inizio'].setValue(dateI);
    this.formPersonale.controls['ora_ini'].setValue(timeI);
    this.formPersonale.controls['fine'].setValue(dateF);
    this.formPersonale.controls['ora_fin'].setValue(timeF);
  }

  openModal(form: 'Nucleo' | 'Personale' | 'Esterni', tipo: 'upd' | 'add', ar: any) {
    if (this.btnMode == true || this.controllo_chiuso == true) {
      return
    }
    this.LoadingService.openDialog()
    this.tipoModale = tipo;
    if (form === 'Nucleo') {
      this.preparaNucleo(ar)
    }
    if (form === 'Personale') {
      this.preparaPersonale(ar)
    }
    if (form === 'Esterni') {
      this.preparaEsterni(ar)
    }
    //console.log(form, tipo, ar);
  }


  preparaNucleo(ar: any) {
    //chiamata x creazione albero
    this.formNucleo.reset()
    this.resetPiano()
    if (this.tipoModale == 'add') {
      this.setDateDefault()
      if (Object.keys(this._piani).length == 1) {
        this.selezionaPiano(this._piani[0].id_cu_piano)
      }
      this.app.getNominativiUosByAsl().subscribe(res => {
        if (res.esito) {
          this._risorseTree = res.info;
          this.risorseTree!.root = toTree(this._risorseTree, node => {
            node.expanded = node.parent == null ? true : false;
            return node;
          }).root;

          this.modalNucleo?.toggle()
        }
        this.LoadingService.closeDialog()
      });
    } else {
      if (this.tipoModale == 'upd') {
        this.selezionaPiano(ar.id_cu_piano)
        this.formNucleo.controls.id_nucleo_periodo.setValue(ar.id_nucleo_periodo)
        this.formNucleo.controls.id_tipo_isp.setValue(ar.descr_isp)
        this.formNucleo.controls.id_nominativo.setValue(ar.nominativo)
        this.formNucleo.controls.id_struttura.setValue(ar.descrizione_struttura)

        if (ar.inizio != null && ar.fine != null) {
          let dateI = new Date(ar.inizio).toISOString().split('T')[0];
          let timeI = new Date(ar.inizio).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });
          let dateF = new Date(ar.fine).toISOString().split('T')[0];
          let timeF = new Date(ar.fine).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });

          this.formNucleo.controls['inizio'].setValue(dateI);
          this.formNucleo.controls['ora_ini'].setValue(timeI);
          this.formNucleo.controls['fine'].setValue(dateF);
          this.formNucleo.controls['ora_fin'].setValue(timeF);
        }
      }
      this.LoadingService.closeDialog()
      this.modalNucleo?.toggle()
    }
    this.formNucleo.updateValueAndValidity()
  }

  preparaPersonale(ar: any) {
    this._ruoli_personale_selezionabili = []
    this.formPersonale.reset()
    // if (this._ruoli_personale == undefined) {
    //   this.cus.getTipiPersonale().subscribe(res => {
    //     if (res.esito)
    //       this._ruoli_personale = res.info.dati;
    //   });
    // }
    if (this.tipoModale == 'add') {
      let cntLeg = 0
      this._personale.forEach((ele: any) => {
        if (ele.sigla_per == 'leg') {
          cntLeg++
        }
      })

      if (cntLeg >= 1) {
        this._ruoli_personale.forEach((ele: any) => {
          if (ele.sigla != 'leg') this._ruoli_personale_selezionabili.push(ele)
        })
      } else {
        this._ruoli_personale_selezionabili = this._ruoli_personale
      }

      if (Object.keys(this._personale).length == 0) {
        this._ruoli_personale_selezionabili = this._ruoli_personale
      }

      // console.log(this._personale)
      // console.log(this._ruoli_personale)
      // console.log(this._ruoli_personale_selezionabili)

      this.setDateDefault()
      this.LoadingService.closeDialog()
    } else {
      if (this.tipoModale == 'upd') {
        this._ruoli_personale_selezionabili = this._ruoli_personale
        if (ar.inizio != null && ar.fine != null) {
          let dateI = new Date(ar.inizio).toISOString().split('T')[0];
          let timeI = new Date(ar.inizio).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });
          let dateF = new Date(ar.fine).toISOString().split('T')[0];
          let timeF = new Date(ar.fine).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });

          this.formPersonale.controls['inizio'].setValue(dateI);
          this.formPersonale.controls['ora_ini'].setValue(timeI);
          this.formPersonale.controls['fine'].setValue(dateF);
          this.formPersonale.controls['ora_fin'].setValue(timeF);
        }

        this.formPersonale.controls.id_cu_nucleo.setValue(ar.id_cu_nucleo)
        this.formPersonale.controls.nome.setValue(ar.nome)
        this.formPersonale.controls.cognome.setValue(ar.cognome)
        this.formPersonale.controls.dt_nascita.setValue(ar.dt_nascita)
        this.formPersonale.controls.comune_nascita.setValue(ar.comune_nascita)
        this.formPersonale.controls.cf.setValue(ar.cf)
        this.formPersonale.controls.ruolo.setValue(ar.id_tipo_per)

        this.LoadingService.closeDialog()
      }
    }
    this.modalPersonale?.toggle()
    this.formPersonale.updateValueAndValidity()
  }

  preparaEsterni(ar: any) {
    this.formEsterni.reset()
    if (this.tipoModale == 'add') {
      this.setDateDefault()
      this.LoadingService.closeDialog()
    } else {
      if (this.tipoModale == 'upd') {
        if (ar.inizio != null && ar.fine != null) {
          let dateI = new Date(ar.inizio).toISOString().split('T')[0];
          let timeI = new Date(ar.inizio).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });
          let dateF = new Date(ar.fine).toISOString().split('T')[0];
          let timeF = new Date(ar.fine).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });

          this.formEsterni.controls['inizio'].setValue(dateI);
          this.formEsterni.controls['ora_ini'].setValue(timeI);
          this.formEsterni.controls['fine'].setValue(dateF);
          this.formEsterni.controls['ora_fin'].setValue(timeF);
        }
        this.formEsterni.controls.id_cu_nucleo.setValue(ar.id_cu_nucleo)
        this.formEsterni.controls.nome.setValue(ar.nome)
        this.formEsterni.controls.cognome.setValue(ar.cognome)
        this.formEsterni.controls.dt_nascita.setValue(ar.dt_nascita)
        this.formEsterni.controls.comune_nascita.setValue(ar.comune_nascita)
        this.formEsterni.controls.cf.setValue(ar.cf)
        this.formEsterni.controls.ruolo.setValue(ar.ruolo)

        this.LoadingService.closeDialog()
      }
    }
    this.modalEsterni?.toggle()
    this.formPersonale.updateValueAndValidity()
  }

  onTreeNodeClick(node: ATreeNodeComponent) {
    let sel: true | false = true;
    if (node.isLeafNode()) {

      //deseleziona tutti i nodi
      this.risorseTree?.getSelectedLeafNodes().forEach((ele) => {
        ele.selected = false;
        ele.htmlElement.className = '';
      })

      //seleziona quello cliccato
      node.selected = true
      node.htmlElement.className = 'selected'

      //this._risorsaSel = node.data
      //console.log(node.data)
      this.formNucleo.controls.id_nominativo.setValue(node.data.id_nominativo)
      this.formNucleo.controls.id_struttura.setValue(node.data.id_struttura)
    }
  }

  resetPiano() {
    let rows = document.querySelectorAll('button[id^="riga_"]');
    rows.forEach((el: any) => {
      el.className = "btn btn-secondary ms-auto"
      el.innerHTML = '<i class="fa-regular fa-square"></i>'
      // el.innerText = "Seleziona"
    })
    this.formNucleo.controls.id_cu_piano.setValue("")
  }

  selezionaPiano(idPiano: any) {
    let rows = document.querySelectorAll('button[id^="riga_"]');
    this.resetPiano()
    rows.forEach((el: any) => {
      if (el.id == 'riga_' + idPiano) {
        el.className = "btn btn-primary ms-auto"
        el.innerHTML = '<i class="fa-solid fa-square-check"></i>'
        // el.innerText = "Selezionato"
      }
    })
    //this._pianoSel = idPiano;
    //console.log(idPiano)
    this.formNucleo.controls.id_cu_piano.setValue(idPiano)
  }

  aggiungiNucleo() {
    if (!this.formNucleo.valid) {
      return;
    }
    if (this.formNucleo.value != null) {
      let params = {
        id_cu: +this._id_cu,
        id_nominativo: this.formNucleo.value.id_nominativo != null ? +this.formNucleo.value.id_nominativo : null,
        id_struttura: this.formNucleo.value.id_struttura != null ? +this.formNucleo.value.id_struttura : null,
        id_cu_piano: this.formNucleo.value.id_cu_piano != null ? +this.formNucleo.value.id_cu_piano : null,
        id_tipo_isp: this.formNucleo.value.id_tipo_isp != null ? +this.formNucleo.value.id_tipo_isp : null,
        inizio: this.formNucleo.value.inizio + 'T' + this.formNucleo.value.ora_ini,
        fine: this.formNucleo.value.fine + 'T' + this.formNucleo.value.ora_fin
      }
      if (params.inizio == params.fine) params.fine = params.fine + ':01'

      this.ComunicazioneDB.updDati('upd_cu_add_nucleo', params).subscribe((res: any) => {
        if (!res.esito) {
          return;
        }
        window.location.reload()
      })
    }
  }

  aggiungiPersonale() {
    if (!this.formPersonale.valid) {
      return;
    }
    if (!this.datiCodiciNascita.map((elem: any) => elem.denominazione_it).includes(this.formPersonale.value.comune_nascita?.toUpperCase())) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: "Attenzione! Comune di nascita non inserito correttamente."
      });
      return;
    }
    let params = {
      id_cu: +this._id_cu,
      nome: this.formPersonale.value.nome,
      cognome: this.formPersonale.value.cognome,
      dt_nascita: this.formPersonale.value.dt_nascita,
      comune_nascita: this.formPersonale.value.comune_nascita,
      cf: this.formPersonale.value.cf,
      ruolo: this.formPersonale.value.ruolo != null ? +this.formPersonale.value.ruolo : null,
      inizio: this.formPersonale.value.inizio + 'T' + this.formPersonale.value.ora_ini,
      fine: this.formPersonale.value.fine + 'T' + this.formPersonale.value.ora_fin
    }
    if (params.inizio == params.fine) params.fine = params.fine + ':01'

    this.ComunicazioneDB.updDati('upd_cu_add_personale', params).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      window.location.reload()
    })
  }

  aggiungiEsterni() {
    if (!this.formEsterni.valid) {
      return;
    }
    if (this.formEsterni.value.comune_nascita) {
      if (!this.datiCodiciNascita.map((elem: any) => elem.denominazione_it).includes(this.formEsterni.value.comune_nascita?.toUpperCase())) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: "Attenzione! Comune di nascita non inserito correttamente."
        });
        return;
      }
    }
    let params = {
      id_cu: +this._id_cu,
      inizio: this.formEsterni.value.inizio + 'T' + this.formEsterni.value.ora_ini,
      fine: this.formEsterni.value.fine + 'T' + this.formEsterni.value.ora_fin,
      nome: this.formEsterni.value.nome,
      cognome: this.formEsterni.value.cognome,
      dt_nascita: this.formEsterni.value.dt_nascita ? this.formEsterni.value.dt_nascita : null,
      comune_nascita: this.formEsterni.value.comune_nascita,
      cf: this.formEsterni.value.cf,
      ruolo: this.formEsterni.value.ruolo
    }
    if (params.inizio == params.fine) params.fine = params.fine + ':01'

    this.ComunicazioneDB.updDati('upd_cu_add_esterno', params).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      window.location.reload()
    })
  }

  rimuoviNucleo(ar: any) {
    if (this.btnMode == true || this.controllo_chiuso == true) {
      return
    }
    this.ComunicazioneDB.updDati('upd_cu_del_nucleo', { id_cu_nucleo: ar.id_cu_nucleo, id_cu_nucleo_periodo: ar.id_nucleo_periodo }).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      window.location.reload()
    })
  }

  rimuoviPersonale(ar: any) {
    if (this.btnMode == true || this.controllo_chiuso == true) {
      return
    }
    this.ComunicazioneDB.updDati('upd_cu_del_personale', { id_cu_nucleo: ar.id_cu_nucleo, id_cu_nucleo_periodo: ar.id_nucleo_periodo }).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      window.location.reload()
    })
  }

  rimuoviEsterni(ar: any) {
    if (this.btnMode == true || this.controllo_chiuso == true) {
      return
    }
    this.ComunicazioneDB.updDati('upd_cu_del_esterno', { id_cu_nucleo: ar.id_cu_nucleo, id_cu_nucleo_periodo: ar.id_nucleo_periodo }).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      window.location.reload()
    })
  }

  aggiornaNucleo() {
    if (!this.formNucleo.valid) {
      return;
    }
    let params = {
      inizio: this.formNucleo.value.inizio + 'T' + this.formNucleo.value.ora_ini,
      fine: this.formNucleo.value.fine + 'T' + this.formNucleo.value.ora_fin,
      id_cu_piano: this.formNucleo.value.id_cu_piano,
      id_nucleo_periodo: this.formNucleo.value.id_nucleo_periodo != null ? +this.formNucleo.value.id_nucleo_periodo : null
    }
    if (params.inizio == params.fine) params.fine = params.fine + ':01'

    this.ComunicazioneDB.updDati('upd_cu_upd_date_NI', params).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      window.location.reload()
    })
  }

  aggiornaPersonale() {
    if (!this.formPersonale.valid) {
      return;
    }
    let params = {
      inizio: this.formPersonale.value.inizio + 'T' + this.formPersonale.value.ora_ini,
      fine: this.formPersonale.value.fine + 'T' + this.formPersonale.value.ora_fin,
      ruolo: this.formPersonale.value.ruolo != null ? +this.formPersonale.value.ruolo : null,
      id_cu_nucleo: this.formPersonale.value.id_cu_nucleo != null ? +this.formPersonale.value.id_cu_nucleo : null,
    }
    if (params.inizio == params.fine) params.fine = params.fine + ':01'

    this.ComunicazioneDB.updDati('upd_cu_upd_date_per', params).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      window.location.reload()
    })
  }

  aggiornaEsterni() {
    if (!this.formEsterni.valid) {
      return;
    }
    let params = {
      inizio: this.formEsterni.value.inizio + 'T' + this.formEsterni.value.ora_ini,
      fine: this.formEsterni.value.fine + 'T' + this.formEsterni.value.ora_fin,
      ruolo: this.formEsterni.value.ruolo,
      id_cu_nucleo: this.formEsterni.value.id_cu_nucleo != null ? +this.formEsterni.value.id_cu_nucleo : null,
    }
    if (params.inizio == params.fine) params.fine = params.fine + ':01'

    this.ComunicazioneDB.updDati('upd_cu_upd_date_ce', params).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      window.location.reload()
    })
  }

  openDichiarazioni(idCuNucleo: any) {
    this._dichiarazioni = null;
    this.formNuovaDichiarazione.controls.dichiarazione.setValue(null)
    this._id_cu_nucleo = +idCuNucleo;
    this.cus.getDichiarazioniPersonaleCu(idCuNucleo).subscribe(res => {
      if (res.esito && res.info != null) {
        //vedi
        this._dichiarazioni = res.info.dati[0];
        this.formNuovaDichiarazione.controls.dichiarazione.setValue(this._dichiarazioni.dichiarazione);
        this.apriModaleDichiarazioni('view');
      } else {
        //aggiungi
        this.apriModaleDichiarazioni('add');
      }
    });

  }

  apriModaleDichiarazioni(tipo: 'add' | 'view') {
    this.tipoModale = tipo;
    this.modalDichiarazioni?.toggle();
  }

  addDichiarazioni() {
    if (this.btnMode == true || this.controllo_chiuso == true || !this.formNuovaDichiarazione.valid) {
      return;
    }
    this.modalDichiarazioni?.hide();
    //this.LoadingService.openDialog();

    this.dichiarazione = {
      id_cu_nucleo: this._id_cu_nucleo,
      dichiarazione: this.formNuovaDichiarazione.value.dichiarazione
    }
    this.cus.addDichiarazioniPersonaleCu(this.dichiarazione).subscribe((res: any) => {
      if (res.esito) {
        //this.ngOnInit();
        window.location.reload()
      }
    });
  }

  verificaAnagraficaAssistiti() {
    if (((!this.formPersonale.value.nome || !this.formPersonale.value.cognome) &&
      !this.formPersonale.value.cf) ||
      this.tipoModale == 'upd') {
      return;
    }
    this.LoadingService.openDialog()
    this.tipoVerificaAnagrafica = 'assistiti'
    this._ui_anag = null;
    this._anag = null;
    this._anag_tot = null;
    let params: any;

    //Ricerca per nome e cognome
    if (this.formPersonale.get('nome')?.value && this.formPersonale.get('cognome')?.value && !this.formPersonale.get('cf')?.value) {
      params = {
        nome: this.formPersonale.get('nome')?.value,
        cognome: this.formPersonale.get('cognome')?.value
      }
    }
    //Ricerca per codice fiscale
    else if (this.formPersonale.get('cf')?.value && !this.formPersonale.get('nome')?.value && !this.formPersonale.get('cognome')?.value) {
      params = {
        cf: this.formPersonale.get('cf')?.value
      }
    }
    //Ricerca per nome, cognome e codice fiscale
    else if (this.formPersonale.get('nome')?.value && this.formPersonale.get('cognome')?.value && this.formPersonale.get('cf')?.value) {
      params = {
        cf: this.formPersonale.get('cf')?.value,
        nome: this.formPersonale.get('nome')?.value,
        cognome: this.formPersonale.get('cognome')?.value
      }
    }
    else {
      this.notificationService.push({
        notificationClass: 'warning',
        content: "La ricerca sul sistema regionale deve essere effettuata per nome e cognome oppure per codice fiscale."
      });
      this.LoadingService.closeDialog();
      return;
    }

    this.aus.ricercaAnagrafica(params).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      if (res.CodiceRitorno == "0") {
        this._ui_anag = res.info.ui;
        //Map per estrapolare l'array di oggetti dell'anagrafica
        this._anag_tot = res.info.dati
        this._anag = res.info.dati.map((elem: any) => elem.Anagrafica);
        // console.log("dati Anagrafica Tot", this._anag_tot);
        // console.log("dati Anagrafica", this._anag);
      }
      else if (res.CodiceRitorno == -1) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: "Persona non presente nell'anagrafica assistita"
        });
        return;
      } else if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: "Servizio non disponibile."
        });
        return;
      }
      this.modalPersonale?.hide();
      this.modalAnagraficaAssistiti?.toggle();
    })
  }

  compilaAssistito(ar: any) {
    this.formPersonale.patchValue({
      nome: ar.Nome,
      cognome: ar.Cognome,
      cf: ar.CodiceFiscale,
      dt_nascita: ar.NascitaData,
      comune_nascita: ar.NascitaLuogo.Descrizione,
      // ruolo: "",
      // inizio: "",
      // ora_ini: "",
      // fine: "",
      // ora_fin: "",
    })
    this.modalAnagraficaAssistiti?.hide();
    this.modalPersonale?.toggle();
  }

  verificaSoggettiFisici() {
    if (((!this.formPersonale.value.nome || !this.formPersonale.value.cognome) &&
      !this.formPersonale.value.cf) ||
      this.tipoModale == 'upd') {
      return;
    }
    this.LoadingService.openDialog()
    this.tipoVerificaAnagrafica = 'soggetti'

    let params = {
      nome: this.formPersonale.value.nome,//this.formRicerca.value.nome,
      cognome: this.formPersonale.value.cognome,//this.formRicerca.value.cognome,
      cf: this.formPersonale.value.cf,//this.formRicerca.value.cf,
      comune_nascita: "",//this.formRicerca.value.comune_nascita,
      data_nascita: "",//this.formRicerca.value.data_nascita,
      limite: 1000,//this.formRicerca.value.limite ? +this.formRicerca.value.limite : null
    }
    this.cus.getSoggettiBySel(params).subscribe((res: any) => {
      if (res.esito) {
        this._ui_soggetti = res.info.ui
        this._soggetti = res.info.dati
      } else {
        //this._ui_stabilimenti = null
        this._soggetti = null
      }
      this.LoadingService.closeDialog()

      this.modalPersonale?.hide()
      this.modalAnagraficaAssistiti?.toggle()
    });

  }

  compilaSoggetto(ar: any) {
    console.log(ar)
    this.formPersonale.patchValue({
      nome: ar.nome,
      cognome: ar.cognome,
      cf: ar.codice_fiscale,
      dt_nascita: ar.data_nascita,
      comune_nascita: ar.comune_nascita_descr,
    })

    this.modalAnagraficaAssistiti?.hide();
    this.modalPersonale?.toggle();
  }

  updCustode(id_cu_nucleo: any) {
    if (this.btnMode == true || this.controllo_chiuso == true) {
      return
    }
    this.cus.updFirmatarioVerbale({ id_cu_nucleo: id_cu_nucleo }).subscribe((res: any) => {
      window.location.reload()
    })
  }

  patchValue(evt: Event, field: string, form: any): void {
    form.get(field)?.setValue(evt);
  }

  checkDate(event: any, form: any) {
    //this.errore_data = false
    const regex = /^(19|20)[0-9]{2}-\d{2}-\d{2}$/ //per data
    let src = event.srcElement
    //console.log(src.value)
    //if (!src.validity.valid) src.value = src.min
    //console.log(regex.test(src.value))
    if (src.getAttribute('formControlName') === 'dt_nascita') {
      if (!src.validity.valid || !regex.test(src.value)) {
        form.controls.dt_nascita.setValue("")
        //this.errore_data_nascita = true
      }
    }

    if (src.getAttribute('formControlName') === 'inizio') {
      if (!src.validity.valid || !regex.test(src.value)) {
        form.controls.inizio.setValue("")
        // this.errore_data = true
      }
      else
        if (src.value > form.value.fine) {
          form.controls.fine.setValue("")
          //form.controls.ora_fin.setValue("")
        }

      //form.controls.ora_ini.setValue("")
    }

    if (src.getAttribute('formControlName') === 'fine') {
      if (!src.validity.valid || !regex.test(src.value)) {
        form.controls.fine.setValue("")
        // this.errore_data = true
      }
      else
        if (src.value + 'T' + form.value.ora_fin < form.value.inizio + 'T' + form.value.ora_ini) {
          form.controls.fine.setValue(form.value.inizio)
          form.controls.ora_fin.setValue(form.value.ora_ini)
        }

      //form.controls.ora_fin.setValue("")
    }


    if (src.getAttribute('formControlName') === 'ora_ini') {
      if (form.value.inizio == "" || form.value.ora_ini == "" || form.value.inizio + 'T' + src.value > form.value.fine + 'T' + src.value) {
        form.controls.ora_ini.setValue("")
        // this.errore_data = true
      }
      if (src.value > form.value.ora_fin) form.controls.ora_fin.setValue("")
    }

    if (src.getAttribute('formControlName') === 'ora_fin') {
      if (form.value.fine == "" || form.value.ora_fin == "" || form.value.fine + 'T' + src.value < form.value.inizio + 'T' + form.value.ora_ini) {
        form.controls.ora_fin.setValue("")
        // this.errore_data = true
      }
      //if (src.value < form.value.ora_ini) form.controls.ora_fin.setValue(form.value.ora_ini)
    }


    form.updateValueAndValidity()
  }

  get id_cu() { return this._id_cu }
  get cu() { return this._cu }
  get nucleo() { return this._nucleo }
  get ui_nucleo() { return this._ui_nucleo }
  get personale() { return this._personale }
  get ui_personale() { return this._ui_personale }
  get esterni() { return this._esterni }
  get ui_esterni() { return this._ui_esterni }
  get piani() { return this._piani }
  get ui_piani() { return this._ui_piani }

  get ui_anag() { return this._ui_anag }
  get anag_tot() { return this._anag_tot }
  get ui_soggetti() { return this._ui_soggetti }
  get soggetti() { return this._soggetti }

  get ruoli_nucleo() { return this._ruoli_nucleo }
  get ruoli_personale() { return this._ruoli_personale_selezionabili }
  get datiCodiciNascita() { return this._datiCodiciNascita; }
}
