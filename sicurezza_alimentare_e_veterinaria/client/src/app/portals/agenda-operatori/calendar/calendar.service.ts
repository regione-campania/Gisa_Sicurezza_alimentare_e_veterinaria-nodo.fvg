/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Injectable } from '@angular/core';
import { EventApi } from '@fullcalendar/core';
import { map } from 'rxjs';
import { CalendarComponent } from './calendar.component';
import { CalendarEventsParser } from './lib/calendar-events-parser';
import { BackendCommunicationService } from '@us/utils';

@Injectable()
export class CalendarService {
  calendarComponent?: CalendarComponent;

  constructor(private be: BackendCommunicationService) { }

  getCalendario(userId: string) {
    return this.be.getDati('get_eventi', { id: userId })
      .pipe(
        map((res) => {
          if (res.info)
            res.info.calendario.eventi = CalendarEventsParser.parse(...res.info.calendario.eventi);
          return res;
        })
      );
  }

  getStatoEventi() {
    return this.be.getDati('get_stato_eventi');
  }

  updateEvento(eventInfo: EventApi) {
    return this.be.updDati('upd_evento', eventInfo);
  }
}
