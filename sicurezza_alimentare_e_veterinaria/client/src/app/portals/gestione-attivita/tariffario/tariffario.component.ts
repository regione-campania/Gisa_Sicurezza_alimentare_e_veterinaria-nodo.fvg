/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { BackendCommunicationService } from '@us/utils';

@Component({
  selector: 'app-tariffario',
  templateUrl: './tariffario.component.html',
  styleUrls: ['./tariffario.component.scss'],
})
export class TariffarioComponent implements OnInit {
  voceAttiva?: any;
  private _menu?: any;

  constructor(
    private client: BackendCommunicationService
  ) { }

  ngOnInit(): void {
    this.client.getDati('get_menu', {"menu":"tariffario"}).subscribe(res => {
      console.log("res:", res);
      if (res) this._menu = res.info;
      this.voceAttiva = this.menu[0];
    })
  }

  public get menu() { return this._menu; }
}
