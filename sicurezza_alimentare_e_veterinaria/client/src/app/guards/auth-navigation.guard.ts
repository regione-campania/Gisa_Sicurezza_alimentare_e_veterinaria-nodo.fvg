/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { inject } from '@angular/core';
import { UserService } from '../services/user.service';
import { CanActivateFn, Router } from '@angular/router';

/**
 * Route guard che controlla se l'utente che sta tentando di accedere a quella rotta è loggato
 */
export const authNavigationGuard: CanActivateFn = function () {
  const router = inject(Router);
  return inject(UserService)
    .isUserLogged()
    .pipe((logged) => logged || router.createUrlTree(['login']));
};
