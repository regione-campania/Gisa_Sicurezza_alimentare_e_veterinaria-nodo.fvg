/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, Output } from '@angular/core';
import { MenuService } from '../services/menu.service';
import { Menu, MenuItem } from './types';
import { Router } from '@angular/router';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.scss'],
})
export class MenuComponent implements Menu {
  @Output() menuItemClicked = new EventEmitter();

  constructor(private menuService: MenuService, private router: Router) {}

  get menuItems(): MenuItem[] {
    return this.menuService.getMenu();
  }

  navigateTo(path: string) {
    this.router.navigateByUrl(
      `${this.menuService.getMenuBase() || this.router.url}/${path}`
    );
  }
}
