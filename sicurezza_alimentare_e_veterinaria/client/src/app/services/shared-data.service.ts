/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core';

export interface Data {
  [key: string]: any;
}

/**
 * Servizio che permette di condividere dati all'interno dell'app
 */
@Injectable({
  providedIn: 'root',
})
export class SharedDataService {
  private _data: Data = {};

  constructor() {}

  get(key: string): any {
    return this._data[key];
  }

  set(key: string, value: any) {
    this._data[key] = value;
  }

  has(key: string) {
    return key in this._data;
  }

  delete(key: string) {
    delete this._data[key];
  }

  clear() {
    this._data = {};
  }
}
