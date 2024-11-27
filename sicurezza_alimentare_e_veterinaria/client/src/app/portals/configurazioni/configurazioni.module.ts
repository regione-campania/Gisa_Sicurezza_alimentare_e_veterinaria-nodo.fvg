/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule, inject } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ConfigurazioniRoutingModule } from './configurazioni-routing.module';
import { ConfigurazioniComponent } from './configurazioni.component';
import { BASE_URI, BackendCommunicationService, NotificationService, UsUtilsModule } from '@us/utils';
import { baseUri } from 'src/environments/environment';
import { AppService } from '../../app.service';
import { CONFIGURAZIONI_ENDPOINT, RBAC_ENDPOINT } from '../../conf';
import { ConfigurazioniService } from './configurazioni.service';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { RuoliComponent } from './ruoli/ruoli.component';
import { DettaglioRuoliComponent } from './dettaglio-ruoli/dettaglio-ruoli.component';
import { UtentiComponent } from './utenti/utenti.component';
import { DettaglioUtenteComponent } from './dettaglio-utente/dettaglio-utente.component';
import { UtenteRuoliUpsertComponent } from './utente-ruoli-upsert/utente-ruoli-upsert.component';
import { RuoloPermessiUpsertComponent } from './ruolo-permessi-upsert/ruolo-permessi-upsert.component';
import { RuoloRuoliUpsertComponent } from './ruolo-ruoli-upsert/ruolo-ruoli-upsert.component';
import { LogMainComponent } from './log-main/log-main.component';
import { DettaglioLogComponent } from './log-main/dettaglio-log/dettaglio-log.component';
import { AggiungiUtenteComponent } from './utenti/aggiungi-utente/aggiungi-utente.component';
import { StruttureUtenteComponent } from './utenti/strutture-utente/strutture-utente.component';
import { RuoliStruttureUtenteComponent } from './utenti/ruoli-strutture-utente/ruoli-strutture-utente.component';


@NgModule({
  declarations: [
    ConfigurazioniComponent,
    RuoliComponent,
    DettaglioRuoliComponent,
    UtentiComponent,
    DettaglioUtenteComponent,
    UtenteRuoliUpsertComponent,
    RuoloPermessiUpsertComponent,
    RuoloRuoliUpsertComponent,
    LogMainComponent,
    DettaglioLogComponent,
    AggiungiUtenteComponent,
    StruttureUtenteComponent,
    RuoliStruttureUtenteComponent,
  ],
  imports: [
    CommonModule,
    ConfigurazioniRoutingModule,
    ReactiveFormsModule,
    FormsModule,
    UsUtilsModule,
    NgbModule
  ],
  providers: [
    ConfigurazioniService,
    BackendCommunicationService,
    {
      provide: NotificationService,
      useFactory: () => inject(AppService).notification,
    },
    {
      provide: BASE_URI,
      useValue: baseUri + RBAC_ENDPOINT
    },
  ]
})
export class ConfigurazioniModule { }
