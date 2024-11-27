/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { CUSTOM_ELEMENTS_SCHEMA, NgModule, LOCALE_ID } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import {
  UsUtilsModule,
  BASE_URI,
  BackendCommunicationService,
} from '@us/utils';
import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
import { TokenInterceptor } from 'src/http-interceptor';
import { baseUri } from 'src/environments/environment';
import {
  HashLocationStrategy,
  LocationStrategy,
  registerLocaleData,
} from '@angular/common';
import localeIt from '@angular/common/locales/it';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { LoginComponent } from './login/login.component';
import { MenuModule } from './menu/menu.module';
import { TestLoginComponent } from './test-login/test-login.component';
import { SelezioneRuoloComponent } from './selezione-ruolo/selezione-ruolo.component';
import { AngularSvgIconModule } from 'angular-svg-icon';
import { AvvisiUpsertComponent } from './avvisi/avvisi-upsert/avvisi-upsert.component';
import { AvvisiComponent } from './avvisi/avvisi.component';
import { UnitaDiCrisiUpsertComponent } from './unita-di-crisi/unita-di-crisi-upsert/unita-di-crisi-upsert.component';
import { UnitaDiCrisiComponent } from './unita-di-crisi/unita-di-crisi.component';
import { UTILS, Utils } from './shared/shared';

registerLocaleData(localeIt);

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    TestLoginComponent,
    SelezioneRuoloComponent,
    UnitaDiCrisiComponent,
    UnitaDiCrisiUpsertComponent,
    AvvisiComponent,
    AvvisiUpsertComponent,
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    AppRoutingModule,
    ReactiveFormsModule,
    FormsModule,
    NgbModule,
    UsUtilsModule,
    MenuModule,
    HttpClientModule,
    AngularSvgIconModule.forRoot(),
  ],
  providers: [
    BackendCommunicationService,
    {
      provide: BASE_URI,
      useValue: baseUri + 'api/',
    },
    {
      provide: HTTP_INTERCEPTORS,
      useClass: TokenInterceptor,
      multi: true,
    },
    {
      provide: UTILS, //provider per l'intera libreria Utils
      useValue: Utils,
    },
    {
      provide: LocationStrategy,
      useClass: HashLocationStrategy,
    },
    {
      provide: LOCALE_ID,
      useValue: 'it-IT',
    },
  ],
  schemas: [CUSTOM_ELEMENTS_SCHEMA],
  bootstrap: [AppComponent],
})
export class AppModule {}
