/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { AfterViewChecked, ChangeDetectorRef, Component, Inject, Input, OnInit, QueryList, ViewChild, ViewChildren } from '@angular/core';
import { ATreeNodeComponent, LetterListComponent, LoadingDialogComponent, LoadingDialogService, NotificationService, Tree, TreeNode, ValueTracker, toTree } from '@us/utils';
import { GestioneAttivitaService } from 'src/app/portals/gestione-attivita/gestione-attivita.service';
import { InfoStrutturaPrimaria } from '../types';
import { UTILS, UtilsType } from 'src/app/shared/shared';

@Component({
  selector: 'uos-conf',
  templateUrl: './uos.component.html',
  styleUrls: ['./uos.component.scss']
})
export class UosComponent implements OnInit, AfterViewChecked {
  @Input() info?: InfoStrutturaPrimaria;
  @ViewChild(LetterListComponent) letterList?: LetterListComponent;

  uosLoading = false;
  comuniLoading = false;

  uosTree?: Tree;
  comuni: any;

  private _selectedUos?: ATreeNodeComponent;

  constructor(
    private gs: GestioneAttivitaService,
    private loading: LoadingDialogService,
    private notification: NotificationService,
    private changeDetector: ChangeDetectorRef,
    @Inject(UTILS) public utils: UtilsType,
  ) {}

  ngOnInit(): void {
    if (!(this.uosTree = this.gs.storage.getItem('confUosTree'))) {
      this.uosLoading = true;
      this.gs.getUos().subscribe(res => {
        this.uosLoading = false;
        this.uosTree = toTree(res.info.uos, (node) => {
          node.expanded = node.parent == null ? true : false;
          return node;
        });
        this.gs.storage.setItem('confUosTree', this.uosTree);
      });
    }
  }

  ngAfterViewChecked() {
    if (this.letterList && this.comuni && this.infoComuni) {
      if (!this.infoComuni.trackerModifiche)
        this.infoComuni.trackerModifiche = new ValueTracker(this.letterList.getSelectedData());
      else
        this.infoComuni.trackerModifiche.updateValue(this.letterList.getSelectedData());
      this.changeDetector.detectChanges();
    }
  }

  getUosComuni(node: ATreeNodeComponent) {
    if(node.isLeafNode()) {
      if (this.selectedUos) this.unselectUos();
      this.selectUos(node);
      this.comuniLoading = true;
      this.comuni = null;
      this.gs.getUosComuni(node.data.id).subscribe(res => {
        this.comuniLoading = false;
        this.comuni = res.info.uos_comuni;
        this.infoComuni!.trackerModifiche = undefined;
      });
    }
  }

  selectUos(node: ATreeNodeComponent) {
    this.selectedUos = node;
  }

  unselectUos() {
    this.selectedUos = undefined;
  }

  salva() {
    if(!this.selectedUos) {
      this.notification.push({
        content: 'Attenzione! Selezionare un UOS.',
        notificationClass: 'warning'
      })
    }
    else {
      let idComuni = this.letterList?.getSelectedData().map(d => d.source.id);
      this.loading.openDialog('Salvataggio in corso...');
      this.gs.updUosComuni(this.selectedUos.data.id, idComuni ?? []).subscribe(res => {
        this.loading.closeDialog();
        if (res.esito) {
          this.infoComuni!.trackerModifiche = new ValueTracker(this.letterList?.getSelectedData());
        }
      });
    }
  }

  //computed
  public get infoComuni() {
    return this.info?.struttureAssociate.find(s => s.label == 'Comuni');
  }

  //accessors
  public get selectedUos(): ATreeNodeComponent | undefined {
    return this._selectedUos;
  }

  public set selectedUos(value: ATreeNodeComponent | undefined) {
    if (this._selectedUos) this._selectedUos.htmlElement.classList.remove('selected');
    this._selectedUos = value;
    this._selectedUos?.htmlElement.classList.add('selected');
  }
}
