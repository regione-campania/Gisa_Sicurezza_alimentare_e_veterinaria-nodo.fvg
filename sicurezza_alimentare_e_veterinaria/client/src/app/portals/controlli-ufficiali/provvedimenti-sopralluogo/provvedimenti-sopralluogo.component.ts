/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { NotificationService, LoadingDialogService, BackendCommunicationService, ATreeComponent, ATreeNodeComponent } from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';
import { FormBuilder, Validators } from '@angular/forms';
import * as bootstrap from 'bootstrap';
import { AppService } from 'src/app/app.service';

@Component({
  selector: 'app-provvedimenti-sopralluogo',
  templateUrl: './provvedimenti-sopralluogo.component.html',
  styleUrls: ['./provvedimenti-sopralluogo.component.scss']
})
export class ProvvedimentiSopralluogoComponent {

  @ViewChild('risorseTree') risorseTree?: ATreeComponent;

  _risorse_tree: any

  mappaturaAlberi = ((node: any) => {
    node.selectable = false
    return node
  })

  cu: any
  btnMode: any
  private form_ui: any
  controllo_chiuso: any
  tipoModale: 'upd' | 'add' = 'add'
  data_min: any //= "1900-01-01"
  ora_min: any
  errore_data: boolean = false

  private _ui_provv: any
  private _provv: any
  private _tipi_provv: any
  private evidenza: any
  private _linee_cu: any
  private _piani_cu: any
  private _classi_evidenze: any
  private _gradi_evidenze: any
  private _gradi_evidenze_selezionabili: any

  private modalAdd?: bootstrap.Modal
  private modalSelezionaVet?: bootstrap.Modal
  private lineeSel: any[] = []
  private pianiSel: any[] = []

  constructor(
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    public modalService: NgbModal,
    private fb: FormBuilder,
    private LoadingService: LoadingDialogService,
    private changeDetector: ChangeDetectorRef,
    private client: BackendCommunicationService,
    private cus: ControlliUfficialiService,
    private app: AppService,
  ) { }

  formNuovaEvidenza = this.fb.group({
    id_evidenza: this.fb.control(null),
    id_cu_linee: this.fb.control("", Validators.required),
    id_cu_piani: this.fb.control("", Validators.required),
    id_cu_classe_evidenza: this.fb.control("", Validators.required),
    id_cu_grado_evidenza: this.fb.control("", Validators.required),
    evidenza: this.fb.control("", Validators.required),
    id_tipo_provv: this.fb.control(0, Validators.required),
    dt: this.fb.control("")
  });

  formVet = this.fb.group({
    id_provv: this.fb.control("", Validators.required),
    id_nominativo: this.fb.control("", Validators.required)
  });

