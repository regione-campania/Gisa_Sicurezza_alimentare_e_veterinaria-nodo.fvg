/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, OnInit, TemplateRef, ViewChild, ViewContainerRef } from '@angular/core';
import { ASmartTableComponent, ATreeComponent, ATreeNodeComponent, BackendCommunicationService, LoadingDialogService, NotificationService, TreeNode, stretchToWindow, toTree } from '@us/utils';
import { Router } from '@angular/router';
import { GestioneAttivitaService } from 'src/app/portals/gestione-attivita/gestione-attivita.service';
import * as bootstrap from 'bootstrap';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { anagraficaUnicaService } from 'src/app/portals/controlli-ufficiali/services/anagraficaUnica.service';
import { AppService } from 'src/app/app.service';
import { SharedService } from 'src/app/shared/shared.service';
import { map } from 'rxjs';
import { NgbModal, NgbModalOptions, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-lista-attivita',
  templateUrl: './lista-attivita.component.html',
  styleUrls: ['./lista-attivita.component.scss']
})
export class ListaAttivitaComponent implements OnInit {

  @ViewChild(ASmartTableComponent) tabella?: ASmartTableComponent;
  attivita?: any;
  disabilitaAnag: boolean = true
  private _tipologia_struttura: any
  private _uiSogg?: any;
  private _retDatiSogg?: any;
  private _uiStab?: any;
  private _retDatiStab?: any;
  private _uiAnag?: any
  private _retDatiAnag?: any;
  private _retDatiAnagTot?: any;
  private _modalAnagrafica?: bootstrap.Modal;
  formRicercaSoggettiFisici: FormGroup;
  formRicercaStabilimento: FormGroup;
  private _attivitaSelezionate: any[] = [];
  private _ui?: any;
  private _tariffario?: any;
  private _voiceSelected?: ATreeNodeComponent;
  private _attivitaSelected?: any;
  private modalTariffario?: bootstrap.Modal;
  private modalTariffarioModifica?: bootstrap.Modal;
  tariffarioParsed?: TreeNode;
  userInfo: any;
  btnModifica: boolean = false;
  private _id_tariffa_preso: any;
  formConfig: any;
  loadingAttivita = false;
  private _ui_attivita?: any;
  private _attivita?: any;

  aggiungiClienteModalRef?: NgbModalRef;
  private modalCliente?: bootstrap.Modal;

  @ViewChild('messaggioNoSogg') messaggioNoSogg!: TemplateRef<any>;
  @ViewChild('messaggioNoStab') messaggioNoStab!: TemplateRef<any>;

  @ViewChild(ATreeComponent) tariffarioTree?: ATreeComponent;

  constructor(
    private client: BackendCommunicationService,
    private notificationService: NotificationService,
    private LoadingService: LoadingDialogService,
    private router: Router,
    private gs: GestioneAttivitaService,
    private changeDetector: ChangeDetectorRef,
    private fb: FormBuilder,
    private aus: anagraficaUnicaService,
    private vref: ViewContainerRef,
    private ComunicazioneDB: BackendCommunicationService,
    private app: AppService,
    private sharedService: SharedService,
    private modalService: NgbModal
  ) {
    this.formRicercaSoggettiFisici = this.fb.group({
      nome: this.fb.control(null, [Validators.required]),
      cognome: this.fb.control(null, [Validators.required]),
      cf: this.fb.control(null, [Validators.required]),
      // comune_nascita: this.fb.control(null, [Validators.required]),
      // data_nascita: this.fb.control(null, [Validators.required]),
      limite: this.fb.control(1000)
    })
    this.formRicercaStabilimento = this.fb.group({
      cod_regionale: this.fb.control(null),
      p_iva: this.fb.control(null),
      comune: this.fb.control(null),
      nome: this.fb.control(null),
      tipologia_struttura: this.fb.control(null),
      limite: this.fb.control(1000),
    })
  }


  ngOnInit(): void {
    this.formConfig = this.sharedService
      .getFormDefinition('cu/', 'sel_lista_attivita')
      .pipe(
        map((res) => {
          let info = JSON.parse(res.info[0]['configurazione']);
          //Costruzione del limite dinamicamente per la data inizio e fine
          let dataCorrente = new Date();
          let annoCorrente = dataCorrente.getFullYear();
          // console.log(info['controls']);
          info['controls'].find((c: any) => c.name == 'periodo').value.start = annoCorrente + '-01-01';
          info['controls'].find((c: any) => c.name == 'periodo').options.start.max = annoCorrente + '-12-31';
          info['controls'].find((c: any) => c.name == 'periodo').options.end.max = annoCorrente + '-12-31';
          return { info: info };
        })
      );
      
    this.modalCliente = new bootstrap.Modal('#aggiungiCliente');

    this.gs.getTipologieStruttura().subscribe((res: any) => {
      if (res.esito) {
        this._tipologia_struttura = res.info.dati
      }
    })
    this._modalAnagrafica = new bootstrap.Modal('#anagraficaAssistiti');
    // recupera info utente
    this.app.getUser().subscribe((res: any) => this.userInfo = res);
    // recupera le attività
    // this.LoadingService.openDialog('Caricamento Dati...');
    // this.client.getDati('get_attivita', { id: 1 }).subscribe(res => {
    //   this.LoadingService.closeDialog();
    //   if (!res.esito) {
    //     this.notificationService.push({
    //       notificationClass: 'warning',
    //       content: 'Non sono presenti dati.'
    //     });
    //     return;
    //   }
    //   this.attivita = res.info.attivita.map((att: any) => {
    //     att.closed = att.closed ? 'Chiusa' : 'Aperta';
    //     return att;
    //   })
    //   res.info.ui.colonne = res.info.ui.colonne.map((col: any) => {
    //     if (col.intestazione == 'Stato') col.tipo = 'selection';
    //     return col;
    //   });
    //   this._ui = res.info.ui;
    // });

    // Recupera tariffario per le attività
    this.client.getDati('get_tariffario_per_attivita').subscribe((res: any) => {
      this._tariffario = res.info;
      this.tariffarioParsed = toTree(this._tariffario, node => {
        node.expanded = node.parent == null ? true : false;
        return node;
      }).root;

      setTimeout(() => {
        stretchToWindow(document.getElementById('tariffario-content')!);
      }, 0);
    });

    // this.modalTariffario = new bootstrap.Modal('#selectTariffa');
    this.modalTariffarioModifica = new bootstrap.Modal('#modificaTariffa');

  }

  ngAfterViewChecked() {
    if ((this.formRicercaSoggettiFisici.value.nome != null && this.formRicercaSoggettiFisici.value.nome != '' && this.formRicercaSoggettiFisici.value.cognome != null && this.formRicercaSoggettiFisici.value.cognome != '')
      || this.formRicercaSoggettiFisici.value.cf != null && this.formRicercaSoggettiFisici.value.cf != '') {
      this.disabilitaAnag = false
    } else {
      this.disabilitaAnag = true
    }
    this.changeDetector.detectChanges()
    this.formRicercaSoggettiFisici.controls['limite'].setValue('1000');
    this.formRicercaStabilimento.controls['limite'].setValue('1000');
  }


