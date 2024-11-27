/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NotificationService, LoadingDialogService, ASmartTableComponent } from '@us/utils';
import { Location, formatDate } from '@angular/common';
import { InterventiService } from '../services';
import { FormControl } from '@angular/forms';
import * as bootstrap from 'bootstrap';
import { BdnfvgService } from '../bdnfvg.service';
import { AppService } from 'src/app/app.service';

const THREEYEARS: number = 1095;

@Component({
  selector: 'app-nuovo-intervento',
  templateUrl: './nuovo-intervento.component.html',
  styleUrls: ['./nuovo-intervento.component.scss']
})
export class NuovoInterventoComponent implements OnInit {
  private _piani?: any;
  private _ui_piani?: any;
  private _allevamenti?: any;
  private _ui_allevamenti?: any;
  private _veterinari?: any;
  private _ui_veterinari?: any;
  private _selectedVeterinari?: number[] = [];
  private _selectedNominativiStruttura?: number[] = [];
  private _selectedPiano?: any;
  private _selectedAllevamento?: any;
  private _selected_piani?: number[];
  private _dataInizio?: string;
  private _dataFine?: string;
  private _oraInizio?: string;
  private _oraFine?: string;
  private _userInfo?: any;
  _id_all_shared?: number | null = null;
  isLivelloUos: boolean = false;

  private modalAllevamenti?: bootstrap.Modal;
  private modalVeterinari?: bootstrap.Modal;

  _startDate?: any = new FormControl([this.minDate.split(' ')[0] + ' 08:00:00']);
  _endDate?: any = new FormControl([this.minDate.split(' ')[0] + ' 12:00:00']);
   _startOra?: any = new FormControl;
   _endOra?: any = new FormControl;

  @ViewChild('tableVeterinari') tableVeterinari?: ASmartTableComponent;
  @ViewChild('tabellaPiani') tablePiani?: ASmartTableComponent;

  colsInfoVeterinari: any = [];

  constructor(
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private _location: Location,
    private _is: InterventiService,
    private _bfs: BdnfvgService,
    private app: AppService
  ) { }

