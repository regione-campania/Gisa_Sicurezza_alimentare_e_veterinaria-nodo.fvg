/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { GeneratoreCalendarioComponent } from './generatore-calendario/generatore-calendario.component';
import { ListaAttivitaComponent } from './lista-attivita/lista-attivita.component';
import { ScontrinoComponent } from './scontrino/scontrino.component';
import { FatturaComponent } from './fattura/fattura.component';
import { ListaCalendariComponent } from './lista-calendari/lista-calendari.component';
import Swal from 'sweetalert2';
import { ConfigurazioneTariffeComponent } from './configurazione-tariffe/configurazione-tariffe.component';
import { ConfigurazioniComponent } from './configurazioni/configurazioni.component';
import { ListaConfigurazioneComponent } from './lista-configurazione/lista-configurazione.component';
import { MonitoraggioImportComponent } from './monitoraggio-import/monitoraggio-import.component';
import { ScartiImportComponent } from './scarti-import/scarti-import.component';
import { ListaComponent } from './configurazioni/tipo-liste/lista/lista.component';
import { ListaDetComponent } from './configurazioni/tipo-liste/lista/listadet.component';
import { TipoListaPianiComponent } from './configurazioni/tipo-liste/tipolista-piani/tipolista-piani.component';

//import { ListaFatturePeriodicheComponent } from './lista-fatture-periodiche/lista-fatture-periodiche.component';
import { ListaFattureComponent } from './lista-fatture/lista-fatture.component';
import { GeneraFattureComponent } from './genera-fatture/genera-fatture.component';
import { GestioneAttivitaComponent } from './gestione-attivita.component';
import { ListaFatturePeriodicheComponent } from './lista-fatture-periodiche/lista-fatture-periodiche.component';
import { AttivitaInviateComponent } from './attivita-inviate/attivita-inviate.component';
import { AttivitaUltimoStatoComponent } from './attivita-ultimo-stato/attivita-ultimo-stato.component';
import { menuResolver } from 'src/app/resolvers/menu.resolver';
import { portalNavigationGuard } from 'src/app/guards/portal-navigation.guard';
import { portalRedirectGuard } from 'src/app/guards/portal-redirect.guard';

const routes: Routes = [
  {
    path: '',
    title: 'Gestione Attività',
    component: GestioneAttivitaComponent,
    canActivate: [portalRedirectGuard],
    canActivateChild: [portalNavigationGuard],
    resolve: { menu: menuResolver },
    data: {
      menuResolverParam: 'gestione-attivita',
      menuBase: '/portali/gestione-attivita',
      isPortal: true,
    },
    children: [
      {
        path: 'lista-attivita', children: [
          { path: 'scontrino', component: ScontrinoComponent },
          { path: '', component: ListaAttivitaComponent }
        ]
      },
      { path: 'lista-configurazione', component: ListaConfigurazioneComponent },
      {
        path: 'lista-calendari', children: [
          {
            path: 'genera-calendario',
            component: GeneratoreCalendarioComponent,
            canDeactivate: [
              (component: GeneratoreCalendarioComponent) => {
                if (!component.hasPendingChanges) return true;
                return Swal.fire({
                  title: 'Salvare le modifiche prima di uscire?',
                  icon: 'warning',
                  confirmButtonText: 'Si',
                  showDenyButton: true,
                  denyButtonText: 'No',
                }).then((res) => {
                  if (res.isConfirmed) component.salvaTutto().subscribe();
                  return true;
                });
              },
            ],
          },
          { path: '', component: ListaCalendariComponent }
        ]
      },

      {
        path: 'tariffario',
        loadChildren: () =>
          import(
            'src/app/portals/gestione-attivita/tariffario/tariffario.module'
          ).then((m) => m.TariffarioModule),
      },
      { path: 'lista-prestazioni', component: ListaFattureComponent },
      { path: 'import', component: MonitoraggioImportComponent },
      { path: 'import/scarti', component: ScartiImportComponent },
      { path: 'listadet', component: ListaDetComponent },
      { path: 'fattura', component: FatturaComponent },
      { path: 'genera-prestazioni', component: GeneraFattureComponent },
      { path: 'configurazione', component: ConfigurazioniComponent },
      { path: 'configurazione/lista', component: ListaComponent },
      {
        path: 'configurazione/tipolistapiani',
        component: TipoListaPianiComponent,
      },
      {
        path: 'configurazione-tariffe',
        component: ConfigurazioneTariffeComponent,
      },
      { path: 'lista-fatture', component: ListaFatturePeriodicheComponent },
      { path: 'lista-attivita-inviate', component: AttivitaInviateComponent },
      {
        path: 'lista-attivita-inviate',
        children: [
          {
            path: 'lista-attivita-ultimo-stato',
            component: AttivitaUltimoStatoComponent,
          },
          { path: '', component: AttivitaInviateComponent },
        ],
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
export class GestioneAttivitaRoutingModule { }
