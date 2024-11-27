/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ATreeComponent, ATreeNodeComponent, BackendCommunicationService, LoadingDialogService, NotificationService, TreeNode, stretchToWindow, toTree } from '@us/utils';
import { ConfigurazioniService } from '../../configurazioni/configurazioni.service';
import { OrganizzazioneService } from '../organizzazione.service';

@Component({
  selector: 'app-sposta-piano',
  templateUrl: './sposta-piano.component.html',
  styleUrls: ['./sposta-piano.component.scss']
})
export class SpostaPianoComponent {
  private _id_nodo: any;
  private _id_nodo_padre: any;
  private _piani: any;
  private _selectedNodo?: any;
  pianiTree?: TreeNode;
  private _pianoSingolo: any;

  @ViewChild('pianiTreeComponent') pianoTree?: ATreeComponent;
  constructor(
    private route: ActivatedRoute,
    private ComunicazioneDB: BackendCommunicationService,
    private og: OrganizzazioneService, //RICORDARSI CHE LE FUNZIONI GIRANO SOTTO AGENDA
    private LoadingService: LoadingDialogService,
    private notificationService: NotificationService,
    private router: Router,
  ) { }

  ngOnInit() {
    this.route.queryParams.subscribe((res: any) => {
      console.log(res);
      this._id_nodo = res['id_node'];
      this._id_nodo_padre = res['id_node_parent'];
      console.log(this._id_nodo);
      console.log(this._id_nodo_padre);
      this.og.getPianiTotaliSpostamento({id_node: parseInt(this._id_nodo)}).subscribe((res: any) => {
        this._piani = res.info;
        this.pianiTree = toTree(this._piani, node => {
          node.expanded = node.parent == null ? true : false;
          return node;
        }).root;
        setTimeout(() => {
          stretchToWindow(document.getElementById('piani-main-content')!);
        }, 0);
      })
      this.og.getPianoSingolo({id_piano: parseInt(this._id_nodo)}).subscribe((res : any) => {
        this._pianoSingolo = res.info[0];
      })
    })
  }

  spostaPiano() {
    console.log(this._selectedNodo.data);
    console.log(this._pianoSingolo);
    this.og.movePiano({id_node: this._pianoSingolo.id_node, id_node_parent: this._selectedNodo.data.id_node}).subscribe((res : any) => {
      if(res.esito) {
        this.router.navigate(['portali/organizzazione/struttura-piani']);
      }
    })
  }

  prendiValoreAlbero(nodo: ATreeNodeComponent) {
    console.log("nodo preso: ", nodo.data);
      if (this._selectedNodo) this._selectedNodo.htmlElement.classList.remove('selected');
      this._selectedNodo = nodo;
      this._selectedNodo?.htmlElement.classList.add('selected');
      console.log(this._selectedNodo);
  }

  get pianoSingolo() { return this._pianoSingolo; }
  get selectedNodo() { return this._selectedNodo; }
}
