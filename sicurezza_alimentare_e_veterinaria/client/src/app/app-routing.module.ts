/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { inject, NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { authNavigationGuard } from './guards/auth-navigation.guard';
import { loginNavigationGuard } from './guards/login-navigation.guard';
import { TestLoginComponent } from './test-login/test-login.component';
import { SelezioneRuoloComponent } from './selezione-ruolo/selezione-ruolo.component';
import { AvvisiUpsertComponent } from './avvisi/avvisi-upsert/avvisi-upsert.component';
import { AvvisiComponent } from './avvisi/avvisi.component';
import { UnitaDiCrisiUpsertComponent } from './unita-di-crisi/unita-di-crisi-upsert/unita-di-crisi-upsert.component';
import { UnitaDiCrisiComponent } from './unita-di-crisi/unita-di-crisi.component';
import { menuResolver } from './resolvers/menu.resolver';
import { portalsMenuResolver } from './resolvers/portals-menu.resolver';

const routes: Routes = [
  {
    path: 'login',
    component: LoginComponent,
    canActivate: [loginNavigationGuard],
  },
  {
    path: 'test-login',
    component: TestLoginComponent,
    canActivate: [loginNavigationGuard],
  },
  {
    path: 'corso-login',
    component: TestLoginComponent,
    canActivate: [loginNavigationGuard],
  },
  {
    path: 'portali',
    title: 'Portali',
    canActivate: [authNavigationGuard],
    canActivateChild: [authNavigationGuard],
    loadChildren: () =>
      import('./portals/portals.module').then((m) => m.PortalsModule),
  },
  {
    path: 'avvisi',
    title: 'Avvisi',
    resolve: { menu: portalsMenuResolver },
    canActivate: [authNavigationGuard],
    canActivateChild: [authNavigationGuard],
    children: [
      { path: 'aggiungi-avvisi', component: AvvisiUpsertComponent },
      { path: 'modifica-avvisi', component: AvvisiUpsertComponent },
      { path: '', component: AvvisiComponent },
    ],
  },
  {
    path: 'unita-di-crisi',
    title: 'Unità di Crisi',
    resolve: { menu: portalsMenuResolver },
    canActivate: [authNavigationGuard],
    canActivateChild: [authNavigationGuard],
    children: [
      {
        path: 'modifica-unita-di-crisi',
        component: UnitaDiCrisiUpsertComponent,
      },
      {
        path: 'aggiungi-unita-di-crisi',
        component: UnitaDiCrisiUpsertComponent,
      },
      { path: '', component: UnitaDiCrisiComponent },
    ],
  },
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: '**', redirectTo: 'login' }, // Gestione delle rotte non trovate
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
