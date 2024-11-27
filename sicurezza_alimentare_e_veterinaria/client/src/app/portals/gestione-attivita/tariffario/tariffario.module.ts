/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { TariffarioComponent } from './tariffario.component';
import { TariffarioRoutingModule } from './tariffario-routing.module';
import { ReactiveFormsModule } from '@angular/forms';
import { NotificationService, UsUtilsModule } from '@us/utils';
import { TariffeComponent } from './tariffe/tariffe.component';
import { TariffeForfettarieComponent } from './tariffe-forfettarie/tariffe-forfettarie.component';
import { TariffeForfettarieRiepilogoComponent } from './tariffe-forfettarie-riepilogo/tariffe-forfettarie-riepilogo.component';
import { ListaAttivitaForfettarieComponent } from './tariffe-forfettarie-riepilogo/lista-attivita-forfettarie/lista-attivita-forfettarie.component';
import { inject } from '@angular/core';
import { AppService } from 'src/app/app.service';

@NgModule({
  declarations: [
    TariffarioComponent,
    TariffeComponent,
    TariffeForfettarieComponent,
    TariffeForfettarieRiepilogoComponent,
    ListaAttivitaForfettarieComponent
  ],
  imports: [
    CommonModule,
    TariffarioRoutingModule,
    ReactiveFormsModule,
    NgbModule,
    UsUtilsModule
  ],
  providers: [
    {
      provide: NotificationService,
      useFactory: () => inject(AppService).notification,
    }
  ],
  exports: [
    TariffarioComponent
  ],
})
export class TariffarioModule { }
