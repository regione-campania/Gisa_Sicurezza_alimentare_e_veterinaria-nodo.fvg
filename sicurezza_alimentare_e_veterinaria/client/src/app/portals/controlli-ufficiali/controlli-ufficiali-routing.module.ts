/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ControlliUfficialiComponent } from './controlli-ufficiali.component';
import { ListaCuComponent } from './lista-cu/lista-cu.component';
import { DettaglioControlloComponent } from './dettaglio-controllo/dettaglio-controllo.component';
import { LineeCuComponent } from './linee-cu/linee-cu.component';
import { PianiCuComponent } from './piani-cu/piani-cu.component';
import { AssociaOggettiCuComponent } from './associa-oggetti-cu/associa-oggetti-cu.component';
import { OggettiChecklistCuComponent } from './oggetti-checklist-cu/oggetti-checklist-cu.component';
import { OggettiEvidenzeCuComponent } from './oggetti-evidenze-cu/oggetti-evidenze-cu.component';
import { OggettiCuComponent } from './oggetti-cu/oggetti-cu.component';
import { OggettiRequisitiCuComponent } from './oggetti-requisiti-cu/oggetti-requisiti-cu.component';
import { ProvvedimentiCuComponent } from './provvedimenti-cu/provvedimenti-cu.component';
import { ProvvedimentiAddCuComponent } from './provvedimenti-add-cu/provvedimenti-add-cu.component';
import { VerificaProvvedimentiFuComponent } from './verifica-provvedimenti-fu/verifica-provvedimenti-fu.component';
import { VerificaEvidenzeFuComponent } from './verifica-evidenze-fu/verifica-evidenze-fu.component';
import { NucleoIspettivoCuRefactoringComponent } from './nucleo-ispettivo-cu-refactoring/nucleo-ispettivo-cu-refactoring.component';
import { CategoriaRischioComponent } from './categoria-rischio/categoria-rischio.component';
import { ProvvedimentiSopralluogoComponent } from './provvedimenti-sopralluogo/provvedimenti-sopralluogo.component';
import { VerificaProvvedimentiFsComponent } from './verifica-provvedimenti-fs/verifica-provvedimenti-fs.component';
import { TrasportatoriComponent } from './trasportatori/trasportatori.component';
import { menuResolver } from 'src/app/resolvers/menu.resolver';
import { portalNavigationGuard } from 'src/app/guards/portal-navigation.guard';
import { portalRedirectGuard } from 'src/app/guards/portal-redirect.guard';
import { DurataCuComponent } from './durata-cu/durata-cu.component';

const routes: Routes = [
  {
    path: '',
    title: 'Controlli Ufficiali',
    component: ControlliUfficialiComponent,
    canActivate: [portalRedirectGuard],
    canActivateChild: [portalNavigationGuard],
    resolve: { menu: menuResolver },
    data: {
      menuResolverParam: 'controlli-ufficiali',
      menuBase: '/portali/controlli-ufficiali',
      isPortal: true,
    },
    children: [
      {
        path: 'oggetti',
        children: [
          { path: 'requisiti', component: OggettiRequisitiCuComponent },
          { path: '', component: OggettiCuComponent },
        ],
      },
      {
        path: 'lista',
        children: [
          {
            path: 'dettaglio',
            children: [
              {
                path: 'nucleo-ispettivo',
                component: NucleoIspettivoCuRefactoringComponent,
              },
              { path: 'linee', component: LineeCuComponent },
              { path: 'piani', component: PianiCuComponent },
              {
                path: 'associa-oggetti',
                children: [
                  {
                    path: 'oggetti-checklist-cu',
                    children: [
                      {
                        path: 'oggetti-evidenze-cu',
                        component: OggettiEvidenzeCuComponent,
                      },
                      { path: '', component: OggettiChecklistCuComponent },
                    ],
                  },

                  { path: '', component: AssociaOggettiCuComponent },
                ],
              },
              {
                path: 'provvedimenti',
                children: [
                  { path: 'aggiungi', component: ProvvedimentiAddCuComponent },
                  { path: '', component: ProvvedimentiCuComponent },
                ],
              },
              {
                path: 'categoria-rischio',
                component: CategoriaRischioComponent,
              },
              {
                path: 'verifica-provvedimenti',
                children: [
                  {
                    path: 'evidenze-provvedimenti',
                    component: VerificaEvidenzeFuComponent,
                  },
                  { path: '', component: VerificaProvvedimentiFuComponent },
                ],
              },
              {
                path: 'provvedimenti-sopralluogo',
                component: ProvvedimentiSopralluogoComponent,
              },
              {
                path: 'verifica-provvedimenti-fs',
                component: VerificaProvvedimentiFsComponent,
              },
              { path: 'trasportatori', component: TrasportatoriComponent },

              { path: '', component: DettaglioControlloComponent },
            ],
          },

          { path: '', component: ListaCuComponent },
        ],
      },
      {
        path: 'durata-cu',
        children: [
          { path: '', component: DurataCuComponent },
        ],
      },
      { path: '', redirectTo: 'lista', pathMatch: 'full' },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ControlliUfficialiRoutingModule {}
