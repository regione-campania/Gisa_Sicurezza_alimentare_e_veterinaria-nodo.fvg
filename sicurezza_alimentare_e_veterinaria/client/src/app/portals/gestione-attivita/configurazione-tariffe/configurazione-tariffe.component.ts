/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, DoCheck, OnInit, ViewChild } from "@angular/core";
import { ATreeComponent, ATreeNodeComponent, LoadingDialogService, NotificationService, TemplateService, isDeeplyEqual, stretchToWindow, toTree, ValueTracker } from "@us/utils";
import { NgbModal, NgbModalRef } from "@ng-bootstrap/ng-bootstrap";
import { FormBuilder, Validators } from "@angular/forms";
import Swal from "sweetalert2";
import { GestioneAttivitaService } from "../gestione-attivita.service";


@Component({
  selector: 'configurazione-tariffe',
  templateUrl: './configurazione-tariffe.component.html',
  styleUrls: ['./configurazione-tariffe.component.scss']
})
export class ConfigurazioneTariffeComponent implements OnInit {
  @ViewChild('tariffeTree') tariffeTree?: ATreeComponent;

  activeSlide: 'tariffe' | 'regole' = 'tariffe';
  modalRef?: NgbModalRef;

  idTariffaCorrente?: string | number;
  regole?: { elementi: any, operazioni: any, tipi_op: any };
  regoleTracker?: ValueTracker;
  loadingRegole = false;
  pendingRegole: any[] = [];
  operandiNuovaRegola: any[] = [];
  formNuovaRegola = this.fb.group({
    elemento: this.fb.control("", Validators.required),
    operazione: this.fb.control("", Validators.required)
  });


  constructor(
    private gs: GestioneAttivitaService,
    private loadingDialog: LoadingDialogService,
    private notifications: NotificationService,
    private modalEngine: NgbModal,
    private fb: FormBuilder,
    private changeDetector: ChangeDetectorRef
  ) { }

  ngOnInit() {
    this.loadingDialog.openDialog();
    this.gs.getTariffarioPerRegole().subscribe(res => {
      this.loadingDialog.closeDialog();
      if (!res.esito) {
        this.notifications.push({
          content: 'Errore nel reperimento delle tariffe. Riprovare.',
          notificationClass: 'error'
        });
        return;
      }
      setTimeout(() => {
        this.tariffeTree!.root = toTree(res.info, node => {
          node.expanded = node.parent == null ? true : false;
          return node;
        }).root;
        let viewSlider = document.querySelector('.view-slider') as HTMLElement;
        stretchToWindow(viewSlider, '1rem');
      });
    })
  }

  onTreeNodeClick(node: ATreeNodeComponent) {
    if (node.isLeafNode()) {
      this.loadRegole(node.id!);
      this.idTariffaCorrente = node.id;
      this.activeSlide = 'regole';
    }
  }

  goBack() {
    this.activeSlide = 'tariffe';
  }

  annullaModifiche() {
    Swal.fire({
      title: 'Annullare le modifiche?',
      text: 'Questa operazione è irreversibile',
      icon: 'warning',
      confirmButtonText: 'Annulla Modifiche',
      showCancelButton: true,
      cancelButtonText: 'No',
      customClass: {
        confirmButton: 'btn-danger'
      }
    }).then(res => {
      if(res.isConfirmed) {
        if(this.regoleTracker) this.regole = this.regoleTracker.getOriginalValue();
        this.pendingRegole = [];
        this.regoleTracker! = new ValueTracker(this.regole);
      }
    })
  }

  loadRegole(idTariffa: number | string) {
    this.loadingRegole = true;
    this.gs.getTrfPerRegole(idTariffa).subscribe(res => {
      this.loadingRegole = false;
      if (!res.esito) {
        this.notifications.push({
          content: 'Errore nel reperimento delle regole. Riprovare.',
          notificationClass: 'error'
        });
        return;
      }
      this.regole = res.info instanceof Object ? res.info : undefined;
      setTimeout(() => {
        if(this.regole) this.regoleTracker = new ValueTracker(this.regole);
        this.changeDetector.detectChanges();
        console.log(this.regoleTracker);
      })
    })
  }

  openModal(content: any) {
    this.modalRef = this.modalEngine.open(content, { modalDialogClass: 'system-modal', size: 'xl' });
    this.formNuovaRegola.reset();
    this.operandiNuovaRegola = [];
  }

