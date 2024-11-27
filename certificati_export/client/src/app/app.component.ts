/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from './user/user.service';
import Swal from 'sweetalert2';
import { environment } from 'src/environments/environment';
declare let GisaSpid: any;

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {
  title = 'Certificati Export';
  private _menu?: any;
  private _userData?: any;
  
  
  constructor(
    private _router: Router,
    private us: UserService,
  ) {

    const script = document.createElement('script');
    script.src = environment.gisaSpid;
    script.async = false;
    document.head.appendChild(script);

    console.log("----- Constructor app.component -----");
    if (!localStorage.getItem('token')) {
      const query = window.location.search;
      console.log("query:", query);

      const searchTerm = '?token=';
      localStorage.setItem('token', query.slice(query.indexOf(searchTerm) + searchTerm.length));
    }
  }

  ngOnInit(): void {
    if (localStorage.getItem('token')) {
      this.us.getUser().subscribe((res: any) => {
        console.log("res:", res);
 
  
        if(res.responsabile_asl)
          this.us.setShowValidaUtentiBtn = true;

        if (res.permission.some((p: any) => p.descr_permission === 'CAN_SEE_ALL_CERTIFICATE_STABS')) {
          this.us.setShowButtons = true;
        }

       /* if (res.permission.some((p: any) => p.descr_permission === 'CAN_VALIDATE_USERS')) {
          this.us.setShowValidaUtentiBtn = true;
        }*/

        this._userData = res;
      });
    }
  }

  onActivate(componentRef: any){
    console.log("emitUserdata", componentRef);
    if(componentRef.getUserData)
      this._userData = null;
    componentRef.getUserData?.subscribe((data :any) => {
      console.log('getUserData', data)
      if(data) {
        this._userData = JSON.parse(data);
        this.ngOnInit();
      }
    })
  }

  // Clear all and come back to login page
  logout(): void {
    Swal.fire({
      titleText: 'Logout',
      icon: 'question',
      text: 'Sei sicuro di voler uscire?',
      showConfirmButton: true,
      confirmButtonText: 'Si',
      showDenyButton: true,
      denyButtonText: 'No',
    }).then(result => {
      if (result.isConfirmed) {
        localStorage.clear();
        GisaSpid.logoutSpid(``);
        this._userData = null;
        //window.location.href = ``;
         
      }
    });
  }

  public get menu() { return this._menu; }

  public get router() { return this._router; }

  public get getShowButtons() { return this.us.getShowButtons; }
  get getShowValidaUtentiBtn() { return this.us.getShowValidaUtentiBtn; }
  get userData() { return this._userData; }
}
