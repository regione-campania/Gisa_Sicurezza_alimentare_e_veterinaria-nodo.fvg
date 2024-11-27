/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NotificationService, LoadingDialogService, Utils } from '@us/utils';
import { Location } from '@angular/common';
import { AllevamentiService } from '../services';

@Component({
  selector: 'app-allevamenti',
  templateUrl: './allevamenti.component.html',
  styleUrls: ['./allevamenti.component.scss']
})
export class AllevamentiComponent implements OnInit {
  private _allevamenti?: any;
  private _ui?: any;
  private _accountNumber?: any;

  constructor(
    private as: AllevamentiService,
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private _location: Location,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.route.data.subscribe((data: any) => {
      this.loadingService.closeDialog();
      console.log("data:", data);
      if (!data.allevamenti.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore nel caricamento dei dati.'
        });
        return;
      }

      if (data.allevamenti.info === true) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Allevamenti non presenti.'
        });
        return;
      }

      this._allevamenti = data.allevamenti.info.dati;
      console.log("this._allevamenti:", this._allevamenti);

      this._ui = data.allevamenti.info.ui;
      console.log("this._ui:", this._ui);

      this.route.queryParams.subscribe((res: any) => {
        console.log("res:", res);
        if (!res) return;

        if (res['fromRiepilogo'] == false) {
          this._accountNumber = data.allevamenti.info.dati[0].account_number;
          console.log("this._accountNumber:", this._accountNumber);
        }
      });
    });
  }

  // Scegli la route successiva in base al gruppo specie
  goCapi(all: any) {
    if (all['id_gruppo_specie'] == 7) {
      this.router.navigate(
        ['capannoni'],
        {relativeTo: this.route, queryParams: all }
      );
    } else {
      this.router.navigate(
        ['capiinstalla'],
        { relativeTo: this.route, queryParams: all }
      );
    }
  }

  printReport(): void {
    // Altre informazioni del PDF
    const filename: string = 'allevamenti_azienda_' + this._accountNumber + '.pdf';
    const title: any = { text: 'Allevamenti Azienda ' + this._accountNumber, dim: 25 };
    const other_text: any[] = [];

    // Compone il pacchetto dati da stampare prima della tabella
    const previous_data: any = {
      filename: filename,
      title: title,
      other_text: other_text
    };

    // Crea l'header della tabella
    let headers: any[] = [];
    this._ui.colonne.forEach((c: any) => {
      headers.push({
        label: c.intestazione,
        property: c.campo,
        width: 512 / (this._ui.colonne.length + 1)
      });
    });

    // Crea il body della tabella
    let selectedData: any[] = [];
    this._allevamenti.forEach((a: any) => {
      selectedData.push({
        name: a.name ?? '',
        partita_iva: a.partita_iva ?? '',
        tipo_allevamento: a.tipo_allevamento ?? '',
        descrizione_specie: a.descrizione_specie ?? '',
        descrizione_tipo_produzione: a.descrizione_tipo_produzione ?? '',
        tipologia_strutt: a.tipologia_strutt ?? ''
      });
    });

    // Crea la tabella da stampare sul PDF
    const tablejson = {
      headers: headers,
      datas: selectedData,
      options: {
        width: 512
      }
    }

    console.log("tablejson:", tablejson);
    console.log("JSON.stringify(tablejson):", JSON.stringify(tablejson));
    console.log("previous_data:", previous_data);

    this.as.makePDF({ previous_data: previous_data, tablejson: JSON.stringify(tablejson) }).subscribe((res: any) => {
      console.log("res:", res);
      if (res.ok === true) {
        this.as.getPDF({ filename: filename }).subscribe((data: any) => {
          Utils.download(data.body, `${data.headers.get('content-disposition').split('filename="')[1].replaceAll('"', '')}`);
        });
      }
    });
  }

  goBack(): void { this._location.back(); }

  get allevamenti() { return this._allevamenti; }
  get ui() { return this._ui; }
  get accountNumber() { return this._accountNumber; }
}