  closeModal() {
    this.modalRef?.close();
  }

  salvaPendingRegola() {
    let elemento = this.regole?.elementi.find((el: any) =>
      el.sigla == this.formNuovaRegola.get('elemento')?.value
    );
    let regola: any = {};
    regola.sigla = elemento.sigla;
    regola.descr = elemento.descr;
    regola.id_tariffa = elemento.id;
    regola.id_regola_fatt = "";
    regola.op = this.formNuovaRegola.get('operazione')?.value;
    regola.operandi = [...this.operandiNuovaRegola];
    regola.ord_exec = this.operazioni.length + this.pendingRegole.length + 1;
    elemento.calcolabile = false;
    this.pendingRegole.push(regola);
  }

  salvaPendingRegole() {
    let operazioni = this.operazioni.concat(this.pendingRegole);
    let operazioniMapped = operazioni.map((op: any) => {
      let operandi = op.operandi.map((x: any) => {
        return { id_tariffa: x.id };
      });
      return {
        id_regola_fatt: op.id_regola_fatt,
        op: op.op,
        ord_exec: op.ord_exec,
        id_tariffa: op.id_tariffa,
        operandi: operandi
      }
    });
    this.loadingRegole = true;
    this.gs.updTrfPerRegole(this.idTariffaCorrente!, operazioniMapped).subscribe(res => {
      if (!res.esito) {
        this.notifications.push({
          notificationClass: 'error',
          content: 'Errore nel salvataggio regole.'
        });
        return;
      }
      Swal.fire({
        title: 'Salvataggio riuscito!',
        icon: 'success'
      })
      this.pendingRegole = [];
      this.loadRegole(this.idTariffaCorrente!);
    });
  }

  eliminaLastRegola() {
    let index = this.regole?.operazioni.indexOf(this.lastRegola);
    if (index >= 0) {
      this.regole?.operazioni.splice(index, 1);
    }
    else if ((index = this.pendingRegole.indexOf(this.lastRegola)) >= 0) {
      this.pendingRegole.splice(index, 1);
    }
  }

  onDragOver(ev: DragEvent) {
    ev.preventDefault();
    ev.dataTransfer!.dropEffect = 'move';
  }

  onDrop(ev: DragEvent) {
    ev.preventDefault();
    let container = ev.currentTarget as HTMLElement;
    container.classList.remove('dragging-over');
    let el = document.getElementById(ev.dataTransfer!.getData('text/plain'));
    if (el) {
      container.append(el);
      let operando = this.regole?.elementi.find((op: any) => op.id == el!.id);
      if (container.id === 'operandi-selezionati')
        this.operandiNuovaRegola.push(operando);
      else
        this.operandiNuovaRegola.splice(this.operandiNuovaRegola.indexOf(operando), 1);
    }
  }

  onDragStart(ev: DragEvent) {
    ev.dataTransfer!.dropEffect = 'move';
    ev.dataTransfer?.setData('text/plain', (ev.target as HTMLElement)!.id);
  }

  onDragEnter(ev: DragEvent) {
    let target = ev.currentTarget as HTMLElement;
    if (target) {
      target.classList.add('dragging-over');
    }
  }

  onDragLeave(ev: DragEvent) {
    let target = ev.currentTarget as HTMLElement;
    if (target) {
      target.classList.remove('dragging-over');
    }
  }

  isLastRegola(regola: any) {
    return isDeeplyEqual(regola, this.lastRegola);
  }

  //computed
  get elementiCalcolabili() {
    if (!this.regole) return [];
    return this.regole?.elementi.filter((el: any) => el.calcolabile === true);
  }

  get elementiCalcolati() {
    if (!this.regole) return [];
    return this.regole?.elementi.filter((el: any) => el.calcolabile === false);
  }

  get operazioni() {
    if (!this.regole) return [];
    return this.regole?.operazioni.sort((a: any, b: any) => a.ord_exec - b.ord_exec);
  }

  get lastRegola() {
    return this.pendingRegole.length > 0 ? this.pendingRegole.at(-1) : this.regole?.operazioni.at(-1);
  }

  get areRegoleModified() {
    if(!this.regoleTracker) return this.pendingRegole.length > 0;
    return this.pendingRegole.length > 0 || !this.regoleTracker.isSame;
  }
}
