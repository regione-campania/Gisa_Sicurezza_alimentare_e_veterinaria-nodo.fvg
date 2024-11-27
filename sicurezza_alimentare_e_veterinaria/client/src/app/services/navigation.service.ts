/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core';
import {
  NavigationCancel,
  NavigationEnd,
  NavigationStart,
  Router,
} from '@angular/router';

/**
 * Salva alcuni dati utili durante la navigazione
 */
@Injectable({
  providedIn: 'root',
})
export class NavigationService {
  private _path: string[] = ['/'];
  /** Path di navigazione attuale */
  get path(): string[] {
    return this._path;
  }

  private _lastRequestedUrl: string = '';
  get lastRequestedUrl(): string {
    return this._lastRequestedUrl;
  }

  private _lastSuccessfulUrl: string = '';
  get lastSuccessflUrl(): string {
    return this._lastSuccessfulUrl;
  }

  private _lastUrlBeforeCancel: string = '';
  get lastUrlBeforeCancel(): string {
    return this._lastUrlBeforeCancel;
  }

  constructor(private router: Router) {
    this.router.events.subscribe((ev) => {
      if (ev instanceof NavigationStart) {
        this._lastRequestedUrl = ev.url;
      }
      if (ev instanceof NavigationCancel) {
        this._lastUrlBeforeCancel = ev.url;
      }
      if (ev instanceof NavigationEnd) {
        this._lastSuccessfulUrl = ev.url;
        this._path = ['/'].concat(...ev.url.split('/').slice(1));
      }
    });
  }

  /** Resetta la navigazione allo stato iniziale */
  reset() {
    this._path = ['/'];
    for (let prop in this)
      if (typeof prop == 'string') (this[prop] as string) = '';
  }
}
