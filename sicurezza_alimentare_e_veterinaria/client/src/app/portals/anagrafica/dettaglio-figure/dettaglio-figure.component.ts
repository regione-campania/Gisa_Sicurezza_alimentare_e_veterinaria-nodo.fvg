/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-dettaglio-figure',
  templateUrl: './dettaglio-figure.component.html',
  styleUrls: ['./dettaglio-figure.component.scss']
})
export class DettaglioFigureComponent {
  private _id_soggetto_fisico: any;
  private _ui: any;
  private _retDati: any;
  private _nomeSogg: any;
  private _cognomeSogg: any;
  private _cfSogg: any;
  private _indirizzoSogg: any;
  private _comuneSogg: any;

  constructor(private ComunicazioneDB: BackendCommunicationService,
    private LoadingService: LoadingDialogService,
    private route : ActivatedRoute,
    private notificationService: NotificationService,
    private router: Router,){
      
    }
  ngOnInit(): void {
    this.route.queryParams.subscribe((res : any) =>{
      console.log("dati: ", res['id_soggetto_fisico']);
      this._id_soggetto_fisico = res['id_soggetto_fisico'];
      this._nomeSogg = res['nome'];
      this._cognomeSogg = res['cognome'];
      this._cfSogg = res['codice_fiscale'];
      this._indirizzoSogg = res['indirizzo_completo'];
      this._comuneSogg = res['comune'];
    })
    this.ComunicazioneDB.getDati('get_cu_stabilimenti_figure_by_f',{id_soggetto_fisico : parseInt(this._id_soggetto_fisico)}).subscribe((res : any) =>{
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      console.log("dati sedi", res);
      this._ui = res.info.ui;
      this._retDati = res.info.dati;
    })
  }
    get ui() {return this._ui};
    get retDati() {return this._retDati};
    get nomeSogg() {return this._nomeSogg};
    get cognomeSogg() {return this._cognomeSogg};
    get cfSogg() {return this._cfSogg};
    get indirizzoSogg() {return this._indirizzoSogg};
    get comuneSogg() {return this._comuneSogg}
}
