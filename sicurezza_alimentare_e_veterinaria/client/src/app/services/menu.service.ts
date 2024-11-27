/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core';
import { MenuItem } from '../menu/types';

/**
 * Si occupa di gestire il menù utente
 */
@Injectable({
  providedIn: 'root',
})
export class MenuService {
  private _menu: MenuItem[] = [];
  private _menuBase: string = '';

  constructor() {}

  getMenu(): MenuItem[] {
    return this._menu.filter(item => !item.hidden);
  }

  setMenu(menu: MenuItem[]) {
    this._menu = menu;
  }

  getMenuBase(): string {
    return this._menuBase;
  }

  setMenuBase(base: string) {
    this._menuBase = base;
  }
}
