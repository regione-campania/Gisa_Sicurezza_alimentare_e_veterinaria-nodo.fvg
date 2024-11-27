/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
/*
 * Modulo che contiene funzioni di mappatura (mappers) di vario genere
 */

import { BackendResponse } from '@us/utils';
import { MenuItem } from '../menu/types';
import { PromptService } from '../services/prompt.service';

/**
 * Unwrappa la risposta ritornata dal backend
 * @param res la risposta del backend
 * @returns i dati richiesti al backend, ossia res.info
 */
export function backendResponseUnwrapper<T = any>(res: BackendResponse): T {
  return res.info;
}

/**
 * Mappa il menu richiesto al backend come array di MenuItem
 * @param res la risposta del backend
 * @returns il menu mappato come MenuItem[]
 */
export function menuMapper(res: BackendResponse): MenuItem[] {
  return backendResponseUnwrapper<Array<any>>(res).map<MenuItem>(
    (item: any) => {
      return {
        label: item['descr'],
        icon: item['icon'],
        link: item['cod'],
        disabled: item['disabled'],
        lev: item['lev'],
        ord: item['ord'],
        modality: item['modality'],
        hidden: !item['visibile'] || false,
      };
    }
  );
}
