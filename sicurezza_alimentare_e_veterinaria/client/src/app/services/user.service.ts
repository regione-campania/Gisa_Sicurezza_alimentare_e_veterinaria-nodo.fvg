/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Buffer } from 'buffer';
import { catchError, map, Observable, of } from 'rxjs';
import { baseUri } from 'src/environments/environment';
import { CacheService } from './cache.service';
import { USER_CACHE_TOKEN } from '../shared/cache-tokens';

/**
 * Si occupa di salvare in sessione e gestire l'utente loggato (se presente)
 */
@Injectable({
  providedIn: 'root',
})
export class UserService {
  private _user: any = null;
  private _roles: any = null;

  constructor(private http: HttpClient, private cache: CacheService) {}

  /** Ritorna l'utente loggato (se presente) */
  getUser(): Observable<any> {
    if (!localStorage.getItem('token')) return of(null);
    if (this._user) return of(this._user);
    if (!this.cache.get(USER_CACHE_TOKEN))
      this.cache.set(
        () =>
          this.http
            .get<any>(baseUri + 'um/getUser')
            .pipe(catchError((_) => of(null))),
        USER_CACHE_TOKEN
      );
    return this.cache.get(USER_CACHE_TOKEN)!;
  }

  setUser(user: any): void {
    if ('token' in user) {
      this._user = user;
      localStorage.setItem('token', user.token);
    } else console.error("Campo 'token' mancante nell'oggetto user.");
  }

  /** Ritorna i ruoli dell'utente loggato (se presente) */
  getRoles(): any {
    return this._roles;
  }

  setRoles(roles: any): void {
    this._roles = roles;
    let rolesString = JSON.stringify(roles);
    localStorage.setItem(
      'ruoli',
      Buffer.from(rolesString.split('').reverse().join('')).toString('base64')
    );
  }

  isUserLogged(): Observable<boolean> {
    return this.getUser().pipe(map((user) => !!user));
  }

  /** Rimuove l'utente dalla sessione ed eventuali dati salvati nel localStorage */
  clear(): void {
    this._user = null;
    this._roles = null;
    localStorage.removeItem('token');
    localStorage.removeItem('ruoli');
    this.cache.delete(USER_CACHE_TOKEN);
  }
}
