/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { MovimentazioniCapoService } from '../services/movimentazioniCapo.service';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { Location } from '@angular/common';

@Component({
  selector: 'app-movimentazioni-capo',
  templateUrl: './movimentazioni-capo.component.html',
  styleUrls: ['./movimentazioni-capo.component.scss']
})
export class MovimentazioniCapoComponent implements OnInit {

  private _movimentazioniCapo?: any;
  private _ui?: any;
  private _marchio?: any;
  private _idCapo?: any;
  private _id_azienda?: any;
  public ws_movimentazioni: any;

  constructor(
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private client: MovimentazioniCapoService,
    private _location: Location
  ) { }

  ngOnInit(): void {
    this.route.data.subscribe((data: any) => {
      this.loadingService.closeDialog();
      console.log("data:", data);
      if (data.movimentazioniCapo.esito == false) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore nel caricamento dei dati.'
        });
        return;
      }

      if (data.movimentazioniCapo.info == true) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: 'Non sono presenti dati.'
        });
        return;
      }

      this._movimentazioniCapo = data.movimentazioniCapo.info.dati;
      console.log("this._movimentazioniCapo:", this._movimentazioniCapo);

      this._ui = data.movimentazioniCapo.info.ui;
      console.log("this._ui:", this._ui);

      this._id_azienda = data.movimentazioniCapo.info.dati[0].id_azienda;
      this.ws_movimentazioni = data.movimentazioniCapo.info.dati[0].ws_movimentazioni;
      console.log("this._id_azienda:", this._id_azienda);
    })

    this.route.queryParams.subscribe((data: any) => {
      this._marchio = data['marchio'];
      console.log("this._marchio:", this._marchio);
      this._idCapo = parseInt(data['idCapo']);
      console.log("this._idCapo:", this._idCapo);
    });
  }

  aggiornaMovimentazioniCapo() {
   // this.loadingService.openDialog('Caricamento dati...');
    // Prende i parametri per interrogare la BDN
      // Costruisce parametri per WSDL
      let entries = new Map();
      
     if(!this.ws_movimentazioni){
      this.notificationService.push({
        notificationClass: 'error',
        content: 'Attenzione! Servizio di movimentazioni non presente in BDN per il gruppo specie corrente'
      })
     }
      entries.set('WS_BDN_METHOD', this.ws_movimentazioni);
      entries.set('p_capo_codice', this._marchio);
      // entries.set('p_capo_codice', 'IT030990320533');

      const params = Object.fromEntries(entries);
      console.log("params:", params);

      // Effettua la richiesta SOAP alla BDN
      this.client.getSOAPRequest(params).subscribe((resSOAP: any) => {
        console.log("resSOAP:", resSOAP);
        this.loadingService.closeDialog();
        if(resSOAP.esito === false){
          this.notificationService.push({
            notificationClass: 'error',
            content: resSOAP.info
          });
          return;
        }
        if (!(resSOAP[`${this.ws_movimentazioni}Result`].root.error_info.error.id == null && resSOAP[`${this.ws_movimentazioni}Result`].root.error_info.error.des == null)) {
          
        }

        let capi;
        if (resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsCAPI_G) {
          capi = resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsCAPI_G.CAPI_BOVINI;
        }
        if (resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsOVI_CAPI_G) {
          capi = resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsOVI_CAPI_G.CAPI_OVINI;
        }
        if (resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsEQUI_CAPI_G) {
          capi = resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsEQUI_CAPI_G.CAPI_OVINI;
        }

        let macellazioni;
        if (resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsMACELLAZIONI_G) {
          macellazioni = resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsMACELLAZIONI_G.MACELLAZIONE;
        }

        let movimentazioni;
        if (resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsMOVIMENTAZIONI_G) {
          movimentazioni = resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsMOVIMENTAZIONI_G.MOVIMENTAZIONI;
        }

        if (resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsOVI_MOVIMENTAZIONI_G) {
          movimentazioni = resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsOVI_MOVIMENTAZIONI_G.MOVIMENTAZIONI;
        }

        if (resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsEQUI_MOVIMENTAZIONI_G) {
          movimentazioni = resSOAP[`${this.ws_movimentazioni}Result`].root.dati.dsEQUI_MOVIMENTAZIONI_G.MOVIMENTAZIONI;
        }

        console.log("capi:", capi);
        console.log("macellazioni:", macellazioni);
        console.log("movimentazioni:", movimentazioni);

        if (!Array.isArray(movimentazioni)) { movimentazioni = [movimentazioni]; }

        console.log("movimentazioni:", movimentazioni);

        // Aggiorna DB interno
        this.client.updMovimentazioniCapo('upd_movimentazioni_capo', {
          id_capo: this._idCapo,
          CAPI_BOVINI: capi,
          MACELLAZIONI: macellazioni,
          MOVIMENTAZIONI: movimentazioni
        }).subscribe((resUPD: any) => {
          console.log("resUPD:", resUPD);
          if (!resUPD.esito) {
            this.loadingService.closeDialog();
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Attenzione! Errore upload dati DB.'
            });
            return;
          }
          this.client.getMovimentazioniCapo('get_movimentazioni_capo', { id_capo: this._idCapo }).subscribe((dataGET: any) => {
            console.log("dataGET:", dataGET);
            if (!dataGET.esito) {
              this.loadingService.closeDialog();
              this.notificationService.push({
                notificationClass: 'error',
                content: 'Attenzione! Errore nel caricamento dei dati.'
              });
              return;
            }

            if (dataGET.info.dati == null) {
              this.loadingService.closeDialog();
              this.notificationService.push({
                notificationClass: 'warning',
                content: 'Non sono presenti dati.'
              });
              return;
            }

            this._movimentazioniCapo = dataGET.info.dati;
            console.log("this._movimentazioniCapo:", this._movimentazioniCapo);

            this._ui = dataGET.info.ui;
            console.log("this._ui:", this._ui);
            this.loadingService.closeDialog();
          })
        });
      })
    // })
  }

  goBack(): void { this._location.back(); }

  get movimentazioniCapo() { return this._movimentazioniCapo; }
  get ui() { return this._ui; }
  get idCapo() { return this._idCapo; }
  get id_azienda() { return this._id_azienda; }
}
