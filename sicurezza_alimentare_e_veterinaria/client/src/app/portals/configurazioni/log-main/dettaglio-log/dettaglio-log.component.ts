/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ConfigurazioniService } from '../../configurazioni.service';
import { ATreeComponent, LoadingDialogService } from '@us/utils';

@Component({
  selector: 'app-dettaglio-log',
  templateUrl: './dettaglio-log.component.html',
  styleUrls: ['./dettaglio-log.component.scss']
})
export class DettaglioLogComponent {

  @ViewChild('riepilogo_tree') riepilogo_tree?: ATreeComponent;

  codice: any
  private _ui: any = []
  private _operazioni: any
  private _uiOperazione: any = []
  private _operazione: any
  private _id_transazione: any;
  _vista: any;
  mostraAlbero: boolean = false;
  private _identificativo: any;

  _riepilogo: any

  mappaturaAlberi = ((node: any) => {
    //node.selectable = true
    //node.disabled = true
    node.expanded = false
    return node
  })

  constructor(
    private cns: ConfigurazioniService,
    private route: ActivatedRoute,
    private LoadingService: LoadingDialogService
  ) { }

  ngOnInit() {
    this.LoadingService.openDialog()
    this.route.queryParams.subscribe((res: any) => {
      this._id_transazione = +res['id_transazione'];
      this._vista = res['vista'];
      this._identificativo = res['identificativo'];
      if (res['codice']) {
        this.codice = res['codice']
      }
      if(this._vista.includes('vw_cu')) {
        console.log("trovato");
        this.mostraAlbero = true;
      }

      this.cns.getOperazioneSingolo(this._id_transazione).subscribe((res: any) => {
        this._uiOperazione = res.info.ui;
        this._operazione = res.info.dati[0];

        if (this.codice && this.mostraAlbero) {
          this.cns.getRiepilogoCU({ id_transazione: this._id_transazione }).subscribe((res: any) => {
            if (res.info) {
              this._riepilogo = res.info.dati
              this.LoadingService.closeDialog()
            }
          })
        } else {
          this.cns.getDettaglioOperazioni(this._id_transazione, this._vista, this._identificativo).subscribe((res: any) => {
            this._ui = res.info.ui;
            this._operazioni = res.info.dati;
            this.LoadingService.closeDialog()
          })
        }
      })
    })
  }

  get ui() { return this._ui; }
  get operazioni() { return this._operazioni; }
  get uiOperazione() { return this._uiOperazione; }
  get operazione() { return this._operazione; }
}