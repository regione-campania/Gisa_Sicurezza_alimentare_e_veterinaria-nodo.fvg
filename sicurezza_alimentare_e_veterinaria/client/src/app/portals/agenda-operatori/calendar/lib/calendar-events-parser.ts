/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { EventInput } from '@fullcalendar/core';

export class CalendarEventsParser {
  static parse(...events: any[]): EventInput[] {
    let parsed: EventInput[] = [];
    events.forEach((ev) => {
      let obj: EventInput = {};
      for(let p in ev) {
        switch(p) {
          case 'id': obj.id = ev.id; break;
          case 'evento': obj.title = ev.evento; break;
          case 'inizio': obj.start = ev.inizio; break;
          case 'fine': obj.end = ev.fine; break;
          case 'colore': obj.color = ev.colore; break;
          case 'colore_bordo': obj.borderColor = ev.colore_bordo; break;
          case 'modifica_inizio': obj.startEditable = ev.modifica_inizio; break;
          case 'modifica_durata': obj.durationEditable = ev.modifica_durata; break;
          default: obj[p] = ev[p]; break;
        }
      }
      parsed.push(obj);
    });
    return parsed;
  }
}
