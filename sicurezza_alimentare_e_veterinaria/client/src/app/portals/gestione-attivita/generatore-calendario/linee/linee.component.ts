/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  Component,
  Input,
  OnChanges,
  OnInit,
  SimpleChanges,
  ViewChild,
} from '@angular/core';
import { GeneratoreCalendarioService } from '../generatore-calendario.service';
import { Subscription, throwError } from 'rxjs';
import { ASmartTableComponent } from '@us/utils';

@Component({
  selector: 'gen-linee',
  templateUrl: './linee.component.html',
  styleUrls: ['./linee.component.scss'],
})
export class LineeComponent implements OnChanges, OnInit {
  @ViewChild('lineeTable') lineeTable?: ASmartTableComponent;
  @Input() elab?: {
    id: number;
    descr: string;
    bloccato: boolean;
    elaborato: boolean;
  };

  loading = false;
  linee: any;
  lineeSub?: Subscription;
  ui: any;

  mappaturaLinee = (linea: any) => {
    linea.selectable = true;
    linea.selected = linea.selezionata;
    return linea;
  };

  constructor(private gs: GeneratoreCalendarioService) {}

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['elab']) {
      this.initLinee();
    }
  }

  ngOnInit() {
    this.initLinee();
  }

  initLinee() {
    if (this.elab) {
      this.loading = true;
      this.linee = undefined;
      this.ui = undefined;
      this.lineeSub = this.gs.getElabLinee(this.elab!.id).subscribe((res) => {
        this.loading = false;
        if (res.esito) {
          //ordina le linee mettendo in cima quelle selezionate
          this.linee = res.info.dati.sort((a: any, b: any) => {
            if (a.selezionata && b.selezionata) {
              return a['denominazione_sede_operativa'].localeCompare(
                b['denominazione_sede_operativa']
              );
            }
            if (a.selezionata) return -1;
            if (b.selezionata) return 1;
            return 0;
          });
          this.ui = res.info.ui;
        }
      });
    }
  }

  updLinee() {
    if (this.elab) {
      return this.gs.updElabLinee(
        this.elab.id,
        this.lineeTable?.selectedData.map((x) => {
          return { id_linea: x['id_linea'], id_piano: x['id_piano'] };
        }) ?? []
      );
    } else {
      return throwError(() => new Error('Nessun elaborazione presente.'));
    }
  }
}
