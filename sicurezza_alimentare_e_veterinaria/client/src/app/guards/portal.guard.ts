/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { inject } from '@angular/core';
import { CanActivateFn } from '@angular/router';
import { BackendCommunicationService } from '@us/utils';
import { map } from 'rxjs';

/**
 * Route guard che controlla se l'utente ha accesso al portale richiesto
 */
export const portalGuard: CanActivateFn = function (route, state) {
  console.log('--- esecuzione portalGuard');
  let segment = route.url[0];
  if (!segment) return false;
  let path = segment.path;
  return inject(BackendCommunicationService)
    .getDati('get_portali')
    .pipe(
      map((res) => {
        if (!res.info) return false;
        let portali = res.info.dati as Array<any>;
        return portali.map((item) => item.parametro).includes(path);
      })
    );
};
