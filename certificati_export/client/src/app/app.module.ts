/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { CommonModule, HashLocationStrategy, LocationStrategy } from '@angular/common';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { TokenInterceptor } from 'src/http-interceptor';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { CertificatiComponent } from './certificati/certificati.component';
import { CompilaCertificatoComponent } from './certificati/compila-certificato/compila-certificato.component';
import { PreviewCertificatoComponent } from './certificati/preview-certificato/preview-certificato.component';
import { UserComponent } from './user/user.component';
import { ListaCertificatiComponent } from './lista-certificati/lista-certificati.component';
import { UsUtilsModule, ASmartTableModule } from '@us/utils';
import { GestioneDelegheComponent } from './gestione-deleghe/gestione-deleghe.component';
import { RegistrazioneComponent } from './user/registrazione/registrazione.component';
import { ValidaUtentiComponent } from './user/valida-utenti/valida-utenti.component';
import { DenominazioneProdottoComponent } from './user/denominazione-prodotto/denominazione-prodotto.component';
import { ConfiguraCertificatoComponent } from './configura-certificato/configura-certificato.component';
import { TipoListeComponent } from './tipo-liste/tipo-liste.component';
import { ListaComponent } from './tipo-liste/lista/lista.component';

@NgModule({
  declarations: [
    AppComponent,
    CertificatiComponent,
    CompilaCertificatoComponent,
    PreviewCertificatoComponent,
    UserComponent,
    ListaCertificatiComponent,
    GestioneDelegheComponent,
    RegistrazioneComponent,
    ValidaUtentiComponent,
    TipoListeComponent,
    ListaComponent,
    ValidaUtentiComponent,
    DenominazioneProdottoComponent,
    ConfiguraCertificatoComponent
  ],
  imports: [
    NgbModule,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    UsUtilsModule,
    ASmartTableModule
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: TokenInterceptor,
      multi: true
    },
    { provide: LocationStrategy, useClass: HashLocationStrategy },
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
