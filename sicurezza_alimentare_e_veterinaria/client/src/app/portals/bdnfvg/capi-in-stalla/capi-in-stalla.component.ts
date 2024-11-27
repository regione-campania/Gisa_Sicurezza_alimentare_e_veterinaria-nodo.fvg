/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CapiInStallaService } from '../services/capiInStalla.service';
import { LoadingDialogService, ASmartTableComponent, NotificationService, Utils } from '@us/utils';
import { Location } from '@angular/common';
declare let require: any;
const JsBarcode = require('jsbarcode');

@Component({
  selector: 'app-capi-in-stalla',
  templateUrl: './capi-in-stalla.component.html',
  styleUrls: ['./capi-in-stalla.component.scss']
})
export class CapiInStallaComponent implements OnInit {

  @ViewChild(ASmartTableComponent) tabella?: ASmartTableComponent;
  private _capiInStalla?: any;
  private _ui?: any;
  private _fields: string[] = [];
  private _allevData?: any;
  private _info_all?: any;
  private _selectedCapi?: string[] = [];

  constructor(
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private ciss: CapiInStallaService,
    private _location: Location
  ) { }

  ngOnInit(): void {
    this.loadingService.openDialog('Caricamento Dati...');
    // Recupera dati tabella
    this.route.data.subscribe((data: any) => {
      console.log("data:", data);
      if (data.capiInStalla.esito == false) {
        this.loadingService.closeDialog();
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore nel caricamento dei dati.'
        });
        return;
      }
      if (data.capiInStalla.info === true) {
        this.loadingService.closeDialog();
        this.notificationService.push({
          notificationClass: 'warning',
          content: 'Non sono presenti dati.'
        });
        return;
      }

      this._capiInStalla = data.capiInStalla.info.dati;
      console.log("this._capiInStalla:", this._capiInStalla);

      this._ui = data.capiInStalla.info.ui;
      console.log("this._ui:", this._ui);

      this._fields = data.capiInStalla.info.ui.colonne.map((field: any) => {
        return field.campo;
      });
      console.log("this._fields:", this._fields);
      this.loadingService.closeDialog();
    });

    // Recupera dati per interrogazioni
    this.route.queryParams.subscribe((data: any) => {
      this._allevData = Object.assign({}, data);
      for (const [key, value] of Object.entries(this._allevData)) {
        if (typeof value == 'string') {
          this._allevData[key] = value.trim();
        }
      }
      console.log("_allevData:", this._allevData);

      this._info_all = {
        'Codice Azienda': data['account_number'],
        'Nome': data['name'],
        'Partita IVA': data['partita_iva'],
        'Descrizione Specie': data['descrizione_specie'],
        'Tipo Allevamento': data['tipo_allevamento'],
        'Numero Capi': data['n_capi']
      };
      console.log("this._info_all:", this._info_all);
    });
  }

  aggiornaStoricoStalla() {
    const multiWS: string[] = this._allevData['ws'].split(';');
    console.log("multiWS:", multiWS);

    // this.loadingService.openDialog('Caricamento Dati...');
    this.ciss.getWSBDNParams('get_ws_bdn_param').subscribe((res: any) => {
      console.log("res:", res);
      if (!res.esito) {
        this.loadingService.closeDialog();
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore caricamento parametri per richieste alla BDN.'
        });
        return;
      }

      // Prepara i parametri da inviare alla richiesta
      let entries = new Map();
      res.info.forEach((elem: any) => {
        entries.set(elem.nome, elem.valore);
      });

      entries.set('WS_BDN_URL', entries.get('WS_BDN_URL') + this._allevData['wsdl']);
      entries.set('WS_BDN_METHOD', 'getRegistriStalla_Ascii');
      entries.set('p_allev_id', this._allevData['id_allevamento_bdn']);
      entries.set('storico', true);
      entries.set('orderby_dtingresso', true);

      const params = Object.fromEntries(entries);
      console.log("params:", params);

      this.ciss.getSOAPRequest(params).subscribe((resSOAP: any) => {
        console.log("resSOAP:", resSOAP);
        let parser = new DOMParser();
        const xml = parser.parseFromString(resSOAP.getRegistriStalla_Ascii.getRegistriStalla_AsciiResult, 'text/xml');
        if (xml.getElementsByTagName('dati')[0].childNodes[0] == undefined) {
          this.loadingService.closeDialog();
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Il WS non ha restituito dati.'
          });
          return;
        }

        console.log("Aggiornamento avvenuto con successo!");

        let datiXML: string | null = xml.getElementsByTagName('dati')[0].childNodes[0].nodeValue;
        console.log("datiXML:", datiXML);

        // Converte stringa a base64
        if (datiXML) datiXML = btoa(datiXML);

        console.log("datiXML:", datiXML);

        this.ciss.updCapiInStalla('upd_capi_in_stalla_storico', { id_allevamento: parseInt(this._allevData['id_allevamento_bdn']), dati: datiXML }).subscribe((resUPD: any) => {
          console.log("resUPD:", resUPD);
          if (!resUPD.esito) {
            this.loadingService.closeDialog();
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Attenzione! Errore upload dati nel DB.'
            });
            return;
          }

          // Recupera dati da DB
          this.ciss.getCapiInStalla(`get_${multiWS[0]}`, {
            id_allevamento: parseInt(this._allevData['id_allevamento']),
            cod_gruppo_specie: this._allevData['cod_gruppo_specie']
          }).subscribe((resGET: any) => {
            console.log("resGET:", resGET);
            if (!resGET.esito) {
              this.loadingService.closeDialog();
              this.notificationService.push({
                notificationClass: 'error',
                content: 'Attenzione! Errore nel caricamento dei dati.'
              });
              return;
            }

            if (resGET.info.dati == null) {
              this.loadingService.closeDialog();
              this.notificationService.push({
                notificationClass: 'warning',
                content: 'Non sono presenti dati.'
              });
              return;
            }

            this._capiInStalla = resGET.info.dati;
            console.log("this._capiInStalla:", this._capiInStalla);

            this._ui = resGET.info.ui;
            console.log("this._ui:", this._ui);

            this._fields = resGET.info.ui.colonne.map((field: any) => {
              return field.campo;
            });
            console.log("this._fields:", this._fields);
            this.loadingService.closeDialog();
          })

        })
      });
    })
  }

  // Aggiornamento generico dei capi in stalla
  aggiornaGenerale(): void {
    // Dividi la stringa nel caso ci siano più richieste al WS
    const multiWS: string[] = this._allevData['ws'].split(';');
    console.log("multiWS:", multiWS);

    // Recupera dati (username e password) per interrogare la BDN
    this.ciss.getWSBDNParams('get_ws_bdn_param').subscribe((res: any) => {
      console.log("res:", res);
      if (!res.esito) { return }

      let entries = new Map();
      res.info.forEach((elem: any) => {
        entries.set(elem.nome, elem.valore);
      });

      // In base al tipo di WS crea un oggetto differente per i parametri
      entries.set('WS_BDN_URL', entries.get('WS_BDN_URL') + this._allevData['wsdl']);
      switch (multiWS[0]) {
        // Bovini, Bufalini, Caprini e Ovini
        case 'Capi_In_Stalla':
          entries.set('WS_BDN_METHOD', 'Capi_In_Stalla');
          entries.set('p_allev_id', parseInt(this._allevData['id_allevamento_bdn']));
          entries.set('p_ordinamento', '');
          break;

        // Equini
        case 'Elenco_Equi_RegistriStalla':
          entries.set('WS_BDN_METHOD', 'Elenco_Equi_RegistriStalla');
          entries.set('p_allev_id', parseInt(this._allevData['id_allevamento_bdn']));
          entries.set('p_tipo', '');
          entries.set('p_ordinamento', '');
          break;

        // Avicoli
        case 'getAllevamento_AVI':
          console.log("this._allevData:", this._allevData);
          entries.set('WS_BDN_METHOD', 'getAllevamento_AVI');
          entries.set('p_azienda_codice', this._allevData['account_number']);
          entries.set('p_prop_id_fiscale', this._allevData['cf_proprietario']);
          entries.set('p_det_id_fiscale', this._allevData['cf_detentore']);
          entries.set('p_spe_codice', this._allevData['specie_allev']);
          entries.set('p_tipo_prod ', this._allevData['tipologia_strutt']);
          entries.set('p_orientamento', this._allevData['orientamento_prod']);
          entries.set('p_tipo_allev', this._allevData['tipo_allev_cod']);

          /*
          entries.set('WS_BDN_URL', entries.get('WS_BDN_URL') + this._allevData['wsdl']);
          entries.set('WS_BDN_METHOD', 'getAllevamento_AVI');
          entries.set('p_azienda_codice', '004UD033');
          entries.set('p_prop_id_fiscale', '05474300281');
          entries.set('p_det_id_fiscale', 'BRTDNE63S14Z118N');
          entries.set('p_spe_codice', '0131');
          entries.set('p_tipo_prod ', 'AL');
          entries.set('p_orientamento', 'C');
          entries.set('p_tipo_allev', '8');
          */
          break;

        // Suini
        case 'FindRegistriStallaPartitaSuini':
          entries.set('WS_BDN_URL', entries.get('WS_BDN_URL') + this._allevData['wsdl']);
          entries.set('WS_BDN_METHOD', this._allevData['ws']);
          entries.set('p_spe_codice', this._allevData['specie_allev']);
          entries.set('p_azienda_codice', this._allevData['account_number']);
          entries.set('p_dt_ingresso', '');
          entries.set('p_dt_uscita', '');
          // Da sistemare in quanto l'id fiscaled dell'allevamento non è sempre
          // il codice fiscale del proprietario
          entries.set('p_allev_idfiscale', this._allevData['cf_proprietario']);
          break;
      }

      // Converte Map come args
      const params = Object.fromEntries(entries);
      console.log("params:", params);

      // Effettua Richiesta SOAP
      this.ciss.getSOAPRequest(params).subscribe((resSOAP: any) => {
        console.log("resSOAP:", resSOAP);

        let error_info: any;
        let dati: any[] = [];
        let firstArray: any[] = [];
        let secondArray: any[] = [];

        // Recupera i dati dalla richiesta SOAP
        switch (multiWS[0]) {
          case 'Capi_In_Stalla':
            error_info = resSOAP[this._allevData['ws']].Capi_In_StallaResult.root.error_info;
            dati = resSOAP[this._allevData['ws']].Capi_In_StallaResult.root.dati?.dsREGISTRO_STALLA.REGISTRO_DI_STALLA;
            break;
          case 'Elenco_Equi_RegistriStalla':
            error_info = resSOAP[this._allevData['ws']].Elenco_Equi_RegistriStallaResult.root.error_info;
            dati = resSOAP[this._allevData['ws']].Elenco_Equi_RegistriStallaResult.root.dati?.dsEQUI_REGISTRI_G.EQUI_REGISTRI_DI_STALLA;
            break;
          case 'getAllevamento_AVI':
            error_info = resSOAP[this._allevData['ws']].getAllevamento_AVIResult.root.error_info;
            dati = resSOAP[this._allevData['ws']].getAllevamento_AVIResult.root.dati?.dsAVI_GETALLEVAMENTI_A.AVI_GETALLEVAMENTO;
            break;
          case 'FindRegistriStallaPartitaSuini':
            error_info = resSOAP['FindRegistriStallaPartitaSuini'].FindRegistriStallaPartitaSuiniResult.root.error_info;
            error_info = resSOAP['FindRegistriUscitePartitaSuini'].FindRegistriUscitePartitaSuiniResult.root.error_info;
            firstArray = resSOAP['FindRegistriStallaPartitaSuini'].FindRegistriStallaPartitaSuiniResult.root.dati?.dsINGRESSI_SUI_A.SUI_INGRESSI;
            secondArray = resSOAP['FindRegistriUscitePartitaSuini'].FindRegistriUscitePartitaSuiniResult.root.dati?.dsUSCITE_SUI_A.SUI_USCITE;
            console.log("firstArray:", firstArray);
            console.log("secondArray:", secondArray);

            // Mapping dati di ingresso
            firstArray?.forEach((elem: any) => {
              let app = new Map();
              app.set('NUM_SUINI_INGR', elem['NUM_SUINI']);
              app.set('DESCR_MOTIVO_INGR_USC', elem['DESCR_MOTIVO_INGR']);
              app.set('DT_INGRESSO_USCITA', elem['DT_INGRESSO']);
              dati.push(Object.fromEntries(app));
            });

            // Mapping dati di uscita
            secondArray?.forEach((elem: any) => {
              let app = new Map();
              app.set('NUM_SUINI_USC', elem['NUM_SUINI']);
              app.set('DESCR_MOTIVO_INGR_USC', elem['DESCR_MOTIVO_USC']);
              app.set('DT_INGRESSO_USCITA', elem['DT_USCITA']);
              dati.push(Object.fromEntries(app));
            });
            break;
        }

        // Se i dati non sono sottoforma di array, convertili
        if (!Array.isArray(dati)) dati = [dati];

        if (!(error_info.error.id == null && error_info.error.des == null)) {
          console.log("error_info:", error_info);
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Attenzione! Errore richiesta WS.'
          });
          return;
        }

        if (dati == undefined || dati[0] == undefined) {
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Il WS non ha restituito dati.'
          });
          return;
        }

        this.notificationService.push({
          notificationClass: 'success',
          content: 'Aggiornamento avvenuto con successo!'
        });

        console.log("dati:", dati);

        // Carica i dati in DB
        this.ciss.updCapiInStalla(`upd_${multiWS[0]}`, { id_allevamento: parseInt(this._allevData['id_allevamento']), REGISTRO_DI_STALLA: dati }).subscribe((resUPD: any) => {
          console.log("resUPD:", resUPD);
          if (!resUPD.esito) { return; }

          // Recupera dati da DB
          this.ciss.getCapiInStalla(`get_${multiWS[0]}`, {
            id_allevamento: parseInt(this._allevData['id_allevamento']),
            cod_gruppo_specie: this._allevData['cod_gruppo_specie']
          }).subscribe((resGET: any) => {
            if (!resGET.esito) { return }
            this._capiInStalla = resGET.info.dati;
            console.log("this._capiInStalla:", this._capiInStalla);

            this._ui = resGET.info.ui;
            console.log("this._ui:", this._ui);

            this._fields = resGET.info.ui.colonne.map((field: any) => {
              return field.campo;
            });
            console.log("this._fields:", this._fields);
            this.loadingService.closeDialog();
          });
        });
      });
    });
  }

  aggiornaCapi(): void {

    console.log("---aggiorna capi---");

    this.loadingService.openDialog('Aggiornamento capi in corso');

    try{
      this.ciss.getSOAPRequest({p_allev_id: this._allevData['id_allevamento_bdn']}).subscribe((resSOAP: any) => {
        console.log("resSOAP:", resSOAP);
        this.loadingService.closeDialog();
        if(resSOAP.esito){
          this.notificationService.push({
            notificationClass: 'success',
            content: 'Aggiornamento effettuato con successo.'
          });
          window.location.reload();        
        }else{
          this.notificationService.push({
            notificationClass: 'error',
            content: resSOAP.info
          });
        }
      });
    }catch(err){
      console.log(err);
      this.loadingService.closeDialog();
    }


  }

  // Genera i codici a barre dei capi selezionati
  generateBarcodes() {
    this._selectedCapi = this.tabella?.selectedData.map((capo: any) => capo.marchio);
    console.log("this._selectedCapi:", this._selectedCapi);

    if (this.selectedCapi?.length == 0) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: 'Non hai selezionato elementi.'
      });
      return;
    }

    window.setTimeout(() => {
      // Crea i codici a barre
      this._selectedCapi?.forEach((marchio: string) => {
        JsBarcode('#barcode_' + marchio, marchio, {
          margin: 20,
          width: 4,
          height: 100
        });
      });

      // Seleziona il container con i codici e stampa
      const svgContainer = document.querySelector('#svg-container')?.innerHTML;
      let win = window.open('', '_blank', 'height=' + 720 + ', width=' + 1280);

      win?.document.write('<html><head>');
      win?.document.write('<title> barcodes.pdf </title>'); // <title> FOR PDF HEADER.
      win?.document.write('</head><body style="pointer-events: none;">');
      win?.document.write(svgContainer!); // THE TABLE CONTENTS INSIDE THE BODY TAG.
      win?.document.write('</body></html>');

      win?.document.close(); // CLOSE THE CURRENT WINDOW.

      win?.setInterval(function () { win?.focus(); }, 100);

      // Stampa il contenuto
      win?.addEventListener('load', function () {
        win?.print();
        win?.close();
      }, false)
    }, 1000);

    return;

    // Genera e poi effettua il download del PDF (Deprecata lato server)
    /*this.ciss.generatePDF({ selectedCapi: this._selectedCapi }).subscribe((res: any) => {
      console.log("res:", res);
      if (res.ok == true) {
        this.ciss.getPDF({ filename: 'Barcodes.pdf' }).subscribe((data: any) => {
          Utils.download(data.body, `${data.headers.get('content-disposition').split('filename="')[1].replaceAll('"', '')}`)
        });
      }
    });*/
  }

  // Effettua selezione di tutti i checkbox manualmente
  /*
  checkboxSelection(selection: boolean): void {
    this.tabella?.controls?.forEach((control: any) => {
      if (control._selector)
        selection ? control._selector.select() : control._selector.unselect();
    })
  }
  */

  printReport(): void {
    // Intestazione e filename PDF
    const filename: string = 'allevamento_' + this.p_iva + '.pdf';
    const title: any = { text: 'Capi in Stalla', dim: 25 };
    const other_text: any[] = [];

    other_text.push({ text: 'Allevamento: ' + this.p_iva, dim: 20 });

    const previous_data: any = {
      filename: filename,
      title: title,
      other_text: other_text
    };

    // Tabella PDF
    let headers: any[] = [];
    this._ui.colonne.forEach((c: any) => {
      headers.push({
        label: c.intestazione,
        property: c.campo,
        width: 512 / (this._ui.colonne.length + 1)
      });
    });

    console.log("headers:", headers);

    let selectedData: any[] = [];
    this._capiInStalla.forEach((cis: any) => {
      selectedData.push({
        id_capo: cis.id_capo ?? '',
        dt_nascita: cis.dt_nascita ?? '',
        marchio: cis.marchio ?? '',
        razza: cis.razza ?? ''
      });
    });

    console.log("selectedData:", selectedData);

    // Crea la tabella da stampare sul PDF
    const tablejson = {
      headers: headers,
      datas: selectedData,
      options: {
        width: 512
      }
    }

    console.log("tablejson:", tablejson);
    console.log("previous_data:", previous_data);

    this.ciss.reportPDF({ previous_data: previous_data, tablejson: JSON.stringify(tablejson) }).subscribe((res: any) => {
      console.log("res:", res);
      if (res.ok === true) {
        this.ciss.getPDF({ filename: filename }).subscribe((data: any) => {
          Utils.download(data.body, `${data.headers.get('content-disposition').split('filename="')[1].replaceAll('"', '')}`)
        });
      }
    });
  }

  goBack(): void { this._location.back(); }

  // Accessors
  get datiAllevamento() { return this._allevData; }
  get capiInStalla() { return this._capiInStalla; }
  get ui() { return this._ui; }
  get fields() { return this._fields; }
  get p_iva() { return this._allevData['partita_iva']; }
  get selectedCapi() { return this._selectedCapi; }
  get info_all() { return this._info_all; }

  get checkSpecie() {
    return ['BOVINI', 'OVINI', 'CAPRINI'].indexOf(this._allevData['descrizione_specie']) >= 0;
  }

  idMarchio(marchio: string) { return 'barcode_' + marchio; }
}
