/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  AfterViewChecked,
  AfterViewInit,
  ChangeDetectorRef,
  Component,
  Inject,
  Input,
  OnInit,
  ViewChild,
} from '@angular/core';
import { InfoStrutturaPrimaria } from '../types';
import {
  ASmartTableComponent,
  ATreeNodeComponent,
  Data,
  MONTHS,
  TemplateService,
  Tree,
  Utils,
  getDaysOfMonth,
  toTree,
} from '@us/utils';
import { ATreeComponent } from '@us/utils';
import { ValueTracker } from '@us/utils';
import { LoadingDialogService } from '@us/utils';
import { NotificationService } from '@us/utils';
import { NgModel } from '@angular/forms';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import Swal from 'sweetalert2';
import { GestioneAttivitaService } from '../../gestione-attivita.service';
import { UTILS, UtilsType } from 'src/app/shared/shared';

@Component({
  selector: 'piani-conf',
  templateUrl: './piani.component.html',
  styleUrls: ['./piani.component.scss'],
})
export class PianiComponent implements OnInit, AfterViewInit, AfterViewChecked {
  @Input() info?: InfoStrutturaPrimaria;
  @ViewChild('tabellaOggetti') tabellaOggetti?: ASmartTableComponent;
  @ViewChild('tabellaProfilassi') tabellaProfilassi?: ASmartTableComponent;
  @ViewChild('tabellaTipologiaControllo')
  tabellaTipologiaControllo?: ASmartTableComponent;

  private _oggSel: any[] = [];
  private _profSel: any[] = [];
  private _tipoControlloSel: any;
  selected: any;

  pianiLoading = false;
  tipoLineeLoading = false;
  frequenzeLoading = false;
  tariffaLoading = false;
  periodoLoading = false;
  oggettiLoading = false;
  profilassiLoading = false;
  tipologiaControlloLoading = false;

  private _ui?: any;
  private _retDati?: any;
  private _uiProfilassi?: any;
  private _retDatiProfilassi?: any;
  private _uiTipologiaControllo?: any;
  private _retDatiTipologiaControllo?: any;
  private _id_tipologia_controllo?: any;

  pianiTree?: Tree;
  pianiSelezionabiliTree?: Tree;
  tipoLineeTree?: Tree;
  tipoLineeTreeComponent?: ATreeComponent;
  tariffaTree?: Tree;
  tariffaTreeComponent?: ATreeComponent;

  modaleDuplicaTipoLinee?: NgbModalRef;

  formFrequenze = {
    basso: { livello: 0, num: 1, den: 1 },
    medio: { livello: 1, num: 1, den: 1 },
    alto: { livello: 2, num: 1, den: 1 },
  };

  formPeriodo = {
    giornoInizio: '1',
    meseInizio: '1',
    giornoFine: '1',
    meseFine: '1',
  };

  mesi = MONTHS;

  private _selectedPiano?: ATreeNodeComponent;
  private _today = new Date();

  constructor(
    private gs: GestioneAttivitaService,
    private loading: LoadingDialogService,
    private notification: NotificationService,
    private changeDetector: ChangeDetectorRef,
    private modalEngine: NgbModal,
    public ts: TemplateService,
    @Inject(UTILS) public utils: UtilsType
  ) { }

  ngOnInit(): void {
    if (!(this.pianiTree = this.gs.storage.getItem('confPianiTree'))) {
      this.pianiLoading = true;
      this.gs.getPiani().subscribe((res) => {
        this.pianiLoading = false;
        this.pianiTree = toTree(res.info, (node) => {
          node.expanded = node.parent == null ? true : false;
          return node;
        });
        this.pianiSelezionabiliTree = toTree(res.info, (node) => {
          node.expanded = node.parent == null ? true : false;
          node.selectable = true;
          return node;
        });
        this.gs.storage.setItem('confPianiTree', this.pianiTree);
      });
    }
  }

  ngAfterViewInit(): void { }

