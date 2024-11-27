/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { ATreeComponent, ATreeNodeComponent, BackendCommunicationService, LoadingDialogService, NotificationService, ContextMenuService, TreeNode, toTree, stretchToWindow } from '@us/utils';
import { ConfigurazioniService } from '../../configurazioni/configurazioni.service';
import { OrganizzazioneService } from '../organizzazione.service';

@Component({
  selector: 'app-strutture-asl',
  templateUrl: './strutture-asl.component.html',
  styleUrls: ['./strutture-asl.component.scss']
})
export class StruttureAslComponent {
  //-------------------------------VARIABILI---------------------------------
  private _asl: any;
  struttureAslTree?: TreeNode;
  private _headerModaleASl?: string;
  private id_asl: any = [];
  formASl?: FormGroup;
  private aslSingolo: any;
  maxInizio: any;
  maxFine: any;
  private _noValidi: any[] = [];

  @ViewChild('struttureAslComponent') aslTree?: ATreeComponent;
  @ViewChild('templateFormAsl') templateFormAsl!: TemplateRef<any>;
  private _voceSelModifica?: ATreeNodeComponent;
  private _isNewNode?: boolean;
  modalRef?: NgbModalRef;
  //------------------------COSTRUTTORE---------------------------------
  constructor(private ComunicazioneDB: BackendCommunicationService,
    private og: OrganizzazioneService, //RICORDARSI CHE LE FUNZIONI GIRANO SOTTO AGENDA
    private LoadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private contextMenuService: ContextMenuService,
    private modalEngine: NgbModal,
    private fb: FormBuilder,
    private router: Router,
  ) {
    this.formASl = this.fb.group({
      descrizione: this.fb.control(null, [Validators.required]),
      descrizione_breve: this.fb.control(null, [Validators.required]),
      data_inizio_validita: this.fb.control(null, [Validators.required]),
      data_fine_validita: this.fb.control(null),
    })
  }
  //---------------------------------NGONINIT----------------------------
  ngOnInit(): void {
    this.og.getStruttureAsl().subscribe((res: any) => {
      this._asl = res.info;
      this.struttureAslTree = toTree(this._asl, node => {
        node.expanded = node.parent == null ? true : false;
        return node;
      }).root;

        this._noValidi = this._asl.filter((asl: any) => asl.fine_validita !== null);
       const id_no_validi = this._noValidi.map((noVal: any) => noVal.id);

      setTimeout(() => {
        this._initTreeContextMenu();
        stretchToWindow(document.getElementById('piani-main-content')!);

        this.aslTree?.nodes?.forEach((node: ATreeNodeComponent) => {
          if (id_no_validi.includes(node.id)) {
            node.htmlElement.style.textDecoration = 'line-through';
          }
        })
      }, 0);
    })
  }
  //---------------------------FUNZIONI----------------------------------------
  //Costruzione del menù quando si clicca il tasto sinistro del mouse sul piano
  private _initTreeContextMenu() {
    this.aslTree?.nodes?.forEach((node) => {
      if (node.isLeafNode()) {
        //Se il piano è presente al nodo dell'albero e' cancellabile
        if (node.data.cancellabile) {
          //adding context menu
          this.contextMenuService.assignContextMenu(node.htmlElement, [
            {
              label: 'Modifica Asl',
              action: () => {
                this._headerModaleASl = 'Modifica Asl';
              },
            },
            {
              label: 'Elimina Asl',
              action: (node: ATreeNodeComponent) => {
                this._headerModaleASl = 'Elimina Asl';
              },
              context: node,
            },
            {
              label: 'Nuova Asl',
              action: () => {
                this._headerModaleASl = 'Nuova Asl';
              },
            }
          ]);
        }
        //se la tariffa presente al nodo dell'albero non e' cancellabile
        else {
          if (node.data.primo) {
            this.contextMenuService.assignContextMenu(node.htmlElement, [
              {
                label: 'Modifica ASL',
                action: () => {
                  this._headerModaleASl = 'Modifica ASL';
                  this.apriModaleAsl(node, false);
                },
              },
              {
                label: 'Nuova ASL',
                action: () => {
                  this._headerModaleASl = 'Nuova ASL';
                  this.apriModaleAsl(node, true);
                },
              },
              // {
              //   label: 'Elimina ASL',
              //   action: (node: ATreeNodeComponent) => {
              //     this.og.updDelAsl({ id_node: node.id! }).subscribe((res: any) => {
              //       if (res.esito) {
              //         this.ngOnInit();
              //       }
              //     })
              //   },
              //   context: node,
              // },
              {
                label: 'Sposta giù',
                action: () => {
                  this.cambiaOrdine(node, false, 'down');
                },
              },
            ])
          }
          else if (node.data.ultimo) {
            this.contextMenuService.assignContextMenu(node.htmlElement, [
              {
                label: 'Modifica ASL',
                action: () => {
                  this._headerModaleASl = 'Modifica ASL';
                  this.apriModaleAsl(node, false);
                },
              },
              {
                label: 'Nuova ASL',
                action: () => {
                  this._headerModaleASl = 'Nuova ASL';
                  this.apriModaleAsl(node, true);
                },
              },
              // {
              //   label: 'Elimina ASL',
              //   action: (node: ATreeNodeComponent) => {
              //     this.og.updDelAsl({ id_node: node.id! }).subscribe((res: any) => {
              //       if (res.esito) {
              //         this.ngOnInit();
              //       }
              //     })
              //   },
              //   context: node,
              // },
              {
                label: 'Sposta su',
                action: () => {
                  this.cambiaOrdine(node, false, 'up');
                },
              },
            ])
          }
          else {
            this.contextMenuService.assignContextMenu(node.htmlElement, [
              {
                label: 'Modifica ASL',
                action: () => {
                  this._headerModaleASl = 'Modifica ASL';
                  this.apriModaleAsl(node, false);
                },
              },
              {
                label: 'Nuova ASL',
                action: () => {
                  this._headerModaleASl = 'Nuova ASL';
                  this.apriModaleAsl(node, true);
                },
              },
              // {
              //   label: 'Elimina ASL',
              //   action: (node: ATreeNodeComponent) => {
              //     this.og.updDelAsl({ id_node: node.id! }).subscribe((res: any) => {
              //       if (res.esito) {
              //         this.ngOnInit();
              //       }
              //     })
              //   },
              //   context: node,
              // },
              {
                label: 'Sposta su',
                action: () => {
                  this.cambiaOrdine(node, false, 'up');
                },
              },
              {
                label: 'Sposta giù',
                action: () => {
                  this.cambiaOrdine(node, false, 'down');
                },
              },
            ])
          }
        }
      }
      else {
        if (node.data.primo) {
          this.contextMenuService.assignContextMenu(node.htmlElement, [
            {
              label: 'Modifica ASL',
              action: () => {
                this._headerModaleASl = 'Modifica ASL';
                this.apriModaleAsl(node, false);
              },
            },
            {
              label: 'Nuova ASL',
              action: () => {
                this._headerModaleASl = 'Nuova ASL';
                this.apriModaleAsl(node, true);
              },
            },
            // {
            //   label: 'Elimina ASL',
            //   action: (node: ATreeNodeComponent) => {
            //     this.og.updDelAsl({ id_node: node.id! }).subscribe((res: any) => {
            //       if (res.esito) {
            //         this.ngOnInit();
            //       }
            //     })
            //   },
            //   context: node,
            // },
            {
              label: 'Sposta giù',
              action: () => {
                this.cambiaOrdine(node, false, 'down');
              },
            },
          ])
        }
        else if (node.data.ultimo) {
          this.contextMenuService.assignContextMenu(node.htmlElement, [
            {
              label: 'Modifica ASL',
              action: () => {
                this._headerModaleASl = 'Modifica ASL';
                this.apriModaleAsl(node, false);
              },
            },
            {
              label: 'Nuova ASL',
              action: () => {
                this._headerModaleASl = 'Nuova ASL';
                this.apriModaleAsl(node, true);
              },
            },
            // {
            //   label: 'Elimina ASL',
            //   action: (node: ATreeNodeComponent) => {
            //     this.og.updDelAsl({ id_node: node.id! }).subscribe((res: any) => {
            //       if (res.esito) {
            //         this.ngOnInit();
            //       }
            //     })
            //   },
            //   context: node,
            // },
            {
              label: 'Sposta su',
              action: () => {
                this.cambiaOrdine(node, false, 'up');
              },
            },
          ])
        }
        else {
          this.contextMenuService.assignContextMenu(node.htmlElement, [
            {
              label: 'Modifica ASL',
              action: () => {
                this._headerModaleASl = 'Modifica ASL';
                this.apriModaleAsl(node, false);
              },
            },
            {
              label: 'Nuova ASL',
              action: () => {
                this._headerModaleASl = 'Nuova ASL';
                this.apriModaleAsl(node, true);
              },
            },
            // {
            //   label: 'Elimina ASL',
            //   action: (node: ATreeNodeComponent) => {
            //     this.og.updDelAsl({ id_node: node.id! }).subscribe((res: any) => {
            //       if (res.esito) {
            //         this.ngOnInit();
            //       }
            //     })
            //   },
            //   context: node,
            // },
            {
              label: 'Sposta su',
              action: () => {
                this.cambiaOrdine(node, false, 'up');
              },
            },
            {
              label: 'Sposta giù',
              action: () => {
                this.cambiaOrdine(node, false, 'down');
              },
            },
          ])
        }
      }
    });
  }

