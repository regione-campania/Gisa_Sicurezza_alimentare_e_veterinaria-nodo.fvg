/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule, inject } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AgendaOperatoriRoutingModule } from './agenda-operatori-routing.module';
import { AgendaOperatoriComponent } from './agenda-operatori.component';
import { BASE_URI, BackendCommunicationService, NotificationService, UsUtilsModule } from '@us/utils';
import { AgendaOperatoriService } from './agenda-operatori.service';
import { baseUri } from 'src/environments/environment';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { CalendarModule } from './calendar/calendar.module';
import { ListaAttivitaComponent } from './lista-attivita/lista-attivita.component';
import { ListaRisorseComponent } from './lista-risorse/lista-risorse.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AppService } from '../../app.service';
import { ListaAttivitaToolbarComponent } from './lista-attivita/toolbar/toolbar.component';
import { SharedModule } from '../../shared/shared.module';
import { AGENDA_ENDPOINT } from '../../conf';
import { ListaNominativiCaricoComponent } from './lista-nominativi-carico/lista-nominativi-carico.component';


@NgModule({
  declarations: [
    AgendaOperatoriComponent,
    ListaAttivitaComponent,
    ListaRisorseComponent,
    ListaAttivitaToolbarComponent,
    ListaNominativiCaricoComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    UsUtilsModule,
    NgbModule,
    CalendarModule,
    AgendaOperatoriRoutingModule,
    SharedModule
  ],
  providers: [
    AgendaOperatoriService,
    BackendCommunicationService,
    {
      provide: NotificationService,
      useFactory: () => inject(AppService).notification,
    },
    {
      provide: BASE_URI,
      useValue: baseUri + AGENDA_ENDPOINT
    }
  ]
})
export class AgendaOperatoriModule { }
