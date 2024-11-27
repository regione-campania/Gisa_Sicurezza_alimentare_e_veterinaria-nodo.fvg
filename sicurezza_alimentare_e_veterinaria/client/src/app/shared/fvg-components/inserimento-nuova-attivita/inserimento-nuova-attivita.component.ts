/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  ChangeDetectorRef,
  Component,
  EventEmitter,
  OnInit,
  Output,
  ViewChild,
} from '@angular/core';
import { SharedService } from '../../shared.service';
import { DateTimeFormComponent } from '../../fvg-forms/date-time-form/date-time-form.component';
import { ASliderComponent, ATreeNodeComponent, isValidDate } from '@us/utils';
import { FormBuilder } from '@angular/forms';
import { PromptService } from 'src/app/services/prompt.service';

@Component({
  selector: 'inserimento-nuova-attivita',
  templateUrl: './inserimento-nuova-attivita.component.html',
  styleUrls: ['./inserimento-nuova-attivita.component.scss'],
})
export class InserimentoNuovaAttivitaComponent implements OnInit {
  @ViewChild('slider') slider!: ASliderComponent;

  @Output('onSave') saveEvent = new EventEmitter<void>();

  //strutture dati
  tipiAttivita: any;
  ns: any;
  pianiByNs: any;
  lineeByNsPiano: any;
  stabilimenti: any;

  //elementi selezionati
  tipoAttivitaSelezionato: any;
  nsSelezionato: any;
  partnerSelezionato: any;
  pianoSelezionato: any;
  lineaSelezionata: any;
  stabilimentoSelezionato: any;

  //loading
  tipiAttivitaLoading = false;
  nsLoading = false;
  pianiByNsLoading = false;
  lineeByNsPianoLoading = false;
  stabilimentiLoading = false;

  //flag
  fasePreliminareCompleta = false;

  //intervallo in cui è possibile inserire attività
  //(1 Gennaio anno corrente - 31 Dicembre anno successivo)
  private _today = new Date();
  startMin: string;
  startMax: string;
  endMin: string;
  endMax: string;

  formPeriodo = this.fb.group({
    periodo: {
      start: '',
      end: '',
    },
  });

  constructor(
    private sharedService: SharedService,
    private prompt: PromptService,
    private fb: FormBuilder
  ) {
    this.startMin = this.endMin = `${this._today.getFullYear()}-01-01`;
    this.startMax = this.endMax = `${this._today.getFullYear() + 1}-12-31`;
  }

  ngOnInit(): void {
    this.initTipoAttivita();
    this.initNs();
  }

  initTipoAttivita() {
    this.tipiAttivitaLoading = true;
    this.sharedService.getAgTipoEventi().subscribe((res) => {
      this.tipiAttivitaLoading = false;
      if (res.esito)
        this.tipiAttivita = res.info.dati
          .filter((att: any) => att.inserisci)
          .sort((a: any, b: any) => a.id - b.id);
    });
  }

  initNs() {
    this.nsLoading = true;
    this.sharedService.getNs().subscribe((res) => {
      this.nsLoading = false;
      if (res.esito) {
        this.ns = res.info;
      }
    });
  }

  selezionaTipoAttivita(tipoAtt: any) {
    this.tipoAttivitaSelezionato = tipoAtt;
    this._setPeriodoInterval(this.formPeriodo.get('periodo')?.value);
    //controllo se il valore di fine intervallo è corretto;
    //se non lo è lo aggiusto
    let control = this.formPeriodo.get('periodo')!;
    let endValue = control!.value?.end;
    if (endValue && new Date(endValue) > new Date(this.endMax))
      control.value!.end = this.endMax;
  }

  deselezionaTipoAttivita() {
    //chiede conferma della deselezione se la fase preliminare è completa
    if (this.fasePreliminareCompleta) {
      this.prompt
        .ask(
          `Deselezionando il tipo attività si ritornerà alla schemata di selezione. Continuare?`,
          `Deselezionare il tipo attività?`
        )
        .then((res) => {
          if (res.isConfirmed) {
            this.tipoAttivitaSelezionato = undefined;
            this.nsSelezionato = undefined;
            this.resetParams();
            this.backToFasePreliminare();
          }
        });
    } else this.tipoAttivitaSelezionato = undefined;
  }

