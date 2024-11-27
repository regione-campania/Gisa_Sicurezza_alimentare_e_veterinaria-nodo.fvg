/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core'
import { BdnfvgService } from 'src/app/portals/bdnfvg/bdnfvg.service';
import { LoadingDialogService } from '@us/utils';

@Injectable()
export class PianiService {
  constructor(
    private loadingService: LoadingDialogService,
    private client: BdnfvgService
  ) { }

  getCombos(params: any = {}) {
    return this.client.getDati('get_combos', params);
  }

  getPianoMatrici(params: any = {}) {
    return this.client.getDati('get_piano_matrici', params);
  }

  updPianoMatrice(params: any = {}) {
    this.loadingService.openDialog('Aggiornamento in corso...');
    return this.client.updDati('upd_piano_matrici', params);
  }

  insPiano(params: any = {}) {
    this.loadingService.openDialog('Inserimento Piano...');
    return this.client.updDati('ins_piano', params);
  }
}
