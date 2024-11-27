/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AllevamentiComponent } from './allevamenti/allevamenti.component';
import { AziendeComponent } from './aziende/aziende.component';
import { CapiInStallaComponent } from './capi-in-stalla/capi-in-stalla.component';
import { CapiComponent } from './capi/capi.component';
import { MovimentazioniCapoComponent } from './movimentazioni-capo/movimentazioni-capo.component';
import {
  allevamentiResolver,
  aziendeResolver,
  capapnnoniResolver,
  capiInStallaResolver,
  capiResolver,
  giornataResolver,
  monitoraggioAllevamentiResolver,
  movimentazioniCapoResolver,
  nuovoInterventoResolver,
  pianiResolver,
  riepilogoResolver,
  risultatiResolver,
  sottoscrizioniElaborazioniFilesResolver,
  sottoscrizioniElaborazioniResolver,
  sottoscrizioniResolver,
} from './resolvers/resolvers';
import { InterventiComponent } from './interventi/interventi.component';
import { GestioneInterventoComponent } from './gestione-intervento/gestione-intervento.component';
import { GiornataComponent } from './giornata/giornata.component';
import { RisultatiComponent } from './risultati/risultati.component';
import { NuovoInterventoComponent } from './nuovo-intervento/nuovo-intervento.component';
import { PianiComponent } from './piani/piani.component';
import { RiepilogoComponent } from './riepilogo/riepilogo.component';
import { CapannoniComponent } from './capannoni/capannoni.component';
import { SottoscrizioniComponent } from './sottoscrizioni/sottoscrizioni.component';
import { SottoscrizioniElaborazioniComponent } from './sottoscrizioni-elaborazioni/sottoscrizioni-elaborazioni.component';
import { SottoscrizioniElaborazioniFilesComponent } from './sottoscrizioni-elaborazioni-files/sottoscrizioni-elaborazioni-files.component';
import { MonitoraggioAllevamentiComponent } from './monitoraggioallevamenti/monitoraggioallevamenti.component';
import { ImportaMovimentazioniComponent } from './importa-movimentazioni/importa-movimentazioni.component';
import { BdnfvgComponent } from './bdnfvg.component';
import { menuResolver } from 'src/app/resolvers/menu.resolver';
import { portalRedirectGuard } from 'src/app/guards/portal-redirect.guard';
import { portalNavigationGuard } from 'src/app/guards/portal-navigation.guard';

const routes: Routes = [
  {
    path: '',
    title: 'Profilassi',
    component: BdnfvgComponent,
    // canActivate: [portalRedirectGuard],
    // canActivateChild: [portalNavigationGuard],
    resolve: { menu: menuResolver },
    data: {
      menuResolverParam: 'bdn',
      menuBase: '/portali/bdnfvg',
      isPortal: true,
    },
    children: [
      {
        path: 'riepilogo',
        component: RiepilogoComponent,
        resolve: { riepilogo: riepilogoResolver },
      },
      {
        path: 'riepilogo/allevamenti',
        redirectTo: 'aziende/allevamenti',
        resolve: { allevamenti: allevamentiResolver },
      },
      {
        path: 'aziende',
        component: AziendeComponent,
        resolve: { aziende: aziendeResolver },
      },
      {
        path: 'aziende/allevamenti',
        component: AllevamentiComponent,
        resolve: { allevamenti: allevamentiResolver },
      },
      {
        path: 'aziende/allevamenti/capiinstalla',
        component: CapiInStallaComponent,
        resolve: { capiInStalla: capiInStallaResolver },
      },
      {
        path: 'aziende/allevamenti/capannoni',
        component: CapannoniComponent,
        resolve: { capannoni: capapnnoniResolver },
      },
      { path: 'aziende/allevamenti/interventi', redirectTo: 'interventi' },
      {
        path: 'aziende/allevamenti/capiinstalla/movimentazionicapo',
        component: MovimentazioniCapoComponent,
        resolve: { movimentazioniCapo: movimentazioniCapoResolver },
      },
      {
        path: 'capi',
        component: CapiComponent,
        resolve: { capi: capiResolver },
      },
      {
        path: 'capi/movimentazionicapo',
        component: MovimentazioniCapoComponent,
        resolve: { movimentazioniCapo: movimentazioniCapoResolver },
      },
      // {path: 'capi/movimentazionicapo/allevamenti', component: AllevamentiComponent, resolve: {allevamenti: allevamentiResolver}},
      {
        path: 'capi/movimentazionicapo/allevamenti',
        redirectTo: 'aziende/allevamenti',
        resolve: { allevamenti: allevamentiResolver },
      },
      { path: 'interventi', component: InterventiComponent },
      {
        path: 'interventi/nuovo-intervento',
        component: NuovoInterventoComponent,
        resolve: { piani: nuovoInterventoResolver },
      },
      {
        path: 'interventi/nuovo-intervento/capiinstalla',
        component: CapiInStallaComponent,
      },
      {
        path: 'interventi/gestione-intervento',
        component: GestioneInterventoComponent,
      },
      {
        path: 'interventi/gestione-intervento/giornata',
        component: GiornataComponent,
        resolve: { capiGiornata: giornataResolver },
      },
      {
        path: 'interventi/gestione-intervento/risultati',
        component: RisultatiComponent,
        resolve: { risultati: risultatiResolver },
      },
      {
        path: 'piani',
        component: PianiComponent,
        resolve: { piani: pianiResolver },
      },

      {
        path: 'sottoscrizioni',
        component: SottoscrizioniComponent,
        resolve: { sottoscrizioni: sottoscrizioniResolver },
      },
      {
        path: 'sottoscrizioni/sottoscrizioni-elaborazioni',
        component: SottoscrizioniElaborazioniComponent,
        resolve: {
          sottoscrizioniElaborazioni: sottoscrizioniElaborazioniResolver,
        },
      },
      {
        path: 'sottoscrizioni/sottoscrizioni-elaborazioni/sottoscrizioni-elaborazioni-files',
        component: SottoscrizioniElaborazioniFilesComponent,
        resolve: {
          sottoscrizioniElaborazioniFiles:
            sottoscrizioniElaborazioniFilesResolver,
        },
      },
      {
        path: 'monitoraggioallevamenti',
        component: MonitoraggioAllevamentiComponent,
        resolve: { monitoraggioAllevamenti: monitoraggioAllevamentiResolver },
      },
      {
        path: 'importa-movimentazioni',
        component: ImportaMovimentazioniComponent,
      },
      { path: '', redirectTo: 'interventi', pathMatch: 'full' },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class BdnfvgRoutingModule {}
