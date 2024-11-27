/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core';
import { CacheService } from './cache.service';
import { BackendCommunicationService, Utils } from '@us/utils';
import { MANUALI_CACHE_TOKEN } from '../shared/cache-tokens';
import { Observable, tap } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { baseUri } from 'src/environments/environment';

/**
 * Sevizio che si occupa della gestione e del download dei manuali.
 */
@Injectable({
  providedIn: 'root',
})
export class ManualiService {
  constructor(
    private cache: CacheService,
    private be: BackendCommunicationService,
    private http: HttpClient
  ) {}

  getManuali(): Observable<any> {
    if (!this.cache.has(MANUALI_CACHE_TOKEN)) {
      this.cache.set(() => this.be.getDati('get_manuali'), MANUALI_CACHE_TOKEN);
    }
    return this.cache.get(MANUALI_CACHE_TOKEN)!;
  }

  downloadManuale(manuale: string) {
    return this.http
      .request<any>('POST', baseUri + 'manuali/' + manuale, {
        observe: 'response',
        responseType: 'blob' as 'json',
      })
      .pipe(
        tap((data: any) => {
          Utils.download(data.body, manuale);
        })
      );
  }
}
