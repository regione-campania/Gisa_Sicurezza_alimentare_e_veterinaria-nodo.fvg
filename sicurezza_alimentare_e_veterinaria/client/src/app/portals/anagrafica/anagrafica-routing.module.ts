/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ANAGRAFICA_ENDPOINT } from '../../conf';
import { AnagraficaComponent } from './anagrafica.component';
import { ImpreseMainComponent } from './imprese-main/imprese-main.component';
import { ImpreseDettaglioComponent } from './imprese-main/imprese-dettaglio/imprese-dettaglio.component';
import { ImpreseUpsertComponent } from './imprese-main/imprese-upsert/imprese-upsert.component';
import { StabilimentiMainComponent } from './stabilimenti-main/stabilimenti-main.component';
import { StabilimentiDettaglioComponent } from './stabilimenti-main/stabilimenti-dettaglio/stabilimenti-dettaglio.component';
import { StabilimentiUpsertComponent } from './stabilimenti-main/stabilimenti-upsert/stabilimenti-upsert.component';
import { StabilimentiSubingressoComponent } from './stabilimenti-main/stabilimenti-subingresso/stabilimenti-subingresso.component';
import { FormIndirizzoMainComponent } from './form-indirizzo-main/form-indirizzo-main.component';
import { FigureDettaglioComponent } from './stabilimenti-main/figure-dettaglio/figure-dettaglio.component';
import { FigureUpsertComponent } from './stabilimenti-main/figure-upsert/figure-upsert.component';
import { SediDettaglioComponent } from './stabilimenti-main/sedi-dettaglio/sedi-dettaglio.component';
import { SediUpsertComponent } from './stabilimenti-main/sedi-upsert/sedi-upsert.component';
import { LineeUpsertComponent } from './stabilimenti-main/linee-upsert/linee-upsert.component';
import { LineeDettaglioComponent } from './stabilimenti-main/linee-dettaglio/linee-dettaglio.component';
import { SoggettiMainComponent } from './soggetti-main/soggetti-main.component';
import { SoggettiDettaglioComponent } from './soggetti-main/soggetti-dettaglio/soggetti-dettaglio.component';
import { SoggettiUpsertComponent } from './soggetti-main/soggetti-upsert/soggetti-upsert.component';
import { SoggettiAnagraficaAssistitiComponent } from './soggetti-main/soggetti-anagrafica-assistiti/soggetti-anagrafica-assistiti.component';
import { LineeMainComponent } from './linee-main/linee-main.component';
import { TipoListeComponent } from './tipo-liste/tipo-liste.component';
import { PraticheMainComponent } from './pratiche-main/pratiche-main.component';
import { PraticheDettaglioComponent } from './pratiche-main/pratiche-dettaglio/pratiche-dettaglio.component';
import { PraticheUpsertComponent } from './pratiche-main/pratiche-upsert/pratiche-upsert.component';
import { DettaglioPraticheComponent } from './stabilimenti-main/dettaglio-pratiche/dettaglio-pratiche.component';
//import { BonificaCfComponent } from './bonifica-cf/bonifica-cf.component';
import { AutomezziMainComponent } from './automezzi-main/automezzi-main.component';
import { AutomezziUpsertComponent } from './automezzi-main/automezzi-upsert/automezzi-upsert.component';
import { AutomezziDettaglioComponent } from './automezzi-main/automezzi-dettaglio/automezzi-dettaglio.component';
import { StabilimentiAutomezziUpsertComponent } from './automezzi-main/stabilimenti-automezzi-upsert/stabilimenti-automezzi-upsert.component';
import { AllineamentoParixComponent } from './allineamento-parix/allineamento-parix.component';
import { menuResolver } from 'src/app/resolvers/menu.resolver';
import { portalRedirectGuard } from 'src/app/guards/portal-redirect.guard';
import { portalNavigationGuard } from 'src/app/guards/portal-navigation.guard';
import { readOnlyGuard } from 'src/app/guards/read-only.guard';

