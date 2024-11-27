/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BdnfvgComponent } from './bdnfvg.component';
import { AziendeComponent } from './aziende/aziende.component';
import { AllevamentiComponent } from './allevamenti/allevamenti.component';
import { CapiInStallaComponent } from './capi-in-stalla/capi-in-stalla.component';
import { MovimentazioniCapoComponent } from './movimentazioni-capo/movimentazioni-capo.component';
import { NgbActiveModal, NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { CapiComponent } from './capi/capi.component';
import { BASE_URI, BackendCommunicationService, NotificationService, UsUtilsModule } from '@us/utils';
import { InterventiComponent } from './interventi/interventi.component';
import { GestioneInterventoComponent } from './gestione-intervento/gestione-intervento.component';
import { GiornataComponent } from './giornata/giornata.component';
import { RisultatiComponent } from './risultati/risultati.component';
import { NuovoInterventoComponent } from './nuovo-intervento/nuovo-intervento.component';
import { ReactiveFormsModule } from '@angular/forms';
import { FormsModule } from '@angular/forms';
import { PianiComponent } from './piani/piani.component';
import { RiepilogoComponent } from './riepilogo/riepilogo.component';
import { CapannoniComponent } from './capannoni/capannoni.component';
import { PreaccettazioniComponent } from './preaccettazioni/preaccettazioni.component';
import { PreaccettazioniCapiComponent } from './preaccettazioni-capi/preaccettazioni-capi.component';
import { PreaccettazioniStatiComponent } from './preaccettazioni-stati/preaccettazioni-stati.component';
import { SottoscrizioniComponent } from './sottoscrizioni/sottoscrizioni.component';
import { SottoscrizioniElaborazioniComponent } from './sottoscrizioni-elaborazioni/sottoscrizioni-elaborazioni.component';
import { SottoscrizioniElaborazioniFilesComponent } from './sottoscrizioni-elaborazioni-files/sottoscrizioni-elaborazioni-files.component';
import { MonitoraggioAllevamentiComponent } from './monitoraggioallevamenti/monitoraggioallevamenti.component';
import { FormPianoComponent } from './piani/form-piano/form-piano.component';
import { baseUri } from 'src/environments/environment';
import { ImportaMovimentazioniComponent } from './importa-movimentazioni/importa-movimentazioni.component';
import { BdnfvgRoutingModule } from './bdnfvg-routing.module';
import { AppService } from '../../app.service';
import { BdnfvgService } from './bdnfvg.service';
import { AllevamentiService, AziendeService, RiepilogoService, CapannoniService, CapiService, CapiInStallaService, ImportaMovimentazioniService, InterventiService, MonitoraggioAllevamentiService, MovimentazioniCapoService, PianiService, PreaccettazioniService, PreaccettazioniCapiService, PreaccettazioniStatiService,SottoscrizioniService, SottoscrizioniElaborazioniService, SottoscrizioniElaborazioniFilesService } from './services';
import { BDN_ENDPOINT } from '../../conf';



@NgModule({
  declarations: [
    BdnfvgComponent,
    AziendeComponent,
    AllevamentiComponent,
    CapiInStallaComponent,
    MovimentazioniCapoComponent,
    CapiComponent,
    InterventiComponent,
    GestioneInterventoComponent,
    GiornataComponent,
    RisultatiComponent,
    NuovoInterventoComponent,
    PianiComponent,
    RiepilogoComponent,
    CapannoniComponent,
    PreaccettazioniComponent,
    PreaccettazioniCapiComponent,
    PreaccettazioniStatiComponent,
    SottoscrizioniComponent,
    SottoscrizioniElaborazioniComponent,
    SottoscrizioniElaborazioniFilesComponent,
    MonitoraggioAllevamentiComponent,
    FormPianoComponent,
    ImportaMovimentazioniComponent

  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    UsUtilsModule,
    NgbModule,
    BdnfvgRoutingModule,
  ],
  providers: [
    BdnfvgService,
    AllevamentiService,
    AziendeService,
    CapannoniService,
    CapiService,
    CapiInStallaService,
    ImportaMovimentazioniService,
    InterventiService,
    MonitoraggioAllevamentiService,
    MovimentazioniCapoService,
    PianiService,
    PreaccettazioniService,
    PreaccettazioniCapiService,
    PreaccettazioniStatiService,
    RiepilogoService,
    SottoscrizioniService,
    SottoscrizioniElaborazioniService,
    SottoscrizioniElaborazioniFilesService,
    NgbActiveModal,
    BackendCommunicationService,
    {
      provide: NotificationService,
      useFactory: () => inject(AppService).notification,
    },
    {
      provide: BASE_URI,
      useValue: baseUri + BDN_ENDPOINT,
    },
  ]
})
export class BdnfvgModule { }