  ngOnInit(): void {
    this.route.data.subscribe((data: any) => {
      this.loadingService.closeDialog();
      console.log("data:", data);
      if (!data.piani.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore durante il caricamento dei dati.'
        });
        return;
      }
      this._piani = data.piani.info.dati;
      console.log("this._piani:", this._piani);

      this._ui_piani = data.piani.info.ui;
      console.log("this._ui:", this._ui_piani);
    });

    this.modalAllevamenti = new bootstrap.Modal('#allevamenti-modal', {focus: false});
    this.modalVeterinari = new bootstrap.Modal('#staticBackdrop', {focus: false});

    console.log("this.modalAllevamenti:", this.modalAllevamenti);
    console.log("this.modalVeterinari:", this.modalVeterinari);

    // Recupera l'id allevamento se si passa per il riepilogo
    this.route.queryParams.subscribe((data: any) => {
      if (data && data['id_allevamento']) {
        this._id_all_shared = parseInt(data['id_allevamento']);
        console.log("this._id_all_shared:", this._id_all_shared);
      }
    });

    // Recupera le informazioni dell'utente
    this.app.getUser().subscribe((res: any) => {
      console.log("res:", res);
      if (!res) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore caricamento dati utente.'
        });
        return;
      }
      this._userInfo = res;
      console.log("this._userInfo:", this._userInfo);
      this.isLivelloUos = this._userInfo.livello >= 3;
      this.getVet(false);
    });
  }

  getAllevamentiPiani(): void {
    console.log("this.tablePiani?.selectedData:", this.tablePiani?.selectedData);

    // Recupera la giornata_max più grande tra i piani selezionati
    // this._maxGiornate = this.findGiornataMax(this.tablePiani!.selectedData)!;

    // Recupera la data di intervento e calcola la data massima
    // const dataInizio = new Date(this._startDate.value);
    // const dataFine = new Date(dataInizio);
    // dataFine.setDate(dataFine.getDate() + this._maxGiornate!);

    // Controlla data inizio < data fine
    if (new Date(this._endDate.value) < new Date(this._startDate.value)) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: `Attenzione!
          La data di fine è minore o uguale della data di inizio`
      });
      return;
    }

    // Estrae nel formato stringa le date
    this._dataInizio = formatDate(new Date(this._startDate.value), 'yyyy-MM-dd HH:mm:ss', 'en');
    this._dataFine = formatDate(new Date(this._endDate.value), 'yyyy-MM-dd HH:mm:ss', 'en');

   // this._oraInizio = new Date(this._startOra.value).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });
   // this._oraFine = new Date(this._endOra.value).toLocaleTimeString('it-EU', { hour: '2-digit', minute: '2-digit' });

    // this._oraInizio = formatDate(new (this._startOra.value), 'HH:mm','en');
    // this._oraFine = formatDate(new Date(this._endOra.value), 'HH:mm','en');

    console.log("this._dataInizio:", this._dataInizio);
    console.log("this._dataFine:", this._dataFine);

    console.log("this._startOra.value:", this._startOra.value);
    console.log("this._endOra.value:", this._endOra.value);

    console.log("this._oraInizio:", this._oraInizio);
    console.log("this._oraFine:", this._oraFine);



    if (
      new Set(this.tablePiani?.selectedData.map((p: any) => p.id_gruppo_specie)).size > 1
      // new Set(this.tablePiani?.selectedData.map((p: any) => p.descr_metodo)).size > 1
    ) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: 'Attenzione! Selezionare Piani per un solo gruppo specie.'
      });
      return;
    };

    if (this._id_all_shared === null) {
      this._selected_piani = this.tablePiani!.selectedData.map((p: any) => p.id_piano);
      console.log("selected_piani:", this._selected_piani);
      this.loadingService.openDialog("Caricamento Aziende...");
      this._is.getAziendePiani(this._selected_piani, this._userInfo.idStrutturaRoot).subscribe((res: any) => {
        this.loadingService.closeDialog();
        console.log("res:", res);
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Attenzione! Errore durante il caricamento dei dati.'
          });
          return;
        }
        this._allevamenti = res.info.dati;
        console.log("this._allevamenti:", this._allevamenti);

        this._ui_allevamenti = res.info.ui;
        console.log("this._ui_allevamenti:", this._ui_allevamenti);
      });

      this.modalAllevamenti?.toggle();

    } else { this.modalVeterinari?.toggle(); }
  }

  /**
   * Ricerca il valore più alto tra le giornate massime.
   * @param arr Arrray di oggetti che contengono il campo 'giornate_max'
   * @returns Il piano che ha il valore più alto di giornate max
   */
  private findGiornataMax(arr: any[]): number | null {
    if (arr.length === 0) {
      throw new Error(`L'array è vuoto`);
    }

    if (!arr[0].hasOwnProperty(('giornate_max'))) {
      throw new Error(`La proprietà 'giornate_max' non è stata trovata nell'oggetto`);
    }

    const giornate_max = arr.map((tp: any) => tp['giornate_max']);
    const max = Math.max(...giornate_max);

    return max;
  }

  /*
  getAllevamentiPiano(piano: any, event: any): void {
    console.log("piano:", piano);

    if (!piano.id_piano) return;

    // Colora la riga selezionata
    let trPiani = document.querySelectorAll('.tr-piani');
    trPiani.forEach((p: Element) => { (p as HTMLElement).classList.remove("cliccato") });
    (event.srcElement.parentElement as HTMLElement).classList.add('cliccato');

    this._selectedPiano = piano;

    // Apri la modale per gli allevamenti
    if (this._id_all_shared === null) {
      this.loadingService.openDialog("Caricamento Allevamenti...");
      this._is.getAllevamentiPiano(piano.id_piano).subscribe((res: any) => {
        console.log("res:", res);
        this.loadingService.closeDialog();
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Attenzione! Errore durante il caricamento dei dati.'
          });
          return;
        }
        this._allevamenti = res.info.dati;
        console.log("this._allevamenti:", this._allevamenti);

        this._ui_allevamenti = res.info.ui;
        console.log("this._ui_allevamenti:", this._ui_allevamenti);

        this.modalAllevamenti?.toggle();
      });
    } else { this.modalVeterinari?.toggle(); }
  }
  */

  selezionaAllevamento(allevamento: any, event: any): void {
    console.log("allevamento:", allevamento);
    this._selectedAllevamento = allevamento;
    if (!this._selectedAllevamento) return;

    // Colora la riga selezionata
    let trAllevamenti = document.querySelectorAll('.tr-allevamenti');
    console.log("trAllevamenti:", trAllevamenti);
    trAllevamenti.forEach((a: Element) => { (a as HTMLElement).classList.remove('cliccato') });
    (event.srcElement.parentElement as HTMLElement).classList.add('cliccato');

    // Recupera i veterinari da una data specifica in poi
    this.getVet(true);
  }

  onChange(evt: any): void { this.getVet(false); }

  /**
   * Controlla che la data inserita rientra nel range [min, max]. Nel caso non
   * dovesse rientrare allora viene reimpostata quella minima, ma è possibile
   * impostare qualsiasi altra data.
   *
   * @param evt Evento che scatta
   */
  onBlur(evt: any): void {
    console.log("evt:", evt);
    if (
      evt.target.min.trim() != '' &&
      evt.target.max.trim() != '' &&
      (evt.target.value < evt.target.min || evt.target.value > evt.target.max)
    ) {
      evt.target.value = evt.target.min;
      const id = evt.target.attributes.id.value;
      let DOMElem: HTMLInputElement = <HTMLInputElement>document.querySelector(`#${id}`);
      DOMElem.value = evt.target.min;
      DOMElem.dispatchEvent(new Event('input'));
    }
  }

  /**
   * Crea l'intervento in BDN e oltre all'intervento crea l'evento sul calendario.
   */
  creaIntervento(): void {
    this._selectedVeterinari = [];
    this._selectedNominativiStruttura = [];
    if (this.isLivelloUos)
      this._selectedVeterinari?.push(+this._userInfo.id_utente_struttura);
    else if (this.tableVeterinari!.selectedData.length == 0) {
      this.notificationService.push({
        notificationClass: 'error',
        content: "Attenzione! Selezionare un veterinario."
      })
      return;
    }
    this._selectedVeterinari = this._selectedVeterinari?.concat(this.tableVeterinari!.selectedData.map((v: any) => v.id));
    console.log("this._selectedVeterinari:", this._selectedVeterinari);
    this._selectedNominativiStruttura = this._selectedNominativiStruttura?.concat(this.tableVeterinari!.selectedData.map((v: any) => v.id_nominativo));
    console.log("this._selectedNominativiStruttura:", this._selectedNominativiStruttura);

    this._is.creaInterventoAzienda(
      // parseInt(this._selectedPiano.id_piano),
      this._selected_piani!,
      parseInt(this._selectedAllevamento.id_azienda),
      //this._id_all_shared ? this._id_all_shared : parseInt(this._selectedAllevamento.id_azienda),
      parseInt(this._selectedAllevamento.id_allevamento_per_cal),
      this._startDate.value,
      this._endDate.value,
      this._selectedVeterinari!,
    ).subscribe((res: any) => {
      console.log("res", res);
      if (!res.esito || !res.info.id) {
        this.notificationService.push({
          notificationClass: 'error',
          content: "Attenzione! Errore durante la creazione dell'intervento."
        });
        return;
      }

      console.log("res.info.id:", res.info.id);
      // Dopo la creazione dell'intervento, crea l'evento sul calendario
      this._is.insEventoCalendario(
        this._selectedVeterinari!,
        this._dataInizio,
        this._dataFine,
        res.info.id,
        this._selected_piani!,
        this._selectedNominativiStruttura!
      ).subscribe((res: any) => {
        console.log("res:", res);
      });
      this.modalVeterinari?.hide();
      this.goBack();
    })
  }

  goBack(): void { this._location.back(); }

  onTableVetChange(dataSelected: any): void {
    this.tableVeterinari?.unselectAll();
    dataSelected.selected = true;
  }

  private getVet(showModal: boolean): void {
    const stringDate = formatDate(this._startDate.value, 'yyyy-MM-dd', 'en');
    this.loadingService.openDialog('Caricamento veterinari');
    this._is.getVeterinari(stringDate, this._userInfo.idStrutturaRoot).subscribe((res: any) => {
      console.log("res:", res);
      this.loadingService.closeDialog();
      if (!res.esito) return;
      console.log("res.info:", JSON.parse(res.info));

      // Estrae le date uniche
      this._ui_veterinari = [...new Set(JSON.parse(res.info).map((item: any) => item.dt))];
      console.log("this._ui_veterinari:", this._ui_veterinari);

      // Recupera tutti i valori univoci
      this._veterinari = [];
      const unique = [...new Set(JSON.parse(res.info).map((item: any) => item.id))];
      console.log("unique:", unique);

      // Per ogni valore univoco crea la struttura dei veterinari
      unique.forEach((uid: any) => {
        const allElems = JSON.parse(res.info).filter((elem: any) => elem.id == uid);
        this._veterinari.push({
          id: allElems[0].id,
          name: allElems[0].descrizione,
          struttura: allElems[0].descrizione_breve,
          value: allElems.map((item: any) => {
            let perc = item['durata_perc'] ?? 0;
            perc = new String(new Number(perc).toFixed(2)).valueOf();
            return {
            dt: item['dt'], durata_perc: perc, colore: item['colore']
           } }),
          id_nominativo: allElems[0].id_nominativo
        });
      });
      console.log("this._veterinari:", this._veterinari);
      console.log('--- creazione campi esportazione');
      let maxValueLength = 0;
      let date: any = [];
      //unpacking dei valori
      let remapped = this._veterinari.map((vet: any) => {
        let values = vet['value'];
        if (values.length > maxValueLength)
          maxValueLength = values.length;
        values.forEach((value: any, i: number) => {
          date[i] = value['dt'];
          vet[`value_${i}`] = value['durata_perc'];
        })
        return vet;
      });
      this._veterinari = remapped;
      console.log("this._veterinari:", this._veterinari);
      this.colsInfoVeterinari = [
        { intestazione: 'Veterinario', campo: 'name' },
        { intestazione: 'Struttura', campo: 'struttura' }
      ];
      for (let i = 0; i < maxValueLength; i++) {
        this.colsInfoVeterinari.push(
          { intestazione: date[i], campo: `value_${i}`}
        )
      }
      console.log(this.colsInfoVeterinari);

      // Apri la modale dei veterinari
      if (showModal) {
        this.modalAllevamenti?.hide();
        this.modalVeterinari?.toggle();
      }

      if (this.isLivelloUos) {
        let vetToRemove = this._veterinari?.find((v: any) => v.id == this._userInfo.idNominativoStruttura);
        console.log("vetToRemove:", vetToRemove);
        // Se è entrato con quel veterinario e quindi è presente
        if(vetToRemove){
          // Prendo l'id dai veterinari e mi ricavo l'indice
          let idToRemove = unique.indexOf(vetToRemove.id);
          console.log("indice preso da rimuovere",idToRemove);
          // Rimuovo il veterinario che è entrato dalla lista dei veterinari visto che è già salvato l'id suo per quando
          // si crea l'intervento
          this._veterinari.splice(idToRemove,1);
          console.log("veterinari dopo rimozione",this._veterinari);
        }
      }

    });

  }

  resetPiano(): void {
    let trPiani = document.querySelectorAll('.tr-piani');
    trPiani.forEach((p: Element) => { (p as HTMLElement).classList.remove("cliccato") });
    this._selectedPiano = null;
  }

  get piani() { return this._piani; }
  get ui_piani() { return this._ui_piani; }
  get allevamenti() { return this._allevamenti; }
  get ui_allevamenti() { return this._ui_allevamenti; }
  get veterinari() { return this._veterinari; }
  get ui_veterinari() { return this._ui_veterinari; }
  get currentDate() { return new Date().setHours(0, 0, 0, 0).toString(); }
  get minDate() { return formatDate(this.currentDate, 'yyyy-MM-dd HH:mm:ss', 'en'); }
  get maxDate() {
    const threeYearsAfter = new Date(new Date().setDate(new Date().getDate() + THREEYEARS));
    return formatDate(threeYearsAfter.setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd HH:mm:ss', 'en');
  }
  get showCreaButton() {
    if (
      !this._selectedPiano ||
      !this._selectedAllevamento ||
      !this._startDate.value ||
      this.tableVeterinari?.selectedData.length === 0
    )
      return false;
    return true;
  }
}
