/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { ATreeComponent, ATreeNodeComponent, BackendCommunicationService, LoadingDialogService, NotificationService, TreeNode, toTree } from '@us/utils';
import * as bootstrap from 'bootstrap'

@Component({
  selector: 'app-dettaglio-stab',
  templateUrl: './dettaglio-stab.component.html',
  styleUrls: ['./dettaglio-stab.component.scss']
})
export class DettaglioStabComponent implements OnInit {
  controllo: any;

  private stabilimento: any
  dataMin: any


  private _id_stabilimento?: any;
  private lineaPrincipale?: any;
  private _tipoLineeParsed?: TreeNode;
  private _selectedNodo?: any;
  private _cod_regionale?: any;
  private _id_stabilimento_sede?: any;
  private _id_stabilimento_figura?: any;
  private _id_linea?: any;
  private _uiSedi?: any;
  private _retDatiSedi?: any;
  private _uiFigure?: any;
  private _retDatiFigure?: any = null;
  private _nomeStab?: any
  private _ragsocStab?: any;
  private _uiLinee?: any;
  private _retDatiLinee?: any;
  private _uiProg?: any;
  private _retDatiProg?: any;
  private _uiEff?: any;
  private _retDatiEff?: any;
  private _uiProvv?: any;
  private _retDatiProvv?: any;
  private _tipiSedi: any;
  private _tipiFigure: any;
  private _tipiImprese: any;
  private _data_inizio_validita_presa_sedi: any;
  private _data_inizio_validita_presa_figure: any;
  private _data_inizio_validita_presa_linee: any;
  private _modalIndirizzoNuovo?: bootstrap.Modal;
  private _modalSedi?: bootstrap.Modal;
  private _modalFigure?: bootstrap.Modal;
  private _fine_validita_presa: any;
  emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
  public hasLineaPrincipale: boolean = false;
  modaleModificaSedi?: NgbModalRef;
  modaleModificaFigure?: NgbModalRef;
  @ViewChild('lineeTree') lineeTree?: ATreeComponent;
  private _tipoLinee: any;
  public id_indirizzo_nuovo : any;
  @ViewChild('templateModaleModificaFigure') modificaFigureTemplate!: TemplateRef<any>
  @ViewChild('templateModaleModificaSedi') modificaSediTemplate!: TemplateRef<any>
  formSede: FormGroup;
  formFigure: FormGroup;
  formLinea: FormGroup;
  formModificaSedi: FormGroup;
  formEliminaSede: FormGroup;
  formModificaFigure: FormGroup;
  formEliminaFigura: FormGroup;
  formEliminaLinea: FormGroup;
  formVisualizzaSedi: FormGroup;
  modaleVisualizzaSedi?: NgbModalRef;
  @ViewChild('templateModaleVisualizzaSedi') visualizzaSediTemplate!: TemplateRef<any>
  formVisualizzaFigure: FormGroup;
  modaleVisualizzaFigure?: NgbModalRef;
  @ViewChild('templateModaleVisualizzaFigure') visualizzaFigureTemplate!: TemplateRef<any>
  private _arAppFigure: any;
  private _arAppSede: any;
  constructor(private ComunicazioneDB: BackendCommunicationService,
    private LoadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private router: Router,
    private fb: FormBuilder,
    private modalEngine: NgbModal) {
    this.formSede = this.fb.group({
      sede: this.fb.control(null, [Validators.required]),
      piva: this.fb.control(null, [Validators.required]),
      pec: this.fb.control(null, [Validators.required, Validators.pattern(this.emailPattern)]),
      email: this.fb.control(null, [Validators.pattern(this.emailPattern)]),
      sdi: this.fb.control(null, [Validators.required]),
      split_payement: this.fb.control(null, [Validators.required]),
      cf: this.fb.control(null, [Validators.required]),
      cod_tipo_impresa: this.fb.control(null, [Validators.required]),
      data_inizio_validita: this.fb.control(null, [Validators.required]),
    }),
      this.formFigure = this.fb.group({
        figura: this.fb.control(null, [Validators.required]),
        nome: this.fb.control(null, [Validators.required]),
        cognome: this.fb.control(null, [Validators.required]),
        cf: this.fb.control(null, [Validators.required]),
        data_inizio_validita: this.fb.control(null, [Validators.required]),
        // toponimo: this.fb.control(null, [Validators.required]),
        // indirizzo: this.fb.control(null, [Validators.required]),
        // civico: this.fb.control(null, [Validators.required]),
        // comune: this.fb.control(null, [Validators.required]),
      })
    this.formModificaSedi = this.fb.group({
      piva: this.fb.control(null, [Validators.required]),
      pec: this.fb.control(null, [Validators.required, Validators.pattern(this.emailPattern)]),
      email: this.fb.control(null, [Validators.pattern(this.emailPattern)]),
      sdi: this.fb.control(null, [Validators.required]),
      split_payement: this.fb.control(null, [Validators.required]),
      cf: this.fb.control(null, [Validators.required]),
      cod_tipo_impresa: this.fb.control(null, [Validators.required]),
      data_inizio_validita: this.fb.control(null, [Validators.required]),
    }),
      this.formVisualizzaSedi = this.fb.group({
        piva: this.fb.control(null, [Validators.required]),
        pec: this.fb.control(null, [Validators.required]),
        email: this.fb.control(null, [Validators.required]),
        sdi: this.fb.control(null, [Validators.required]),
        split_payement: this.fb.control(null, [Validators.required]),
        cf: this.fb.control(null, [Validators.required]),
        cod_tipo_impresa: this.fb.control(null, [Validators.required]),
      }),
      this.formModificaFigure = this.fb.group({
        data_inizio_validita: this.fb.control(null, [Validators.required]),
      }),
      this.formVisualizzaFigure = this.fb.group({
        figura: this.fb.control(null, [Validators.required]),
        nome: this.fb.control(null, [Validators.required]),
        cognome: this.fb.control(null, [Validators.required]),
        cf: this.fb.control(null, [Validators.required]),
        // toponimo: this.fb.control(null, [Validators.required]),
        // indirizzo: this.fb.control(null, [Validators.required]),
        // civico: this.fb.control(null, [Validators.required]),
        // comune: this.fb.control(null, [Validators.required]),
      })
    this.formEliminaSede = this.fb.group({
      data_fine_validita: this.fb.control(null, [Validators.required]),
    })
    this.formEliminaFigura = this.fb.group({
      data_fine_validita: this.fb.control(null, [Validators.required]),
    })
    this.formEliminaLinea = this.fb.group({
      data_fine_validita: this.fb.control(null, [Validators.required]),
    })
    this.formLinea = this.fb.group({
      valore: this.fb.control(null, [Validators.required]),
      //data_ultima_visita: this.fb.control(null, [Validators.required]),
      data_inizio_validita: this.fb.control(null, [Validators.required]),
    })
  }
  ngOnInit(): void {
    this._modalIndirizzoNuovo = new bootstrap.Modal('#aggiungiIndirizzo');
    this._modalSedi = new bootstrap.Modal('#aggiungiSede');
    this._modalFigure = new bootstrap.Modal('#aggiungiFigure');
    this.route.queryParams.subscribe((res: any) => {
      console.log("dati: ", res['id_stabilimento']);
      this._id_stabilimento = res['id_stabilimento'];
      this._nomeStab = res['nome'];
      this._ragsocStab = res['ragsoc'];
      this._cod_regionale = res['sd_cod_regionale'];
      this._fine_validita_presa = (res['data_fine_validita']).split('T')[0]
    })

    this.ComunicazioneDB.getDati('get_cu_stabilimento_singolo', { id_stabilimento: +this._id_stabilimento }).subscribe((res: any) => {
      if (res.esito) {
        this.stabilimento = res.info.dati[0]
        console.log(this.stabilimento)
        this.dataMin = new Date(this.stabilimento.inizio_validita).toISOString().split('T')[0]
      }
    });




    //----------------------------------------------------------------------------------------
    //Funzione per prendere le sedi dello stabilimento
    this.ComunicazioneDB.getDati('get_cu_stabilimenti_sedi', { id_stabilimento: parseInt(this._id_stabilimento) }).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      // if (!res.info) {
      //   return;
      // }
      console.log("dati sedi", res);
      this._uiSedi = res.info?.ui;
      this._retDatiSedi = res.info?.dati;
      //---------------------------------------------------------------------------------------
      //Funzione per prendere i tipi di sede per lo stabilimento per creare la select per l'inserimento
      this.ComunicazioneDB.getDati('get_cu_tipi_sede').subscribe((res: any) => {
        if (!res.esito) {
          this.LoadingService.closeDialog();
          return;
        }
        // if (!res.info) {
        //   return;
        // }
        console.log("dati tipi sede", res);
        this._tipiSedi = res.info?.dati;
        if (this._retDatiSedi) {
          for (let i = 0; i < this._retDatiSedi.length; i++) {
            if (!this._retDatiSedi[i].fine_validita) {
              this._tipiSedi = this._tipiSedi.filter((elem: any) => elem.sigla !== this._retDatiSedi[i].sigla_tipo_sede);
            }
            //console.log("tipi figure nel ciclo", this._tipiSedi);
          }
        }
        //console.log("tipi sedi dopo rimozione",this._tipiSedi)
      })
    })
    //----------------------------------------------------------------------------------------
    //Funzione per prendere le figure dello stabilimento
    this.ComunicazioneDB.getDati('get_cu_stabilimenti_figure', { id_stabilimento: parseInt(this._id_stabilimento) }).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      // if (!res.info) {
      //   return;
      // }
      console.log("dati figure", res);
      this._uiFigure = res.info?.ui;
      this._retDatiFigure = res.info?.dati;
      //----------------------------------------------------------------------------------------
      this.ComunicazioneDB.getDati('get_cu_tipi_figure').subscribe((res: any) => {
        if (!res.esito) {
          this.LoadingService.closeDialog();
          return;
        }
        // if (!res.info) {
        //   return;
        // }
        console.log("dati tipi figure", res);
        this._tipiFigure = res.info?.dati;
        if (this._retDatiFigure) {
          for (let i = 0; i < this._retDatiFigure.length; i++) {
            if (!this._retDatiFigure[i].fine_validita) {
              this._tipiFigure = this._tipiFigure.filter((elem: any) => elem.sigla !== this._retDatiFigure[i].sigla_tipo_figura);
            }
          }
        }
        //console.log("tipi figure dopo rimozione",this._tipiFigure);
      })
    })
    //Funzione per prendere i tipi di figure per lo stabilimento per creare la select per l'inserimento
    //----------------------------------------------------------------------------------------
    //Funzione per prendere le linee dello stabilimento
    this.ComunicazioneDB.getDati('get_cu_linee_stabilimenti', { id_stabilimento: parseInt(this._id_stabilimento) }).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati linee", res);
      this._uiLinee = res.info.ui;
      this._retDatiLinee = res.info.dati;
      this._retDatiLinee.forEach((l: any) => {
        if (l.linea_principale && !l.fine_validita)
          this.hasLineaPrincipale = true;
      })
    })
    //----------------------------------------------------------------------------------------
    //Funzione per prendere i CU dello stabilimento
    this.ComunicazioneDB.getDati('get_cu_programmati', { id_stabilimento: parseInt(this._id_stabilimento) }).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati CU programmati", res);
      this._uiProg = res.info.ui;
      this._retDatiProg = res.info.dati;
    })
    //----------------------------------------------------------------------------------------
    //Funzione per prendere i provvedimenti sul CU dello stabilimento
    this.ComunicazioneDB.getDati('get_cu_provv_in_corso', { id_stabilimento: parseInt(this._id_stabilimento) }).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati CU provvedimenti in corso", res);
      this._uiProvv = res.info.ui;
      this._retDatiProvv = res.info.dati;
    })
    //----------------------------------------------------------------------------------------
    //Funzione per prendere i provvedimenti sul CU dello stabilimento
    this.ComunicazioneDB.getDati('get_cu_effettuati', { id_stabilimento: parseInt(this._id_stabilimento) }).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati CU effettuati in corso", res);
      this._uiEff = res.info.ui;
      this._retDatiEff = res.info.dati;
    })
    //----------------------------------------------------------------------------------------
    //Funzione per prendere i tipi di imprese per lo stabilimento per creare la select per la modifica
    this.ComunicazioneDB.getDati('get_cu_tipo_imprese').subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati tipo imprese", res);
      this._tipiImprese = res.info.dati;
    })
    //----------------------------------------------------------------------------------------
    //Funzione per prendere i tipi di linee
    this.ComunicazioneDB.getDati('get_cu_tipo_linee',{ id_stabilimento: parseInt(this._id_stabilimento) }).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati tipo linee", res);
      this._tipoLinee = res.info.dati;
      this._tipoLineeParsed = toTree(this._tipoLinee, node => {
        //Serve per vedere se c'è la radice, se si all'inizio della pagina mostra già i nodi foglia.
        node.expanded = node.parent == null ? true : false;
        return node;
      }).root
      //this._tipiImprese = res.info.dati;
    })
  }
  prendiValoreAlbero(nodo: ATreeNodeComponent) {
    console.log("nodo preso: ", nodo.data);
    if (nodo.isLeafNode()) {
      if (this._selectedNodo) this._selectedNodo.htmlElement.classList.remove('selected');
      this._selectedNodo = nodo;
      this._selectedNodo?.htmlElement.classList.add('selected');
    }
  }
  //----------------------------------------------------------------------------------------
  //Funzione upd per l'aggiunta di una sede per uno stabilimento.
  aggiungiSede() {
    if (!this.formSede.valid) {
      return
    }
    const params = {
      id_stabilimento: +this._id_stabilimento,
      sede: +this.formSede.value.sede,
      piva: this.formSede.value.piva,
      pec: this.formSede.value.pec,
      email: this.formSede.value.email,
      sdi: this.formSede.value.sdi,
      split_payement: this.formSede.value.split_payement,
      cf: this.formSede.value.cf,
      cod_tipo_impresa: this.formSede.value.cod_tipo_impresa,
      data_inizio_validita: this.formSede.value.data_inizio_validita,
    }
    //console.log("parametri form sedi: ", params);
    this.ComunicazioneDB.updDati('upd_cu_add_stabilimenti_sedi', params).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati tipi sede", res);
      this.id_indirizzo_nuovo = res.info;
      this._modalSedi?.hide();
     this._modalIndirizzoNuovo?.toggle();
    })
   // setTimeout(() => { window.location.reload(); }, 1500);
  }
  //-------------------------------------------------------------------------------------
  //Funzione upd per l'aggiunta di una figura per uno stabilimento.
  aggiungiFigure() {
    if (!this.formFigure.valid) {
      return
    }
    const params = {
      id_stabilimento: +this._id_stabilimento,
      figura: +this.formFigure.value.figura,
      nome: this.formFigure.value.nome,
      cognome: this.formFigure.value.cognome,
      cf: this.formFigure.value.cf,
      data_inizio_validita: this.formFigure.value.data_inizio_validita,
      // toponimo: this.formFigure.value.toponimo,
      // indirizzo: this.formFigure.value.indirizzo,
      // civico: this.formFigure.value.civico,
      // comune: this.formFigure.value.comune,
    }
    //console.log("parametri form figure: ", params);
    this.ComunicazioneDB.updDati('upd_cu_add_stabilimenti_figure', params).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati tipi figure", res);
      this.id_indirizzo_nuovo = res.info;
      this._modalFigure?.hide();
     this._modalIndirizzoNuovo?.toggle();
    })
  //  setTimeout(() => { window.location.reload(); }, 1500);
  }
  //----------------------------------------------------------------------------------------
  //funzione per aprire le modali
  openModal(content: any, size: string = 'lg') {
    return this.modalEngine.open(content, {
      modalDialogClass: 'modal-fade',
      size: size,
      centered: true
    });
  }
  //----------------------------------------------------------------------------------------
  //funzione che apre la modale per la modifica della sede
  apriModalModificaSedi(ar: any) {
    this.modaleModificaSedi = this.openModal(this.modificaSediTemplate);
    this._arAppSede = ar;
    console.log(ar);
    this.formModificaSedi.setValue({
      piva: ar.piva,
      pec: ar.pec,
      email: ar.email,
      sdi: ar.sdi,
      split_payement: ar.split_payement,
      cf: ar.cf,
      cod_tipo_impresa: ar.cod_tipo_impresa,
      data_inizio_validita:  ar.inizio_validita===null ? "" : (ar.inizio_validita).split('T')[0]
    });
    //this._datoIdPiano = ar.id_cu_piano;
  }
  //----------------------------------------------------------------------------------------
  //Funzione che fa lato db la modifica della sede
  updSede(ar: any) {
    if (!this.formModificaSedi.valid) {
      return
    }
    const params = {
      id_stabilimento: +this._id_stabilimento,
      // id_indirizzo: +ar.id_indirizzo,
      id_stabilimento_sedi: +ar.id_stabilimento_sedi,
      piva: this.formModificaSedi.value.piva,
      pec: this.formModificaSedi.value.pec,
      email: this.formModificaSedi.value.email,
      sdi: this.formModificaSedi.value.sdi,
      split_payement: this.formModificaSedi.value.split_payement,
      cf: this.formModificaSedi.value.cf,
      cod_tipo_impresa: this.formModificaSedi.value.cod_tipo_impresa,
      data_inizio_validita: this.formModificaSedi.value.data_inizio_validita,
      data_fine_validita: ar.fine_validita
    }
    console.log("params: ", params);
    this.ComunicazioneDB.updDati('upd_cu_upd_stabilimenti_sedi', params).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati upd sedi", res);
    })
    setTimeout(() => { window.location.reload(); }, 1500);
  }
  //----------------------------------------------------------------------------------------
  //funzione che apre la modale per la modifica della sede
  apriModalModificaFigure(ar: any) {
    this.modaleModificaFigure = this.openModal(this.modificaFigureTemplate);
    this._arAppFigure = ar;
    console.log(ar);
    this.formModificaFigure.setValue({
      data_inizio_validita:  ar.inizio_validita===null ? "" : (ar.inizio_validita).split('T')[0]
    });
    //this._datoIdPiano = ar.id_cu_piano;
  }
  //----------------------------------------------------------------------------------------
  //Funzione che elimina una sede
  delSede() {
    const params = {
      //id_stabilimento: +ar.id_stabilimento,
      id_stabilimento_sedi: +this._id_stabilimento_sede,
      data_fine_validita: this.formEliminaSede.value.data_fine_validita
      //id_indirizzo: +ar.id_indirizzo
    }
    //console.log("params: ", params);
    if (this._data_inizio_validita_presa_sedi >= this.formEliminaSede.value.data_fine_validita) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: "La data di fine validità deve essere maggiore di quella di inizio validità"
      });
      return;
    }
    this.ComunicazioneDB.updDati('upd_cu_del_stabilimento_sedi', params).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati upd sedi", res);
    })
    setTimeout(() => { window.location.reload(); }, 1500);
  }
  //----------------------------------------------------------------------------------------
  //Funzione che elimina una sede
  delFigura() {
    const params = {
      //id_stabilimento: +ar.id_stabilimento,
      id_stabilimento_figura: +this._id_stabilimento_figura,
      data_fine_validita: this.formEliminaFigura.value.data_fine_validita
      //id_indirizzo: +ar.id_indirizzo
    }
    console.log("params: ", params);
    if (this._data_inizio_validita_presa_figure >= this.formEliminaFigura.value.data_fine_validita) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: "La data di fine validità deve essere maggiore di quella di inizio validità"
      });
      return;
    }
    this.ComunicazioneDB.updDati('upd_cu_del_stabilimento_figure', params).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati upd sedi", res);
    })
    setTimeout(() => { window.location.reload(); }, 1500);
  }
  //--------------------------------------------------------------------------------------------
  apriModalVisualizzaSedi(ar: any) {
    this.modaleVisualizzaSedi = this.openModal(this.visualizzaSediTemplate);
    this.formVisualizzaSedi.setValue({
      piva: ar.piva,
      pec: ar.pec,
      email: ar.email,
      sdi: ar.sdi,
      split_payement: ar.split_payement,
      cf: ar.cf,
      cod_tipo_impresa: ar.cod_tipo_impresa,
    });
    //this._datoIdPiano = ar.id_cu_piano;
  }
  //--------------------------------------------------------------------------------------------
  apriModalVisualizzaFigure(ar: any) {
    this.modaleVisualizzaFigure = this.openModal(this.visualizzaFigureTemplate);
    this.formVisualizzaFigure.setValue({
      figura: ar.sigla_tipo_figura,
      nome: ar.nome,
      cognome: ar.cognome,
      cf: ar.codice_fiscale,
    });
    //this._datoIdPiano = ar.id_cu_piano;
  }
  //Controllo sul codice fiscale e se c'è valorizzazione del nome e cognome per quando si aggiunge la figura
  checkCodiceFiscale(event: any, form: any) {
    //console.log("valore evento:", event.target.value);
    let cfPreso = event.target.value;
    form.controls.nome.setValue("");
    form.controls.cognome.setValue("");
    const params = {
      cf: cfPreso
    }
    this.ComunicazioneDB.getDati('get_cu_soggetti_fisici_by_sel', params).subscribe((res: any) => {
      if (!res.esito) {
        return;
      }
      if (!res.info) {
        this.notificationService.push({
          notificationClass: 'error',
          content: "Codice fiscale inesistente"
        });
        return;
      }

      console.log("res soggetti:", res);
      if (res.info.dati[0].nome || res.info.dati[0].cognome) {
        form.controls.nome.setValue(res.info.dati[0].nome);
        form.controls.cognome.setValue(res.info.dati[0].cognome);
      }
    })
  }
  checkDate(event: any, form: any) {
    const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
    let src = event.srcElement
    let nomeForm = null;
    Object.keys(form.controls).forEach((controlName) => {
      if (controlName === 'data_inizio_validita' || controlName === 'data_fine_validita' || controlName === 'data_ultima_visita') {
        nomeForm = controlName;
      }
    })
    if (!src.validity.valid || !regex.test(src.value)) form.get(nomeForm).setValue("")

    form.updateValueAndValidity()
  }
  getIdSede(ar: any) {
    //console.log("att:",att);
    this._id_stabilimento_sede = ar.id_stabilimento_sedi;
    this._data_inizio_validita_presa_sedi = ar.inizio_validita;
  }
  getIdFigura(ar: any) {
    //console.log("att:",att);
    this._id_stabilimento_figura = ar.id_stabilimento_figura;
    this._data_inizio_validita_presa_figure = ar.inizio_validita;
  }
  getIdLinea(ar: any) {
    //console.log("att:",att);
    this._id_linea = ar.id_linea;
    this._data_inizio_validita_presa_linee = ar.inizio_validita;
  }
  //----------------------------------------------------------------------------------------
  //Funzione che fa lato db la modifica della sede
  updFigure(ar: any) {
    if (!this.formModificaFigure.valid) {
      return
    }
    const params = {
      id_stabilimento_figura: ar.id_stabilimento_figura,
      data_inizio_validita: this.formModificaFigure.value.data_inizio_validita,
    }
    console.log("params: ", params);
    this.ComunicazioneDB.updDati('upd_cu_upd_stabilimenti_figure', params).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati upd figure", res);
    })
    setTimeout(() => { window.location.reload(); }, 1500);
  }
  aggiungiLinea() {
    if (!this._selectedNodo || !this.formLinea) {
      return
    }
    //console.log(this._selectedNodo);
    const params = {
      linea_principale: this.formLinea.value.valore === 'si' ? true : false,
      //data_ultima_visita: this.formLinea.value.data_ultima_visita,
      data_inizio_validita: this.formLinea.value.data_inizio_validita,
      id_tipo_linea: this._selectedNodo.data.id,
      id_stabilimento: +this._id_stabilimento
    }
    //console.log(params);
    //console.log(this._retDatiLinee.filter((linea : any)=>{ return linea.id === params.id_tipo_linea}));
    this.ComunicazioneDB.updDati('upd_cu_add_linea_stabilimenti', params).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati upd linee", res);
    })
    setTimeout(() => { window.location.reload(); }, 1500);
  }
  delLinea() {
    const params = {
      id_linea: this._id_linea,
      data_fine_validita: this.formEliminaLinea.value.data_fine_validita
    }
    //console.log(params);
    if (this._data_inizio_validita_presa_linee >= this.formEliminaLinea.value.data_fine_validita) {
      this.notificationService.push({
        notificationClass: 'warning',
        content: "La data di fine validità deve essere maggiore di quella di inizio validità"
      });
      return;
    }
    this.ComunicazioneDB.updDati('upd_cu_del_linea_stabilimenti', params).subscribe((res: any) => {
      if (!res.esito) {
        this.LoadingService.closeDialog();
        return;
      }
      if (!res.info) {
        return;
      }
      console.log("dati upd linea", res);
    })
    setTimeout(() => { window.location.reload(); }, 1500);
  }
  get uiSedi() { return this._uiSedi };
  get retDatiSedi() { return this._retDatiSedi };
  get uiFigure() { return this._uiFigure };
  get retDatiFigure() { return this._retDatiFigure };
  get uiLinee() { return this._uiLinee };
  get retDatiLinee() { return this._retDatiLinee };
  get uiProvv() { return this._uiProvv };
  get retDatiProvv() { return this._retDatiProvv };
  get uiProg() { return this._uiProg };
  get retDatiProg() { return this._retDatiProg };
  get uiEff() { return this._uiEff };
  get retDatiEff() { return this._retDatiEff };
  get nomeStab() { return this._nomeStab };
  get codRegionale() { return this._cod_regionale };
  get ragsocStab() { return this._ragsocStab };
  get tipiSedi() { return this._tipiSedi; }
  get tipiFigure() { return this._tipiFigure; }
  get tipiImprese() { return this._tipiImprese; }
  get arAppSede() { return this._arAppSede; }
  get arAppFigure() { return this._arAppFigure; }
  get tipoLineeParsed() { return this._tipoLineeParsed; }
  get fine_validita_presa() { return this._fine_validita_presa; }
}
