/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { DenominazioneProdottoService } from './denominazione-prodotto.service';
import { ATreeComponent, ATreeNodeComponent, ContextMenuService, TreeNode, stretchToWindow, toTree } from '@us/utils';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-denominazione-prodotto',
  templateUrl: './denominazione-prodotto.component.html',
  styleUrls: ['./denominazione-prodotto.component.scss']
})
export class DenominazioneProdottoComponent implements OnInit {
  private _prodotti?: any;
  private _prodottiTreeRoot?: TreeNode;

  @ViewChild('treeProdotti') treeProdotti?: ATreeComponent;

  constructor(
    private dps: DenominazioneProdottoService,
    private contextMenuService: ContextMenuService
  ) { }

  ngOnInit(): void {
    this.dps.getTreeDenominazioneProdotti().subscribe((res: any) => {
      console.log("res:", res);
      this._prodotti = res.info;
      console.log("this._prodotti:", this._prodotti);

      this._prodottiTreeRoot = toTree(this._prodotti, node => {
        node.expanded = node.parent == null ? true : false;
        return node;
      }).root;

      setTimeout(() => {
        this._initTreeContextMenu();
        stretchToWindow(document.getElementById('denominazione-prodotti-content')!);
      }, 0);
    });
  }

  private _insertNewProduct(node: ATreeNodeComponent): void {
    Swal.fire({
      title: 'Inserisci Nome Prodotto',
      input: 'text',
      inputLabel: 'Nome Prodotto',
      showCancelButton: true,
      allowOutsideClick: false
    }).then((result) => {
      if (result.isConfirmed) {
        const params = {
          descrizione: result.value,
          id_tree: node.data.id_tree,
          id_node: node.data.id_node
        };
        console.log("params:", params);
        this.dps.insDenominazioneProdotti(params).subscribe((res: any) => {
          console.log("res:", res);
          if (!res.esito) {
            Swal.fire({
              title: 'Errore',
              icon: 'error',
              text: `Attenzione! Errore durante l'inserimento del prodotto`,
              timer: 1500,
              timerProgressBar: true,
              allowOutsideClick: false,
            });
          }
          Swal.fire({
            title: 'Successo',
            icon: 'success',
            text: `Inserimento avvenuto con successo`,
            showConfirmButton: false,
            timer: 1500,
            timerProgressBar: true,
            allowOutsideClick: false,
          }).then((result) => {
            if (result.dismiss === Swal.DismissReason.timer) {
              window.location.reload();
            }
          })
        });
      }
    });
  }

  private _deleteProduct(node: ATreeNodeComponent): void {
    Swal.fire({
      title: 'Sei sicuro/a?',
      icon: 'question',
      text: `Sei sicuro/a di voler eliminare ${node.data.descrizione}?`,
      showCancelButton: true,
      allowOutsideClick: false,
    }).then((result) => {
      if (result.isConfirmed) {
        const params = {
          id_tree: node.data.id_tree,
          id_node: node.data.id_node
        };
        console.log("params:", params);
        this.dps.delDenominazioneProdotti(params).subscribe((res: any) => {
          console.log("res:", res);
          if (!res.esito) {
            Swal.fire({
              title: 'Errore',
              icon: 'error',
              text: `Attenzione! Errore durante la cancellazione del prodotto`,
              timer: 1500,
              timerProgressBar: true,
              allowOutsideClick: false,
            });
          }
          Swal.fire({
            title: 'Successo',
            icon: 'success',
            text: `Cancellazione avvenuta con successo`,
            showConfirmButton: false,
            timer: 1500,
            timerProgressBar: true,
            allowOutsideClick: false,
          }).then((result) => {
            if (result.dismiss === Swal.DismissReason.timer) {
              window.location.reload();
            }
          });
        })
      }
    })
  }

  // Inizializza il menu del tasto destro dell'albero
  _initTreeContextMenu(): void {
    this.treeProdotti?.nodes?.forEach((n: ATreeNodeComponent) => {
      this.contextMenuService.assignContextMenu(n.htmlElement, [
        {
          label: 'Aggiungi Prodotto',
          action: (node: ATreeNodeComponent) => {
            console.log("node:", node);
            this._insertNewProduct(node);
          },
          context: n
        },
        {
          label: 'Elimina Prodotto',
          action: (node: ATreeNodeComponent) => {
            console.log("node:", node);
            this._deleteProduct(node);
          },
          context: n
        }
      ])
    })
  }

  /******************************** ACCESSORS *********************************/
  get prodottiTreeRoot() { return this._prodottiTreeRoot; }
  /****************************************************************************/
}
