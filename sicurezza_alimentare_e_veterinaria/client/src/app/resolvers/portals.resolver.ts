/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { inject } from '@angular/core';
import { ResolveFn } from '@angular/router';
import { BackendCommunicationService } from '@us/utils';
import { map } from 'rxjs';
import { PORTALI_ENDPOINT } from '../conf';
import { baseUri } from 'src/environments/environment';

export const portalsResolver: ResolveFn<any> = function (route, state) {
  const be = inject(BackendCommunicationService);
  be.baseUri = baseUri + PORTALI_ENDPOINT;

  return be.getDati('get_portali').pipe(map((res) => res.info.dati));
};