  ngAfterViewChecked(): void {
    if (this.tabellaOggetti && this.infoOggetti) {
      if (!this.infoOggetti.trackerModifiche)
        this.infoOggetti.trackerModifiche = new ValueTracker(
          this.tabellaOggetti.selectedData
        );
      else
        this.infoOggetti.trackerModifiche.updateValue(
          this.tabellaOggetti.selectedData
        );
    }
    if (this.tabellaProfilassi && this.infoProfilassi) {
      this.infoProfilassi.trackerModifiche?.updateValue(
        this.tabellaProfilassi.selectedData
      );
    }
    this.changeDetector.detectChanges();
  }

  initStruttureSecondarie(node: ATreeNodeComponent) {
    if (node.isLeafNode()) {
      if (this.selectedPiano) this.unselectPiano();
      this.selectPiano(node);
      this.tipoLineeLoading =
        this.frequenzeLoading =
        this.tariffaLoading =
        this.periodoLoading =
        this.oggettiLoading =
        this.profilassiLoading =
        this.tipologiaControlloLoading =
        true;
      this.gs.getTipoLinee(node.data.id).subscribe((res) => {
        this.tipoLineeLoading = false;
        this.tipoLineeTree = toTree(res.info, (node) => {
          node.selectable = true;
          node.readonly = this.infoTipoLinee?.modality == 'lettura' ?? false;
          node.expanded = node.parent == null ? true : false;
          return node;
        });
      });
      this.gs.getTariffarioPerPiani(node.data.id).subscribe((res) => {
        this.tariffaLoading = false;
        this.tariffaTree = toTree(res.info, (node: any) => {
          if (!node.parent) node.expanded = true;
          return node;
        });
      });
      this.gs.getFrequenzePiano(node.data.id).subscribe((res) => {
        this.frequenzeLoading = false;
        let freq = res.info.piano_freq;
        if (freq) {
          let basso = freq.find((x: any) => x.livello == 0);
          this.formFrequenze.basso = {
            livello: 0,
            num: basso.num,
            den: basso.den,
          };
          let medio = freq.find((x: any) => x.livello == 1);
          this.formFrequenze.medio = {
            livello: 1,
            num: medio.num,
            den: medio.den,
          };
          let alto = freq.find((x: any) => x.livello == 2);
          this.formFrequenze.alto = {
            livello: 2,
            num: alto.num,
            den: alto.den,
          };
        } else {
          this.formFrequenze = {
            basso: { livello: 0, num: 1, den: 1 },
            medio: { livello: 1, num: 1, den: 1 },
            alto: { livello: 2, num: 1, den: 1 },
          };
        }
        this.infoFrequenze!.trackerModifiche = new ValueTracker(
          this.formFrequenze
        );
      });
      this.gs.getPianoPeriodo(node.data.id).subscribe((res) => {
        this.periodoLoading = false;
        if (res.info) {
          let da = new Date(res.info[0].da);
          let a = new Date(res.info[0].a);
          this.formPeriodo.giornoInizio = da.getDate().toString();
          this.formPeriodo.meseInizio = (da.getMonth() + 1).toString();
          this.formPeriodo.giornoFine = a.getDate().toString();
          this.formPeriodo.meseFine = (a.getMonth() + 1).toString();
        } else {
          this.formPeriodo = {
            giornoInizio: '1',
            meseInizio: '1',
            giornoFine: '1',
            meseFine: '1',
          };
        }
        this.infoPeriodo!.trackerModifiche = new ValueTracker(this.formPeriodo);
      });
      //Funzione che prende gli oggetti del controllo in base al piano selezionato
      this.gs.getPianoOggetti({ id_piano: node.data.id }).subscribe((res) => {
        this.oggettiLoading = false;
        console.log('res oggetti: ', res);
        this._ui = res.info.ui;
        this._retDati = res.info.dati;
      });
      //funzione che prende le profilassi in base al piano selezionato
      this.gs
        .getPianiProfilassi({ id_piano: node.data.id })
        .subscribe((res: any) => {
          this.profilassiLoading = false;
          console.log('res profilassi: ', res);
          this._uiProfilassi = res.info.ui;
          this._retDatiProfilassi = res.info.dati;
          setTimeout(() => {
            if (this.infoProfilassi)
              this.infoProfilassi.trackerModifiche = new ValueTracker(
                this.tabellaProfilassi?.selectedData
              );
          });
        });
      //funzione che prende la tipologia controllo in base al piano selezionato
      this.gs.getPianoTipologiaControllo(node.data.id).subscribe((res: any) => {
        console.log('res tipologia controllo: ', res);
        this._uiTipologiaControllo = res.info.ui;
        this._retDatiTipologiaControllo = res.info.dati;
        this._id_tipologia_controllo =
          res.info.dati.find((elem: any) => elem.selezionato)?.id || null;
        this.infoTipologiaControllo!.trackerModifiche = new ValueTracker(
          this._id_tipologia_controllo
        );
        this.tipologiaControlloLoading = false;
      });
    }
  }

