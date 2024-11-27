/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { BackendCommunicationService } from '@us/utils';
import { map } from 'rxjs';
import { NavigationService } from '../services/navigation.service';

export const portalRedirectGuard: CanActivateFn = function (route, state) {
  console.log('--- esecuzione portalRedirectGuard');
  let menuParam = route.data['menuResolverParam'];
  if (!menuParam) return false;
  let menuBase = route.data['menuBase'];
  if (!menuBase) return false;
  let router = inject(Router);
  let navigation = inject(NavigationService);
  if (navigation.lastRequestedUrl != menuBase) return true; //no redirect
  return inject(BackendCommunicationService)
    .getDati('get_menu', { menu: menuParam })
    .pipe(
      map((res) => {
        let menu = res.info;
        if (!menu) return false;
        return router.createUrlTree([
          navigation.lastRequestedUrl + '/' + menu[0].cod,
        ]);
      })
    );
};
