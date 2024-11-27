/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { ConfigurazioniService } from '../../configurazioni.service';

@Component({
  selector: 'app-aggiungi-utente',
  templateUrl: './aggiungi-utente.component.html',
  styleUrls: ['./aggiungi-utente.component.scss']
})
export class AggiungiUtenteComponent {

  formUtente: FormGroup
  emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/
  disabilitaSoggFis: boolean = true
  last_cf: any

  private _asl: any
  private _qualifiche: any

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private cs: ConfigurazioniService,
    private LoadingService: LoadingDialogService,
    private notificationService: NotificationService,
  ) {
    this.formUtente = this.fb.group({
      cf: this.fb.control(null, [Validators.required]),
      nome: this.fb.control(null, [Validators.required]),
      cognome: this.fb.control(null, [Validators.required]),
      dt_nascita: this.fb.control(null, [Validators.required]),
      comune_nascita: this.fb.control(null, [Validators.required]),
      id_qualifica: this.fb.control(null, [Validators.required]),
      id_asl: this.fb.control(null, [Validators.required]),
      mail: this.fb.control(null, [Validators.pattern(this.emailPattern)]),
      tel: this.fb.control(null),
      inizio: this.fb.control(null, [Validators.required]),
      fine: this.fb.control(null)
    })
  }

  ngOnInit() {
    this.route.queryParams.subscribe((res: any) => {
      if (res['cf_utente']) {
        this.formUtente.controls['cf'].setValue(res['cf_utente'])
        this.checkCF(this.formUtente)
      }
    })
    this.cs.getStruttureAsl().subscribe((res: any) => {
      if (res.info) {
        this._asl = res.info.dati
        this.cs.getQualifiche().subscribe((res: any) => {
          if (res.info) {
            this._qualifiche = res.info.dati
          }
        })
      }
    })
  }

  checkCF(form: any): Promise<boolean> {
    let ret: any = false
    if (form.value.cf == "" || form.value.cf == null) {
      this.resetForm(form)
      return ret
    }
    this.LoadingService.openDialog()
    return new Promise((resolve) => {
      this.cs.checkEsisteCF({ cod_fis: form.value.cf }).subscribe((res: any) => {
        if (!res.esito) {
          this.resetForm(form)
          this.disabilitaSoggFis = true
          this.last_cf = null
          resolve(false) // ritorna se cf non valido
          return
        }
        this.cs.getSoggettiBySel({ cf: form.value.cf }).subscribe((res: any) => {
          if (!res.esito) {
            this.last_cf = form.value.cf
            this.disabilitaSoggFis = false
            this.resetForm(form)
            form.controls.cf.setValue(this.last_cf)
            resolve(false) // ritorna se soggetto non trovato
          } else {
            this.disabilitaSoggFis = true
            let dati = res.info.dati[0]
            form.controls.nome.setValue(dati.nome)
            form.controls.cognome.setValue(dati.cognome)
            form.controls.dt_nascita.setValue(dati.data_nascita)
            form.controls.comune_nascita.setValue(dati.comune_nascita_descr)
            resolve(true) // ritorna se OK
          }
        })
      })
    }).then((resolve) => {
      this.LoadingService.closeDialog()
      ret = resolve
      return ret
    })
  }

  resetForm(form: any) {
    form.controls.cf.setValue('')
    form.controls.nome.setValue('')
    form.controls.cognome.setValue('')
    form.controls.dt_nascita.setValue('')
    form.controls.comune_nascita.setValue('')
  }

  aggiungiUtente() {
    if (!this.checkCF(this.formUtente) || !this.formUtente.valid) {
      return;
    }
    this.cs.aggiungiUtente({ ...this.formUtente.value }).subscribe((res: any) => {
      if (res.info.id_utente) {
        this.router.navigate(['portali/configurazioni/utenti/dettaglio'], { queryParams: { id_utente: res.info.id_utente } });
      }
    })
  }

  goToAggiungiSoggettiFisici() {
    this.router.navigate(['/portali/anagrafica/soggetti-fisici/aggiungi'], { queryParams: { cf_utente: this.last_cf } })
  }

  get asl() { return this._asl }
  get qualifiche() { return this._qualifiche }
}
