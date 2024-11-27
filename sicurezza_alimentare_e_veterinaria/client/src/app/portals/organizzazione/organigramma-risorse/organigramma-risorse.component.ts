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
  selector: 'app-organigramma-risorse',
  templateUrl: './organigramma-risorse.component.html',
  styleUrls: ['./organigramma-risorse.component.scss']
})
export class OrganigrammaRisorseComponent {
  //-------------------------------VARIABILI---------------------------------
  private _risorse: any;
  risorsaTree?: TreeNode;
  private _headerModaleRisorsa?: string;
  private id_risorse: any = [];
  formRisorsa?: FormGroup;
  private risorsaSingolo: any;
  _selectedRisorsa: any;
  private _ui: any;
  private _utenti: any;

  @ViewChild('organigrammaRisorseComponent') risorseTree?: ATreeComponent;
  @ViewChild('templateFormRisorse') templateFormRisorse!: TemplateRef<any>;
  private _voceSelModifica?: ATreeNodeComponent;
  private _isNewNode?: boolean;
  modalRef?: NgbModalRef;
  //------------------------COSTRUTTORE---------------------------------
  constructor(private ComunicazioneDB: BackendCommunicationService,
    private og: OrganizzazioneService,
    private LoadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private contextMenuService: ContextMenuService,
    private modalEngine: NgbModal,
    private fb: FormBuilder,
    private router: Router,
  ) { }
  //---------------------------------NGONINIT----------------------------
  ngOnInit(): void {
    this.og.getOrganigrammaRisorse().subscribe((res: any) => {
      this._risorse = res.info;
      this.risorsaTree = toTree(this._risorse, node => {
        node.expanded = node.parent == null ? true : false;
        return node;
      }).root;
      setTimeout(() => {
        this._initTreeContextMenu();
        stretchToWindow(document.getElementById('piani-main-content')!);
      }, 0);
    })
  }
  //---------------------------FUNZIONI----------------------------------------
  //Costruzione del menù quando si clicca il tasto sinistro del mouse sul piano
  private _initTreeContextMenu() {
    this.risorseTree?.nodes?.forEach((node) => {
      if (node.isLeafNode()) {
        //Se il piano è presente al nodo dell'albero e' cancellabile
        if (node.data.cancellabile) {
          //adding context menu
          this.contextMenuService.assignContextMenu(node.htmlElement, [
            {
              label: 'Modifica Risorsa',
              action: () => {
                this._headerModaleRisorsa = 'Modifica Risorsa';
              },
            },
            {
              label: 'Elimina Risorsa',
              action: (node: ATreeNodeComponent) => {
                this._headerModaleRisorsa = 'Elimina Risorsa';
              },
              context: node,
            },
            {
              label: 'Nuova Risorsa',
              action: () => {
                this._headerModaleRisorsa = 'Nuova Risorsa';
              },
            }
          ]);
        }
        //se la tariffa presente al nodo dell'albero non e' cancellabile
        else {
          this.contextMenuService.assignContextMenu(node.htmlElement, [
            {
              label: 'Nuova Risorsa',
              action: () => {
                this._headerModaleRisorsa = 'Nuova Risorsa';
                this.apriModaleRisorsa(node, true);
              },
            },
          ])
        }
      }
    });
  }

  async apriModaleRisorsa(selNode: ATreeNodeComponent, newNode: boolean) {
    console.log("selNode:", selNode);
    this._voceSelModifica = selNode;
    this._isNewNode = newNode;
    let idRisorsa = selNode?.data.id;
    console.log(idRisorsa);
    let risorsa = [];
    // console.log("id piano:", idPiano);
    this.id_risorse = [];
    this.recuperaRisorse(idRisorsa, selNode);
    // console.log(this.id_piani);
    this.LoadingService.openDialog('Caricamento dei piani in corso...');
    if (this.id_risorse[0] === undefined) {
      this.LoadingService.closeDialog();
    }
    for (let i = 0; i < this.id_risorse.length; i++) {
      if (this.id_risorse[i]) {
        // console.log(this.id_piani[i]);
        risorsa.push(await this.getDatiSincrono('get_risorsa_singolo', { id_risorsa: this.id_risorse[i] }));
        // console.log("piano:", piano);
      }
    }
    // console.log(piano);
    //Se il piano è presente, quindi vuol dire un modifica metti i dati altrimenti è uno nuovo quindi
    //non deve esserci niente.
    this.risorsaSingolo = risorsa[0];
    console.log(this.risorsaSingolo);
    if (newNode == false) {
      this.formRisorsa?.patchValue({
        descrizione: risorsa[0].map((elem: any) => elem.descrizione),
        descrizione_breve: risorsa[0].map((elem: any) => elem.descrizione_breve),
      })
    }
    else {
      this.formRisorsa?.patchValue({
        descrizione: '',
        descrizione_breve: '',
      })
    }

    this.router.navigate(['portali', 'organizzazione','associa-risorse'], { queryParams: { id_node: (this.risorsaSingolo[0].id_node)/10 } });
  }
  //Funzione ricorsiva per ricavare le informazioni del nodo o nodi padri della foglia selezionata
  recuperaRisorse(id_risorsa_corrente: any, selNode: ATreeNodeComponent) {
    console.log("selNode.data.id_node_parent:", selNode.data.id_node_parent);
    this.id_risorse.push(id_risorsa_corrente);
    if (selNode.data.id_node_parent === null) {
      return;
    }
    else {
      this.risorseTree?.nodes?.forEach((nodo: any) => {
        if (nodo.id === selNode.data.id_node_parent) {
          this.recuperaRisorse(nodo.id, nodo)
        }
      })
    }
  }

  //Funzione per rendere la funzione sincrona aspettando la risposta del promise in modo tale
  //da avere i dati in ordine di arrivo.
  getDatiSincrono(api: string, params: any): Promise<any> {
    return new Promise((resolve, reject) => {
      this.og.getOrganigrammaRisorsaSingolo(params).subscribe((res: any) => {
        this.LoadingService.closeDialog();
        if (!res.esito) {

        }
        resolve(res.info);
      }, (error) => {
        reject(error);
      });
    });
  }

  checkArrayFormAsl(value: any) {
    if (Array.isArray(value)) {
      return value[0];
    }
    return value;
  }

  prendiValoreAlbero(nodo: ATreeNodeComponent) {
    console.log("nodo preso: ", nodo.data);
      if(nodo.isLeafNode()){
        if (this._selectedRisorsa) this._selectedRisorsa.htmlElement.classList.remove('selected');
        this._selectedRisorsa = nodo;
        this._selectedRisorsa?.htmlElement.classList.add('selected');
        console.log(this._selectedRisorsa);
        this.og.getStruttureUtente({id_struttura: this._selectedRisorsa.data.id}).subscribe((res : any) => {
          this._ui = res.info.ui
          this._utenti = res.info.dati;
        })
      }
  }

  delRisorsa(ar : any) {
    console.log(ar);
    this.og.updDelRisorsa({id_utente_struttura: ar.id_utente_struttura}).subscribe((res : any) => {
      if(res.esito) {
        this.og.getStruttureUtente({id_struttura: this._selectedRisorsa.data.id}).subscribe((res : any) => {
          this._ui = res.info.ui
          this._utenti = res.info.dati;
        })
      }
    })
  }

  //-------------------------GETTERE E SETTER------------------------------
  get headerModaleRisorsa() { return this._headerModaleRisorsa; }
  get selectedRisorsa() { return this._selectedRisorsa; }
  get ui() { return this._ui; }
  get utenti() { return this._utenti; }
}
