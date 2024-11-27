/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ElementRef, OnInit, SimpleChanges, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { jsPDF } from 'jspdf';
import * as htmlToImage from 'html-to-image';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';
import { Location } from '@angular/common';
import { GestioneAttivitaService } from 'src/app/portals/gestione-attivita/gestione-attivita.service';

@Component({
  selector: 'app-scontrino',
  templateUrl: './scontrino.component.html',
  styleUrls: ['./scontrino.component.scss'],
})
export class ScontrinoComponent implements OnInit {
  idTrf?: any;
  trfattivita?: any;
  trfTipo: any;
  trfFunzione: any
  dettagli?: any;
  editMode = false;
  disableCloseTariffa: boolean = true;
  disableModifica: boolean = true;

  private _idFattura?: any;
  private closed: any;
  private _isFatturabile?: boolean;
  private dontshowViewSezioni?: boolean = true;
  @ViewChild('scontrino', { static: false }) public dataToExport: ElementRef | undefined;

  constructor(
    private client: BackendCommunicationService,
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private location: Location,
    private loadingService: LoadingDialogService,
    private _as: GestioneAttivitaService
  ) { }

  ngOnChanges(changes: SimpleChanges) {
    console.log("changes:", changes);
    console.log("", changes['editMode'].currentValue);
  }

