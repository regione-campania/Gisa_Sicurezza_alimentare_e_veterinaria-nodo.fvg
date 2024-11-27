/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { GestioneAttivitaService } from '../../../gestione-attivita.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { NotificationService, ValueTracker, LoadingDialogService, BackendCommunicationService, Tree, ATreeComponent, toTree, ATreeNodeComponent, ASmartTableComponent, TreeNode } from '@us/utils';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'tipolista-piani',
  templateUrl: './tipolista-piani.component.html',
  styleUrls: ['./tipolista-piani.component.scss']
})
export class TipoListaPianiComponent implements OnInit {

  @ViewChild('pianiTree') pianiTree!: ATreeComponent;

  piani: any[] = [];

  mappaturaAlberi = ((node: any) => {
    node.selectable = true
    node.disabled = node.data.disabled
    return node
  })

  tipoListaDescr = "";
  id_tipo_lista: any;
  pianiLoading = false;
  //pianiTree?: TreeNode;
  pianiTreeComponent?: ATreeComponent;

  trackerModifiche?: ValueTracker;


  constructor(
    private gs: GestioneAttivitaService,
    public modalService: NgbModal,
    private loading: LoadingDialogService
  ) { }


  ngOnInit(): void {
  }

  getTipoListaPiani(tipolista: any) {

    console.log("tipoListaDescr", tipolista.id_tipo_lista);
    //if (!(this.pianiTree = this.gs.storage.getItem('tipolistaPianiConf'))) {
    this.id_tipo_lista = tipolista.id_tipo_lista;
    this.pianiLoading = true;
    this.gs.getTipoListaPiani(tipolista.id_tipo_lista).subscribe(res => {
      this.pianiLoading = false;

      this.piani = res.info
      // this.pianiTree = toTree(res.info, node => {
      //   node.selectable = true;
      //   //console.log("node id",node.data.id);
      //   //console.log("node ",node.data.selezionato);
      //   node.selected = node.data.selezionato ? true : false;
      //   node.expanded = node.parent == null ? true : false;
      //   return node;
      // }).root;

      //  this.gs.storage.setItem('tipolistaPianiConf', this.pianiTree);
    });

    this.tipoListaDescr = tipolista.descr;
    //}

  }




  onPianiTreeLoad(tree: ATreeComponent) {
    this.pianiTreeComponent = tree;

    this.trackerModifiche = new ValueTracker(tree.nodes?.map(node => node.selected));

  }

  onPianiTreeClick(node: ATreeNodeComponent) {

    setTimeout(() => {
      this.trackerModifiche?.updateValue(this.pianiTreeComponent?.nodes?.map(node => node.selected));
    });
  }




  salva() {
    let selectedPiani = this.pianiTreeComponent?.leafNodes!.filter(node => node.selected).map(node => node.data.id);

    this.loading.openDialog('Salvataggio in corso...');

    console.log('selectedPiani', selectedPiani);
    this.gs.updTipoListaPerPiano(this.id_tipo_lista, selectedPiani ?? []).subscribe(res => {
      this.loading.closeDialog();

      if (res.esito)
        this.trackerModifiche = new ValueTracker(this.pianiTreeComponent?.nodes?.map(node => node.selected));
    });

  }



}
