/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { CalendarComponent } from './calendar.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { EventDetailsPopupComponent } from './popup/event-details-popup/event-details-popup.component';
import { CalendarService } from './calendar.service';
import { FormsModule } from '@angular/forms';
import { FullCalendarModule } from '@fullcalendar/angular';
import { UsUtilsModule } from '@us/utils';
import { SharedModule } from 'src/app/shared/shared.module';

@NgModule({
  declarations: [
    CalendarComponent,
    EventDetailsPopupComponent,
  ],
  imports: [
    CommonModule,
    HttpClientModule,
    FormsModule,
    NgbModule,
    FullCalendarModule,
    UsUtilsModule,
    SharedModule
  ],
  exports: [
    CalendarComponent
  ],
  providers: [
    CalendarService,
  ],
  schemas: [CUSTOM_ELEMENTS_SCHEMA],
})
export class CalendarModule { }
