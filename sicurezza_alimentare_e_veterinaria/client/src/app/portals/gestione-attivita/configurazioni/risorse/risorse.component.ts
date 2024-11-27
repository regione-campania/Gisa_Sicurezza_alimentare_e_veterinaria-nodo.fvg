/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  AfterViewChecked,
  ChangeDetectorRef,
  Component,
  Inject,
  Input,
  OnInit,
  ViewChild,
} from '@angular/core';
import { InfoStrutturaPrimaria } from '../types';
import {
  ATreeComponent,
  ATreeNodeComponent,
  Data,
  TemplateService,
  Tree,
  ValueTracker,
  stretchToWindow,
  toTree,
} from '@us/utils';
import { GestioneAttivitaService } from 'src/app/portals/gestione-attivita/gestione-attivita.service';
import { LetterListComponent, ASmartTableComponent } from '@us/utils';
import { LoadingDialogService } from '@us/utils';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import Swal from 'sweetalert2';
import { UTILS, UtilsType } from 'src/app/shared/shared';

@Component({
  selector: 'risorse-conf',
  templateUrl: './risorse.component.html',
  styleUrls: ['./risorse.component.scss'],
})
export class RisorseComponent implements OnInit, AfterViewChecked {
  @Input() info?: InfoStrutturaPrimaria;
  @ViewChild(LetterListComponent) letterList?: LetterListComponent;
  @ViewChild(ASmartTableComponent) risorseLineeTable?: ASmartTableComponent;

  risorseLoading = false;
  comuniLoading = false;
  pianiLoading = false;
  lineeLoading = false;

  risorseTree?: Tree;
  risorseSelezionabiliTree?: Tree;
  pianiTree?: Tree;
  pianiTreeComponent?: ATreeComponent;
  lineeTableSrc: any;
  comuni: any;

  modaleDuplicaPiani?: NgbModalRef;

  private _selectedRisorsa?: ATreeNodeComponent;

  constructor(
    private gs: GestioneAttivitaService,
    private loading: LoadingDialogService,
    private changeDetector: ChangeDetectorRef,
    private modalEngine: NgbModal,
    @Inject(UTILS) public utils: UtilsType
  ) {}

  ngOnInit(): void {
    if (!(this.risorseTree = this.gs.storage.getItem('confRisorseTree'))) {
      this.risorseLoading = true;
      this.gs.getNominativiUos().subscribe((res) => {
        this.risorseLoading = false;
        this.risorseTree = toTree(res.info.nominativi_uos, (node) => {
          node.expanded = node.parent == null ? true : false;
          return node;
        });
        this.risorseSelezionabiliTree = toTree(
          res.info.nominativi_uos,
          (node) => {
            node.expanded = node.parent == null ? true : false;
            node.selectable = true;
            return node;
          }
        );
        this.gs.storage.setItem('confRisorseTree', this.risorseTree);
      });
    }
    let timer = setInterval(() => {
      let slider = document.querySelector('.slider');
      if (slider) {
        stretchToWindow(slider as HTMLElement);
        clearInterval(timer);
      }
    }, 500);
  }

  ngAfterViewChecked() {
    if (this.letterList && this.comuni && this.infoComuni) {
      if (!this.infoComuni.trackerModifiche)
        this.infoComuni.trackerModifiche = new ValueTracker(
          this.letterList.getSelectedData()
        );
      else
        this.infoComuni.trackerModifiche.updateValue(
          this.letterList.getSelectedData()
        );
    }
    if (this.risorseLineeTable && this.infoLinee) {
      if (!this.infoLinee.trackerModifiche)
        this.infoLinee.trackerModifiche = new ValueTracker(
          this.risorseLineeTable.selectedData
        );
      else
        this.infoLinee.trackerModifiche.updateValue(
          this.risorseLineeTable.selectedData
        );
    }
    this.changeDetector.detectChanges();
  }

  initStruttureSecondarie(node: ATreeNodeComponent) {
    if (node.isLeafNode()) {
      if (this.selectedRisorsa) this.unselectRisorsa();
      this.selectRisorsa(node);
      this.initComuni(node.data.id);
      this.initPiani(node.data.id);
      this.initLinee(node.data.id);
    }
  }

  initComuni(id: number | string) {
    this.comuniLoading = true;
    this.gs.getNominativiComuni(id).subscribe((res) => {
      this.comuniLoading = false;
      this.comuni = res.info.nominativi[0].comuni as Array<any>;
      this.infoComuni!.trackerModifiche = undefined;
    });
  }

  initPiani(id: number | string) {
    this.pianiLoading = true;
    this.gs.getNsPiani(id).subscribe((res) => {
      this.pianiLoading = false;
      this.pianiTree = toTree(res.info.ns_piani, (node) => {
        node.selectable = this.infoPiani?.modality === 'modifica';
        node.expanded = node.parent == null ? true : false;
        return node;
      });
    });
  }

