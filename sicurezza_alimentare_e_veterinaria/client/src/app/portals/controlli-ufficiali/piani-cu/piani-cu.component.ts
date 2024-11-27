/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { NotificationService, LoadingDialogService, BackendCommunicationService, ATreeComponent, toTree, ATreeNodeComponent, ASmartTableComponent } from '@us/utils';
import * as bootstrap from 'bootstrap';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';

@Component({
  selector: 'app-piani-cu',
  templateUrl: './piani-cu.component.html',
  styleUrls: ['./piani-cu.component.scss']
})
export class PianiCuComponent implements OnInit {

  @ViewChild('tabella') tabella?: ASmartTableComponent;
  @ViewChild('pianiTree') pianiTree?: ATreeComponent;
  @ViewChild('aslTree') aslTree?: ATreeComponent;

  private form_ui: any
  btnMode: any

  btnSave: boolean = false;
  btnDelete: boolean = false;

  private _resPiani: any;
  private _resAsl: any;

  private _id_cu: any;
  private _cu: any;
  private _ui: any;
  private _piani_cu: any;
  private _piani: any;
  private _asl: any;

  private modalAdd?: bootstrap.Modal;
  private _selectedPiano?: ATreeNodeComponent;
  private _selectedAsl?: ATreeNodeComponent;

  private _eleSelezionati: any[] = [];
  controllo_chiuso: boolean = false;
  follow_up: boolean = false;

  constructor(
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    public modalService: NgbModal,
    private LoadingService: LoadingDialogService,
    private changeDetector: ChangeDetectorRef,
    private client: BackendCommunicationService,
    private cus: ControlliUfficialiService
  ) { }

  ngOnInit() {
    this.route.queryParams.subscribe(params => {
      this._id_cu = parseInt(params['id_cu']);

      this.cus.getCuSingolo(this._id_cu).subscribe((res: any) => {
        this._cu = res.info.dati[0]
        this.follow_up = this._cu.sigla_tecnica == 'FU' || this._cu.sigla_tecnica == 'FS'
        this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
        this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'cuPiani')) ?? { mode: 'view' } //se non è definito
        this.btnMode = this.form_ui.mode == 'view'
      });
    });

    this.client.getDati('get_cu_piani', { id_cu: this._id_cu }).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      this._ui = res.info.ui;
      this._piani_cu = res.info.dati;
      this.controllo_chiuso = res.info.controllo_chiuso;
      //this.follow_up = res.info.follow_up;
    });

    this.client.getDati('get_piani', { id_cu: this._id_cu }).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      this._resPiani = res.info.dati;
    });

    this.client.getDati('get_asl', { id_cu: this._id_cu }).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      this._resAsl = res.info.dati;
    });

    this.modalAdd = new bootstrap.Modal('#modal-add');
  }

  ngAfterViewChecked(): void {
    if (this._selectedAsl && this._selectedPiano) this.btnSave = true; else this.btnSave = false;
    if (this.tabella?.selectedData.length != 0 && !this.btnMode) this.btnDelete = true; else this.btnDelete = false;
    this.changeDetector.detectChanges();
  }

  createAlberi() {
    this.pianiTree!.root = toTree(this._resPiani, node => {
      node.expanded = node.parent == null ? true : false;
      return node;
    }).root; //albero piani
    this.aslTree!.root = toTree(this._resAsl, node => {
      node.expanded = node.parent == null ? true : false;
      return node;
    }).root; //albero perContoDi

    this._selectedPiano = undefined;
    this._selectedAsl = undefined;
  }

  openModal() {
    if (this.btnMode == true || this.controllo_chiuso == true || this.follow_up == true) {
      return;
    }
    this.createAlberi();
    this.modalAdd?.toggle();
  }

  onTreeNodeClick(node: ATreeNodeComponent) {
    let sel: true | false = true;
    if (node.isLeafNode()) {
      if (node.data.name_tree.includes("Piani")) {
        this._piani_cu.forEach((ele: any) => {
          if (ele.id_piano == node.data.id) {
            sel = false;
            this._selectedPiano = undefined;
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Attenzione! Questo piano è stato già selezionato.'
            });
          }
        })
        if (sel) this._selectedPiano = node;
        console.log(node);
        this.pianiTree?.getSelectedLeafNodes().forEach((ele) => {
          ele.selected = false;
          ele.htmlElement.className = '';
        })
      }

      if (node.data.name_tree.includes("ASL")) {
        this._selectedAsl = node;
        console.log(node);
        this.aslTree?.getSelectedLeafNodes().forEach((ele) => {
          ele.selected = false;
          ele.htmlElement.className = '';
        })
      }

      if (sel) {
        node.selected = true;
        node.htmlElement.className = 'selected';
      }
    }
  }

  insert() {
    if (this.btnSave == false) {
      return;
    }
    if (this._selectedAsl != undefined && this._selectedPiano != undefined) {
      this.client.updDati('upd_add_cu_piano', { id_cu: this._id_cu, id_piano: this._selectedPiano.id, id_per_conto_di: this._selectedAsl.id }).subscribe((res: any) => {
        this.LoadingService.closeDialog();
        this.modalAdd?.hide();
        this.ngOnInit();
      });
    } else {
      this.notificationService.push({
        notificationClass: 'error',
        content: 'Attenzione! Selezionare un Piano ed un ASL per procedere.'
      });
    }
  }

  delete() {
    if (this.btnDelete == false) {
      return;
    }
    this._eleSelezionati = [];
    this.tabella?.selectedData.forEach((ele: any) => {
      this._eleSelezionati.push(ele.id_cu_piano);
    });

    if (this._eleSelezionati.length != 0) {
      this.LoadingService.openDialog();
      this.client.updDati('upd_del_cu_piano', { id_cu_piano: this._eleSelezionati }).subscribe((res: any) => {
        if (!res.esito) {
          this.notificationService.push({
            notificationClass: 'warning',
            content: 'Errore durante l\'eliminazione.'
          });
        }
        this.ngOnInit();
      });
    } else {
      this.notificationService.push({
        notificationClass: 'error',
        content: 'Attenzione! Selezionare un Piano ed un ASL per procedere.'
      });
      return;
    }
  }

  get id_cu() { return this._id_cu }
  get cu() { return this._cu }
  get ui() { return this._ui }
  get piani_cu() { return this._piani_cu }
  get piani() { return this._piani }
  get asl() { return this._asl }

}
