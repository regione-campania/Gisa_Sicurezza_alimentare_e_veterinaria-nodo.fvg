/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  AfterViewInit,
  ChangeDetectorRef,
  Component,
  OnInit,
  ViewChild,
} from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import {
  NotificationService,
  LoadingDialogService,
  BackendCommunicationService,
  ATreeComponent,
  toTree,
  ATreeNodeComponent,
} from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';

@Component({
  selector: 'app-categoria-rischio',
  templateUrl: './categoria-rischio.component.html',
  styleUrls: ['./categoria-rischio.component.scss'],
})
export class CategoriaRischioComponent implements OnInit, AfterViewInit {
  @ViewChild('categ_rischio_tree') categ_rischio_tree?: ATreeComponent;

  btnMode: any;
  private form_ui: any;

  private _id_cu: any;
  private _cu: any;

  _categ_rischio: any;
  id_categ: any;

  mappaturaAlberi = (node: any) => {
    node.selectable = true;
    node.expanded = true;
    return node;
  };

  constructor(
    private route: ActivatedRoute,
    public modalService: NgbModal,
    private cus: ControlliUfficialiService,
    private loading: LoadingDialogService
  ) {}

  ngOnInit() {
    this.route.queryParams.subscribe((params: any) => {
      this._id_cu = +params['id_cu'];
      this.cus.getCuSingolo(this._id_cu).subscribe((res: any) => {
        if (res.esito) {
          this._cu = res.info.dati[0];
          this.form_ui = JSON.parse(res.info.ui_def[0].str_conf);
          this.form_ui = this.form_ui.find(
            (ele: any) => ele.nome === 'cuCategRischio'
          ) ?? { mode: 'view' }; //se non è definito
          this.btnMode = this.form_ui.mode == 'view';

          this.cus.getCategRischioCU(this._id_cu).subscribe((res: any) => {
            if (res.esito) {
              this._categ_rischio = res.info.dati;
            }
            this.loading.closeDialog();
          });
        }
      });
    });
  }

  ngAfterViewInit(): void {
    let tree = this.categ_rischio_tree;
    if (tree) {
      tree.loadEvent.subscribe((treeComp) => {
        treeComp.nodes?.forEach((node) => {
          let checkbox = node.htmlElement.querySelector('input');
          if (!node.isLeafNode()) {
            checkbox?.addEventListener('click', (ev) => {
              ev.preventDefault();
              ev.stopImmediatePropagation();
            });
          } else {
            checkbox?.addEventListener('click', (ev) => {
              ev.preventDefault();
            });
          }
        });
      });
    }
  }

  onTreeNodeClick(node: ATreeNodeComponent) {
    if (this._cu.chiuso || this.btnMode) return;
    if (node.isLeafNode()) {
      if (node.selected) {
        return;
      }
      let parent = node.parentComponent;
      parent?.childComponents.forEach((child) => (child.selected = false));
      let checkbox = node.htmlElement.querySelector('input')!;
      checkbox.checked = true;
      node.selected = true;
      this.id_categ = node.id;
      this.salva();
    }
  }

  salva() {
    let params = {
      id_cu: +this._id_cu,
      id_categ: +this.id_categ,
      valore: 1,
    };
    this.loading.openDialog('Aggiornamento in corso...');
    this.cus.updCategRischioCU(params).subscribe((res: any) => {
      if (res.esito) this.ngOnInit();
    });
  }
}