  selezionaNs(ns: any) {
    this.nsSelezionato = ns;
  }

  deselezionaNs() {
    //chiede conferma della deselezione se la fase preliminare è completa
    if (this.fasePreliminareCompleta) {
      this.prompt
        .ask(
          `Deselezionando la risorsa si ritornerà alla schemata di selezione. Continuare?`,
          `Deselezionare la risorsa?`
        )
        .then((res) => {
          if (res.isConfirmed) {
            this.nsSelezionato = undefined;
            this.resetParams();
            this.backToFasePreliminare();
          }
        });
    } else this.nsSelezionato = undefined;
  }

  selezionaPiano(node: ATreeNodeComponent) {
    if (node.isLeafNode()) {
      this.pianoSelezionato = node.data;
      if (this.isLineaRichiesta) {
        this._initLineeByNsPiano(
          this.nsSelezionato.id_ns,
          this.pianoSelezionato.id
        );
        this.slider?.goTo('linea');
      }
    }
  }

  deselezionaPiano() {
    this.pianoSelezionato = undefined;
  }

  selezionaLinea(linea: any) {
    this.lineaSelezionata = linea;
    if (this.isPartnerRichiesto && this.partnerDisponibili.length > 0)
      this.slider?.goTo('partner');
  }

  deselezionaLinea() {
    this.lineaSelezionata = undefined;
  }

  selezionaPartner(partner: any) {
    this.partnerSelezionato = partner;
  }

  deselezionaPartner() {
    this.partnerSelezionato = undefined;
  }

  selezionaStabilimento(stab: any) {
    this.stabilimentoSelezionato = stab;
    if (this.isPartnerRichiesto && this.partnerDisponibili.length > 0)
      this.slider?.goTo('partner');
  }

  deselezionaStabilimento() {
    this.stabilimentoSelezionato = undefined;
  }

  back(): void {
    let campiRichiesti = this.campiRichiesti.filter(
      (c: any) => c !== 'risorsa' && c !== 'tempo'
    ) as any[];
    let activeSlide = this.slider.activeSlide?.label;
    let indexOfActiveSlide = campiRichiesti.indexOf(activeSlide);
    let prev = campiRichiesti[indexOfActiveSlide - 1];
    switch (activeSlide) {
      case 'piano':
        this.deselezionaPiano();
        break;
      case 'linea':
        this.deselezionaLinea();
        break;
      case 'partner':
        this.deselezionaPartner();
        break;
      case 'stabilimenti':
        this.deselezionaStabilimento();
        break;
    }
    if (prev) this.slider.goTo(prev);
    else this.backToFasePreliminare();
  }

  continue() {
    if (this.canContinue) {
      let ns = this.nsSelezionato;
      if (this.isPianoRichiesto) {
        this.slider.goTo('piano');
        this._initPianiByNs(ns.id_ns);
      } else if (this.isStabilimentoRichiesto) {
        this.slider.goTo('stabilimenti');
        this._initStabilimenti();
      }
      this.fasePreliminareCompleta = true;
    }
  }

  save() {
    if (this.canSave) {
      let tipo = this.tipoAttivitaSelezionato;
      let ns = this.nsSelezionato;
      let form = this.formPeriodo;
      if (form) {
        let inizio = form.value.periodo?.start;
        let fine = form.value.periodo?.end;
        let pkg: any = {
          id_tipo_evento: tipo.id,
          id_ns: ns.id_ns,
          inizio: inizio,
          fine: fine,
        };
        if (this.isPianoRichiesto && this.pianoSelezionato)
          pkg.id_piano = this.pianoSelezionato.id;
        if (this.isLineaRichiesta && this.lineaSelezionata)
          pkg.id_linea = this.lineaSelezionata.id;
        if (this.isStabilimentoRichiesto && this.stabilimentoSelezionato)
          pkg.id_stabilimento = this.stabilimentoSelezionato.id;
        if (this.isPartnerRichiesto && this.partnerSelezionato)
          pkg.id_partner = this.partnerSelezionato.id_ns;
        this.sharedService
          .insEvento(pkg)
          .subscribe((_: any) => this.saveEvent.emit());
      }
    }
  }

  backToFasePreliminare() {
    this.fasePreliminareCompleta = false;
    this.slider.goTo('main');
  }