  dataMapping(d: any) {
    d.selected = d.selezionato;
    return d as Data;
  }

  selectPiano(node: ATreeNodeComponent) {
    this.selectedPiano = node;
  }

  unselectPiano() {
    this.selectedPiano = undefined;
  }

  selectTariffa(node: ATreeNodeComponent) {
    let selected = this.tariffaTreeComponent?.nodes?.find((node: any) =>
      node.htmlElement.classList.contains('selected')
    );
    selected?.htmlElement.classList.remove('selected');
    if (node.id != selected?.id) node.htmlElement.classList.add('selected');
  }

  openModal(content: any) {
    return this.modalEngine.open(content, {
      modalDialogClass: 'system-modal',
      size: 'lg',
      centered: true,
    });
  }

  salva() {
    if (this.strutturaSecondariaAttiva) {
      switch (this.strutturaSecondariaAttiva.label) {
        case 'Tipo Linee':
          this.salvaTipoLinee();
          break;
        case 'Frequenze':
          this.salvaFrequenze();
          break;
        case 'Tariffa':
          this.salvaTariffa();
          break;
        case 'Periodo':
          this.salvaPeriodo();
          break;
        case 'Oggetti':
          this.salvaOggetti();
          break;
        case 'Profilassi':
          this.salvaProfilassi();
          break;
        case 'Tipologia Controllo':
          this.salvaTipologiaControllo();
          break;
      }
    }
  }

  salvaPeriodo() {
    let dataInizio = `${this.today.getFullYear()}-${this.formPeriodo.meseInizio.padStart(
      2,
      '0'
    )}-${this.formPeriodo.giornoInizio.padStart(2, '0')}`;
    let dataFine = `${this.today.getFullYear()}-${this.formPeriodo.meseFine.padStart(
      2,
      '0'
    )}-${this.formPeriodo.giornoFine.padStart(2, '0')}`;
    if (new Date(dataInizio) > new Date(dataFine)) {
      this.notification.push({
        notificationClass: 'error',
        content: 'Attenzione! Data Inizio maggiore della Data Fine.',
      });
      return;
    }
    let periodo = `[${dataInizio}, ${dataFine}]`;
    this.loading.openDialog('Salvataggio in corso...');
    this.gs
      .updPianoPeriodo(this.selectedPiano!.data.id, periodo)
      .subscribe((res) => {
        this.loading.closeDialog();
        if (res.esito)
          this.infoPeriodo!.trackerModifiche = new ValueTracker(
            this.formPeriodo
          );
      });
  }

  salvaTariffa() {
    let selectedTariffa = this.tariffaTreeComponent?.nodes?.find((node) =>
      node.htmlElement.classList.contains('selected')
    );
    this.loading.openDialog('Salvataggio in corso...');
    this.gs
      .updTariffaPiano(this.selectedPiano!.data.id, selectedTariffa?.data.id)
      .subscribe((res) => {
        this.loading.closeDialog();
        this.initStruttureSecondarie(this.selectedPiano!)
        if (res.esito)
          this.infoTariffa!.trackerModifiche = new ValueTracker(
            this.tariffaTreeComponent?.nodes?.find((node) =>
              node.htmlElement.classList.contains('selected')
            )?.id
          );
      });
  }

