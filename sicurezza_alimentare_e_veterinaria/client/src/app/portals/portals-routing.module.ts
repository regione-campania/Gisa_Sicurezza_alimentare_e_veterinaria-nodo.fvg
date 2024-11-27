/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PortalsHomeComponent } from './portals-home/portals-home.component';
import { portalsResolver } from '../resolvers/portals.resolver';
import { newFeatureGuard } from '../guards/new-feature.guard';
import { portalsMenuResolver } from '../resolvers/portals-menu.resolver';
import { portalGuard } from '../guards/portal.guard';

const routes: Routes = [
  {
    path: '',
    children: [
      {
        path: 'agenda-operatori',
        canActivate: [portalGuard],
        loadChildren: () =>
          import('./agenda-operatori/agenda-operatori.module').then(
            (m) => m.AgendaOperatoriModule
          ),
      },
      {
        path: 'anagrafica',
        canActivate: [portalGuard],
        loadChildren: () =>
          import('./anagrafica/anagrafica.module').then(
            (m) => m.AnagraficaModule
          ),
      },
      {
        path: 'bdnfvg',
        canActivate: [portalGuard],
        loadChildren: () =>
          import('./bdnfvg/bdnfvg.module').then((m) => m.BdnfvgModule),
      },
      {
        path: 'configurazioni',
        canActivate: [portalGuard],
        loadChildren: () =>
          import('./configurazioni/configurazioni.module').then(
            (m) => m.ConfigurazioniModule
          ),
      },
      {
        path: 'controlli-ufficiali',
        canActivate: [portalGuard],
        loadChildren: () =>
          import('./controlli-ufficiali/controlli-ufficiali.module').then(
            (m) => m.ControlliUfficialiModule
          ),
      },
      {
        path: 'gestione-attivita',
        canActivate: [portalGuard],
        loadChildren: () =>
          import('./gestione-attivita/gestione-attivita.module').then(
            (m) => m.GestioneAttivitaModule
          ),
      },
      {
        path: 'organizzazione',
        canActivate: [portalGuard],
        loadChildren: () =>
          import('./organizzazione/organizzazione.module').then(
            (m) => m.OrganizzazioneModule
          ),
      },
      {
        path: '',
        resolve: { portals: portalsResolver, menu: portalsMenuResolver },
        component: PortalsHomeComponent,
      },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class PortalsRoutingModule {}
