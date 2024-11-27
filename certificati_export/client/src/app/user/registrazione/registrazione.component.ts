/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { UserService } from '../user.service';
import { LoadingDialogService } from '@us/utils';
import Swal from 'sweetalert2';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-registrazione',
  templateUrl: './registrazione.component.html',
  styleUrls: ['./registrazione.component.scss']
})
export class RegistrazioneComponent implements OnInit {
  private _stabilimenti: any;
  private _ragioni_sociali: any;
  private _rs_no_dup: any;
  private _rs_selected: any;
  private _filtered_stab: any;
  userData: any;

  formRegistrazione: FormGroup = this.fb.group({
    nome: this.fb.control(null, Validators.required),
    cognome: this.fb.control(null, Validators.required),
    codice_fiscale: this.fb.control(null, Validators.required),
    email: this.fb.control(null, Validators.required),
    ragione_sociale: this.fb.control(null),
    id_stabilimento: this.fb.control(null, Validators.required),
    superuser: this.fb.control(false),
    check: this.fb.control(null, Validators.required),
    registrazione_responsabile: this.fb.control(true)
  });

  constructor(
    private us: UserService,
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private ls: LoadingDialogService
  ) { }

  ngOnInit(): void {
    this.route.queryParams.subscribe((res) => {
      console.log("userData", res);
      if(!res || Object.getOwnPropertyNames(res).length === 0){
        this.router.navigate(['login']);
        return;
      }
      this.userData = res;
      this.formRegistrazione.get('nome')?.setValue(this.userData.firstName);
      this.formRegistrazione.get('cognome')?.setValue(this.userData.lastName)
      this.formRegistrazione.get('codice_fiscale')?.setValue(this.userData.fiscalCode)
      this.formRegistrazione.get('check')?.setValue(this.userData.crypt)

      this.us.getVWStabilimenti(res).subscribe((res: any) => {
        console.log("res", res);
        if (res.length === 0) { return; }
        this._stabilimenti = res;
        this._ragioni_sociali = this._stabilimenti.map((s: any) => s.ragione_sociale);
        this._rs_no_dup = [...new Set(this._ragioni_sociali)];
        console.log("this._stabilimenti:", this._stabilimenti);
        console.log("this._ragioni_sociali:", this._ragioni_sociali);
        console.log("this._rs_no_dup:", this._rs_no_dup);
      });

    })
  }

  onSubmit(): void {
    for (const key of Object.keys(this.formRegistrazione.controls)) {
      if (typeof this.formRegistrazione.get(key)?.value === 'string') {
        this.formRegistrazione.get(key)?.setValue((this.formRegistrazione.get(key)?.value).trim());
      }
    }

    console.log("this.formRegistrazione.value:", this.formRegistrazione.value);
    this.formRegistrazione.updateValueAndValidity();

    if (!this.formRegistrazione.valid) {
      Swal.fire({
        title: 'Attenzione',
        text: 'Attenzione! È necessario compilare tutti i campi correttamente.',
        icon: 'warning',
        timer: 1500,
        timerProgressBar: true,
        allowOutsideClick: false
      })
      return;
    };
    console.log("this.formRegistrazione.value:", this.formRegistrazione.value);
    this.ls.openDialog('Salvataggio in corso');
    this.us.insAccessStabilimento(this.formRegistrazione.value).subscribe((res: any) => {
      this.ls.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        Swal.fire({
          title: 'Errore',
          text: 'Attenzione! Errore durante la registrazione.',
          icon: 'error',
          timer: 1500,
          timerProgressBar: true,
          allowOutsideClick: false
        });
        /*
        this.notificationService.push({
          notificationClass: 'error',
          content: `Attenzione! Errore durante la registrazione.`
        });
        */
        return;
      }
      this.ls.openDialog('Invio email in corso');
      this.us.sendEmailRegistrazione(this.formRegistrazione.value).subscribe((res: any) => {
        this.ls.closeDialog();
        Swal.fire({
          title: 'Successo',
          text: 'Registrazione avvenuta con successo. Riceverai una mail di attivazione account all\'indirizzo indicato',
          icon: 'success',
          allowOutsideClick: false
        }).then((result) => {
          if (result.dismiss === Swal.DismissReason.timer || result.isConfirmed) {
            this.us.logoutSPID('');
            //this.router.navigate(['login'])
          }
        });
      })
      
      /*
      this.notificationService.push({
        notificationClass: 'success',
        content: 'Registrazione avvenuta con successo'
      });
      setTimeout(() => { history.back(); }, 1500);
      */
    });
  }

  selezionaRagioneSociale(rs: any): void {
    console.log("rs:", rs);
    this._rs_selected = rs;

    this.formRegistrazione.patchValue({ ragione_sociale: rs });

    this._filtered_stab = [];
    this._filtered_stab = this._stabilimenti.filter((s: any) => {
      return s.ragione_sociale.trim() == this._rs_selected.trim();
    });

    console.log("this._filtered_stab:", this._filtered_stab);
  }

  get stabilimenti() { return this._stabilimenti; }
  get ragioni_sociali() { return this._ragioni_sociali; }
  get rs_no_dup() { return this._rs_no_dup; }
  get rs_selected() { return this._rs_selected; }
  get filtered_stab() { return this._filtered_stab; }
}
