/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { environment } from 'src/environments/environment';

/**
 * Route guard usata per testare l'ambiente di runtime.
 * Viene usata per permettere l'accesso ai portali in sviluppo quando l'ambiente NON è quello di produzione.
 */
export const newFeatureGuard = function () {
  return !(environment.production);
};
