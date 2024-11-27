/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { GeneratoreCalendarioComponent } from './generatore-calendario.component';
import { CalendarioComponent } from './calendario/calendario.component';
import { StruttureModule } from '../strutture/strutture.module';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { SettaggiComponent } from './settaggi/settaggi.component';
import { RiepilogoComponent } from './riepilogo/riepilogo.component';
import { GeneratoreCalendarioService } from './generatore-calendario.service';
import { HttpClientModule } from '@angular/common/http';
import { ReactiveFormsModule } from '@angular/forms';
import { UsUtilsModule } from '@us/utils';
import { StruttureComponent } from './strutture/strutture.component';
import { LineeComponent } from './linee/linee.component';
import { RiversaComponent } from './riversa/riversa.component';
import { CalToolbarComponent } from './calendario/toolbar/toolbar.component';



@NgModule({
  declarations: [
    GeneratoreCalendarioComponent,
    CalendarioComponent,
    CalToolbarComponent,
    SettaggiComponent,
    RiepilogoComponent,
    StruttureComponent,
    LineeComponent,
    RiversaComponent,
  ],
  imports: [
    CommonModule,
    ReactiveFormsModule,
    HttpClientModule,
    StruttureModule,
    UsUtilsModule,
    NgbModule,
  ],
  providers: [
    GeneratoreCalendarioService,
  ],
})
export class GeneratoreCalendarioModule { }
