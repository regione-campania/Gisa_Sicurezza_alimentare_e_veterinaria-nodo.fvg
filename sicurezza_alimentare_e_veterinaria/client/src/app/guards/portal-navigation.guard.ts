/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { BackendCommunicationService } from '@us/utils';
import { map } from 'rxjs';
import { SharedDataService } from '../services/shared-data.service';
import { UserService } from '../services/user.service';

/**
 * Route guard che controlla la navigazione all'interno di un portale
 */
export const portalNavigationGuard: CanActivateFn = function (route, state) {
  console.log('--- esecuzione portalNavigationGuard');
  let menuParam = route.parent?.data['menuResolverParam'];
  //se non è un figlio diretto del menù, avanza (perché già controllato)
  if (!menuParam) return true;
  let sharedData = inject(SharedDataService);
  let userService = inject(UserService);
  let userInfo: any;
  userService.getUser().subscribe((res) => {
    userInfo = res;
  });
  return inject(BackendCommunicationService)
    .getDati('get_menu', { menu: menuParam })
    .pipe(
      map((res) => {
        //ad hoc per bloccare bdn con hideProfilassi true
        if (menuParam == 'bdn' && userInfo.hideProfilassi == true) return false;
        let menu = res.info;
        if (!menu) return false;
        let path = route.routeConfig?.path;
        if (!path) return false;
        let menuItem = menu.find((item: any) => item.cod.includes(path));
        if (!menuItem) return false;
        sharedData.set('activeMenuItem', menuItem);
        return true;
      })
    );
};