  resetParams() {
    this.partnerSelezionato = undefined;
    this.pianoSelezionato = undefined;
    this.lineaSelezionata = undefined;
    this.stabilimentoSelezionato = undefined;
  }

  //helpers
  getIconClass(tipoAtt: any) {
    switch (tipoAtt.sigla) {
      case 'CU':
        return 'pencil';
      case 'Ferie':
        return 'beach';
      case 'Malattia':
        return 'thermometer';
      case 'AI':
        return 'clipboard-circle';
      case 'RO':
        return 'coffee-cup';
      case 'Agg':
        return 'update';
      case 'FU':
        return 'arrow-down-circle';
      case 'PL':
        return 'pharma';
      case 'AS':
        return 'flower';
      case 'AE':
        return 'file-2';
      case 'CT':
        return 'bus';
      default:
        return '';
    }
  }

  //imposta i valori minimi e massimi della fine del periodo di validità
  _setPeriodoInterval(value: any) {
    if (!this.tipoAttivitaSelezionato) return;
    let durataMax = this.tipoAttivitaSelezionato.durata_max_ms as number;
    let startDate = new Date(value.start);
    if (!isValidDate(startDate)) return;
    this.endMin = value.start;
    let endMaxDate = new Date(startDate.valueOf() + durataMax);
    this.endMax = endMaxDate.toISOString().split('T')[0];
  }

  private _initPianiByNs(idNs: string) {
    this.pianiByNsLoading = true;
    this.sharedService
      .getPianiByNs(idNs, this.tipoAttivitaSelezionato.id)
      .subscribe((res) => {
        this.pianiByNsLoading = false;
        if (res.esito) this.pianiByNs = res.info;
        else this.pianiByNs = null;
      });
  }

  private _initLineeByNsPiano(idNs: string, idPiano: string) {
    this.lineeByNsPianoLoading = true;
    this.sharedService.getLineeByNsPiano(idNs, idPiano).subscribe((res) => {
      this.lineeByNsPianoLoading = false;
      if (res.esito) {
        let info = res.info;
        //commentato momentaneamente (issue: #12412)
        /* if (this.tipoAttivitaSelezionato.sigla == 'CT')
          info.dati = info.dati.filter((item: any) =>
            item.cod_tipo_linea.toLowerCase().includes('trasport')
          ); */
        this.lineeByNsPiano = info;
      } else this.lineeByNsPiano = null;
    });
  }

  private _initStabilimenti() {
    this.stabilimentiLoading = true;
    this.sharedService.getAzSedi().subscribe((res) => {
      this.stabilimentiLoading = false;
      if (res.esito) {
        this.stabilimenti = res.info.dati;
      }
    });
  }

  //computed
  get canContinue(): boolean {
    return (
      this.tipoAttivitaSelezionato &&
      this.nsSelezionato &&
      this.formPeriodo.valid
    );
  }

  get canSave(): boolean {
    if (this.canContinue) {
      if (this.isPianoRichiesto && !this.pianoSelezionato) return false;
      if (this.isLineaRichiesta && !this.lineaSelezionata) return false;
      if (this.isStabilimentoRichiesto && !this.stabilimentoSelezionato)
        return false;
      return true;
    }
    return false;
  }

  get partnerDisponibili() {
    if (!this.ns || !this.nsSelezionato) return [];
    return this.ns.filter((ns: any) => {
      return this.nsSelezionato.descrizione != ns.descrizione;
    });
  }

  get campiRichiesti() {
    return this.tipoAttivitaSelezionato
      ? this.tipoAttivitaSelezionato['campi_richiesti']
      : undefined;
  }

  get isPianoRichiesto() {
    if (!this.tipoAttivitaSelezionato) return false;
    return this.campiRichiesti.includes('piano');
  }

  get isLineaRichiesta() {
    if (!this.tipoAttivitaSelezionato) return false;
    return this.campiRichiesti.includes('linea');
  }

  get isStabilimentoRichiesto() {
    if (!this.tipoAttivitaSelezionato) return false;
    return this.campiRichiesti.includes('stabilimenti');
  }

  get isPartnerRichiesto() {
    if (!this.tipoAttivitaSelezionato) return false;
    return this.campiRichiesti.includes('partner');
  }
}
