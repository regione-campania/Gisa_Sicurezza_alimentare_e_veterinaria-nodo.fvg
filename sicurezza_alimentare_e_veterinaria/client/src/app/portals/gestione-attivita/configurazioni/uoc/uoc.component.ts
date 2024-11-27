/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Inject, Input } from '@angular/core';
import { ATreeNodeComponent, Tree, toTree } from '@us/utils';
import { GestioneAttivitaService } from 'src/app/portals/gestione-attivita/gestione-attivita.service';
import { InfoStrutturaPrimaria } from '../types';
import { ATreeComponent } from '@us/utils';
import { ValueTracker } from '@us/utils';
import { NotificationService } from '@us/utils';
import { LoadingDialogService } from '@us/utils';
import { UTILS, UtilsType } from 'src/app/shared/shared';

@Component({
  selector: 'uoc-conf',
  templateUrl: './uoc.component.html',
  styleUrls: ['./uoc.component.scss']
})
export class UocComponent {
  @Input() info?: InfoStrutturaPrimaria;

  uocLoading = false;
  pianiLoading = false;
  uocTree?: Tree;
  pianiTree?: Tree;
  pianiTreeComponent?: ATreeComponent;

  private _selectedUoc?: ATreeNodeComponent;

  constructor(
    private gs: GestioneAttivitaService,
    private notification: NotificationService,
    private loading: LoadingDialogService,
    @Inject(UTILS) public utils: UtilsType,
  ) { }

  ngOnInit(): void {
    if (!(this.uocTree = this.gs.storage.getItem('confUocTree'))) {
      this.uocLoading = true;
      this.gs.getUoc().subscribe(res => {
        this.uocLoading = false;
        this.uocTree = toTree(res.info.uoc, (node) => {
          node.expanded = node.parent == null ? true : false;
          return node;
        });
        this.gs.storage.setItem('confUocTree', this.uocTree);
      });
    }
  }

  getUocPiani(node: ATreeNodeComponent) {
    if (node.isLeafNode()) {
      if (this.selectedUoc) this.unselectUoc();
      this.selectUoc(node);
      this.pianiLoading = true;
      this.gs.getUocPiani(node.data.id).subscribe(res => {
        this.pianiLoading = false;
        this.pianiTree = toTree(res.info.uoc_piani, (node) => {
          node.selectable = this.infoPiani?.modality === 'modifica';
          node.expanded = node.parent == null ? true : false;
          return node;
        });
      });
    }
  }

  selectUoc(node: ATreeNodeComponent) {
    this.selectedUoc = node;
  }

  unselectUoc() {
    this.selectedUoc = undefined;
  }

  salva() {
    if (!this.selectedUoc) {
      this.notification.push({
        notificationClass: 'warning',
        content: 'Attenzione! Selezionare UOC.'
      });
    }
    else {
      let selectedPiani = this.pianiTreeComponent?.leafNodes?.filter(node => node.selected).map(node => node.data.id);
      this.loading.openDialog('Salvataggio in corso...');
      this.gs.updUocPiani(this.selectedUoc.data.id, selectedPiani ?? []).subscribe(res => {
        this.loading.closeDialog();
        if (res.esito) {
          this.infoPiani!.trackerModifiche = new ValueTracker(this.pianiTreeComponent?.nodes?.map(node => node.selected));
          //invalida la cache dei Piani per permettere il loro reload quando si seleziona l'apposita tab (Bug fix #12022)
          this.gs.storage.removeItem('confPianiTree');
        }
      })
    }
  }

  onPianiTreeLoad(tree: ATreeComponent) {
    this.pianiTreeComponent = tree;
    this.infoPiani!.trackerModifiche = new ValueTracker(tree.nodes?.map(node => node.selected));
  }

  onPianiTreeClick() {
    //aspetta il checkStatus() dell'albero
    setTimeout(() => {
      this.infoPiani!.trackerModifiche?.updateValue(this.pianiTreeComponent?.nodes?.map(node => node.selected));
    });
  }

  //computed
  public get infoPiani() {
    return this.info?.struttureAssociate.find(s => s.label == 'Piani');
  }

  //accessors
  public get selectedUoc(): ATreeNodeComponent | undefined {
    return this._selectedUoc;
  }

  public set selectedUoc(value: ATreeNodeComponent | undefined) {
    if (this._selectedUoc) this._selectedUoc.htmlElement.classList.remove('selected');
    this._selectedUoc = value;
    this._selectedUoc?.htmlElement.classList.add('selected');
  }

}
