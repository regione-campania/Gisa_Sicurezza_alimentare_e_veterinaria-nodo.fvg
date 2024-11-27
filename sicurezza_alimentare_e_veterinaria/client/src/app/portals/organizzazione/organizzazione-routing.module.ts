/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { OrganizzazioneComponent } from './organizzazione.component';
import { StrutturaPianiComponent } from '../organizzazione/struttura-piani/struttura-piani.component';
import { SpostaPianoComponent } from '../organizzazione/sposta-piano/sposta-piano.component';
import { StruttureAslComponent } from '../organizzazione/strutture-asl/strutture-asl.component';
import { OrganigrammaRisorseComponent } from '../organizzazione/organigramma-risorse/organigramma-risorse.component';
import { AssociaRisorsaComponent } from '../organizzazione/associa-risorsa/associa-risorsa.component';
import { menuResolver } from 'src/app/resolvers/menu.resolver';
import { portalNavigationGuard } from 'src/app/guards/portal-navigation.guard';
import { portalRedirectGuard } from 'src/app/guards/portal-redirect.guard';

const routes: Routes = [
  {
    path: '',
    title: 'Organizzazione',
    component: OrganizzazioneComponent,
    canActivate: [portalRedirectGuard],
    canActivateChild: [portalNavigationGuard],
    resolve: { menu: menuResolver },
    data: {
      menuResolverParam: 'organizzazione',
      menuBase: '/portali/organizzazione',
      isPortal: true,
    },
    children: [
      {
        path: 'struttura-piani',
        children: [{ path: '', component: StrutturaPianiComponent }],
      },
      {
        path: 'sposta-piano',
        children: [{ path: '', component: SpostaPianoComponent }],
      },
      {
        path: 'strutture-asl',
        children: [{ path: '', component: StruttureAslComponent }],
      },
      {
        path: 'organigramma-risorse',
        children: [{ path: '', component: OrganigrammaRisorseComponent }],
      },
      {
        path: 'associa-risorse',
        children: [{ path: '', component: AssociaRisorsaComponent }],
      },
      { path: '', redirectTo: 'struttura-piani', pathMatch: 'full' },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class OrganizzazioneRoutingModule {}