  async apriModaleAsl(selNode: ATreeNodeComponent, newNode: boolean) {
    console.log("selNode:", selNode);
    console.log("livello selNode:", selNode.data.n_livello);
    this._voceSelModifica = selNode;
    this._isNewNode = newNode;
    let idAsl = selNode?.id;
    console.log(idAsl);
    let asl = [];
    // console.log("id piano:", idPiano);
    this.id_asl = [];
    this.recuperaAsl(idAsl, selNode);
    // console.log(this.id_piani);
    this.LoadingService.openDialog('Caricamento dei piani in corso...');
    if (this.id_asl[0] === undefined) {
      this.LoadingService.closeDialog();
    }
    for (let i = 0; i < this.id_asl.length; i++) {
      if (this.id_asl[i]) {
        // console.log(this.id_piani[i]);
        asl.push(await this.getDatiSincrono('get_strutture_asl_singolo', { id_node: this.id_asl[i] }));
        // console.log("piano:", piano);
      }
    }
    // console.log(piano);
    //Se il piano è presente, quindi vuol dire un modifica metti i dati altrimenti è uno nuovo quindi
    //non deve esserci niente.
    this.aslSingolo = asl[0];
    console.log(this.aslSingolo);
    if (newNode == false) {
      this.formASl?.patchValue({
        descrizione: asl[0].map((elem: any) => elem.descrizione),
        descrizione_breve: asl[0].map((elem: any) => elem.descrizione_breve),
        data_inizio_validita: this.checkArrayFormAsl(asl[0].map((elem: any) => elem.inizio_validita === null ? "" : (elem.inizio_validita).split('T')[0])),
        data_fine_validita: this.checkArrayFormAsl(asl[0].map((elem: any) => elem.fine_validita === null ? null : (elem.fine_validita).split('T')[0])),
      })

      this.maxInizio = this.formASl?.value.data_inizio_validita;
      this.maxFine = new Date().toISOString().split('T')[0];
    }
    else {
      this.maxInizio = null;
      this.maxFine = null;
      this.formASl?.patchValue({
        descrizione: '',
        descrizione_breve: '',
        data_inizio_validita: null,
        data_fine_validita: null,
      })
    }
    //Mi serve perchè essendo che è un array faccio il check e mi prendo il valore primitivo
    //altrimenti il vaild mi dà true


    // //Assegnazione dei valori nella form in caso di modifica o aggiungi
    // //nel caso di aggiungi, l'ultimo elemento in base a cui si trova mette il valore vuoto.
    // const fields = ['norma', 'macroarea', 'aggregazione', 'attivita'];
    // for (let i = 0; i < fields.length; i++) {
    //   const field = fields[i];
    //   //Se il primo elemento è undefined, allora calcola l’indice come this.id_piani.length - 2 - i.
    //   //this.id_piani.length - 2 - i. Accede a un elemento dall’ultimo al penultimo elemento dell’array this.id_piani, 
    //   //a seconda del valore di i.
    //   //Se il primo elemento non è undefined, allora calcola l’indice come this.id_piani.length - 1 - i. 
    //   //In questo caso, si accede a un elemento dall’ultimo elemento dell’array this.id_piani, a seconda del valore di i.
    //   const pianoIndex = this.id_piani[0] === undefined ? this.id_piani.length - 2 - i : this.id_piani.length - 1 - i;
    //   const value = piano[pianoIndex]?.map((elem: any) => elem.descrizione) || '';
    //   this.formPiano?.patchValue({ [field]: value });
    // }

    this.modalRef = this.modalEngine.open(this.templateFormAsl, {
      centered: true,
      modalDialogClass: 'modal-fade',
      size: 'lg',
      animation: true,
    });
  }
  //Funzione ricorsiva per ricavare le informazioni del nodo o nodi padri della foglia selezionata
  recuperaAsl(id_asl_corrente: any, selNode: ATreeNodeComponent) {
    console.log("selNode.data.id_node_parent:", selNode.data.id_node_parent);
    this.id_asl.push(id_asl_corrente);
    if (selNode.data.id_node_parent === null) {
      return;
    }
    else {
      this.aslTree?.nodes?.forEach((nodo: any) => {
        if (nodo.id === selNode.data.id_node_parent) {
          this.recuperaAsl(nodo.id, nodo)
        }
      })
    }
  }

