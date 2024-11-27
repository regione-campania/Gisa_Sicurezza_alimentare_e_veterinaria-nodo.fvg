/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { inject } from '@angular/core';
import { ResolveFn, Router } from '@angular/router';
import { MenuService } from '../services/menu.service';
import { BackendCommunicationService } from '@us/utils';
import { tap } from 'rxjs';
import { menuMapper } from '../shared/mappers';

export const menuResolver: ResolveFn<any> = function (route, state) {
  const menuService = inject(MenuService);

  return inject(BackendCommunicationService)
    .getDati('get_menu', { menu: route.data['menuResolverParam'] })
    .pipe(
      tap((res) => {
        menuService.setMenu(menuMapper(res));
        menuService.setMenuBase(route.data['menuBase']);
      })
    );
};
