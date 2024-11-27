/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from "@angular/router";
import { TariffarioComponent } from './tariffario.component';
import { TariffeComponent } from './tariffe/tariffe.component';
import { TariffeForfettarieComponent } from './tariffe-forfettarie/tariffe-forfettarie.component';
import { TariffeForfettarieRiepilogoComponent } from './tariffe-forfettarie-riepilogo/tariffe-forfettarie-riepilogo.component';
import { ListaAttivitaForfettarieComponent } from './tariffe-forfettarie-riepilogo/lista-attivita-forfettarie/lista-attivita-forfettarie.component';

const routes: Routes = [
  {
    path: '', component: TariffarioComponent, children: [
      { path: 'tariffe', component: TariffeComponent },
      { path: 'tariffe-forfettarie', component: TariffeForfettarieComponent },
      { path: 'attivita-forfettarie-riepilogo', component: TariffeForfettarieRiepilogoComponent },
      { path: 'lista-attivita-forfettarie', component: ListaAttivitaForfettarieComponent },
      { path: '', redirectTo: 'tariffe', pathMatch: 'full' },
    ]
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class TariffarioRoutingModule { }