  salvaFrequenze() {
    let freq = [
      this.formFrequenze.basso,
      this.formFrequenze.medio,
      this.formFrequenze.alto,
    ];
    this.gs.updPianoFreq(this.selectedPiano!.data.id, freq).subscribe((res) => {
      if (res.esito)
        this.infoFrequenze!.trackerModifiche = new ValueTracker(
          this.formFrequenze
        );
    });
  }

  salvaTipoLinee() {
    let selectedTipiLinea = this.tipoLineeTreeComponent
      ?.leafNodes!.filter((n) => n.selected)
      .map((n) => n.data.id);
    this.loading.openDialog('Salvataggio in corso...');
    this.gs
      .updLineePiano(this.selectedPiano!.data.id, selectedTipiLinea ?? [])
      .subscribe((res) => {
        this.loading.closeDialog();
        if (res.esito)
          this.infoTipoLinee!.trackerModifiche = new ValueTracker(
            this.tipoLineeTreeComponent?.nodes?.map((node) => node.selected)
          );
      });
  }

  //Funzione che salva gli oggetti selezionati
  salvaOggetti() {
    this._oggSel = [];
    //if (this.tabellaOggetti?.selectedData.length) {
    this.tabellaOggetti?.selectedData.forEach((elem: any) => {
      this._oggSel.push(elem.id);
    });
    // if (this._oggSel.length > 0) {
    this.loading.openDialog('Aggiunta oggetti al piano...');
    this.gs
      .updPianoOggetti({
        id_piano: this.selectedPiano!.data.id,
        id_tipo_oggetto: this._oggSel,
      })
      .subscribe((res: any) => {
        if (!res.esito) {
          this.notification.push({
            notificationClass: 'error',
            content: "Errore nell'associazione degli oggetti",
          });
          return;
        } else {
          this.notification.push({
            notificationClass: 'success',
            content: 'Aggiunta degli oggetti avvenuta con successo!',
          });
          if (this.tabellaOggetti && this.infoOggetti)
            this.infoOggetti.trackerModifiche = new ValueTracker(
              this.tabellaOggetti.selectedData
            );
        }
        this.loading.closeDialog();
      });
    // }
    //}
  }
  //Funzione che salva le profilassi selezionate
  salvaProfilassi() {
    this._profSel = [];
    //if (this.tabellaProfilassi?.selectedData.length) {
    this.tabellaProfilassi?.selectedData.forEach((elem: any) => {
      this._profSel.push(elem.id);
    });
    //if (this._profSel.length > 0) {
    this.loading.openDialog('Aggiunta profilassi al piano...');
    this.gs
      .updPianiProfilassi({
        id_piano: this.selectedPiano!.data.id,
        id_piano_profilassi: this._profSel,
      })
      .subscribe((res: any) => {
        if (!res.esito) {
          this.notification.push({
            notificationClass: 'error',
            content:
              "Errore nell'associazione delle profilassi. Ogni piano può essere associato solo a una profilassi e viceversa.",
          });
          this.loading.closeDialog();
          return;
        } else {
          this.notification.push({
            notificationClass: 'success',
            content: 'Aggiunta delle profilassi avvenuta con successo!',
          });
          if (this.tabellaProfilassi && this.infoProfilassi)
            this.infoProfilassi.trackerModifiche = new ValueTracker(
              this.tabellaProfilassi.selectedData
            );
        }
        this.loading.closeDialog();
      });

    // }
    //}
  }
  //Funzione che salva la tipologia controllo
  salvaTipologiaControllo() {
    this.loading.openDialog('Aggiunta tipologia controllo al piano...');
    if (!this._id_tipologia_controllo) {
      console.log(this._id_tipologia_controllo);
      this.gs
        .updPianoTipologiaControllo(this.selectedPiano!.data.id, [])
        .subscribe((res: any) => {
          if (!res.esito) {
            this.loading.closeDialog();
            this.notification.push({
              notificationClass: 'error',
              content: "Errore nell'associazione della tipologia del controllo",
            });
            return;
          } else {
            this.notification.push({
              notificationClass: 'success',
              content:
                'Aggiunta della tipologia controllo avvenuta con successo!',
            });
            if (this.tabellaTipologiaControllo && this.infoTipologiaControllo)
              this.infoTipologiaControllo.trackerModifiche = new ValueTracker(
                this._id_tipologia_controllo
              );
          }
          this.loading.closeDialog();
        });
    } else {
      this.gs
        .updPianoTipologiaControllo(this.selectedPiano!.data.id, [
          this._id_tipologia_controllo,
        ])
        .subscribe((res: any) => {
          if (!res.esito) {
            this.loading.closeDialog();
            this.notification.push({
              notificationClass: 'error',
              content: "Errore nell'associazione della tipologia del controllo",
            });
            return;
          } else {
            this.notification.push({
              notificationClass: 'success',
              content:
                'Aggiunta della tipologia controllo avvenuta con successo!',
            });
            if (this.tabellaTipologiaControllo && this.infoTipologiaControllo)
              this.infoTipologiaControllo.trackerModifiche = new ValueTracker(
                this._id_tipologia_controllo
              );
          }
          this.loading.closeDialog();
        });
    }
  }

