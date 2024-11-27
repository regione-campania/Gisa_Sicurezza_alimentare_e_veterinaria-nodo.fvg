/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule, inject } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ControlliUfficialiRoutingModule } from './controlli-ufficiali-routing.module';
import { ControlliUfficialiComponent } from './controlli-ufficiali.component';
import { ControlliUfficialiService } from './controlli-ufficiali.service';
import { BASE_URI, BackendCommunicationService, NotificationService, UsUtilsModule } from '@us/utils';
import { baseUri } from 'src/environments/environment';
import { DettaglioControlloComponent } from './dettaglio-controllo/dettaglio-controllo.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { ListaCuComponent } from './lista-cu/lista-cu.component';
import { LineeCuComponent } from './linee-cu/linee-cu.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AssociaOggettiCuComponent } from './associa-oggetti-cu/associa-oggetti-cu.component';
import { PianiCuComponent } from './piani-cu/piani-cu.component';
import { OggettiChecklistCuComponent } from './oggetti-checklist-cu/oggetti-checklist-cu.component';
import { OggettiEvidenzeCuComponent } from './oggetti-evidenze-cu/oggetti-evidenze-cu.component';
import { OggettiCuComponent } from './oggetti-cu/oggetti-cu.component';
import { AppService } from '../../app.service';
import { OggettiRequisitiCuComponent } from './oggetti-requisiti-cu/oggetti-requisiti-cu.component';
import { ProvvedimentiCuComponent } from './provvedimenti-cu/provvedimenti-cu.component';
import { ProvvedimentiAddCuComponent } from './provvedimenti-add-cu/provvedimenti-add-cu.component';
import { VerificaProvvedimentiFuComponent } from './verifica-provvedimenti-fu/verifica-provvedimenti-fu.component';
import { VerificaEvidenzeFuComponent } from './verifica-evidenze-fu/verifica-evidenze-fu.component';
import { FormIndirizzoComponent } from './form-indirizzo/form-indirizzo.component';
import { CU_ENDPOINT } from '../../conf';
import { NucleoIspettivoCuRefactoringComponent } from './nucleo-ispettivo-cu-refactoring/nucleo-ispettivo-cu-refactoring.component';
import { CategoriaRischioComponent } from './categoria-rischio/categoria-rischio.component';
import { ProvvedimentiSopralluogoComponent } from './provvedimenti-sopralluogo/provvedimenti-sopralluogo.component';
import { VerificaProvvedimentiFsComponent } from './verifica-provvedimenti-fs/verifica-provvedimenti-fs.component';
import { TrasportatoriComponent } from './trasportatori/trasportatori.component';
import { AnagraficaModule } from '../anagrafica/anagrafica.module';
import { DurataCuComponent } from './durata-cu/durata-cu.component';

@NgModule({
  declarations: [
    ControlliUfficialiComponent,
    DettaglioControlloComponent,
    ListaCuComponent,
    LineeCuComponent,
    AssociaOggettiCuComponent,
    PianiCuComponent,
    OggettiCuComponent,
    OggettiChecklistCuComponent,
    OggettiEvidenzeCuComponent,
    OggettiRequisitiCuComponent,
    ProvvedimentiCuComponent,
    ProvvedimentiAddCuComponent,
    VerificaProvvedimentiFuComponent,
    VerificaEvidenzeFuComponent,
    FormIndirizzoComponent,
    NucleoIspettivoCuRefactoringComponent,
    CategoriaRischioComponent,
    ProvvedimentiSopralluogoComponent,
    VerificaProvvedimentiFsComponent,
    TrasportatoriComponent,
    DurataCuComponent,
  ],
  imports: [
    CommonModule,
    ReactiveFormsModule,
    FormsModule,
    ControlliUfficialiRoutingModule,
    UsUtilsModule,
    NgbModule,
    AnagraficaModule
  ],
  providers: [
    ControlliUfficialiService,
    BackendCommunicationService,
    {
      provide: NotificationService,
      useFactory: () => inject(AppService).notification,
    },
    {
      provide: BASE_URI,
      useValue: baseUri + CU_ENDPOINT
    },
  ]
})
export class ControlliUfficialiModule { }
