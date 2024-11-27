/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { GestioneAttivitaService } from 'src/app/portals/gestione-attivita/gestione-attivita.service';
import { ATreeComponent, ATreeNodeComponent, BackendCommunicationService, ContextMenuService, LoadingDialogService, NotificationService, TreeNode, Utils, stretchToWindow, toTree } from '@us/utils';
import { formatDate } from '@angular/common';
import Swal from 'sweetalert2';
import { AppService } from 'src/app/app.service';

const TWODAYS: number = 2;
const TENYEARS: number = 3650;

@Component({
  selector: 'app-tariffe',
  templateUrl: './tariffe.component.html',
  styleUrls: ['./tariffe.component.scss']
})
export class TariffeComponent implements OnInit {
  tariffario: any;
  tariffarioParsed?: TreeNode;
  datiTabella: any;
  tariffaVoci?: any[];
  formTabella?: FormGroup;
  formTariffa?: FormGroup;
  unitaMisura: any;
  codiciIva: any;
  modalRef?: NgbModalRef;
  risultatoSimulazione = 0;
  risultatoSimulazioneStorico = 0;
  datiTabellaStorico: any[] = [];
  inputDataDa = '';
  inputDataA = '';

  private _voceSelezionata?: ATreeNodeComponent;
  private _voceSelModifica?: ATreeNodeComponent;
  private _isNewNode?: boolean;
  private _pendingRow?: FormGroup;
  private _loadingVociTariffa = false;
  private _circularValue = 0;
  private _idTariffa?: any;
  private _infoTariffa?: any;
  private _seeTable: boolean = false;
  private _expandedNodes: any[] = [];
  private _noValidi: any[] = [];
  private _datiEsportazione?: any;
  private _headerModaleTariffa?: string;
  private modificabile: boolean = false;
  private isAsl: boolean = false; //flag se sapere se sono a livello asl o regione
  public canModifyCurrentNode: boolean = false;

  @ViewChild(ATreeComponent) tree?: ATreeComponent;
  @ViewChild('templateFormTariffa') templateFormTariffa!: TemplateRef<any>;

  @ViewChild('exportFilenameModalTemplate') exportFilenameModalTemplate!: TemplateRef<any>;
  filenameControl = this.fb.control('', Validators.required);
  exportFilenameModalRef?: NgbModalRef;

  constructor(
    private gs: GestioneAttivitaService,
    private fb: FormBuilder,
    private loadingService: LoadingDialogService,
    private modalEngine: NgbModal,
    private contextMenuService: ContextMenuService,
    private notificationService: NotificationService,
    private as: AppService
  ) { };

  ngOnInit(): void {
    this._initTariffario();
    this.as.getUser().subscribe((res: any) => {
      this.isAsl = res?.idAsl > 0;
      console.log("isAsl", this.isAsl);
    })
  }

  /**
   *
   * @param selNode Nodo selezionato con il tasto destro
   *
   * Apre la tendina per la tendina per modificare o eliminare la
   * tariffa e recuperare le informazioni relative alla tariffa.
   */
  apriModaleTariffa(selNode: ATreeNodeComponent, newNode: boolean) {
    console.log("selNode:", selNode);
    this._voceSelModifica = selNode;
    this._isNewNode = newNode;
    let idTariffa = newNode ? undefined : selNode?.id;
    // let idTariffa = selNode?.isLeafNode() ? selNode?.id : undefined;
    this.gs.getTariffa(idTariffa).subscribe((res) => {
      let tariffa = res.info.tariffa ?? {};
      /*
      tariffa.id_parent = selNode?.isLeafNode()
      ? selNode?.data.id_node_parent
      : selNode?.id;
      */
      if (newNode) tariffa.id_parent = selNode?.id;
      console.log("tariffa:", tariffa);
      this.unitaMisura = res.info.unita_misura;
      this.codiciIva = res.info.codici_iva;
      this._initFormTariffa(tariffa);
      this.modalRef = this.modalEngine.open(this.templateFormTariffa, {
        centered: true,
        modalDialogClass: 'xl',
        animation: true,
      });
    });
  }

