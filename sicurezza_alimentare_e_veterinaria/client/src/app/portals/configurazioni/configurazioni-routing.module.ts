/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ConfigurazioniComponent } from './configurazioni.component';
import { CONFIGURAZIONI_ENDPOINT } from '../../conf';
import { RuoliComponent } from './ruoli/ruoli.component';
import { DettaglioRuoliComponent } from './dettaglio-ruoli/dettaglio-ruoli.component';
import { UtentiComponent } from './utenti/utenti.component';
import { DettaglioUtenteComponent } from './dettaglio-utente/dettaglio-utente.component';
import { UtenteRuoliUpsertComponent } from './utente-ruoli-upsert/utente-ruoli-upsert.component';
import { RuoloPermessiUpsertComponent } from './ruolo-permessi-upsert/ruolo-permessi-upsert.component';
import { RuoloRuoliUpsertComponent } from './ruolo-ruoli-upsert/ruolo-ruoli-upsert.component';
import { LogMainComponent } from './log-main/log-main.component';
import { DettaglioLogComponent } from './log-main/dettaglio-log/dettaglio-log.component';
import { AggiungiUtenteComponent } from './utenti/aggiungi-utente/aggiungi-utente.component';
import { StruttureUtenteComponent } from './utenti/strutture-utente/strutture-utente.component';
import { RuoliStruttureUtenteComponent } from './utenti/ruoli-strutture-utente/ruoli-strutture-utente.component';
import { menuResolver } from 'src/app/resolvers/menu.resolver';
import { portalRedirectGuard } from 'src/app/guards/portal-redirect.guard';
import { portalNavigationGuard } from 'src/app/guards/portal-navigation.guard';

const routes: Routes = [
  {
    path: '',
    title: 'Configurazioni',
    component: ConfigurazioniComponent,
    canActivate: [portalRedirectGuard],
    canActivateChild: [portalNavigationGuard],
    resolve: { menu: menuResolver },
    data: {
      menuResolverParam: 'configurazioni',
      menuBase: '/portali/configurazioni',
      isPortal: true,
    },
    children: [
      {
        path: 'ruoli',
        children: [
          { path: '', component: RuoliComponent },
          { path: 'aggiungi', component: UtenteRuoliUpsertComponent },
          {
            path: 'dettaglio-ruoli',
            children: [
              {
                path: 'aggiungi-permesso',
                component: RuoloPermessiUpsertComponent,
              },
              {
                path: 'modifica-modalita',
                component: RuoloPermessiUpsertComponent,
              },
              {
                path: 'aggiungi-ruolo-ruoli',
                component: RuoloRuoliUpsertComponent,
              },
              { path: '', component: DettaglioRuoliComponent },
            ],
          },
        ],
      },
      {
        path: 'utenti',
        children: [
          { path: '', component: UtentiComponent },
          { path: 'aggiungi', component: AggiungiUtenteComponent },
          {
            path: 'dettaglio',
            children: [
              { path: '', component: StruttureUtenteComponent },
              { path: 'ruoli', component: RuoliStruttureUtenteComponent },
            ],
          },
        ],
      },
      {
        path: 'operazioni',
        children: [
          { path: '', component: LogMainComponent },
          { path: 'dettaglio', component: DettaglioLogComponent },
        ],
      },
      { path: '', redirectTo: 'utenti', pathMatch: 'full' },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ConfigurazioniRoutingModule {}
