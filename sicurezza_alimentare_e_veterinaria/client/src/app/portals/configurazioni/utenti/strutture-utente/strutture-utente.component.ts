/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ATreeComponent, ATreeNodeComponent, LoadingDialogService } from '@us/utils';
import { ConfigurazioniService } from '../../configurazioni.service';
import * as bootstrap from 'bootstrap';
import { FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-strutture-utente',
  templateUrl: './strutture-utente.component.html',
  styleUrls: ['./strutture-utente.component.scss']
})
export class StruttureUtenteComponent {

  @ViewChild('struttureTree') struttureTree?: ATreeComponent;
  _strutture_tree: any

  mappaturaAlberi = ((node: any) => {
    node.selectable = true
    node.disabled = true
    return node
  })

  private id_utente: any
  private _utente: any
  private _ui_utente: any

  modalMode: 'add' | 'upd' = 'add'
  private modalStrutture?: bootstrap.Modal
  private modalUtente?: bootstrap.Modal
  private _strutture: any
  private _ui_strutture: any
  private _qualifiche: any

  emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/

  formUtente = this.fb.group({
    id_utente: this.fb.control(null, [Validators.required]),
    id_qualifica: this.fb.control(null, [Validators.required]),
    mail: this.fb.control(null, [Validators.pattern(this.emailPattern)]),
    tel: this.fb.control(null),
    inizio: this.fb.control('', [Validators.required]),
    fine: this.fb.control('')
  })

  formStruttura = this.fb.group({
    id_utente: this.fb.control(null, [Validators.required]),
    id_struttura: this.fb.control(null, [Validators.required]),
    inizio: this.fb.control('', [Validators.required]),
    fine: this.fb.control('')
  })

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private LoadingService: LoadingDialogService,
    private cs: ConfigurazioniService
  ) { }

  ngOnInit() {
    this.LoadingService.openDialog()
    this.route.queryParams.subscribe((res: any) => {
      this.id_utente = res['id_utente'];
      this.cs.getUtenteSingolo(this.id_utente).subscribe((res: any) => {
        if (res.esito) {
          this._ui_utente = res.info.ui;
          this._utente = res.info.dati[0]

          this.cs.getStruttureUtente(this.id_utente).subscribe((res: any) => {
            if (res.esito) {
              this._ui_strutture = res.info.ui
              this._strutture = res.info.dati

              this.cs.getQualifiche().subscribe((res: any) => {
                if (res.info) {
                  this._qualifiche = res.info.dati
                  this.LoadingService.closeDialog()
                }
              })
            }
          })
        }
      })
    })

    this.modalStrutture = new bootstrap.Modal('#modal-struttura')
    this.modalUtente = new bootstrap.Modal('#modal-utente')
  }

  aggiungiStruttura() {
    this.modalMode = 'add'
    this.formStruttura.reset()
    this.formStruttura.controls.id_utente.setValue(this._utente.id_utente)
    this.cs.getStruttureByAsl(this._utente.id_asl).subscribe((res: any) => {
      if (res.info) {
        this._strutture_tree = res.info
        this.modalStrutture?.toggle()
      }
    })
  }

  modificaStruttura(struttura: any) {
    console.log(struttura)
    this.modalMode = 'upd'
    this.formStruttura.reset()
    this.formStruttura.controls.id_utente.setValue(struttura.id_utente)
    this.formStruttura.controls.id_struttura.setValue(struttura.id_utente_struttura)
    this.formStruttura.controls.inizio.setValue((struttura.inizio_validita ?? 'T').split('T')[0])
    this.formStruttura.controls.fine.setValue((struttura.fine_validita ?? 'T').split('T')[0])
    this.modalStrutture?.toggle()
  }

  onTreeNodeClick(node: ATreeNodeComponent) {
    if (node.isLeafNode()) {
      //let parentId = node.parentComponent?.id
      this.struttureTree?.nodes?.forEach((ele: ATreeNodeComponent) => {
        //if (ele.parentComponent?.id == parentId)
        ele.selected = false
      })
      console.log(node)
      node.selected = true
      //this.id_struttura = node.data.id
      this.formStruttura.controls.id_struttura.setValue(node.data.id)
    }
  }

  salva(action: any) {
    if(!this.formStruttura.valid) {
      return;
    }
    let params = {
      id_utente: this.formStruttura.value.id_utente,
      id_struttura: this.formStruttura.value.id_struttura,
      inizio: this.formStruttura.value.inizio != '' ? this.formStruttura.value.inizio : null,
      fine: this.formStruttura.value.fine != '' ? this.formStruttura.value.fine : null
    }

    if (action == 'add') {
      this.cs.aggiungiStrutturaUtente(params).subscribe((res: any) => {
        if (res.esito) {
          this.modalStrutture?.hide()
          this.ngOnInit()
        }
      })
    }

    if (action == 'upd') {
      this.cs.modificaStrutturaUtente(params).subscribe((res: any) => {
        if (res.esito) {
          this.modalStrutture?.hide()
          this.ngOnInit()
        }
      })
    }
  }

  goToDettaglio(id_utente_struttura: any) {
    this.router.navigate(['portali/configurazioni/utenti/dettaglio/ruoli'], { queryParams: { id_utente_struttura: id_utente_struttura } });
  }

  goToModifica() {
    this.formUtente.reset()
    this.formUtente.controls.id_utente.setValue(this._utente.id_utente)
    this.formUtente.controls.id_qualifica.setValue(this._utente.id_qualifica)
    this.formUtente.controls.mail.setValue(this._utente.mail)
    this.formUtente.controls.tel.setValue(this._utente.tel)
    this.formUtente.controls.inizio.setValue((this._utente.inizio_validita ?? 'T').split('T')[0])
    this.formUtente.controls.fine.setValue((this._utente.fine_validita ?? 'T').split('T')[0])
    this.modalUtente?.toggle()
  }

  modificaUtente() {
    let params = {
      id_utente: this.formUtente.value.id_utente,
      id_qualifica: this.formUtente.value.id_qualifica,
      mail: this.formUtente.value.mail,
      tel: this.formUtente.value.tel,
      inizio: this.formUtente.value.inizio,
      fine: this.formUtente.value.fine != '' ? this.formUtente.value.fine : null
    }
    console.log(params)

    this.cs.modificaUtente(params).subscribe((res: any) => {
      if (res.esito) {
        this.modalUtente?.hide()
        this.ngOnInit()
      }
    })
  }

  checkDate(event: any, form: any) {
    const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
    let src = event.srcElement
    let nomeForm = null;
    Object.keys(form.controls).forEach((controlName) => {
      if (controlName === 'inizio' || controlName === 'fine') {
        nomeForm = controlName;
      }
    })
    if (!src.validity.valid || !regex.test(src.value)) form.get(nomeForm).setValue("")

    form.updateValueAndValidity()
  }

  get utente() { return this._utente }
  get ui_utente() { return this._ui_utente }
  get strutture() { return this._strutture }
  get ui_strutture() { return this._ui_strutture }
  get qualifiche() { return this._qualifiche }

}