  ngOnInit(): void {
    this.loadingService.openDialog();
    this.route.queryParams.subscribe(params => {
      console.log("params:", params);
      this.idTrf = parseInt(params['id']);
      this.trfTipo = params['tipo'];
      this.trfFunzione = params['funzione'];
      // console.log("typeof params['isClosed']:", typeof params['isClosed']);
      // this.closed = params['isClosed'];
      //Gestione del tasto del modifica (matita)
      // if (this.closed == "Aperta") this.disableModifica = true;
      // else if (this.closed == "Chiusa") this.disableModifica = false;
      // console.log("this.closed:", this.getClosed);
      this.client.getDati('get_' + this.trfFunzione, { [this.trfTipo]: this.idTrf }).subscribe((res) => {
        this.loadingService.closeDialog();
        console.log("res:", res);

        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Attenzione! Nessun risultato'
          });
          return;
        }
        this.dettagli = res.info.dettagli;
        this.trfattivita = res.info.trfattivita;
        this._isFatturabile = res.info.fatturabile;
        console.log("this._isFatturabile:", this._isFatturabile);
        // console.log("this.dettagli:", this.dettagli);
        // console.log("this.trfattivita:", this.trfattivita);
        this.sortDettagli(this.dettagli.dati.sezioni);

        this.dettagli.dati.ui_info = JSON.parse(this.dettagli.dati.ui_info);

        this.closed = this.trfattivita.closed;
        this.disableModifica = this.closed ? false : true;

        // console.log("this.dettagli.dati.ui_info:", this.dettagli.dati.ui_info);

        // console.log("this.dettagli.dati.sezioni", this.dettagli.dati.sezioni);
        if (!this.dettagli.dati.sezioni || this.dettagli.dati.sezioni?.length == 0)
          this.dontshowViewSezioni = false;
        /*if (this.dettagli.dati.ui_info == null) {
          this.dontshowViewSezioni = false;
          this.dettagli.dati.ui_info = {
            colonne: [
              {
                "campo": "descrizione",
                "intestazione": "Descrizione",
                "tipo": "text",
                "editabile": false
              },
              {
                "campo": "valore",
                "intestazione": "Valore",
                "tipo": "text",
                "editabile": true
              }
            ]
          }
        }*/

        if (this._isFatturabile && !this.closed) this.disableCloseTariffa = false;

        //waits Angular rendering
        setTimeout(this.parseScontrino, 0);
      });
    })

  }

  changeMode() {
    // Controlla prima eventuali errori
    let inputModificabili = Array.from(document.querySelectorAll('.input-modificabile') as NodeListOf<HTMLInputElement>);

    // Ciclo Trova errori
    if (this.editMode) {
      for (const input of inputModificabili) {
        console.log("verifica input value ", input.value, "min", input.getAttribute('min'), "max", input.getAttribute('max'))
        if (input.getAttribute('formato-input') != 'time') {
          if (isNaN(this.parseCell(input.value, input.getAttribute('formato-input')!))) {
            this.notificationService.push({
              notificationClass: 'error',
              content: `Il valore '${input.value}' non è corretto per tipo ${input.getAttribute('formato-input')!}`
            });
            return;
          } else if (input.getAttribute('min') && (this.parseCell(input.value, input.getAttribute('formato-input')!) < parseInt(input.getAttribute('min')!))) {
            this.notificationService.push({
              notificationClass: 'error',
              content: `Il valore '${input.value}' è inferiore al minimo consentito  ${input.getAttribute('min')!}`
            });
            return;
          } else if (input.getAttribute('max') && (this.parseCell(input.value, input.getAttribute('formato-input')!) > parseInt(input.getAttribute('max')!))) {
            this.notificationService.push({
              notificationClass: 'error',
              content: `Il valore '${input.value}' è superiore al massimo consentito  ${input.getAttribute('max')!}`
            });
            return;
          }
        }
      }
    }

    // Se non ci sono errori effettua normalmente il parse
    this.editMode = !this.editMode;
    let tariffeDaSalvare = [];

    for (const input of inputModificabili) {
      input.readOnly = !this.editMode;
      if (!input.readOnly) {
        console.log("replace", input.value)
        //input.value = input.value.split('.').join('').replace(',', '.');
        input.classList.remove("read-only-input");
        // input.type = 'text';
      }
      else {
        let valueToSave = null;
        input.classList.add("read-only-input");
        if (input.getAttribute('formato-input')! != 'time') {
          valueToSave = this.parseCell(input.value, input.getAttribute('formato-input')!) //salvo valore senza punti delle migliaia
          input.value = this.parseCell(input.value, input.getAttribute('formato-input')!); //visualizzo valori con le migliaia
          // input.type = 'text';
        } else {//formatto tempo in minuti
          valueToSave = parseFloat(input.value.split(':')[0]) * 60 + (parseFloat(input.value.split(':')[1]))
        }
        if (input.value && input.value.trim().length > 0)
          tariffeDaSalvare.push({ id_tariffa: input.getAttribute('id-tariffa'), valore: valueToSave })
      }
    }

    // Salvo
    console.log('---tariffeDaSalvare---', tariffeDaSalvare);
    if (!this.editMode) {
      this.client.updDati('upd_' + this.trfFunzione, { [this.trfTipo]: this.idTrf, valori: tariffeDaSalvare }).subscribe((res) => {
        console.log(res);
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: `${res.msg}`
          });
        } else {
          this.notificationService.push({
            notificationClass: 'success',
            content: `${res.msg || 'Salvataggio riuscito'}`
          });
          this.disableCloseTariffa = false;
        }
      })
    }
  }

  jsonParse(json: string) {
    // console.log("json:", json);
    let res = JSON.parse(json);
    //console.log(res);
    return res;
  }

  // Parse input utente
  parseCell(val: any, format: string, flagAddPointToThousands?: boolean) {
    //console.log(val, format);
    //val = val *1000000;
    if (val == null || val == '') return val;
    val = val.toString().replace(',', '.');
    switch (format) {
      case 'int':
        return flagAddPointToThousands ? this.addPointToThousands(parseInt(val)) : parseInt(val);
      case 'float':
        return flagAddPointToThousands ? this.addPointToThousands(parseFloat(val)) : parseFloat(val);
      case 'currency3':
        return flagAddPointToThousands ? this.addPointToThousands(parseFloat(val).toFixed(3).toString().replace('.', ',')) : parseInt(val);
      case 'currency2':
        return flagAddPointToThousands ? this.addPointToThousands(parseFloat(val).toFixed(2).toString().replace('.', ',')) : parseInt(val);
      case 'time':
        return parseInt((parseInt(val) / 60).toString()).toString().padStart(2, '0') + ':' + (val - parseInt((parseInt(val) / 60).toString()) * 60).toString().padStart(2, '0');
      default:
        return val.replace('.', ',');  //flagAddPointToThousands ? this.addPointToThousands(val) : parseInt(val);
    }
  }

  addPointToThousands(val: string | number) {
    if (typeof val != 'string')
      val = val.toString();
    //console.log("this.addPointToThousands", val);
    let splitted = val.split(','); //separo parte intera e decimale
    for (let i = splitted[0].length - 3; i > 0; i = i - 3) { //aggiungo punto per le migliaia
      splitted[0] = [splitted[0].slice(0, i), '.', splitted[0].slice(i)].join('');
    }
    if (splitted[1])
      return [splitted[0], splitted[1]].join(',');
    else
      return splitted[0];
  }

  sortDettagli(currSezione: any) {
    /*console.log('---sort sezione---');
    console.log(currSezione);*/
    //currSezione.sort((a: any, b: any) => (a.id_node > b.id_node) ? 1 : ((b.id_node > a.id_node) ? -1 : 0))
    currSezione.sort((a: any, b: any) => (a.path_ord > b.path_ord) ? 1 : ((b.path_ord > a.path_ord) ? -1 : 0))
    currSezione.forEach((sez: any) => {
      if (sez.sezioni && sez.sezioni.length > 0)
        this.sortDettagli(sez.sezioni)
    });
  }

  parseScontrino(): void {
    document.querySelectorAll('table')?.forEach((table) => {
      let indicesOfNumericColumns = new Set<number>();
      let indicesOfDecimalColumns = new Set<number>();
      let tableCells = Array.from(table.querySelectorAll('th, td') as NodeListOf<HTMLTableCellElement>);
      for (const cell of tableCells) {
        if (cell.tagName === 'TH') continue; //skips th
        const value = +cell.innerText;
        if (Number.isFinite(value)) {
          indicesOfNumericColumns.add(cell.cellIndex);
          if (!Number.isInteger(value)) {
            if (indicesOfDecimalColumns.has(cell.cellIndex))
              break;
            indicesOfDecimalColumns.add(cell.cellIndex);
          }
        }
      }
      for (const cell of tableCells) {
        if (indicesOfNumericColumns.has(cell.cellIndex)) {
          cell.classList.add('text-end');
          if (cell.tagName === 'TD' && indicesOfDecimalColumns.has(cell.cellIndex))
            cell.innerText = (+cell.innerText as number).toFixed(3);
        }
      }
    });
  }

  printScontrino(): void {
    console.log("this.dataToExport:", this.dataToExport);
    const margin = { x: 300, y: 100 };
    var width = this.dataToExport!.nativeElement.clientWidth + margin.x;
    var height = this.dataToExport!.nativeElement.clientHeight + margin.y;
    //fix stampa pdf con campi tempo non visibili
    let timeInputes = document.querySelectorAll('input[type="time"]');
    timeInputes?.forEach((t: any) => {
      t.type = 'text';
    })
    this.loadingService.openDialog('Generazione pdf in corso');
    htmlToImage.toJpeg(this.dataToExport!.nativeElement, {
      width: width,
      height: height,
      quality: 1,
      backgroundColor: 'white'
    })
      .then((result: any) => {
        console.log(result);
        const pdf = new jsPDF({
          orientation: height > width ? "p" : "l",
          unit: "px",
          format: [width, height],
        });
        pdf.addImage(result, 'JPEG', margin.x / 2, 0, width, height, undefined, "NONE");
        console.log(pdf);
        console.log("pdf.output()", pdf.output());
        let bytes = btoa(pdf.output());
        console.log("bytes:", bytes);
        let filename = 'file_name' + '.pdf';
        this.client.updDati('upd_scontrino_pdf', { bytearray: bytes, filename: filename, id_fattura: this.idTrf }).subscribe((res: any) => {
          console.log(res);
        })
        pdf.save(filename);
      })
      .catch((error: any) => {
        console.error(error);
      })
      .finally(() => {
        timeInputes?.forEach((t: any) => {
          t.type = 'time';
        })
        this.loadingService.closeDialog();
      });
  }

  printXML(): void {
    this.client.getDati('get_scontrino_xml', { id_fattura: this.idTrf }).subscribe((res: any) => {
      console.log("res:", res);
      if (!res.esito) return;

      const blob = new Blob([res.info.testo_xml[0].xmlstring], { type: 'text/txt' });
      const url = window.URL.createObjectURL(blob);
      window.open(url);
    })
  }

  // STESSO SCHEMA DEL JOB AUTOMATICO
  updateFattura(): void {
    // get_ws_call
    this.client.getDati('get_ws_call', { id_trf_fattura: this.idTrf }).subscribe((res_get_ws_call: any) => {
      console.log("res_get_ws_call:", res_get_ws_call);

      if (!res_get_ws_call.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore durante il recupero della chiamata dal WS.'
        });
        return;
      }

      if (res_get_ws_call.info === true) {
        this.notificationService.push({
          notificationClass: 'info',
          content: 'La chiamata al WS è già stata eseguita.'
        });
        return;
      };

      if (res_get_ws_call.info?.id_fattura) {
        this._idFattura = res_get_ws_call.info?.id_fattura;
      }

      console.log("this._idFattura:", this._idFattura);

      // call ws
      this._as.SOAPRequest(res_get_ws_call.info.testo_xml[0].xmlstring).subscribe((resSOAP: any) => {
        console.log("resSOAP:", resSOAP);

        /*  Una volta ottenuta la risposta bisogna spacchettare le informazioni
            da dover inviare al metodo upd_ws_call.
        */

        let xmlDoc = new DOMParser().parseFromString(resSOAP._xmlRes, "text/xml");
        console.log("xmlDoc:", xmlDoc);

        // Inizializza oggetto da caricare
        let updData: any = { esito: {}, info: {} };

        // Recupera eventuali errori
        const faultcode = xmlDoc.getElementsByTagName('faultcode')[0];
        console.log("faultcode.nodeValue:", faultcode?.nodeValue);

        const faultstring = xmlDoc.getElementsByTagName('faultstring')[0];
        console.log("faultstring.nodeValue:", faultstring?.nodeValue);

        updData.esito.faultcode = faultcode?.nodeValue;
        updData.esito.faultstring = faultstring?.nodeValue;

        if (faultcode?.nodeValue === undefined && faultstring?.nodeValue === undefined) {
          updData.esito.esito = true;
        }

        // Recupera rowcount per querydata
        const rowcount = xmlDoc.getElementsByTagName('rowcount')[0];
        console.log("rowcount?.nodeValue:", rowcount?.nodeValue);

        if (rowcount?.nodeValue !== undefined) {
          updData.info.rowcount = rowcount?.nodeValue;
        }

        // Recupera i field e i val nel caso della querydata
        const datarow = xmlDoc.getElementsByTagName('DataRow');
        const field = xmlDoc.getElementsByTagName('field');
        const val = xmlDoc.getElementsByTagName('val');

        if (field.length != 0 && val.length != 0) {
          updData.info.dati = [];
          for (let i = 0; i < datarow.length; i++) {
            let app: any = {};
            for (let j = 0; j < Array.from(field).length; j++) {
              Array.from(val)[j].nodeValue === undefined ?
                app[Array.from(field)[j].attributes.getNamedItem('column')!.value] = Array.from(val)[j].attributes.getNamedItem('nil')!.value :
                app[Array.from(field)[j].attributes.getNamedItem('column')!.value] = Array.from(val)[j].nodeValue;
            }
            updData.info.dati.push(app);
          }
        }

        // Recupera gli outputfield nel caso della createdata
        let outputFields = xmlDoc.getElementsByTagName('outputField');

        if (outputFields !== undefined) {
          Array.from(outputFields).forEach((of: Element) => {
            updData.info[of.attributes.getNamedItem('column')!.value] = of.attributes.getNamedItem('value')?.value;
          });
        }

        console.log("updData:", updData);

        // upd_ws_call
        this.client.updDati('upd_ws_call', {
          id_trf_fattura: this._idFattura,
          jsonRes: updData,
          xmlRes: resSOAP._xmlRes
        }).subscribe((res_upd_ws_call: any) => {
          console.log("res_upd_ws_call:", res_upd_ws_call);
          if (!res_upd_ws_call.esito) {
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Attenzione! Errore durante aggiornamento chiamata WS.'
            });
            return;
          }
        });
      });
    });
  }

  // Stessa funzionalità del bottone "Chiudi Tarriffazione" in Lista Attività
  chiudiTariffazione(): void {
    if (!this.idTrf) { return; }
    if (this.disableCloseTariffa == true) {
      return;
    }
    this.loadingService.openDialog('Salvataggio in corso...');
    this.client.updDati('upd_att_close', {
      id_attivita: Array.isArray(this.idTrf) ? this.idTrf : [this.idTrf]
    }).subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore durante la chiusura della Tariffazione.'
        });
        return;
      }

      this.notificationService.push({
        notificationClass: 'success',
        content: 'Salvataggio avvenuto con successo!'
      });

      setTimeout(() => { window.location.reload(); }, 1500);
    });
  }

  private escape(text: string): string | any {
    return String(text).replace(/(['"<>&'])(\w+;)?/g, (match: any, char: any, escaped: any) => {
      if (escaped)
        return match

      switch (char) {
        case '\'': return '&quot;'
        case '"': return '&apos;'
        case '<': return '&lt;'
        case '>': return '&gt;'
        case '&': return '&amp;'
      }
    })
  }

  goBack() { this.location.back(); }

  // getter methods
  public get getClosed() {
    if (this.closed === 'true') return true;
    else if (this.closed === 'false') return false;
    else return false;
  }

  public get getDontshowViewSezioni() {
    return this.dontshowViewSezioni;
  }
}