  // Funzione che controlla tramite la checkbox di selezionarlo uno alla volta
  // e controlla anche da DB se c'è già un elemento se si rimane selezionato
  checkCheckBox(ar: any) {
    //Bug fix #11743
    this.retDatiTipologiaControllo.forEach((item: any) => {
      if (item.id != ar.id) item.selected = false;
    });
    ar.selected = !ar.selected;
    this._id_tipologia_controllo = ar.selected ? ar.id : null;
    this.infoTipologiaControllo?.trackerModifiche?.updateValue(
      this._id_tipologia_controllo
    );
  }

  duplica(tree?: ATreeComponent) {
    //duplicazione tipo linee (per ora è possibile solo quella)
    this.modaleDuplicaTipoLinee?.close();
    let idCloni: any = tree?.getSelectedLeafNodes().map((node) => node.data.id);
    this.gs
      .updClonaTipoLineePerPiano(this.selectedPiano!.data.id, idCloni ?? [])
      .subscribe();
  }

  //TODO: richiedere salvataggio prima di duplicare
  richiediSalvataggio(callback?: Function) {
    Swal.fire({
      title: 'Salvare le modifiche prima di continuare?',
      icon: 'warning',
      showConfirmButton: true,
      confirmButtonText: 'Salva',
      showDenyButton: true,
      denyButtonText: 'Annulla',
    }).then((res) => {
      if (res.isConfirmed && callback) {
        this.salva();
        callback();
      }
    });
  }

  onTipoLineeTreeLoad(tree: ATreeComponent) {
    this.tipoLineeTreeComponent = tree;
    this.infoTipoLinee!.trackerModifiche = new ValueTracker(
      tree.nodes?.map((node) => node.selected)
    );
  }

  onTipoLineeTreeClick() {
    //aspetta il checkStatus() dell'albero
    setTimeout(() => {
      this.infoTipoLinee!.trackerModifiche?.updateValue(
        this.tipoLineeTreeComponent?.nodes?.map((node) => node.selected)
      );
    });
  }

  onTariffaTreeLoad(tree: ATreeComponent) {
    this.tariffaTreeComponent = tree;
    let selected = this.tariffaTreeComponent.nodes?.find(
      (node) => node.selected || node.data.selezionato
    );
    if (selected) this.selectTariffa(selected);
    this.infoTariffa!.trackerModifiche = new ValueTracker(selected?.id);
  }

  onTariffaTreeClick(node: ATreeNodeComponent) {
    if (!node.isLeafNode() || this.infoTariffa?.modality == 'lettura') return;
    this.selectTariffa(node);
    //aspetta il checkStatus() dell'albero
    setTimeout(() => {
      let id = node.htmlElement.classList.contains('selected') ? node.id : null;
      this.infoTariffa!.trackerModifiche?.updateValue(id);
    });
  }