  initLinee(id: number | string) {
    this.lineeLoading = true;
    this.gs.getNSLinee(id).subscribe((res) => {
      this.lineeLoading = false;
      this.lineeTableSrc = res.info;
      this.infoLinee!.trackerModifiche = undefined;
    });
  }

  selectRisorsa(node: ATreeNodeComponent) {
    this.selectedRisorsa = node;
  }

  unselectRisorsa() {
    this.selectedRisorsa = undefined;
  }

  openModal(content: any) {
    return this.modalEngine.open(content, {
      modalDialogClass: 'system-modal',
      size: 'lg',
      centered: true,
    });
  }

  salva() {
    if (this.strutturaSecondariaAttiva) {
      switch (this.strutturaSecondariaAttiva.label) {
        case 'Comuni':
          let idComuni = this.letterList
            ?.getSelectedData()
            .map((c: any) => c.source.id_struttura_comune);
          this.loading.openDialog('Salvataggio in corso...');
          this.gs
            .updNsComuni(this.selectedRisorsa!.data.id, idComuni ?? [])
            .subscribe((res) => {
              this.loading.closeDialog();
              if (res.esito) {
                this.infoComuni!.trackerModifiche = new ValueTracker(
                  this.letterList?.getSelectedData()
                );
                this.initLinee(this.selectedRisorsa?.data.id);
              }
            });
          break;
        case 'Piani':
          let selectedPiani = this.pianiTreeComponent
            ?.leafNodes!.filter((node) => node.selected)
            .map((node) => node.data.id);
          this.loading.openDialog('Salvataggio in corso...');
          this.gs
            .updNsPiani(this.selectedRisorsa!.data.id, selectedPiani ?? [])
            .subscribe((res) => {
              this.loading.closeDialog();
              if (res.esito) {
                this.infoPiani!.trackerModifiche = new ValueTracker(
                  this.pianiTreeComponent?.nodes?.map((node) => node.selected)
                );
                this.initLinee(this.selectedRisorsa?.data.id);
              }
            });
          break;
        case 'Linee':
          let selectedLinee = this.risorseLineeTable?.selectedData.map(
            (linea: any) => linea.id_linea
          );
          this.loading.openDialog('Salvataggio in corso...');
          this.infoLinee!.trackerModifiche = undefined;
          this.gs
            .updNSLinee(this.selectedRisorsa!.data.id, selectedLinee ?? [])
            .subscribe((res) => {
              this.loading.closeDialog();
              if (!res.esito) {
                this.infoLinee!.trackerModifiche = new ValueTracker(
                  this.risorseLineeTable?.selectedData
                );
              } else if (res.esito && this.selectedRisorsa)
                this.initLinee(this.selectedRisorsa.data.id);
            });
          break;
      }
    }
  }

  duplica(tree?: ATreeComponent) {
    //duplicazione piani (per ora è possibile solo quella)
    this.modaleDuplicaPiani?.close();
    let idCloni: any = tree?.getSelectedLeafNodes().map((node) => node.data.id);
    this.gs
      .updClonaNsPiani(this.selectedRisorsa!.data.id, idCloni ?? [])
      .subscribe();
  }

  //TODO: richiedere salvataggio prima di duplicare
  richiediSalvataggio(callback?: Function) {
    Swal.fire({
      title: 'Salvare le modifiche prima di continuare?',
      icon: 'warning',
      showConfirmButton: true,
      confirmButtonText: 'Salva',
      showDenyButton: true,
      denyButtonText: 'Annulla',
    }).then((res) => {
      if (res.isConfirmed && callback) {
        this.salva();
        callback();
      }
    });
  }

  onPianiTreeLoad(tree: ATreeComponent) {
    this.pianiTreeComponent = tree;
    this.infoPiani!.trackerModifiche = new ValueTracker(
      tree.nodes?.map((node) => node.selected)
    );
  }

  onPianiTreeClick() {
    //aspetta il checkStatus() dell'albero
    setTimeout(() => {
      this.infoPiani!.trackerModifiche?.updateValue(
        this.pianiTreeComponent?.nodes?.map((node) => node.selected)
      );
    });
  }

  dataMapping(d: any) {
    d.selected = d.selezionato;
    return d as Data;
  }

  //computed
  public get infoComuni() {
    return this.info?.struttureAssociate.find((s) => s.label == 'Comuni');
  }

  public get infoPiani() {
    return this.info?.struttureAssociate.find((s) => s.label == 'Piani');
  }

  public get infoLinee() {
    return this.info?.struttureAssociate.find((s) => s.label == 'Linee');
  }

  public get strutturaSecondariaAttiva() {
    return this.info?.struttureAssociate.find((s) => s.active);
  }

  //accessors
  public get selectedRisorsa(): ATreeNodeComponent | undefined {
    return this._selectedRisorsa;
  }

  public set selectedRisorsa(value: ATreeNodeComponent | undefined) {
    if (this._selectedRisorsa)
      this._selectedRisorsa.htmlElement.classList.remove('selected');
    this._selectedRisorsa = value;
    this._selectedRisorsa?.htmlElement.classList.add('selected');
  }
}
