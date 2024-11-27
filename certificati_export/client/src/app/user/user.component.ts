/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { UserService } from './user.service';
import { Router } from '@angular/router';
import { UntypedFormBuilder, UntypedFormGroup } from '@angular/forms';
import { environment } from 'src/environments/environment';
import { LoadingDialogService } from '@us/utils';
import  packageInfo  from '../../../../fvg/package.json';

declare let Swal: any;

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.scss']
})


export class UserComponent implements OnInit {

  form!: UntypedFormGroup;
  @Output() getUserData = new EventEmitter<String>();
  test: boolean = false;
  hideCrypt: boolean = false;
  public version = packageInfo.version

  constructor(private us: UserService,
    private router: Router,
    private fb: UntypedFormBuilder,
    private ls: LoadingDialogService
  ) { }

  ngOnInit(): void {
    console.log(this.router.url);
    console.log(environment.hideTest);
    localStorage.removeItem('token');
    if(this.router.url == '/login-test' && environment.hideTest){
      this.router.navigate(['login']);
    }
      
    this.form = this.fb.group({
      username: [''],
      password: [''],
      crypt: ['']
    });
    this.getUserData.emit();
    if(this.router.url == '/login-test' || this.router.url == '/us-us'){
      this.test = true;
    }
    this.hideCrypt = environment.production;
  }

  onSubmit() {

    console.log(this.form.value);
    if (this.form.invalid) { return; }

    const userData = {
      username: this.form.value.username,
      password: this.form.value.password,
      crypt: this.form.value.crypt
    }
    this.ls.openDialog('Accesso in corso');
    this.us.login(userData).subscribe((res: any) => {
      this.ls.closeDialog();
      console.log(res);
      if(res && res.id_asl == -1){
        localStorage.setItem('token', res.token);
        this.router.navigate(['user/denominazione-prodotto']);
      }else if (res && !res.role_descr.includes("_OSA")) {
        localStorage.setItem('token', res.token);
        this.redirectTo();
      }
      else if (res != null) {
        localStorage.setItem('token', res.token);
        console.log("res.id:", res.id);
        this.ls.openDialog('Accesso in corso');
        this.us.getStabilimenti().subscribe((resStab: any) => {
          this.ls.closeDialog();
          console.log("resStab:", resStab);
          if (resStab.length == 1) {
            localStorage.setItem('token', resStab[0].token);

            if (resStab[0].permission.some((p: any)=> p.descr_permission === 'CAN_SEE_ALL_CERTIFICATE_STABS')){
              this.us.setShowButtons = true;
            }

            this.redirectTo();
            console.log(resStab[0]);
          } else {
            let roleOptions: any = {};
            resStab.forEach((u: any, i: number) => {
              roleOptions[i] = `${u.ragione_sociale} - ${u.comune} (${u.provincia_stab}) - ${u.indirizzo}`;
            })
            Swal.fire({
              title: 'Hai più stabilimenti associati',
              input: 'select',
              inputOptions: roleOptions,
              inputPlaceholder: 'Seleziona stabilimento...',
              showCancelButton: true,
              inputValidator: (value: any) => {
                if (!value)
                  return;
                localStorage.setItem('token', resStab[value].token);

                if (resStab[value].permission.some((p: any)=> p.descr_permission === 'CAN_SEE_ALL_CERTIFICATE_STABS')) {
                  this.us.setShowButtons = true;
                }

                this.redirectTo();
                console.log(resStab[value]);
              }
            })
          }

        })
      }
      else
        Swal.fire({
          titleText: 'Utente non trovato',
          icon: 'question',
          text: 'Richiedere accreditamento come OSA?',
          showConfirmButton: true,
          confirmButtonText: 'Si, proseguo con la richiesta',
          showDenyButton: true,
          denyButtonText: 'No, esco',
        }).then((result: any) => {
          if (result.isConfirmed) {
            this.registraOsaSPID();
          }
        });
    })
  }

  loginSPID() {
    this.us.loginSPID();
  }

  registraOsaSPID(){
    this.us.registraOsaSPID();
  }

  private redirectTo() {
    this.router.navigate(['user/lista-certificati']);
  }
}
