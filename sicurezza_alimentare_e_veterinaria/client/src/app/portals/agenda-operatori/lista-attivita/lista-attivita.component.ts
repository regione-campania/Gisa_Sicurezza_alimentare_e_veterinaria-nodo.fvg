/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  AfterViewChecked,
  ChangeDetectorRef,
  Component,
  OnInit,
  ViewChild,
} from '@angular/core';
import { ASmartTableComponent, LoadingDialogService } from '@us/utils';
import { AgendaOperatoriService } from '../agenda-operatori.service';
import { AppService } from 'src/app/app.service';
import Swal from 'sweetalert2';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'lista-attivita',
  templateUrl: './lista-attivita.component.html',
  styleUrls: ['./lista-attivita.component.scss'],
})
export class ListaAttivitaComponent implements OnInit, AfterViewChecked {
  @ViewChild('tabellaAttivita') tabellaAttivita?: ASmartTableComponent;

  infoAttivita: any;
  userInfo: any;

  constructor(
    private changeDetector: ChangeDetectorRef,
    private as: AgendaOperatoriService,
    private loading: LoadingDialogService,
    private userService: UserService
  ) {}

  ngOnInit(): void {
    //if (!(this.infoAttivita = this.as.storage.getItem('infoAttivita'))) {} cache momentaneamente sospesa
    this.initAttivita();
    this.userService.getUser().subscribe((res: any) => {
      if (res) {
        this.userInfo = res;
      }
    });
  }

  ngAfterViewChecked(): void {
    this.changeDetector.detectChanges();
  }

  initAttivita() {
    this.loading.openDialog();
    this.as.getEventiStruttura().subscribe((res) => {
      this.loading.closeDialog();
      if (res.esito) {
        this.infoAttivita = res.info;
        this.infoAttivita.dati.forEach((att: any) => {
          att.selectable = att.modificabile && att.selezionabile;
          return att;
        });
        //this.as.storage.setItem('infoAttivita', this.infoAttivita); cache momentaneamente sospesa
      }
    });
  }

  askBeforeElimina(attivita: any) {
    Swal.fire({
      icon: 'warning',
      title: 'Eliminare attività?',
      showConfirmButton: true,
      confirmButtonText: 'Conferma',
      showDenyButton: true,
      denyButtonText: 'Annulla',
    }).then((res) => {
      if (res.isConfirmed) this.eliminaAttivita(attivita);
    });
  }

  eliminaAttivita(attivita: any) {
    this.as.updEvElimina([attivita.id]).subscribe((_) => this.initAttivita());
  }

  isModificaEnabled(): boolean {
    if (!this.userInfo || !this.tabellaAttivita) return false;
    return this.tabellaAttivita.hasSelectedData;
  }

  //accessors
  get attivitaSelezionate() {
    return this.tabellaAttivita!.selectedData?.map((x) => x['id']);
  }
}
