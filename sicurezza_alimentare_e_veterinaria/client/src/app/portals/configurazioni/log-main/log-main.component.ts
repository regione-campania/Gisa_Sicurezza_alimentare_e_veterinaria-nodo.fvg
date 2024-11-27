/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { map } from 'rxjs';
import { SharedService } from 'src/app/shared/shared.service';
import { ConfigurazioniService } from '../configurazioni.service';
import { Router } from '@angular/router';
import { BackendCommunicationService } from '@us/utils';

@Component({
  selector: 'app-log-main',
  templateUrl: './log-main.component.html',
  styleUrls: ['./log-main.component.scss']
})
export class LogMainComponent {

  loadingOperazioni = false;
  formConfig: any;

  private _ui_operazioni: any = []
  private _operazioni: any
  private _operazione: any
  private _tipi_operazione: any

  constructor(
    private sharedService: SharedService,
    private cns: ConfigurazioniService,
    private b: BackendCommunicationService,
    private router: Router,
  ) { }


  ngOnInit() {
    this.cns.getTipiOperazioni().subscribe((res: any) => {
      if (res.info) {
        this._operazione = [{ "id_funzione": null, "id": "", "descr": "" }]
        this._operazione.push(...res.info.dati);

        this.formConfig = this.sharedService
          .getFormDefinition('cu/', 'sel_log_operazioni_old')
          .pipe(
            map((res) => {
              let info = JSON.parse(res.info[0]['configurazione']);
              let operazione = info['controls'].find((c: any) => c.name == 'id_tipo_operazione');
              //Costruzione del limite dinamicamente per la data inizio e fine
              let dataCorrente = new Date();
              let annoCorrente = dataCorrente.getFullYear();
              info['controls'].find((c: any) => c.name == 'periodo').options.start.max = annoCorrente + '-12-31';
              info['controls'].find((c: any) => c.name == 'periodo').options.end.max = annoCorrente + '-12-31';
              operazione.options =
                this._operazione
                  .map((obj: any) => { return { value: obj.id_funzione, innerText: obj.descr } })
              // let tipi_operazione = info['controls'].find((c: any) => c.name == 'tipo');
              //  tipi_operazione.options = this._operazione
              //    .map((obj: any) => { return { value: obj.tipo, innerText: obj.tipo } })
              return { info: info };
            })
          );

        this.cns.getOperazioniBySel({ 'limite': '1000' }).subscribe((res: any) => {
          this.loadingOperazioni = false;
          if (res.info) {
            this._ui_operazioni = res.info.ui;
            this._operazioni = res.info.dati;
          }
        })
      }
    })
  }


  ricercaOperazioni(params: any) {
    this.loadingOperazioni = true;
    this._ui_operazioni = null;
    this._operazioni = null;
    console.log(params);
    this.cns.getOperazioniBySel(params).subscribe((res: any) => {
      this.loadingOperazioni = false;
      if (res.info) {
        this._ui_operazioni = res.info.ui;
        this._operazioni = res.info.dati;
      }
    })
  }

  goToDettaglio(ar: any) {
    this.router.navigate(['portali/configurazioni/operazioni/dettaglio'], { queryParams: { id_transazione: ar.id_transazione, vista: ar.vista, identificativo: ar.identificativo, codice: ar.descr_oggetto } })
  }

  get operazioni() { return this._operazioni }
  get ui_operazioni() { return this._ui_operazioni }
}
