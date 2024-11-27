/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Input, OnChanges, SimpleChanges, ViewChild } from '@angular/core';
import { GeneratoreCalendarioService } from '../generatore-calendario.service';
import { ATreeComponent } from '@us/utils';
import { throwError } from 'rxjs';

@Component({
  selector: 'gen-strutture',
  templateUrl: './strutture.component.html',
  styleUrls: ['./strutture.component.scss']
})
export class StruttureComponent implements OnChanges {
  @ViewChild('aslTree') aslTree!: ATreeComponent;
  @ViewChild('pianiTree') pianiTree!: ATreeComponent;
  @Input() elab?: { id: number, descr: string, bloccato: boolean, elaborato: boolean };

  loading = false;
  asl: any[] = [];
  piani: any[] = [];

  mappaturaAlberi = ((node: any) => {
    node.selectable = true;
    node.readonly = this.elab?.bloccato || this.elab?.elaborato;
    return node;
  }).bind(this);

  constructor(
    private gs: GeneratoreCalendarioService
  ) { }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['elab']) {
      this.init();
    }
  }

  init() {
    if (this.elab) {
      this.loading = true;
      this.asl = [];
      this.piani = [];
      this.gs
        .getElabNsPiani(this.elab!.id)
        .subscribe((res) => {
          this.loading = false;
          if (!res.esito) return;
          this.asl = res.info.ns;
          this.piani = res.info.piani;
        });
    }
  }

  updStrutture() {
    if (this.elab) {
      return this.gs.updElabNsPiani(
        this.elab.id,
        this.aslSelezionate.map((x) => x.data?.id).filter(id => id != null && id != undefined),
        this.pianiSelezionati.map((x) => x.data?.id).filter(id => id != null && id != undefined)
      )
    } else {
      return throwError(() => new Error('Nessun elaborazione presente.'));
    }
  }

  //computed
  public get aslSelezionate() {
    return this.aslTree?.leafNodes?.filter((node) => node.selected) ?? [];
  }

  public get pianiSelezionati() {
    return this.pianiTree?.leafNodes?.filter((node) => node.selected) ?? [];
  }
}