  ngOnInit() {
    this.route.queryParams.subscribe((res: any) => {
      this.LoadingService.openDialog()
      this.cus.getCuSingolo(res['id_cu']).subscribe((res: any) => {
        if (res.info) {
          this.cu = res.info.dati[0]
          this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
          this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'asProvv')) ?? { mode: 'view' } //se non è definito
          this.btnMode = this.form_ui.mode == 'view'

          this.controllo_chiuso = this.cu.chiuso
          this.data_min = new Date(this.cu.dt).toISOString().split('T')[0];
          this.client.getDati("get_cu_tipi_provv_sopralluogo", { id_cu: +this.cu.id_cu }).subscribe((res: any) => { if (res.esito) { this._tipi_provv = res.info.dati; } });

          this.client.getDati("get_cu_provv_sopralluogo", { id_cu: +this.cu.id_cu }).subscribe((res: any) => {
            if (res.info) {
              this._ui_provv = res.info.ui
              this._provv = res.info.dati
              this.client.getDati('get_cu_classe_evidenze').subscribe((res: any) => {
                if (res.esito) {
                  this._classi_evidenze = res.info.dati;

                  this.client.getDati('get_cu_grado_evidenze').subscribe((res: any) => {
                    if (res.esito) {
                      this._gradi_evidenze = res.info.dati;

                      this.client.getDati('get_cu_linee_associate', { id_cu: +this.cu.id_cu }).subscribe((res: any) => {
                        if (res.esito) {
                          this._linee_cu = res.info.dati;

                          this.client.getDati('get_cu_piani_associati', { id_cu: +this.cu.id_cu }).subscribe((res: any) => {
                            if (res.esito) {
                              this._piani_cu = res.info.dati
                              this.LoadingService.closeDialog()
                            }
                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          })
        }
      })

    })

    this.modalAdd = new bootstrap.Modal('#modal-add');
    this.modalSelezionaVet = new bootstrap.Modal('#modal-vet');
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
      this.formVet.controls.id_nominativo.setValue(node.data.id_nominativo)

    }
  }

  checkClasse(event: any) {
    if (event.target.selectedOptions[0].value != null) {
      this._classi_evidenze.forEach((ele: any) => {
        if (ele.id_cu_classe_evidenza == event.target.selectedOptions[0].value) {
          if (ele.sigla == 'C' || ele.sigla == 'S') {
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

  checkTipoProvv(event: any) {
    if (event.target.selectedOptions[0].value != null) {
      this._tipi_provv.forEach((ele: any) => {
        if (ele.id_tipo_provv == event.target.selectedOptions[0].value) {
          if (ele.data_richiesta == true) {
            this.formNuovaEvidenza.controls.dt.setValidators([Validators.required]);
          } else {
            this.formNuovaEvidenza.controls.dt.clearValidators();
          }
        }
      });
    }
    this.formNuovaEvidenza.controls.dt.setValue(this.formNuovaEvidenza.value.dt ? this.formNuovaEvidenza.value.dt : null);
    this.formNuovaEvidenza.updateValueAndValidity();
  }

  openModal(mode: 'add' | 'upd', ar: any) {
    if (this.btnMode == true || this.controllo_chiuso == true) {
      return;
    }
    this.resetLinee()
    this.resetPiani()
    this.tipoModale = mode
    this.formNuovaEvidenza.reset();
    this.lineeSel = [];
    this.pianiSel = [];
    if (mode == 'upd') {
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

    this.modalAdd?.toggle()
  }

  openVet(ar: any) {
    if (this.btnMode == true || this.controllo_chiuso == true) {
      return;
    }
    this.formVet.controls.id_provv.setValue(ar.id)
    this.app.getNominativiUosByAsl().subscribe((res: any) => {
      if (res.esito) {
        this._risorse_tree = res.info;
        this.modalSelezionaVet?.toggle()
      }
    })
  }

  resetLinee() {
    let rows = document.querySelectorAll('button[id^="riga_"]');
    rows.forEach((el: any) => {
      el.className = "btn btn-secondary ms-auto"
      el.innerHTML = '<i class="fa-regular fa-square"></i>'
      //el.innerText = "Seleziona"
    })
  }

  resetPiani() {
    let rows = document.querySelectorAll('button[id^="piano_riga_"]');
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

  selezionaPiano(id_piano: any) {
    let rows = document.querySelectorAll('button[id^="piano_riga_"]');
    rows.forEach((el: any) => {
      if (el.id == 'piano_riga_' + id_piano) {
        if (el.className == "btn btn-secondary ms-auto") {
          el.className = "btn btn-primary ms-auto"
          el.innerHTML = '<i class="fa-solid fa-square-check"></i>'
          //el.innerText = "Selezionato"
          this.pianiSel.push(id_piano)
        } else {
          el.className = "btn btn-secondary ms-auto"
          el.innerHTML = '<i class="fa-regular fa-square"></i>'
          //el.innerText = "Seleziona"
          this.pianiSel = this.pianiSel.filter((item) => item !== id_piano)
        }
      }
    })

    if (this.pianiSel.length == 0) {
      this.formNuovaEvidenza.controls['id_cu_piani'].setErrors({ 'incorrect': true })
    } else {
      this.formNuovaEvidenza.controls['id_cu_piani'].setValue('true')
    }

  }

  insert() {
    if (!this.formNuovaEvidenza.valid) {
      return;
    }
    this.modalAdd?.hide();
    //parse int dei campi 
    if (this.formNuovaEvidenza.value) {
      this.evidenza = {
        id_cu: +this.cu.id_cu,
        id_cu_linee: this.lineeSel,
        id_cu_piani: this.pianiSel,
        id_cu_classe_evidenza: this.formNuovaEvidenza.value.id_cu_classe_evidenza != null ? +this.formNuovaEvidenza.value.id_cu_classe_evidenza : null,
        id_cu_grado_evidenza: this.formNuovaEvidenza.value.id_cu_grado_evidenza != null ? +this.formNuovaEvidenza.value.id_cu_grado_evidenza : null,
        evidenza: this.formNuovaEvidenza.value.evidenza,
        id_tipo_provv: this.formNuovaEvidenza.value.id_tipo_provv != null ? +this.formNuovaEvidenza.value.id_tipo_provv : null,
        dt: this.formNuovaEvidenza.value.dt != "" ? this.formNuovaEvidenza.value.dt : null
      }
    }
    this.client.updDati('upd_cu_add_provv_sopralluogo', this.evidenza).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
        //window.location.reload()
      }
    });
  }

  delete(ar: any) {
    if (this.btnMode == true || this.controllo_chiuso == true) {
      return;
    }
    this.client.updDati('upd_cu_del_provv_sopralluogo', { id: [ar.id] }).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
        //window.location.reload()
      }
    });
  }

  updVet() {
    if (!this.formVet.valid) {
      return;
    }
    this.modalSelezionaVet?.hide()
    this.LoadingService.openDialog()
    this.client.updDati('upd_cu_upd_vet_provv_sopralluogo', { ...this.formVet.value }).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      if (res.esito) {
        this.ngOnInit();
        //window.location.reload()
      }
    });
  }

  checkDate(event: any, form: any) {
    this.errore_data = false
    const regex = /^(19|20)[0-9]{2}-\d{2}-\d{2}$/ //per data
    let src = event.srcElement

    if (!src.validity.valid || !regex.test(src.value)) {
      form.controls.dt.setValue("")
      this.errore_data = true
    }

    form.updateValueAndValidity()
  }

  get ui_provv() { return this._ui_provv }
  get provv() { return this._provv }
  get linee_cu() { return this._linee_cu; }
  get piani_cu() { return this._piani_cu; }
  get classi_evidenze() { return this._classi_evidenze; }
  get gradi_evidenze() { return this._gradi_evidenze_selezionabili; }
  get tipi_provv() { return this._tipi_provv }
}