const routes: Routes = [
  {
    path: '',
    title: 'Anagrafica',
    component: AnagraficaComponent,
    canActivate: [portalRedirectGuard],
    canActivateChild: [portalNavigationGuard],
    resolve: { menu: menuResolver },
    data: {
      menuResolverParam: 'anagrafica',
      menuBase: '/portali/anagrafica',
      isPortal: true,
    },
    children: [
      {
        path: 'imprese',
        children: [
          { path: 'dettaglio', component: ImpreseDettaglioComponent },
          { path: 'aggiungi', canActivate: [readOnlyGuard], component: ImpreseUpsertComponent },
          { path: 'modifica', canActivate: [readOnlyGuard], component: ImpreseUpsertComponent },
          { path: '', component: ImpreseMainComponent },
        ],
      },
      {
        path: 'stabilimenti',
        children: [
          {
            path: 'dettaglio',
            children: [
              { path: 'pratiche', component: DettaglioPraticheComponent },
              { path: '', component: StabilimentiDettaglioComponent },
            ],
          },
          { path: 'aggiungi', canActivate: [readOnlyGuard], component: StabilimentiUpsertComponent },
          { path: 'modifica', canActivate: [readOnlyGuard], component: StabilimentiUpsertComponent },
          { path: 'subingresso', component: StabilimentiSubingressoComponent },
          {
            path: 'figure',
            children: [
              { path: 'aggiungi', canActivate: [readOnlyGuard], component: FigureUpsertComponent },
              { path: 'modifica', canActivate: [readOnlyGuard], component: FigureUpsertComponent },
              { path: '', component: FigureDettaglioComponent },
            ],
          },
          {
            path: 'sedi',
            children: [
              { path: 'aggiungi', canActivate: [readOnlyGuard], component: SediUpsertComponent },
              { path: 'modifica', canActivate: [readOnlyGuard], component: SediUpsertComponent },
              { path: '', component: SediDettaglioComponent },
            ],
          },
          {
            path: 'linee',
            children: [
              { path: 'aggiungi', canActivate: [readOnlyGuard], component: LineeUpsertComponent },
              { path: 'modifica', canActivate: [readOnlyGuard], component: LineeUpsertComponent },
              { path: '', component: LineeDettaglioComponent },
            ],
          },
          { path: '', component: StabilimentiMainComponent },
        ],
      },
      {
        path: 'soggetti-fisici',
        children: [
          { path: 'dettaglio', component: SoggettiDettaglioComponent },
          {
            path: 'anagrafica-assistiti', canActivate: [readOnlyGuard],
            component: SoggettiAnagraficaAssistitiComponent,
          },
          { path: 'aggiungi', canActivate: [readOnlyGuard], component: SoggettiUpsertComponent },
          { path: 'modifica', canActivate: [readOnlyGuard], component: SoggettiUpsertComponent },
          { path: '', component: SoggettiMainComponent },
        ],
      },
      {
        path: 'pratiche',
        children: [
          { path: 'dettaglio', component: PraticheDettaglioComponent },
          { path: 'aggiungi', canActivate: [readOnlyGuard], component: PraticheUpsertComponent },
          { path: 'modifica', canActivate: [readOnlyGuard], component: PraticheUpsertComponent },
          { path: '', component: PraticheMainComponent },
        ],
      },
      {
        path: 'allineamento-parix',
        children: [
          {
            path: 'figura',
            children: [
              {
                path: 'soggetti',
                children: [
                  { path: 'aggiungi', canActivate: [readOnlyGuard], component: SoggettiUpsertComponent },
                  { path: 'modifica', canActivate: [readOnlyGuard], component: SoggettiUpsertComponent },
                ],
              },
              { path: 'aggiungi', canActivate: [readOnlyGuard], component: FigureUpsertComponent },
              { path: 'modifica', canActivate: [readOnlyGuard], component: FigureUpsertComponent },
              { path: '', component: AllineamentoParixComponent },
            ],
          },
          {
            path: 'sede',
            children: [
              { path: 'aggiungi', canActivate: [readOnlyGuard], component: SediUpsertComponent },
              { path: 'modifica', canActivate: [readOnlyGuard], component: SediUpsertComponent },
              { path: '', component: AllineamentoParixComponent },
            ],
          },
          {
            path: 'impresa',
            children: [
              { path: 'aggiungi', canActivate: [readOnlyGuard], component: ImpreseUpsertComponent },
              { path: 'modifica', canActivate: [readOnlyGuard], component: ImpreseUpsertComponent },
              { path: '', component: AllineamentoParixComponent },
            ],
          },
          {
            path: 'stabilimento',
            children: [
              { path: 'aggiungi', canActivate: [readOnlyGuard], component: StabilimentiUpsertComponent },
              { path: 'modifica', canActivate: [readOnlyGuard], component: StabilimentiUpsertComponent },
              { path: '', component: AllineamentoParixComponent },
            ],
          },
          // { path: '', component: AllineamentoParixComponent }
        ],
      },

      { path: 'form-indirizzo', component: FormIndirizzoMainComponent },
      { path: 'linee', component: LineeMainComponent },
      { path: 'tipo-liste', component: TipoListeComponent },
      //{ path: 'bonifica-cf', component: BonificaCfComponent },

      {
        path: 'automezzi',
        children: [
          { path: 'aggiungi', canActivate: [readOnlyGuard], component: AutomezziUpsertComponent },
          { path: 'modifica', canActivate: [readOnlyGuard], component: AutomezziUpsertComponent },
          { path: 'dettaglio', component: AutomezziDettaglioComponent },
          {
            path: 'aggiungi-stabilimento',
            component: StabilimentiAutomezziUpsertComponent,
          },
          {
            path: 'modifica-stabilimento',
            component: StabilimentiAutomezziUpsertComponent,
          },
          { path: '', component: AutomezziMainComponent },
        ],
      },
      { path: '', redirectTo: 'imprese', pathMatch: 'full' },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AnagraficaRoutingModule { }
