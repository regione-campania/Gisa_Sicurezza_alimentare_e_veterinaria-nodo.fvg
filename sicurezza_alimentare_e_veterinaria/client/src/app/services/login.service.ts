/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { baseUri } from 'src/environments/environment';
import { UserService } from './user.service';
import { Router } from '@angular/router';
import { NotificationService } from '@us/utils';
import { NavigationService } from './navigation.service';
import { HOME_URL } from '../conf';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { SelezioneRuoloComponent } from '../selezione-ruolo/selezione-ruolo.component';

declare const GisaSpid: any;

@Injectable({
  providedIn: 'root',
})
export class LoginService {
  readonly postLoginCallback = (res: any) => {
    console.log('--- login response:', res);
    if (!res) {
      this.notification.push({
        notificationClass: 'error',
        content: 'Utente non trovato.',
      });
    } else {
      let roles = res instanceof Array ? res : [res];
      this.userService.setRoles(roles);
      if (roles.length > 1) {
        this.modalService.open(SelezioneRuoloComponent, {
          centered: true
        });
      } else {
        this.userService.setUser(roles[0]);
        this.router.navigateByUrl(
          this.navigation.lastUrlBeforeCancel || HOME_URL
        );
      }
    }
  };

  constructor(
    private http: HttpClient,
    private router: Router,
    private notification: NotificationService,
    private navigation: NavigationService,
    private userService: UserService,
    private modalService: NgbModal
  ) {}

  login(formData: any) {
    return this.http.post<any>(baseUri + 'um/login', formData);
  }

  logout() {
    this.userService.clear();
    if (GisaSpid) GisaSpid.logoutSpid(`/`);
    this.router.navigateByUrl('/login');
  }
}