  // Salva la tariffa
  salvaTariffa() {
    console.log("this.formTariffa:", this.formTariffa);
    console.log("this.formTariffa.value:", this.formTariffa?.value);

    if (this.formTariffa && this.formTariffa.valid) {
      console.log("this.validoDa:", this.validoDa);
      console.log("this.validoA:", this.validoA);

      // Check dates solo se ci sono entrambe
      if (this.validoA && this.validoA.length > 0) {
        const data_da = (new Date(this.formTariffa?.get('valido_da_tariffa')?.value)).setHours(0, 0, 0, 0);
        const data_a = (new Date(this.formTariffa?.get('valido_a_tariffa')?.value)).setHours(0, 0, 0, 0);

        console.log("data_a:", data_a);

        if (data_da >= data_a) {
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'La data di inizio periodo deve essere minore della data di fine.'
          });
          return;
        }
      }

      // Controlla se esiste già una tariffa con la stessa sigla
      if (this.checkSigla((this.formTariffa?.get('sigla')?.value).trim(), this.formTariffa?.get('id')?.value)) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: 'Attenzione! Esiste già una tariffa con questa sigla.'
        });
        return;
      }

      // Controlla che almeno uno dei due limiti venga inserito
      /*
      if (this.checkLimiti()) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: 'Attenzione! È necessario inserire almeno uno dei 2 limiti'
        });
        return;
      }
      */

      if (!this.formTariffa.value.visibile_fatt)
        this.formTariffa.value.descr_in_fatt = '';

      // Salva gli elementi dell'albero aperti
      this._saveExpanded();

      // Prima di richiamare la funzione per caricare i dati
      // converti le stringhe vuote in null
      for (const key of Object.keys(this.formTariffa.controls)) {
        if (
          typeof this.formTariffa.get(key)?.value === 'string' &&
          this.formTariffa.get(key)?.value.trim() === ''
        ) {
          this.formTariffa.get(key)?.setValue(null);
        }
      }

      // this._voceSelModifica?.isLeafNode()
      if (!this._isNewNode) {
        console.log(this.formTariffa.value);
        // Modifica Tariffa
        this.gs.updTariffa(this.formTariffa?.value).subscribe((res) => {
          if (res.esito) {
            this._initTariffario();
            this.modalRef?.close();
            this.gs.getTariffa(this.voceSelezionata?.id).subscribe((res: any) => {
              console.log("res Tariffa:", res);
              this._infoTariffa = res;
            });
          }
        });
      } else {
        // Nuova Tariffa
        this.gs.insTariffa(this.formTariffa.value).subscribe((res) => {
          if (res.esito) {
            this._initTariffario();
            this.modalRef?.close();
          }
        });
      }
    }
  }

  /**
   *
   * @param node Nodo selezionato nell'albero
   *
   * Seleziona la tariffa all'interno dell'albero. Se la tariffa è un
   * nodo foglia dell'albero allora recupera le tabelle della tariffa.
   * In particolare sia la tabella modificabile che lo storico.
   */
  selezionaVoce(node: ATreeNodeComponent) {
    this.contextMenuService.closeMenu();
    if (!node.isLeafNode()) return;

    // Resetta le strutture
    this.datiTabella = null;
    this.datiTabellaStorico = [];
    this.formTabella?.reset();
    this.inputDataDa = '';
    this._seeTable = false;

    // Considera il nuovo nodo
    this.voceSelezionata = node;
    this._loadingVociTariffa = true;
    this.gs.getTariffaVoci(+this.voceSelezionata.id!).subscribe((res) => {
      console.log("res Tariffa Voci:", res);

      this._loadingVociTariffa = false;

      // Setting datiTabella
      if (res.info != true) { this.fillVars(res.info); }

      this._initFormTabella();
      this.risultatoSimulazione = 0;
      this.risultatoSimulazioneStorico = 0;
    });

    this.gs.getTariffa(+this.voceSelezionata.id!).subscribe((res: any) => {
      console.log("res Tariffa:", res);
      this._infoTariffa = res;
      this.canModifyCurrentNode = false;
      if(res?.info.tariffa.livello_asl && this.isAsl && res?.info.tariffa.valida == true)
        this.canModifyCurrentNode = true;
      else if(!res?.info.tariffa.livello_asl && !this.isAsl && res?.info.tariffa.valida == true)
        this.canModifyCurrentNode = true;
    });
  }

  /**
   * Aggiunge una riga alla tabella relativa ad una tariffa.
   */
  aggiungiVoceTariffa() {
    let array = this.formTabella?.get('dati') as FormArray;
    let prev = array.at(-1);

    /**
     * Se l'ultima riga non ha campi valorizzati o tutti i valori
     * sono uguali a 0 allora non dare la possibilità di aggiungere
     * una nuova riga.
     */
    if (prev.value.valori.every((elem: any) => elem === 0 || elem === null)) {
      this.notificationService.push({
        notificationClass: 'info',
        content: 'La riga attuale non ha campi valorizzati.'
      });
      return;
    }

    //setto il valore 'upp' dell'ultima riga uguale al suo valore 'inf' + 1
    prev.get('upp')?.setValue(prev.get('inf')?.value + 1);
    prev.updateValueAndValidity();
    array.push(
      this.fb.group({
        id: '',
        ordine: array.length,
        inf: prev.get('upp')?.value || null,
        inf_incl: true,
        upp: null,
        upp_incl: false,
        valori: this.fb.array([0, 0, 0, 0]),
      })
    );

    /*
    this._pendingRow = this.fb.group({
      id: '',
      ordine: array.length,
      inf: prev.get('upp')?.value || null,
      inf_incl: true,
      upp: null,
      upp_incl: false,
      valori: this.fb.array([0, 0, 0, 0]),
    })
    */

    this.formTabella?.updateValueAndValidity();
  }

  /*
  salvaPendingVoceTariffa() {
    if (!this.pendingRow) return true;
    if (this.pendingRow?.value.valori.every((elem: any) => elem === 0 || elem === null)) {
      this.notificationService.push({
        content: 'La riga da aggiungere deve contenere almeno un valore.',
        notificationClass: 'info'
      });
      return false;
    }
    let array = this.formTabella?.get('dati') as FormArray;
    array.push(this.pendingRow);
    this._pendingRow = un ined;
    this.formTabella?.updateValueAndValidity();
    return true;
  }
  */

  eliminaVoceTariffa(index?: number) {
    let array = this.formTabella?.get('dati') as FormArray;
    if (index) {
      let prev = array.at(index - 1);
      let next = array.at(index + 1) ?? this.pendingRow;
      //se !next vuol dire che siamo all'ultimo FormControl e quindi il valore 'upp'
      //di quello precedente va settato a null
      if (!next) prev.get('upp')?.setValue(null);
      //ci troviamo in mezzo al FormArray, quindi next.inf = prev.upp
      else next.get('inf')?.setValue(prev.get('upp')?.value);
      array.removeAt(index);
    }
    else if (this.pendingRow) {
      //rimuovo la pendingRow e setto a null il valore 'upp' dell'ultimo FormControl dell'array
      this._pendingRow = undefined;
      array.at(-1)?.get('upp')?.setValue(null);
    }
    this.formTabella?.updateValueAndValidity();
  }

  salvaVociTariffa() {
    console.log("this.formTabella?.get('dati')?.value:", this.formTabella?.get('dati')?.value);
    // console.log("this.pendingRow.value:", this.pendingRow?.value);
    // console.log("this.datiTabellaStorico:", this.datiTabellaStorico);
    this.inputDataDa = (<HTMLInputElement>document.getElementById('inputDa')).value;

    let dateFInputDataDa = new Date(this.inputDataDa)?.setHours(0, 0, 0, 0);
    let dateFValidoDa = new Date(this._infoTariffa.info.tariffa.valido_da_tariffa)?.setHours(0, 0, 0, 0);
    let dateFValidoA = new Date(this._infoTariffa.info.tariffa.valido_a_tariffa)?.setHours(0, 0, 0, 0);

    if (this.inputDataDa.trim() === "") {
      this.notificationService.push({
        content: 'Inserisci una data',
        notificationClass: 'info'
      });
      return;
    }

    /**
     * Controlla che la data inserita in tabella sia compresa nel
     * range della tariffa.
     */
    if (dateFInputDataDa < dateFValidoDa || (dateFValidoA > 0 && dateFInputDataDa > dateFValidoA)) {
      this.notificationService.push({
        content: 'Attenzione! La data inserita non è compresa nel periodo della tariffa.',
        notificationClass: 'error'
      });
      return;
    }

    const validoDaStorico = new Date(this.datiTabellaStorico[0]?.da?.trim())?.setHours(0, 0, 0, 0);
    const validoAStorico = new Date(this.datiTabellaStorico[0]?.a?.trim())?.setHours(0, 0, 0, 0);

    // Controlla che la data inserita sia almeno maggiore di un giorno
    // rispetto alla data inserita nell'ultima voce
    // Considerare il caso che l'ultima voce abbia la data di fine
    if (
      this.datiTabellaStorico?.length > 0 && (dateFInputDataDa <= validoAStorico || dateFInputDataDa <= validoDaStorico)
    ) {
      this.notificationService.push({
        content: "La data inserita deve essere maggiore della data dell'ultima configurazione.",
        notificationClass: 'info'
      });
      return;
    }

    console.log("this.formTabella:", this.formTabella);

    if (!this.formTabella) throw new Error('Errore Form Tabella');

    // Controlla che siano state valorizzate tutte le righe
    let noValue: boolean = false;
    this.formTabella?.get('dati')?.value.forEach((val: any) => {
      if (val.valori.every((elem: any) => elem === 0 || elem === null)) {
        this.notificationService.push({
          content: 'Bisogna inserire almeno un valore nella riga.',
          notificationClass: 'info'
        });
        noValue = true;
      }
    });
    if (noValue) return;

    /*
    if (this.formTabella?.get('dati')?.value[0].valori.every((elem: any) => elem === 0 || elem === null)) {
      this.notificationService.push({
        content: 'Bisogna inserire almeno un valore nella riga.',
        notificationClass: 'info'
      });
      return;
    }
    */

    // if (!this.salvaPendingVoceTariffa()) return;

    //fix dell'ordine dei controlli prima di salvare perchè modificando le voci il loro
    //ordine viene alterato
    (this.formTabella.get('dati') as FormArray).controls.forEach((c, i) => {
      c.get('ordine')?.setValue(i);
    })

    this.gs.updTariffaVoci(
      // this.formTabella.get('id_tariffa')!.value,
      this._voceSelezionata?.id!,
      this.formTabella.get('dati')!.value,
      this.inputDataDa,
      this.datiTabella?.id_tariffa_struttura ?? null,
    ).subscribe(res => {
      if (res.esito) {
        this.resetTable();
        if (!this.voceSelezionata) return;
        setTimeout(() => {
          this.gs.getTariffaVoci(this._voceSelezionata?.id!).subscribe((resGet) => {
            console.log("resGet:", resGet);
            if (!resGet.info) return;
            this.fillVars(resGet.info);
          });
        }, 100);
      }
    });
  }

  simulaCosto(quantita: number) {
    if (!this.formTabella) throw new Error('Errore Form Tabella');

    let dati: any = JSON.parse(JSON.stringify(this.formTabella.get('dati')?.value));
    if (this._pendingRow?.value) dati.push(this._pendingRow?.value);

    this.gs
      .getCostoSimulato(quantita, {
        id_tariffa: this.formTabella.get('id_tariffa')!.value,
        // dati: this.formTabella.get('dati')!.value,
        dati: dati,
      })
      .subscribe((res) => {
        console.log("res:", res);
        this.risultatoSimulazione = res.info.valore;
      });
  }

  // Simula il costo della tabella attuale dello storico
  simulaCostoStorico(quantita: number) {
    if (!this.getCurrentTable()) throw new Error('Errore form Tabella Storico');

    // Recupera dati dalla tabella corrente
    let dati: any = JSON.parse(JSON.stringify(this.getCurrentTable().dati));
    this.gs.getCostoSimulato(quantita, {
      id_tariffa: this.formTabella?.get('id_tariffa')!.value,
      dati: dati
    }).subscribe((res: any) => {
      console.log("res:", res);
      this.risultatoSimulazioneStorico = res.info.valore;
    });
  }

  // Elimina una voce della tabella
  deleteTariffaVoci(): void {
    this.gs.delTariffaVoci(this.getCurrentTable()?.id_tariffa_struttura).subscribe((res: any) => {
      console.log("res:", res);
      if (res.esito) {
        if (this._seeTable) this.resetTable();
        if (!this.voceSelezionata) return;
        this.gs.getTariffaVoci(+this._voceSelezionata?.id!).subscribe((resGet) => {
          console.log("resGet:", resGet);
          if (resGet.esito === true && resGet.info === true) {
            this.datiTabellaStorico = [];
            this.datiTabella = undefined;
            return;
          };
          this.fillVars(resGet.info);
        });
      }
    });
  }

  onInfValueChange(value: number, index: number) {
    let datiArray = this.formTabella?.get('dati') as FormArray;
    let prev = datiArray.at(index - 1);
    prev.get('upp')?.patchValue(value);
  }

  onUppValueChange(value: number, index: number) {
    let datiArray = this.formTabella?.get('dati') as FormArray;
    let next = datiArray.at(index + 1) ?? this.pendingRow;
    if (next) next.get('inf')?.patchValue(value);
  }

  /**
   *
   * @returns Tabella storica attuale.
   *
   * Tra le tabelle storiche ritorna l'attuale tabella.
   */
  getCurrentTable(): any {
    return this.datiTabellaStorico[Math.abs(this._circularValue) % this.datiTabellaStorico.length];
  }

  // Visualizza tabella storica precedente.
  goBack(): void { this._circularValue--; this.risultatoSimulazioneStorico = 0 }

  // Visualizza tabella storica successiva.
  goAhead(): void { this._circularValue++;; this.risultatoSimulazioneStorico = 0 }

  // Al click mostra o nasconde la tabella di input per i dati.
  showTable(): void {
    this._seeTable = !this._seeTable;
    if (this._seeTable === false) { this.resetTable(); }
  }

  openExportFilenameModal() {
    this.filenameControl.reset();
    this.exportFilenameModalRef = this.modalEngine.open(this.exportFilenameModalTemplate, {
      modalDialogClass: 'system-modal', centered: true
    });
  }

  closeExportFilenameModal() { this.exportFilenameModalRef?.close(); }

  // Recupera i dati del tariffario ed esporta l'Excel
  exportTariffario(): void {
    this._datiEsportazione = null;
    this.loadingService.openDialog('Esportazione in corso...');
    this.gs.getTariffeExport().subscribe((res: any) => {
      this.loadingService.closeDialog();
      console.log("res:", res);
      if (!res.esito) return;
      this._datiEsportazione = res.info;
      this._datiEsportazione.intestazione = 'Prova';

      // Modifica la formazione dei dati
      let arrDati: any[] = [];
      this._datiEsportazione.dati.forEach((item: any) => {
        arrDati.push(Object.values(item));
      });
      console.log("arrDati:", arrDati);
      this._datiEsportazione.dati = arrDati;

      console.log("this._datiEsportazione:", this._datiEsportazione);

      if (Array.isArray(this._datiEsportazione) == false) {
        this._datiEsportazione = [this._datiEsportazione];
      }

      console.log("this._datiEsportazione:", this._datiEsportazione);
      console.log("this.filenameControl.value:", this.filenameControl.value);
      Utils.exportXlsxWithSheetJs(this._datiEsportazione, this.filenameControl.value!);
      this.modalEngine.dismissAll();
    })
  }

  // Inizializza le variabili
  private fillVars(info: any): void {
    if (info === true || !info) return;

    console.log("info:", info);
    this.tariffaVoci = info.tariffa_voci ?? undefined;
    this._idTariffa = info.id_tariffa ?? undefined;

    this.datiTabella = undefined;
    this.datiTabellaStorico = [];
    if ('lista' in info) {
      // Inizializza dati tabella
      this.datiTabella = info.lista.filter((tabella: any) => { return tabella.attiva === true })[0];
      this.datiTabella?.dati.sort((a: any, b: any) => a.ordine - b.ordine);

      // Inizializza Dati Storico
      this.datiTabellaStorico = info.lista;
      this.datiTabellaStorico?.forEach((storico: any) => {
        storico.dati.sort((a: any, b: any) => a.ordine - b.ordine);
      });
    }

    console.log("this.tariffaVoci:", this.tariffaVoci);
    console.log("this._idTariffa:", this._idTariffa);
    console.log("this.datiTabella:", this.datiTabella);
    console.log("this.datiTabellaStorico:", this.datiTabellaStorico);
  }

  // Resetta la tabella per le voci
  private resetTable(): void {
    this.formTabella?.reset();
    let array = this.formTabella?.get('dati') as FormArray;
    while (array?.length > 1) array.removeAt(-1);
    if (this._pendingRow) {
      this._pendingRow = undefined;
      array.at(-1)?.get('upp')?.setValue(null);
    }
    this._initFormTabella();
    this.formTabella?.updateValueAndValidity();
    this.risultatoSimulazione = 0;
    this.inputDataDa = '';
    if (<HTMLInputElement>document.querySelector('#inputDa'))
      (<HTMLInputElement>document.querySelector('#inputDa')).value = '';
    if (<HTMLInputElement>document.querySelector('#simulazione'))
      (<HTMLInputElement>document.querySelector('#simulazione')).value = '';
  }

  private _initTariffario() {
    this.gs.getTariffario().subscribe((res) => {
      this.modificabile = res.info.modificabile;
      console.log("modificabile: ", this.modificabile);
      this.tariffario = res.info.tariffario;
      console.log("tariffario: ", this.tariffario);
      this.tariffarioParsed = toTree(this.tariffario, node => {
        node.expanded = node.parent == null ? true : false;
        return node;
      }).root;

      // Recupera le tariffe non più valide
      this._noValidi = this.tariffario.filter((tar: any) => tar.valida === false);
      const id_no_validi = this._noValidi.map((noVal: any) => noVal.id);

      // Attendi il rendering dell'albero
      setTimeout(() => {
        this._initTreeContextMenu();
        stretchToWindow(document.getElementById('tariffario-main-content')!);

        // Aggiungi l'effetto barrato al testo se non è valida
        this.tree?.nodes?.forEach((node: ATreeNodeComponent) => {
          if (id_no_validi.includes(node.id)) {
            node.htmlElement.style.textDecoration = 'line-through';
          }
        })

        if (this._expandedNodes.length > 0) {
          this.tree?.nodes?.forEach((node: ATreeNodeComponent) => {
            if (this._expandedNodes.includes(node.name)) node.expand();
            if (this._voceSelezionata && node.name === this._voceSelezionata.name) { this.voceSelezionata = node; }
          });
        }
      }, 0);
    });
  }

  private _initTreeContextMenu() {
    if(!this.modificabile)
      return;
    this.tree?.nodes?.forEach((node) => {
      if (node.isLeafNode()) {
        //Se la tariffa presente al nodo dell'albero e' cancellabile
        if (node.data.cancellabile) {
          //adding context menu
          this.contextMenuService.assignContextMenu(node.htmlElement, [
            {
              label: 'Modifica Tariffa',
              action: () => {
                this._headerModaleTariffa = 'Modifica Tariffa';
                this.apriModaleTariffa(node, false);
              },
            },
            {
              label: 'Elimina Tariffa',
              action: (node: ATreeNodeComponent) => {
                Swal.fire({
                  title: "Eliminare tariffa selezionata?",
                  icon: "warning",
                  showConfirmButton: true,
                  confirmButtonText: "Conferma",
                  showDenyButton: true,
                  denyButtonText: "Annulla"
                }).then((res) => {
                  if (res.isConfirmed) {
                    this.gs.delTariffa(node.id!).subscribe((res) => {
                      if (res.esito) {
                        // Effettua reset e nascondi le tabelle
                        // node.remove();
                        this.resetTable();
                        this.voceSelezionata = undefined;
                        this.datiTabella = undefined;
                        this.datiTabellaStorico = [];
                        this._seeTable = false;
                        this._initTariffario();
                      }
                    });
                  }
                });
              },
              context: node,
            },
            {
              label: 'Nuova Tariffa',
              action: () => {
                this._headerModaleTariffa = 'Nuova Tariffa';
                this.apriModaleTariffa(node, true);
              },
            }
          ]);
        }
        //se la tariffa presente al nodo dell'albero non e' cancellabile
        else {
          this.contextMenuService.assignContextMenu(node.htmlElement, [
            {
              label: 'Modifica Tariffa',
              action: () => {
                this._headerModaleTariffa = 'Modifica Tariffa';
                this.apriModaleTariffa(node, false);
              },
            },
            {
              label: 'Nuova Tariffa',
              action: () => {
                this._headerModaleTariffa = 'Nuova Tariffa';
                this.apriModaleTariffa(node, true);
              },
            },
          ]);
        }
      }
      else {
        //is a parent node
        this.contextMenuService.assignContextMenu(node.htmlElement, [
          {
            label: 'Modifica Tariffa',
            action: () => {
              this._headerModaleTariffa = 'Modifica Tariffa';
              this.apriModaleTariffa(node, false);
            },
          },
          {
            label: 'Nuova Tariffa',
            action: () => {
              this._headerModaleTariffa = 'Nuova Tariffa';
              this.apriModaleTariffa(node, true);
            },
          },
        ]);
      }
    });
  }

  private _initFormTabella() {
    this._pendingRow = undefined; // Resetta pendingRow

    // Inizializza Array
    let datiArray = this.fb.array<FormGroup>([]);
    let idTariffa: any;

    console.log("datiTabella:", this.datiTabella);

    datiArray.push(
      this.fb.group({
        id: null,
        ordine: 0,
        inf: 0,
        inf_incl: true,
        upp: null,
        upp_incl: null,
        valori: this.fb.array([0, 0, 0, 0]),
      })
    );
    idTariffa = this._idTariffa ?? this.voceSelezionata?.id;

    console.log("datiArray:", datiArray);

    this.formTabella = this.fb.group({
      dati: datiArray,
      id_tariffa: idTariffa,
    });
    console.log('--- formTabella', this.formTabella);
  }

  // Inizializza la form della Tariffa
  private _initFormTariffa(data: any) {
    console.log("data:", data);
    this.formTariffa = this.fb.group({
      id: data?.id_tariffa ?? null,
      id_tariffario: data?.id_tariffario ?? 1,
      id_parent: data?.id_parent,
      sigla: [data?.sigla_tariffa ?? '', Validators.required],
      descr: [data?.descr_tariffa ?? '', Validators.required],
      id_u_mis: [data?.id_u_mis ?? null, Validators.required],
      unita_misura: '',
      cod_iva: [data?.cod_iva ?? null, Validators.required],
      ordinamento: [data?.ordinamento ?? null, [Validators.required, Validators.min(0)]],
      descr_in_fatt: data?.descr_in_fatt ?? '',
      limite_inf: data?.limite_inf ?? null,
      limite_sup: data?.limite_sup ?? null,
      nota: data?.nota ?? null,
      visibile_trf: data?.visibile_trf ?? false,
      visibile_fatt: data?.visibile_fatt ?? false,
      visibile_piani: data?.visibile_piani ?? false,
      visibile_contabilita: data?.visibile_contabilita ?? false,
      livello_asl: data?.livello_asl ?? false,
      valido_da_tariffa: [(data?.valido_da_tariffa as string)?.split('T')[0] ?? this.tomorrow, Validators.required],
      valido_a_tariffa: [(data?.valido_a_tariffa as string)?.split('T')[0] ?? null]
    });
  }

  // Memorizza i nodi che sono aperti nell'albero
  private _saveExpanded(): void {
    this._expandedNodes = [];
    this.tree?.nodes?.forEach((node: ATreeNodeComponent) => {
      if (node.expanded) { this._expandedNodes.push(node.name); }
    });
  }

  // Check Tariffa con la stessa Sigla
  private checkSigla(sigla: string, id: number): boolean {
    let double: boolean = false;
    this.tariffario.forEach((tariffa: any) => {
      if (double) return;
      let sigla_tariffa: string | undefined = undefined;
      sigla_tariffa = tariffa.descrizione == tariffa.descrizione_breve ?
        tariffa.descrizione : tariffa.descrizione.split(' - ')[0].trim();

      if (id != tariffa.id && sigla === sigla_tariffa) { double = true; }
    });
    return double;
  }

  private checkLimiti(): boolean {
    if (this.formTariffa?.get('limite_inf')?.value == null && this.formTariffa?.get('limite_sup')?.value == null) {
      return true;
    } else return false;
  }

  // Converte la stringa in una data senza orario
  private myDate(_date: string): number {
    return new Date(_date).setHours(0, 0, 0, 0);
  }

  checkTypeNumber(evt: any): void {
    console.log("evt:", evt);
    const id: string = evt.target.attributes.id.value;
    const valueAsNumber: number = evt.target.valueAsNumber;
    let DOMElem: HTMLInputElement = <HTMLInputElement>document.querySelector(`#${id}`);
    console.log("valueAsNumber:", valueAsNumber);

    if (valueAsNumber < 0 || Number.isNaN(valueAsNumber)) {
      evt.target.value = null;
      DOMElem.value = 'null';
      DOMElem.dispatchEvent(new Event('input'));
    }

    console.log(this.formTariffa?.value);
  }

  /**
   * Controlla che la data inserita rientra nel range [min, max]. Nel caso non
   * dovesse rientrare allora viene reimpostata quella minima, ma è possibile
   * impostare qualsiasi altra data.
   *
   * @param evt Evento che scatta
   */
  onBlur(evt: any): void {
    console.log("evt:", evt);

    // Recupera le info
    const id = evt.target.attributes.id.value;
    let DOMElem: HTMLInputElement = <HTMLInputElement>document.querySelector(`#${id}`);

    // Controlla che la stringa sia vuota
    if ((evt.target.value as string).length === 0) {
      evt.target.value = '';
      DOMElem.value = '';
    } else {
      // Controlla se l'anno inserito sia maggiore dell'anno massimo indicato
      const year = parseInt((evt.target.value as string).split('-')[0]);
      const yearMax = parseInt((evt.target.max as string).split('-')[0]);
      if (year && year > yearMax) {
        evt.target.value = evt.target.max;
        DOMElem.value = evt.target.max;
      }

      if (evt.target.min.trim() != '' && evt.target.value < evt.target.min) {
        // Caso data inserita minore della data minima
        evt.target.value = evt.target.min;
        DOMElem.value = evt.target.min;
      } else if (evt.target.max.trim() != '' && evt.target.value > evt.target.max) {
        // Caso data inserita maggiore della data massima
        evt.target.value = evt.target.max;
        DOMElem.value = evt.target.max;
      }
    }

    DOMElem.dispatchEvent(new Event('input'));
  }

  /********************************* ACCESSORS ********************************/
  get formTariffaControls() { return this.formTariffa!.controls; }
  get voceSelezionata() { return this._voceSelezionata; }
  get voceSelModifica() { return this._voceSelModifica; }

  private set voceSelezionata(value) {
    this._voceSelezionata?.htmlElement.classList.remove('selected');
    this._voceSelezionata = value;
    this._voceSelezionata?.htmlElement.classList.add('selected');
  }

  get loadingVociTariffa() { return this._loadingVociTariffa; }
  get pendingRow() { return this._pendingRow; }
  get seeTable() { return this._seeTable; }

  get siglarequired() {
    return this.formTariffa?.controls['sigla'].errors?.['required'];
  }

  get validoDa() { return this.formTariffa?.get('valido_da_tariffa')?.value; }
  get validoA() { return this.formTariffa?.get('valido_a_tariffa')?.value; }

  get currentStorico() { return (Math.abs(this._circularValue) % this.datiTabellaStorico.length) + 1; }
  get isFirst() { return this.currentStorico === 1 ? true : false; }
  get isLast() { return this.currentStorico === this.totaleStorico ? true : false; }
  get totaleStorico() { return this.datiTabellaStorico?.length; }
  get headerModaleTariffa() { return this._headerModaleTariffa; }

  get currentDate() {
    return formatDate(new Date().setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
  }

  get tomorrow() {
    const today = new Date();
    const tomorrow = new Date(today.setDate(today.getDate() + 1));
    return formatDate(tomorrow.setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
  }

  /**
   * Ritorna la data minima per la nuova voce della tariffa. Nel caso esistano
   * già delle voci allora recupera l'ultima voce e prendi la data maggiore. Se
   * invece non esistono voci, allora controlla la data "da" della tariffa.
   */
  get min_valido_da() {
    if (this.datiTabellaStorico.length > 0) {
      // const lastVoice = this.datiTabellaStorico[this.datiTabellaStorico.length - 1];
      const lastVoice = this.lastStoricoVoice;
      let _biggest_date: string = lastVoice.a === null ? lastVoice.da : lastVoice.a;

      const date = new Date(_biggest_date);
      const tomorrow = new Date(date.setDate(date.getDate() + 1));
      return formatDate(tomorrow.setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
    }
    else if (this._infoTariffa.info.tariffa.valido_da_tariffa) {
      const tariffa_valido_da = new Date(this._infoTariffa.info.tariffa.valido_da_tariffa);
      const tomorrow = new Date(tariffa_valido_da.setDate(tariffa_valido_da.getDate() + 1));
      return formatDate(tomorrow.setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
    } else {
      return formatDate(new Date().setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
    };
  }

  get theDayAfterTomorrow() {
    const theDayAfterTomorrow = new Date(new Date().setDate(new Date().getDate() + TWODAYS));
    return formatDate(theDayAfterTomorrow.setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
  }

  // Ritorna la data massima da poter inserire (sono stati scelti 10 anni dopo)
  get maxDate() {
    const threeYearsAfter = new Date(new Date().setDate(new Date().getDate() + TENYEARS));
    return formatDate(threeYearsAfter.setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
  }

  get minValidoA() {
    if (this.validoDa) {
      const minA = new Date(new Date(this.validoDa).setDate(new Date(this.validoDa).getDate() + 30));
      return formatDate(minA.setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
    }
    return null;
  }

  // Controlla che la data "valido da" sia minore della data "valido a" in tariffa
  get checkDates() {
    if (!this.validoDa || !this.validoA) return false;

    return this.myDate(this.validoDa) < this.myDate(this.validoA) ? true : false;
  }

  // Ritorna l'ultima voce inserita nello storico in base all'id
  private get lastStoricoVoice() {
    if (this.datiTabellaStorico.length > 0) {
      const ids = this.datiTabellaStorico.map((obj: any) => parseInt(obj.id_tariffa_struttura));
      const max = Math.max(...ids);
      const obj = this.datiTabellaStorico.find((el: any) => parseInt(el.id_tariffa_struttura) === max);
      return obj;
    }
  }
}
