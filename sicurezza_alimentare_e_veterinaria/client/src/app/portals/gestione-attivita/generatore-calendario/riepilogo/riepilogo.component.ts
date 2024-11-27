/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  AfterViewChecked,
  AfterViewInit,
  Component,
  Input,
  OnChanges,
  SimpleChanges,
} from '@angular/core';
import { GeneratoreCalendarioService } from '../generatore-calendario.service';
import { fitHeight, stretchHeight } from '@us/utils';

@Component({
  selector: 'gen-riepilogo',
  templateUrl: './riepilogo.component.html',
  styleUrls: ['./riepilogo.component.scss'],
})
export class RiepilogoComponent
  implements OnChanges, AfterViewInit, AfterViewChecked
{
  @Input() elab?: {
    id: number;
    descr: string;
    bloccato: boolean;
    elaborato: boolean;
  };

  loading = false;
  riepiloghi: any;
  linee: any;
  risorse: any;
  uos: any;

  isTabberHeightSet = false;

  constructor(private gs: GeneratoreCalendarioService) {}

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['elab']) {
      this.init();
    }
  }

  ngAfterViewInit(): void {
    //setting tabber height
    const viewContainer = document.querySelector<HTMLElement>(
      'a-tabber .view-container'
    );
    console.log('tabber: ', viewContainer);
    if (viewContainer) {
      fitHeight(viewContainer);
    }
  }

  ngAfterViewChecked(): void {
    if (!this.isTabberHeightSet) {
      //setting tabber height
      const tabber = document.querySelector<HTMLElement>('a-tabber');
      const viewContainer = document.querySelector<HTMLElement>(
        'a-tabber .view-container'
      );
      console.log('tabber: ', tabber, viewContainer);
      if (tabber && viewContainer) {
        tabber.style.height = 'calc(100% - 15px)';
        viewContainer.style.height = '90%';
        this.isTabberHeightSet = true;
      }
    }
  }

  init() {
    if (this.elab) {
      this.loading = true;
      this.riepiloghi = undefined;
      this.gs.getCalRiepiloghi(this.elab.id).subscribe((res) => {
        this.loading = false;
        if (res.esito) {
          this.riepiloghi = res.info;
          if (this.riepiloghi) {
            //rimappo campi con nomi corretti per l esportazione - fix issue #8692
            this.riepiloghi.linee.ui.colonne =
              this.riepiloghi.linee.ui.colonne.map((l: any) => {
                return {
                  field: l.field,
                  name: l.name,
                  type: l.type,
                  campo: l.field,
                  intestazione: l.name,
                  tipo: l.type,
                  editabile: l.editabile,
                };
              });
            this.riepiloghi.risorse.ui.colonne =
              this.riepiloghi.risorse.ui.colonne.map((l: any) => {
                return {
                  field: l.field,
                  name: l.name,
                  type: l.type,
                  campo: l.field,
                  intestazione: l.name,
                  tipo: l.type,
                  editabile: l.editabile,
                };
              });
            this.riepiloghi.uos.ui.colonne = this.riepiloghi.uos.ui.colonne.map(
              (l: any) => {
                return {
                  field: l.field,
                  name: l.name,
                  type: l.type,
                  campo: l.field,
                  intestazione: l.name,
                  tipo: l.type,
                  editabile: l.editabile,
                };
              }
            );
            this.linee = this.riepiloghi.linee;
            this.risorse = this.riepiloghi.risorse;
            this.uos = this.riepiloghi.uos;
          }
        }
      });
    }
  }
}
