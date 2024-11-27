/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule, inject } from '@angular/core';
import { CommonModule } from '@angular/common';

import { GestioneAttivitaRoutingModule } from './gestione-attivita-routing.module';
import { GestioneAttivitaComponent } from './gestione-attivita.component';
import { NgbActiveModal, NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { BASE_URI, BackendCommunicationService, NotificationService, UsUtilsModule } from '@us/utils';
import { baseUri } from 'src/environments/environment';
import { DocumentiService } from './documenti.service';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { StruttureModule } from './strutture/strutture.module';
import { GeneratoreCalendarioModule } from './generatore-calendario/generatore-calendario.module';
import { ConfigurazioniModule } from './configurazioni/configurazioni.module';
import { ConfigurazioneTariffeComponent } from './configurazione-tariffe/configurazione-tariffe.component';
import { FatturaComponent } from './fattura/fattura.component';
import { GeneraFattureComponent } from './genera-fatture/genera-fatture.component';
import { ListaAttivitaComponent } from './lista-attivita/lista-attivita.component';
import { ListaCalendariComponent } from './lista-calendari/lista-calendari.component';
import { ListaConfigurazioneComponent } from './lista-configurazione/lista-configurazione.component';
import { ListaFattureComponent } from './lista-fatture/lista-fatture.component';
import { MonitoraggioImportComponent } from './monitoraggio-import/monitoraggio-import.component';
import { ScartiImportComponent } from './scarti-import/scarti-import.component';
import { ScontrinoComponent } from './scontrino/scontrino.component';
import { GestioneAttivitaService } from './gestione-attivita.service';
import { AppService } from '../../app.service';
import { ListaFatturePeriodicheComponent } from './lista-fatture-periodiche/lista-fatture-periodiche.component';
import { AttivitaInviateComponent } from './attivita-inviate/attivita-inviate.component';
import { AttivitaUltimoStatoComponent } from './attivita-ultimo-stato/attivita-ultimo-stato.component';
import { UsFriuliModule } from '@us/friuli';
import { GESTIONE_ATTIVITA_ENDPOINT } from '../../conf';


@NgModule({
  declarations: [
    GestioneAttivitaComponent,
    ListaAttivitaComponent,
    ScontrinoComponent,
    ListaFattureComponent,
    ListaFatturePeriodicheComponent,
    FatturaComponent,
    ListaCalendariComponent,
    GeneraFattureComponent,
    ConfigurazioneTariffeComponent,
    ListaConfigurazioneComponent,
    MonitoraggioImportComponent ,
    ScartiImportComponent,
    AttivitaInviateComponent,
    AttivitaUltimoStatoComponent,
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    NgbModule,
    StruttureModule,
    GeneratoreCalendarioModule,
    ConfigurazioniModule,
    UsUtilsModule,
    UsFriuliModule,
    GestioneAttivitaRoutingModule,
  ],
  providers: [
    GestioneAttivitaService,
    BackendCommunicationService,
    NgbActiveModal,
    {
      provide: NotificationService,
      useFactory: () => inject(AppService).notification,
    },
    {
      provide: BASE_URI,
      useValue: baseUri + GESTIONE_ATTIVITA_ENDPOINT
    },
    DocumentiService
  ]
})
export class GestioneAttivitaModule { }
