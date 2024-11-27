/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { inject, NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { OrganizzazioneRoutingModule } from './organizzazione-routing.module';
import { OrganizzazioneComponent } from './organizzazione.component';
import { BackendCommunicationService, BASE_URI, NotificationService, UsUtilsModule } from '@us/utils';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { SpostaPianoComponent } from '../organizzazione/sposta-piano/sposta-piano.component';
import { StrutturaPianiComponent } from '../organizzazione/struttura-piani/struttura-piani.component';
import { StruttureAslComponent } from '../organizzazione/strutture-asl/strutture-asl.component';
import { OrganigrammaRisorseComponent } from '../organizzazione/organigramma-risorse/organigramma-risorse.component';
import { AssociaRisorsaComponent } from '../organizzazione/associa-risorsa/associa-risorsa.component';
import { ConfigurazioniService } from '../configurazioni/configurazioni.service';
import { AppService } from '../../app.service';
import { baseUri } from 'src/environments/environment';
import { RBAC_ENDPOINT, ORGANIZZAZIONE_ENDPOINT } from '../../conf';
import { OrganizzazioneService } from './organizzazione.service';


@NgModule({
  declarations: [
    OrganizzazioneComponent,
    StrutturaPianiComponent,
    SpostaPianoComponent,
    StruttureAslComponent,
    OrganigrammaRisorseComponent,
    AssociaRisorsaComponent,
  ],
  imports: [
    CommonModule,
    OrganizzazioneRoutingModule,
    UsUtilsModule,
    NgbModule,
    ReactiveFormsModule,
    FormsModule,
  ],
  providers: [
    OrganizzazioneService,
    BackendCommunicationService,
    {
      provide: NotificationService,
      useFactory: () => inject(AppService).notification,
    },
    {
      provide: BASE_URI,
      useValue: baseUri + ORGANIZZAZIONE_ENDPOINT
    },
  ]
})
export class OrganizzazioneModule { }