  checkDataPeriodo(e: Event, model: NgModel) {
    let target = e.target as HTMLInputElement;
    let targetDate = new Date(target.value);
    let patch = '';
    if (targetDate.toString() === 'Invalid Date') {
      if (target.id == 'data_inizio')
        patch = `${this.today.getFullYear()}-01-01`;
      else if (target.id == 'data_fine')
        patch = `${this.today.getFullYear()}-12-31`;
    } else {
      if (targetDate.getFullYear() !== this.today.getFullYear())
        patch = `${this.today.getFullYear()}-${targetDate.getMonth() + 1
          }-${targetDate.getDate()}`;
    }
    if (patch) {
      model.control.patchValue(patch);
      target.value = patch;
      model.control.updateValueAndValidity();
      this.changeDetector.detectChanges();
    }
  }

  getArrayGiorni(mese: number, anno: number = new Date().getFullYear()) {
    return Array.from({ length: getDaysOfMonth(mese, anno)! }, (_, i) => i + 1);
  }

  showTariffaSelezionata(scrollBox: HTMLElement) {
    let selected = this.tariffaTreeComponent?.nodes?.find(
      (node) => node.selected || node.data.selezionato
    );
    if (selected) {
      let parent = selected.parentComponent;
      while (parent) {
        parent.expand();
        parent = parent.parentComponent;
      }
      //ritarda lo scrolling aspettando l'espansione dell'albero
      setTimeout(() => {
        scrollBox.scrollTo({
          top: selected!.htmlElement.offsetTop,
          left: 0,
          behavior: 'smooth',
        });
      });
    }
  }

  deselezionaTariffa() {
    if (this.selectedTariffa) {
      this.selectedTariffa.classList.remove('selected');
      this.infoTariffa!.trackerModifiche?.updateValue(null);
    }
  }

  //computed
  get infoTipoLinee() {
    return this.info?.struttureAssociate.find((s) => s.label == 'Tipo Linee');
  }

  get infoFrequenze() {
    return this.info?.struttureAssociate.find((s) => s.label == 'Frequenze');
  }

  get infoTariffa() {
    return this.info?.struttureAssociate.find((s) => s.label == 'Tariffa');
  }

  get infoPeriodo() {
    return this.info?.struttureAssociate.find((s) => s.label == 'Periodo');
  }

  get strutturaSecondariaAttiva() {
    return this.info?.struttureAssociate.find((s) => s.active);
  }

  get infoOggetti() {
    return this.info?.struttureAssociate.find((s) => s.label == 'Oggetti');
  }

  get infoProfilassi() {
    return this.info?.struttureAssociate.find((s) => s.label == 'Profilassi');
  }

  get infoTipologiaControllo() {
    return this.info?.struttureAssociate.find(
      (s) => s.label == 'Tipologia Controllo'
    );
  }

  get today() {
    return this._today;
  }

  get periodoMinDate() {
    return this.today.getFullYear() + '-01-01';
  }

  get periodoMaxDate() {
    return this.today.getFullYear() + '-12-31';
  }

  //accessors
  get selectedPiano(): ATreeNodeComponent | undefined {
    return this._selectedPiano;
  }

  set selectedPiano(value: ATreeNodeComponent | undefined) {
    if (this._selectedPiano)
      this._selectedPiano.htmlElement.classList.remove('selected');
    this._selectedPiano = value;
    this._selectedPiano?.htmlElement.classList.add('selected');
  }

  get selectedTariffa() {
    return this.tariffaTreeComponent?.rootComponent?.htmlElement.querySelector(
      '.selected'
    ) as HTMLElement | null;
  }

  get ui() {
    return this._ui;
  }
  get retDati() {
    return this._retDati;
  }
  get uiProfilassi() {
    return this._uiProfilassi;
  }
  get retDatiProfilassi() {
    return this._retDatiProfilassi;
  }
  get uiTipologiaControllo() {
    return this._uiTipologiaControllo;
  }
  get retDatiTipologiaControllo() {
    return this._retDatiTipologiaControllo;
  }
}
