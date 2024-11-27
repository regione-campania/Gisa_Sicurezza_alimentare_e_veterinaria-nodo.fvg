/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, DoCheck, EventEmitter, Input, OnChanges, OnInit, Output, SimpleChanges, ViewChild } from '@angular/core';
import { CalendarioComponent } from '../calendario/calendario.component';
import Swal from 'sweetalert2';
import { GeneratoreCalendarioService } from '../generatore-calendario.service';
import { ASmartTableComponent } from '@us/utils';

@Component({
  selector: 'gen-riversa',
  templateUrl: './riversa.component.html',
  styleUrls: ['./riversa.component.scss']
})
export class RiversaComponent implements OnInit {
  @ViewChild('tabellaRiversa') tabellaRiversa?: ASmartTableComponent;
  @Input() elab?: { id: number, descr: string, bloccato: boolean, elaborato: boolean };
  @Input('calendario') calendarioComponent?: CalendarioComponent;

  @Output('onRiversa') riversaEvent = new EventEmitter<any>();

  attivitaRiversabili: any;

  constructor(
    private gs: GeneratoreCalendarioService
  ) { }

  ngOnInit(): void {
    this.calendarioComponent?.calendarioChangeEvent.subscribe(cal => {
      this.attivitaRiversabili = cal?.filter((att: any) => att.selezionabile && att.nominativo && att.giorno);
    })
  }

  /* ngDoCheck(): void {
    if (!this.attivitaRiversabili) {
      this.attivitaRiversabili = this.calendarioComponent?.calendario?.filter((att: any) => att.selezionabile && att.nominativo && att.giorno);
    }
  } */

  riversaCalendario() {
    Swal.fire({
      title: 'Riversare tutte le attività?',
      text: 'Questa operazione è irreversibile.',
      icon: 'warning',
      showConfirmButton: true,
      confirmButtonText: 'Riversa',
      showDenyButton: true,
      denyButtonText: 'Annulla'
    }).then(result => {
      if (result.isConfirmed) {
        this.gs
          .riversaCalendario(this.elab!.id)
          .subscribe(_ => this.riversaEvent.emit());
      }
    })
  }

  riversaSelezionati() {
    this.gs
      .riversaAttivitaCalendario(this.tabellaRiversa?.selectedData.map((el) => el['id']) ?? [])
      .subscribe(_ => this.riversaEvent.emit());
  }

  //computed
  get loading() {
    if (!this.calendarioComponent) return false;
    return this.calendarioComponent.loading
  }

}