  //Funzione per rendere la funzione sincrona aspettando la risposta del promise in modo tale
  //da avere i dati in ordine di arrivo.
  getDatiSincrono(api: string, params: any): Promise<any> {
    return new Promise((resolve, reject) => {
      this.og.getStruttureAslSingolo(params).subscribe((res: any) => {
        this.LoadingService.closeDialog();
        if (!res.esito) {

        }
        resolve(res.info);
      }, (error) => {
        reject(error);
      });
    });
  }

  insStrutturaAsl() {
    console.log("operazione", this._headerModaleASl);
    if (!this.formASl?.valid) {
      return;
    }
    const params = {
      descrizione: this.formASl.value.descrizione,
      descrizione_breve: this.formASl.value.descrizione_breve,
      id_node_parent: this.aslSingolo[0].id_node,
      id_node: 0,
      inizio_validita: this.formASl.value.data_inizio_validita,
      fine_validita: null,
      id: 0
    }
    params.descrizione = this.checkArrayFormAsl(this.formASl.value.descrizione);
    params.descrizione_breve = this.checkArrayFormAsl(this.formASl.value.descrizione_breve);
    console.log(params);
    if (this._headerModaleASl === 'Nuova ASL') {
      // console.log(params)
      this.og.insAsl(params).subscribe((res: any) => {
        console.log(res);
        if (!res.esito) {
          return;
        }
        this.modalRef?.close();
        this.ngOnInit();
      })
    }
    else {
      params.id_node_parent = this.aslSingolo[0].id_node_parent;
      params.id_node = this.aslSingolo[0].id_node;
      params.id = this.aslSingolo[0].id;
      params.fine_validita = this.formASl.value.data_fine_validita;
      // console.log(params);
      this.og.updAsl(params).subscribe((res: any) => {
        console.log(res);
        if (!res.esito) {
          return;
        }
        this.modalRef?.close();
        this.ngOnInit();
      })
    }
  }

