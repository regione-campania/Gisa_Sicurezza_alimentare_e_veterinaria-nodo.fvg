/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Buffer } from 'buffer';
import { LoginService } from '../services/login.service';
import { HOME_URL } from '../conf';
import { UserService } from '../services/user.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-selezione-ruolo',
  templateUrl: './selezione-ruolo.component.html',
  styleUrls: ['./selezione-ruolo.component.scss'],
})
export class SelezioneRuoloComponent implements OnInit {
  ruoli: any;

  constructor(
    private loginService: LoginService,
    private userService: UserService,
    private router: Router,
    private modalService: NgbModal
  ) {}

  ngOnInit(): void {
    let ruoliJSON = Buffer.from(localStorage.getItem('ruoli')!, 'base64')
      .toString()
      .split('')
      .reverse()
      .join('');
    if (!ruoliJSON) this.loginService.logout();
    else {
      this.ruoli = JSON.parse(ruoliJSON);
      this.ruoli.sort((a: any, b: any) =>
        a.combUOCUOS?.localeCompare(b.combUOCUOS)
      );
    }
  }

  selezionaRuolo(ruolo: any) {
    this.userService.setUser(ruolo);
    if (this.modalService.hasOpenModals()) this.modalService.dismissAll();
    this.router.navigateByUrl(HOME_URL);
  }
}