  //Ricerca soggetti fisici
  filtraSoggettiFisici() {
    const params = {
      ...this.formRicercaSoggettiFisici.value
    }
    this.LoadingService.openDialog()
    this.vref.clear();
    this.gs.getSoggettiFisici(params).subscribe((res: any) => {
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: res.msg
        });
        this._uiSogg = null;
        this._retDatiSogg = null;
        this.vref.createEmbeddedView(this.messaggioNoSogg);
        this.LoadingService.closeDialog()
        return;
      }
      console.log("dati soggetti fisici per filtro", res);
      this._uiSogg = res.info.ui
      this._retDatiSogg = res.info.dati
      this.LoadingService.closeDialog()
    })
  }

  //Ricerca stabilimenti
  filtraStabilimenti() {
    const params = {
      cod_regionale: this.formRicercaStabilimento.value.cod_regionale,
      p_iva: this.formRicercaStabilimento.value.p_iva,
      comune: this.formRicercaStabilimento.value.comune,
      nome: this.formRicercaStabilimento.value.nome,
      id_tipologia_struttura: this.formRicercaStabilimento.value.tipologia_struttura ? +this.formRicercaStabilimento.value.tipologia_struttura : null,
      limite: this.formRicercaStabilimento.value.limite ? +this.formRicercaStabilimento.value.limite : null,
    }
    console.log(params);
    this.LoadingService.openDialog()
    this.vref.clear();
    console.log("params: ", params);
    this.gs.getStabilimenti(params).subscribe((res: any) => {
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: res.msg
        });
        this._uiStab = null;
        this._retDatiStab = null;
        this.vref.createEmbeddedView(this.messaggioNoStab);
        this.LoadingService.closeDialog()
        return;
      }
      if (res.msg) {
        this.notificationService.push({
          notificationClass: 'success',
          content: res.msg
        });
      }
      console.log("dati stabilimenti per filtro", res);
      this._uiStab = res.info.ui
      this._retDatiStab = res.info.dati
      this.LoadingService.closeDialog()
    })
  }

  selectSogg(ar: any) {
    const params = {
      codice_fiscale: ar.codice_fiscale,
      id_attivita: this._id_tariffa_preso
    }
    this.ComunicazioneDB.updDati('upd_att_id_cliente', params).subscribe((res: any) => {
      console.log("res upd soggetto", res);
    })
    this.modalCliente!.hide();
    setTimeout(() => { this.ngOnInit(); }, 1500);
  }
  selectStab(ar: any) {
    const params = {
      id_stabilimento: ar.id_stabilimento,
      id_attivita: this._id_tariffa_preso
    }
    this.ComunicazioneDB.updDati('upd_att_id_cliente', params).subscribe((res: any) => {
      console.log("res upd stabilimento", res);
    })
    this.modalCliente!.hide();
    setTimeout(() => { this.ngOnInit(); }, 1500);
  }
  // Seleziona una voce del tariffario
  selectVoice(node: ATreeNodeComponent): void {
    if (node.isLeafNode()) this.voiceSelected = node;
  }

  // Vai in scontrino o apri albero quando seleziona un'attività
  onClick(att: any): void {
    //console.log("att:", att);

    // Rimuovi il colore dell'ultimo elemento selezionato
    if (this._attivitaSelected) {
      document.getElementById(this._attivitaSelected.id)!.style.background = '';
    }

    this._attivitaSelected = att;
    if (att.id_tariffa && att.id_cliente) {
      this.router.navigate(["portali/gestione-attivita/lista-attivita/scontrino"], {
        queryParams: {
          id: att.id_trf_attivita,
          tipo: 'id_trf_attivita',
          funzione: 'rilevazione_attivita',
          isClosed: att.closed == 'Chiusa'
        }
      });
    }
    else {
      // this.notificationService.push({
      //   notificationClass: 'warning',
      //   content: 'Inserire prima la tariffa per vedere lo scontrino.'
      // });
      document.getElementById(att.id)!.style.background = 'lightgray';
      return;
    }
    //  else {
    //   this.modalTariffario?.toggle();
    //
    // }
  }
  clickModifica(att: any) {
    // console.log("att modifica: ",att)
    this._attivitaSelected = att;
  }
  getIdTariffa(att: any) {
    //console.log("att:",att);
    this._id_tariffa_preso = att.id_trf_attivita;
  }
  // Aggiorna l'id_tariffa dell'attività
  updateIDTariffa(): void {
    this.modalTariffarioModifica!.toggle();
    // Swal.fire({
    //   title: 'Sei sicuro della scelta?',
    //   showDenyButton: true,
    //   confirmButtonText: 'Si',
    //   denyButtonText: 'No',
    //   allowOutsideClick: false
    // }).then((result: any) => {
    //   if (result.isConfirmed) {
    // console.log("this._attivitaSelected:", this._attivitaSelected);
    // console.log("this._voiceSelected:", this._voiceSelected);
    this.LoadingService.openDialog('Aggiornamento in corso...');
    this.client.updDati('upd_att_id_tariffa', {
      id_tariffa: this._voiceSelected!.id,
      id_attivita: this._attivitaSelected.id
    }).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      console.log("res:", res);
      if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: `Attenzione! Errore durante l'aggiornamento.`
        })
        return;
      }

      this.notificationService.push({
        notificationClass: 'success',
        content: 'Aggiornamento avvenuto con successo!'
      });

      // this.modalTariffario?.hide();
      // Ricarica attività
      this.LoadingService.openDialog('Ricarico attività...');
      this.client.getDati('get_attivita', { id: 1 }).subscribe((_) => {
        this.LoadingService.closeDialog();
        if (!_.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Errore durante il caricamento dei dati.'
          });
          return;
        }
        this.attivita = _.info.attivita;
        this.ngOnInit();
      });
    });
    //   }
    // });
  }

  prendiValoreTariffa(nodo: ATreeNodeComponent) {
    //console.log("nodo preso: ", nodo);
    if (nodo.isLeafNode()) this.voiceSelected = nodo;
  }

  // Chiudi la tariffazione
  chiudiTariffazione(): void {
    this._attivitaSelezionate = [];
    this.tabella?.selectedData.forEach((attivita: any) => {
      //if (attivita.closed == null || attivita.closed == false) this._attivitaSelezionate.push(attivita.id);
      if (attivita.closed == null || attivita.closed == 'Aperta') this._attivitaSelezionate.push(attivita.id);
    });

    if (this._attivitaSelezionate.length != 0) {
      // console.log("this._attivitaSelezionate:", this._attivitaSelezionate);
      this.LoadingService.openDialog('Salvataggio in corso...');
      this.client.updDati('upd_att_close', { id_attivita: this._attivitaSelezionate }).subscribe(res => {
        this.LoadingService.closeDialog();
        console.log("res:", res);
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Attenzione! Errore durante la chiusura della tariffazione.'
          });
          return;
        }
        this.notificationService.push({
          notificationClass: 'success',
          content: 'Salvataggio avvenuto con successo!'
        });

        // Ricarica attività
        this.client.getDati('get_attivita', { id: 1 }).subscribe((_) => {
          if (!_.esito) {
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Errore durante il caricamento dei dati.'
            });
            return;
          }
          this.attivita = _.info.attivita;
        });
      });
    } else {
      this.notificationService.push({
        notificationClass: 'error',
        content: 'Attenzione! Non sono state selezionate attività.'
      });
      return;
    }
  }

  mappingAttivita(data: any) {
    return data;
  }

  openModal(template: any, options?: NgbModalOptions) {
    return this.modalService.open(template, options);
  }

  //Ricerca utilizzando il web service dell'anagrafiche del Friuli
  verificaAnagraficaAssistiti() {
    this.LoadingService.openDialog()
    this._uiAnag = null;
    this._retDatiAnag = null;
    this._retDatiAnagTot = null;
    let params: any;

    //Ricerca per nome e cognome
    if (this.formRicercaSoggettiFisici.get('nome')?.value && this.formRicercaSoggettiFisici.get('cognome')?.value && !this.formRicercaSoggettiFisici.get('cf')?.value) {
      params = {
        nome: this.formRicercaSoggettiFisici.get('nome')?.value,
        cognome: this.formRicercaSoggettiFisici.get('cognome')?.value
      }
    }
    //Ricerca per codice fiscale
    else if (this.formRicercaSoggettiFisici.get('cf')?.value && !this.formRicercaSoggettiFisici.get('nome')?.value && !this.formRicercaSoggettiFisici.get('cognome')?.value) {
      params = {
        cf: this.formRicercaSoggettiFisici.get('cf')?.value
      }
    }
    //Ricerca per nome, cognome e codice fiscale
    else if (this.formRicercaSoggettiFisici.get('nome')?.value && this.formRicercaSoggettiFisici.get('cognome')?.value && this.formRicercaSoggettiFisici.get('cf')?.value) {
      params = {
        cf: this.formRicercaSoggettiFisici.get('cf')?.value,
        nome: this.formRicercaSoggettiFisici.get('nome')?.value,
        cognome: this.formRicercaSoggettiFisici.get('cognome')?.value
      }
    }
    else {
      this.notificationService.push({
        notificationClass: 'warning',
        content: "La ricerca sul sistema regionale deve essere effettuata per nome e cognome oppure per codice fiscale."
      });
      this.LoadingService.closeDialog();
      return;
    }

    this.aus.ricercaAnagrafica(params).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      if (res.CodiceRitorno == "0") {
        this._uiAnag = res.info.ui;
        //Map per estrapolare l'array di oggetti dell'anagrafica
        this._retDatiAnagTot = res.info.dati
        this._retDatiAnag = res.info.dati.map((elem: any) => elem.Anagrafica);
        console.log("dati Anagrafica Tot", this._retDatiAnagTot);
        console.log("dati Anagrafica", this._retDatiAnag);
      }
      else if (res.CodiceRitorno == -1) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: "Persona non presente nell'anagrafica assistita"
        });
        return;
      } else if (!res.esito) {
        this.notificationService.push({
          notificationClass: 'warning',
          content: "Servizio non disponibile."
        });
        return;
      }
      this._modalAnagrafica?.toggle();
    })
  }

  aggiungiAssistito(ar: any) {
    this.LoadingService.openDialog();
    let params = {
      nome: ar.Anagrafica.Nome,
      cognome: ar.Anagrafica.Cognome,
      sesso: ar.Anagrafica.Sesso,
      comune_nascita: ar.Anagrafica.NascitaLuogo.Codice,
      data_nascita: ar.Anagrafica.NascitaData,
      cf: ar.Anagrafica.CodiceFiscale,
      titolo: "",
      pec: "",
      email: "",
      telefono: "",
      telefono2: "",
      documento_identita: "",
      indirizzo: {
        toponimo: ar?.Residenza?.ResidenzaItalia?.LuogoItaliaIndirizzo?.IndirizzoToponimo,
        descrizione: ar?.Residenza?.ResidenzaItalia?.LuogoItaliaIndirizzo?.IndirizzoDescrizione,
        civico: ar?.Residenza?.ResidenzaItalia?.LuogoItaliaIndirizzo?.IndirizzoNumeroCivico,
        codice_catastale: ar?.Residenza?.ResidenzaItalia?.LuogoItaliaComune?.Codice,
        cap: ar?.Residenza?.ResidenzaItalia?.LuogoItaliaCAP
      }
    }
    console.log(params)

    this.ComunicazioneDB.updDati('upd_cu_add_soggetti_fisici_from_service', params).subscribe((res: any) => {
      this.selectSogg({ codice_fiscale: params.cf })
      //this.LoadingService.closeDialog();
    })


  }

  resetModaleCliente() {
    this._uiSogg = null;
    this._retDatiSogg = null;
    this._uiStab = null;
    this._retDatiStab = null;
    this.formRicercaSoggettiFisici.reset();
    this.formRicercaStabilimento.reset();
  }

  ricercaAttivita(params: any) {
    console.log(params);
    this.loadingAttivita = true;
    this._ui_attivita = null;
    this._attivita = null;
    console.log(params);
    this.gs.getAttivitaBySel(params).subscribe((res: any) => {
      this.loadingAttivita = false;
      if (res.info) {
        this._attivita = res.info.dati.map((att: any) => {
          att.closed = att.closed ? 'Chiusa' : 'Aperta';
          return att;
        })
        res.info.ui.colonne = res.info.ui.colonne.map((col: any) => {
          if (col.intestazione == 'Stato') col.tipo = 'selection';
          return col;
        });
        this._ui_attivita = res.info.ui;
      }
    })
  }

  /********************************* ACCESSORS ********************************/

  // getter methods
  get attivitaSelezionate() { return this._attivitaSelezionate; }
  get ui() { return this._ui; }
  get uiSogg() { return this._uiSogg; }
  get retDatiSogg() { return this._retDatiSogg; }
  get uiAnag() { return this._uiAnag; }
  get retDatiStab() { return this._retDatiStab; }
  get uiStab() { return this._uiStab; }
  get retDatiAnag() { return this._retDatiAnag; }
  get retDatiAnagTot() { return this._retDatiAnagTot; }
  get voceSelected() { return this._voiceSelected; }
  get tipologia_struttura() { return this._tipologia_struttura }
  get ui_attivita() { return this._ui_attivita }
  get attivitaSel() { return this._attivita }

  // setter methods
  private set voiceSelected(value: any) {
    this._voiceSelected?.htmlElement.classList.remove('selected');
    this._voiceSelected = value;
    this._voiceSelected?.htmlElement.classList.add('selected');
  }

}
