/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core';
import {
  defer,
  Observable,
  of,
  shareReplay,
  ShareReplayConfig,
  switchMap,
} from 'rxjs';

interface ObservableFactory {
  (...args: any[]): Observable<any>;
}

type CacheType = {
  source: Observable<any>;
  factory: ObservableFactory;
  config: ShareReplayConfig;
};

@Injectable({
  providedIn: 'root',
})
export class CacheService {
  private _cache: {
    [key: string]: CacheType;
  };

  constructor() {
    this._cache = {};
  }

  has(key: string): boolean {
    return key in this._cache;
  }

  get(key: string): Observable<any> | undefined {
    return this.has(key) ? this._cache[key].source : undefined;
  }

  getWithConfig(key: string): CacheType {
    return this._cache[key];
  }

  set(factory: ObservableFactory, key: string, bufferSize: number = 1): void {
    this.setWithConfig(factory, key, {
      bufferSize: bufferSize,
      refCount: false,
    });
  }

  setWithConfig(
    factory: ObservableFactory,
    key: string,
    config: ShareReplayConfig
  ): void {
    this._cache[key] = {
      source: factory().pipe(shareReplay(config)),
      factory: factory,
      config: config,
    };
  }

  delete(key: string) {
    delete this._cache[key];
  }

  refresh(key: string): void {
    const cacheItem = this.getWithConfig(key);
    if (cacheItem) this.setWithConfig(cacheItem.factory, key, cacheItem.config);
  }

  clear(): void {
    this._cache = {};
  }
}
