/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { UosComponent } from './uos/uos.component';
import { UocComponent } from './uoc/uoc.component';
import { RisorseComponent } from './risorse/risorse.component';
import { PianiComponent } from './piani/piani.component';
import { ConfigurazioniComponent } from './configurazioni.component';
import { UsUtilsModule } from '@us/utils';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ClassyfarmComponent } from './classyfarm/classyfarm.component';

import { TipoListeComponent } from './tipo-liste/tipo-liste.component';
import { ListaComponent } from './tipo-liste/lista/lista.component';
import { TipoListaPianiComponent } from './tipo-liste/tipolista-piani/tipolista-piani.component';
import { ListaDetComponent } from './tipo-liste/lista/listadet.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { TipologiaStabilimentoComponent } from './tipologia-stabilimento/tipologia-stabilimento.component';


@NgModule({
  declarations: [
    ConfigurazioniComponent,
    UosComponent,
    UocComponent,
    RisorseComponent,
    PianiComponent,
    ClassyfarmComponent,
    TipoListeComponent,
    ListaComponent,
    ListaDetComponent,
    TipoListaPianiComponent,
    TipologiaStabilimentoComponent,

  ],
  imports: [
    CommonModule,
    UsUtilsModule,
    FormsModule,
    ReactiveFormsModule,
    SharedModule,
    NgbModule
  ]
})
export class ConfigurazioniModule { }