  checkArrayFormAsl(value: any) {
    if (Array.isArray(value)) {
      return value[0];
    }
    return value;
  }

  async cambiaOrdine(selNode: ATreeNodeComponent, newNode: boolean, mode: string) {
    console.log("selNode:", selNode);
    this._voceSelModifica = selNode;
    this._isNewNode = newNode;
    let idPiano = selNode?.id;
    console.log(idPiano);
    let asl = [];
    // console.log("id piano:", idPiano);
    this.id_asl = [];
    this.recuperaAsl(idPiano, selNode);
    // console.log(this.id_piani);
    this.LoadingService.openDialog('Caricamento dei piani in corso...');
    if (this.id_asl[0] === undefined) {
      this.LoadingService.closeDialog();
    }
    for (let i = 0; i < this.id_asl.length; i++) {
      if (this.id_asl[i]) {
        // console.log(this.id_piani[i]);
        asl.push(await this.getDatiSincrono('get_strutture_asl_singolo', { id_node: this.id_asl[i] }));
        // console.log("piano:", piano);
      }
    }
    // console.log(piano);
    //Se il piano è presente, quindi vuol dire un modifica metti i dati altrimenti è uno nuovo quindi
    //non deve esserci niente.
    this.aslSingolo = asl[0];
    console.log(this.aslSingolo);

    const params = {
      id_node: this.aslSingolo[0].id_node,
      id_node_parent: this.aslSingolo[0].id_node_parent,
      spostamento: mode
    }

    console.log("parametri:", params);

    this.og.moveAslOrdinamento(params).subscribe((res: any) => {
      if (res.esito) {
        this.ngOnInit();
      }
    })
  }

  checkDate(event: any, form: any) {
    const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
    let src = event.srcElement as HTMLInputElement;
    let nomeForm = null;
    nomeForm = src.getAttribute('formControlName');
    if (!src.validity.valid || !regex.test(src.value)) form.get(nomeForm).setValue("")


    // Object.keys(form.controls).forEach((controlName) => {
    //   if (controlName === 'data_inizio_validita' || controlName === 'data_fine_validita') {
    //     nomeForm = controlName;
    //     console.log("nomeForm:",nomeForm);
    //     if (!src.validity.valid || !regex.test(src.value)) {
    //       console.log(nomeForm);
    //       form.get(nomeForm).setValue("")
    //       console.log("entrato");
    //     }
    //   }
    // })

  }

  //-------------------------GETTERE E SETTER------------------------------
  get headerModaleASl() { return this._headerModaleASl; }
}
