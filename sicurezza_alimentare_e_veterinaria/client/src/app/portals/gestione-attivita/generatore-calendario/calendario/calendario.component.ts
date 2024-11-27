/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  Component,
  EventEmitter,
  Input,
  OnChanges,
  Output,
  SimpleChanges,
} from '@angular/core';
import { GeneratoreCalendarioService } from '../generatore-calendario.service';

@Component({
  selector: 'gen-calendario',
  templateUrl: './calendario.component.html',
  styleUrls: ['./calendario.component.scss'],
})
export class CalendarioComponent implements OnChanges {
  @Input() elab?: { id: number, descr: string, bloccato: boolean, elaborato: boolean };
  @Output('calendarioChange') calendarioChangeEvent = new EventEmitter();

  loading = false;
  calendario: any;
  ui: any;

  constructor(
    private gs: GeneratoreCalendarioService,
  ) { }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['elab']) {
      this.init();
    }
  }

  init() {
    if (this.elab) {
      this.loading = true;
      this.calendario = undefined;
      this.gs
        .getCalendario(this.elab!.id)
        .subscribe((res) => {
          this.loading = false;
          if (res.esito) {
            this.ui = res.info.ui;
            this.calendario = res.info.dati;
            this.calendarioChangeEvent.emit(this.calendario);
          }
        });
    }
  }

}
