/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CertificatiComponent } from './certificati/certificati.component';
import { UserComponent } from './user/user.component';
import { ListaCertificatiComponent } from './lista-certificati/lista-certificati.component';
import { GestioneDelegheComponent } from './gestione-deleghe/gestione-deleghe.component';
import { RegistrazioneComponent } from './user/registrazione/registrazione.component';
import { ValidaUtentiComponent } from './user/valida-utenti/valida-utenti.component';
import { DenominazioneProdottoComponent } from './user/denominazione-prodotto/denominazione-prodotto.component';
import { ConfiguraCertificatoComponent } from './configura-certificato/configura-certificato.component';
import { TipoListeComponent } from './tipo-liste/tipo-liste.component';
import { ListaComponent } from './tipo-liste/lista/lista.component';

const routes: Routes = [
  {path: '', redirectTo: 'login', pathMatch: 'full'},
  {path: 'login', component: UserComponent},
  {path: 'login-test', component: UserComponent},
  {path: 'registrazione', component: RegistrazioneComponent},
  {path: 'user/lista-certificati', component: ListaCertificatiComponent},
  {path: 'user/gestione-deleghe', component: GestioneDelegheComponent},
  {path: 'user/valida-utenti', component: ValidaUtentiComponent},
  {path: 'user/denominazione-prodotto', component: DenominazioneProdottoComponent},
  {path: 'user/lista-certificati/certificati', component: CertificatiComponent},
  {path: 'user/tipo-liste', component: TipoListeComponent},
  {path: 'user/lista', component: ListaComponent },
  {path: 'configura-certificato', component: ConfiguraCertificatoComponent},
  {path: 'us-us', component: UserComponent},

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
