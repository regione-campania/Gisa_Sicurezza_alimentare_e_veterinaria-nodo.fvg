/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule, inject } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AnagraficaRoutingModule } from './anagrafica-routing.module';
import { AnagraficaComponent } from './anagrafica.component';
import { ImpreseMainComponent } from './imprese-main/imprese-main.component';
import { ImpreseDettaglioComponent } from './imprese-main/imprese-dettaglio/imprese-dettaglio.component';
import { StabilimentiMainComponent } from './stabilimenti-main/stabilimenti-main.component';
import { StabilimentiDettaglioComponent } from './stabilimenti-main/stabilimenti-dettaglio/stabilimenti-dettaglio.component';
import { ImpreseUpsertComponent } from './imprese-main/imprese-upsert/imprese-upsert.component';
import { StabilimentiUpsertComponent } from './stabilimenti-main/stabilimenti-upsert/stabilimenti-upsert.component';
import { FormImpreseComponent } from './imprese-main/form-imprese/form-imprese.component';
import { FormStabilimentiComponent } from './stabilimenti-main/form-stabilimenti/form-stabilimenti.component';
import { FormIndirizzoMainComponent } from './form-indirizzo-main/form-indirizzo-main.component';
import { FigureDettaglioComponent } from './stabilimenti-main/figure-dettaglio/figure-dettaglio.component';
import { SediDettaglioComponent } from './stabilimenti-main/sedi-dettaglio/sedi-dettaglio.component';
import { LineeDettaglioComponent } from './stabilimenti-main/linee-dettaglio/linee-dettaglio.component';
import { LineeUpsertComponent } from './stabilimenti-main/linee-upsert/linee-upsert.component';
import { SediUpsertComponent } from './stabilimenti-main/sedi-upsert/sedi-upsert.component';
import { FigureUpsertComponent } from './stabilimenti-main/figure-upsert/figure-upsert.component';
import { FormSediComponent } from './stabilimenti-main/form-sedi/form-sedi.component';
import { FormFigureComponent } from './stabilimenti-main/form-figure/form-figure.component';
import { FormLineeComponent } from './stabilimenti-main/form-linee/form-linee.component';
import { StabilimentiSubingressoComponent } from './stabilimenti-main/stabilimenti-subingresso/stabilimenti-subingresso.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BASE_URI, BackendCommunicationService, NotificationService, UsUtilsModule } from '@us/utils';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { ANAGRAFICA_ENDPOINT } from '../../conf';
import { baseUri } from 'src/environments/environment';
import { AppService } from '../../app.service';
import { AnagraficaService } from './anagrafica.service';
import { DettaglioFigureComponent } from './dettaglio-figure/dettaglio-figure.component';
import { DettaglioStabComponent } from './dettaglio-stab/dettaglio-stab.component';
import { SoggettiFisiciComponent } from './soggetti-fisici/soggetti-fisici.component';
import { SoggettiMainComponent } from './soggetti-main/soggetti-main.component';
import { SoggettiDettaglioComponent } from './soggetti-main/soggetti-dettaglio/soggetti-dettaglio.component';
import { SoggettiUpsertComponent } from './soggetti-main/soggetti-upsert/soggetti-upsert.component';
import { FormSoggettiComponent } from './soggetti-main/soggetti-upsert/form-soggetti/form-soggetti.component';
import { SoggettiAnagraficaAssistitiComponent } from './soggetti-main/soggetti-anagrafica-assistiti/soggetti-anagrafica-assistiti.component';
import { LineeMainComponent } from './linee-main/linee-main.component';
import { TipoListeComponent } from './tipo-liste/tipo-liste.component';
import { PraticheMainComponent } from './pratiche-main/pratiche-main.component';
import { PraticheDettaglioComponent } from './pratiche-main/pratiche-dettaglio/pratiche-dettaglio.component';
import { PraticheUpsertComponent } from './pratiche-main/pratiche-upsert/pratiche-upsert.component';
import { FormPraticheComponent } from './pratiche-main/form-pratiche/form-pratiche.component';
import { DettaglioPraticheComponent } from './stabilimenti-main/dettaglio-pratiche/dettaglio-pratiche.component';
//import { BonificaCfComponent } from './bonifica-cf/bonifica-cf.component';
import { AutomezziMainComponent } from './automezzi-main/automezzi-main.component';
import { AutomezziUpsertComponent } from './automezzi-main/automezzi-upsert/automezzi-upsert.component';
import { AutomezziDettaglioComponent } from './automezzi-main/automezzi-dettaglio/automezzi-dettaglio.component';
import { FormAutomezziComponent } from './automezzi-main/form-automezzi/form-automezzi.component';
import { StabilimentiAutomezziUpsertComponent } from './automezzi-main/stabilimenti-automezzi-upsert/stabilimenti-automezzi-upsert.component';
import { AllineamentoParixComponent } from './allineamento-parix/allineamento-parix.component';

@NgModule({
  declarations: [
    AnagraficaComponent,
    ImpreseMainComponent,
    StabilimentiMainComponent,
    ImpreseDettaglioComponent,
    StabilimentiDettaglioComponent,
    ImpreseUpsertComponent,
    StabilimentiUpsertComponent,
    FormImpreseComponent,
    FormStabilimentiComponent,
    FormIndirizzoMainComponent,
    FigureDettaglioComponent,
    SediDettaglioComponent,
    LineeDettaglioComponent,
    LineeUpsertComponent,
    SediUpsertComponent,
    FigureUpsertComponent,
    FormSediComponent,
    FormFigureComponent,
    FormLineeComponent,
    StabilimentiSubingressoComponent,
    SoggettiFisiciComponent,
    DettaglioFigureComponent,
    DettaglioStabComponent,
    SoggettiMainComponent,
    SoggettiDettaglioComponent,
    SoggettiUpsertComponent,
    FormSoggettiComponent,
    SoggettiAnagraficaAssistitiComponent,
    LineeMainComponent,
    TipoListeComponent,
    PraticheMainComponent,
    PraticheDettaglioComponent,
    PraticheUpsertComponent,
    FormPraticheComponent,
    DettaglioPraticheComponent,
    //BonificaCfComponent,
    AutomezziMainComponent,
    AutomezziUpsertComponent,
    AutomezziDettaglioComponent,
    FormAutomezziComponent,
    StabilimentiAutomezziUpsertComponent,
    DettaglioPraticheComponent,
    AllineamentoParixComponent
  ],
  imports: [
    CommonModule,
    AnagraficaRoutingModule,
    ReactiveFormsModule,
    FormsModule,
    UsUtilsModule,
    NgbModule
  ],
  exports: [
    FormIndirizzoMainComponent
  ],
  providers: [
    AnagraficaService,
    BackendCommunicationService,
    {
      provide: NotificationService,
      useFactory: () => inject(AppService).notification,
    },
    {
      provide: BASE_URI,
      useValue: baseUri + ANAGRAFICA_ENDPOINT
    },
  ]
})
export class AnagraficaModule { }
