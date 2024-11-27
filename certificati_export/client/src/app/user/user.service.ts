/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { baseUri } from 'src/environments/environment';
declare let Swal: any;

declare class GisaSpid {
  static spidUserData: any;
  static entraConSpid(
    event?: any,
    formId?: any,
    formParam?: any,
    functionName?: string,
    userField?: any,
    exceptionsJson?: any
  ): void;
  static logoutSpid(redirectTo: string | null): void;
}

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private _showButtons: boolean = false;
  private _showValidaUtentiBtn: boolean = false;
  private _associatedPermissions?: any;

  private sbloccaCertificato: boolean = false; //mettere a false prima del commit
  private idAccessSblocco!: number |  null;

  constructor(
    private http: HttpClient,
    private router: Router
    ) { 
    (window as any).getSpidUser = (spidUser: any) => {
      console.log(spidUser);
      this.login(spidUser).subscribe((res: any) => {
        console.log(res);
        if (res && !res.role_descr.includes("_OSA")) {
          localStorage.setItem('token', res.token);
          this.redirectTo();
        }
        else if (res != null) {
          localStorage.setItem('token', res.token);
          console.log("res.id:", res.id);
          this.getStabilimenti().subscribe((resStab: any) => {
            console.log("resStab:", resStab);
            if (resStab.length == 1) {
              localStorage.setItem('token', resStab[0].token);
  
              if (resStab[0].permission.some((p: any)=> p.descr_permission === 'CAN_SEE_ALL_CERTIFICATE_STABS')){
                this.setShowButtons = true;
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
                    this.setShowButtons = true;
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
              this.router.navigate(['/registrazione'], { queryParams:  spidUser, skipLocationChange: true});
            }
          });
      })
    };

    (window as any).registraOsaSPID = (spidUser: any) => {
      this.router.navigate(['/registrazione'], { queryParams:  spidUser, skipLocationChange: true});
    }

    (window as any).sbloccaCertificatoSPIDPost = (spidUser: any) => {
      this.login(spidUser).subscribe((res: any) => {
       // GisaSpid.logoutSpid(null);
        console.log(res);
        if(res?.permission.some((p: any)=> p.descr_permission === 'CAN_ACCEPT_CERTIFICATE')){
          this.sbloccaCertificato = true;
          this.idAccessSblocco = res.id;
          Swal.fire({
            text: 'Veterinario riconosciuto! Proseguire con l\'azione desiderata',
            icon: 'success'
          })
        }
      })
    }
  }

  loginSPID() {
    GisaSpid.entraConSpid(event, null, null, 'getSpidUser', null);
  }

  logoutSPID(redirectTo: string | null) {
    GisaSpid.logoutSpid(redirectTo);
  }

  registraOsaSPID() {
    GisaSpid.entraConSpid(event, null, null, 'registraOsaSPID', null);
  }

  sbloccaCertificatoSPID(){
    setTimeout(()=>{
      GisaSpid.entraConSpid(event, null, null, 'sbloccaCertificatoSPIDPost', null);
    },100)
  }

  getCanUnlock(){
    return this.sbloccaCertificato;
  }

  getIdAccessSblocco(){
    return this.idAccessSblocco;
  }

  resetCanUnlock(){
    this.sbloccaCertificato = false;
    this.idAccessSblocco = null;
    this.logoutSPID(null);
  }



  login(userData: any) {
    return this.http.post<any>(`${baseUri}um/login`, userData);
  }

  getStabilimenti() {
    return this.http.get<any>(`${baseUri}um/getStabilimenti`);
  }

  getUser() {
    return this.http.post<any>(`${baseUri}um/getUser`, null);
  }

  getVWStabilimenti(userData: any) {
    return this.http.post<any>(`${baseUri}ce/get_vw_stabilimenti`, userData);
  }

  insAccessStabilimento(args: any = {}) {
    return this.http.post<any>(`${baseUri}ce/insRegistrazione`, {
      args: JSON.stringify(args)
    });
  }

  sendEmailRegistrazione(args: any = {}) {
    return this.http.post<any>(`${baseUri}ce/sendEmailRegistrazione`, {
      function: 'ins_access_stabilimento',
      args: JSON.stringify(args)
    });
  }

  private redirectTo() {
    this.router.navigate(['user/lista-certificati']);
  }

  // setter
  public set setPermissions(permissions: any) { this._associatedPermissions = permissions; }

  public set setShowButtons(value: boolean) { this._showButtons = value; }
  set setShowValidaUtentiBtn(value: boolean) { this._showValidaUtentiBtn = value; }
  
  // getter
  public get getPermissions() { return this._associatedPermissions; }

  public get getShowButtons() { return this._showButtons; }
  get getShowValidaUtentiBtn() { return this._showValidaUtentiBtn; }
}
