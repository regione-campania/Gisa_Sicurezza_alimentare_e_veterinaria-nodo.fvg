/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AgendaOperatoriComponent } from './agenda-operatori.component';
import { ListaAttivitaComponent } from './lista-attivita/lista-attivita.component';
import { ListaRisorseComponent } from './lista-risorse/lista-risorse.component';
import { CalendarComponent } from './calendar/calendar.component';
import { ListaNominativiCaricoComponent } from './lista-nominativi-carico/lista-nominativi-carico.component';
import { menuResolver } from 'src/app/resolvers/menu.resolver';
import { portalRedirectGuard } from 'src/app/guards/portal-redirect.guard';
import { portalNavigationGuard } from 'src/app/guards/portal-navigation.guard';

const routes: Routes = [
  {
    path: '',
    title: 'Agenda Operatori',
    component: AgendaOperatoriComponent,
    canActivate: [portalRedirectGuard],
    canActivateChild: [portalNavigationGuard],
    resolve: { menu: menuResolver },
    data: {
      menuResolverParam: 'agenda-operatori',
      menuBase: '/portali/agenda-operatori',
      isPortal: true,
    },
    children: [
      { path: 'calendario', component: CalendarComponent },
      {
        path: 'lista-risorse',
        children: [
          {
            path: 'calendario',
            component: CalendarComponent,
          },
          {
            path: '',
            component: ListaRisorseComponent,
          },
        ],
      },
      { path: 'lista-attivita', component: ListaAttivitaComponent },
      {
        path: 'lista-nominativi-carico',
        component: ListaNominativiCaricoComponent,
      },
      {
        path: '',
        redirectTo: 'lista-attivita',
        pathMatch: 'full',
      },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AgendaOperatoriRoutingModule {}
