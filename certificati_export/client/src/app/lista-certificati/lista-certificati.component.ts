/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { CertificatiService } from '../certificati/certificati.service';
import { UserService } from '../user/user.service';
import { LoadingDialogService } from '@us/utils';

declare let Swal: any;

@Component({
  selector: 'app-lista-certificati',
  templateUrl: './lista-certificati.component.html',
  styleUrls: ['./lista-certificati.component.scss']
})
export class ListaCertificatiComponent implements OnInit {

  private _listaCertificati: any[] = [];
  private _ui?: any = {
    "colonne": [
      {
        "campo": "num_certificato",
        "intestazione": "#",
        "tipo": "number",
        "editabile": false
      },
      {
        "campo": "descr_certificato",
        "intestazione": "Descrizione",
        "tipo": "text",
        "editabile": false
      },
      {
        "campo": "descr_certificato_compilato",
        "intestazione": "Denominazione",
        "tipo": "text",
        "editabile": false
      },
      {
        "campo": "descr_stato_certificato_compilato",
        "intestazione": "Stato",
        "tipo": "selection",
        "editabile": false
      },
      {
        "campo": "entered",
        "intestazione": "Data Inserimento",
        "tipo": "date",
        "editabile": false
      },
      {
        "campo": "data_proposta",
        "intestazione": "Data Proposta",
        "tipo": "date",
        "editabile": false
      },
      {
        "campo": "data_controllo",
        "intestazione": "Data Controllo",
        "tipo": "date",
        "editabile": false
      }
    ]
  };
  private _fields: string[] = [];
  private _userPermissions?: any;
  private _canCreate?: boolean;
  tipiStato: string[] = ['Rilasciato', 'Da Approvare'];
  @Output() getUserData = new EventEmitter<String>();

  constructor(
    private cs: CertificatiService,
    private us: UserService,
    private ls: LoadingDialogService
    ) { }

  ngOnInit(): void {

    if (localStorage.getItem('token')) {
      this.us.getUser().subscribe((res: any) => {
        console.log("res:", res);
        this.getUserData.emit(JSON.stringify(res));
        this._userPermissions = [];
        res.permission?.forEach((el: any) => {
          this._userPermissions.push(el.descr_permission);
        });
        console.log("this._userPermissions:", this._userPermissions);

        this._userPermissions.includes('CAN_CREATE_CERTIFICATE') ? this._canCreate = true : this._canCreate = false;
        if(!this._canCreate){
          this._ui.colonne[2].campo = 'ragione_sociale';
          this._ui.colonne[2].intestazione = 'Stabilimento';
        }
        });
    }

    this.ls.openDialog('Caricamento lista certificati');
    this.cs.getListaCertificati().subscribe((data: any) => {
      this.ls.closeDialog();
      console.log("data:", data);
      this._listaCertificati = data;
      this._fields = this._ui.colonne.map((field: any) => {
        return field.campo;
      });

      
    })
  }

  duplicaCertificato(idCertificato: any): void {
    this.cs.duplicaCertificato('duplica_certificato', {
      id_certificato: idCertificato
    }).subscribe((res: any) => {
      console.log("res:", res);
      this.ngOnInit();
    });
  }

  public get listaCertificati() {
    return this._listaCertificati;
  }

  public get fields() {
    return this._fields;
  }

  public get ui() {
    return this._ui;
  }

  public get userPermissions() {
    return this._userPermissions;
  }

  public get canCreate() {
    return this._canCreate;
  }
}
