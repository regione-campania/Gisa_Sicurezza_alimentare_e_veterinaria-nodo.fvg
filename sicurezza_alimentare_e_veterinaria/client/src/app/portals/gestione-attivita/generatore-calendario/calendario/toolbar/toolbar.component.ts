/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, Input, OnChanges, Output, SimpleChanges, TemplateRef, ViewChild } from "@angular/core";
import { NgbModal, NgbModalRef } from "@ng-bootstrap/ng-bootstrap";
import { GeneratoreCalendarioService } from "../../generatore-calendario.service";
import { ASmartTableComponent } from "@us/utils";
import { AbstractControl, FormBuilder, ValidationErrors } from "@angular/forms";

@Component({
  selector: 'cal-toolbar',
  templateUrl: './toolbar.component.html',
  styleUrls: ['./toolbar.component.scss']
})
export class CalToolbarComponent implements OnChanges {
  @ViewChild('modaleConferma') modaleConferma!: TemplateRef<any>;
  @Input() elab?: { id: number, descr: string, bloccato: boolean, elaborato: boolean };
  @Input() disabled = false;
  @Input('tabella') tabella?: ASmartTableComponent;

  @Output('onChange') changeEvent = new EventEmitter<any>();

  linee: any;
  lineeLoading = false;
  ns: any;
  nsLoading = false;
  partner: any;
  partnerLoading = false;

  modaleConfermaConf?: {
    message?: string;
    context?: any;
    confirmAction?: Function;
    cancelAction?: Function;
  };

  //ref modali
  modaleConfermaRef?: NgbModalRef;
  modaleAssociaLineaRef?: NgbModalRef;
  modaleAssociaNsRef?: NgbModalRef;
  modaleAssociaPartnerRef?: NgbModalRef;
  modaleModificaDataRef?: NgbModalRef;
  modaleModificaValiditaRef?: NgbModalRef;

  modificaDataForm = this.fb.group({
    modalita: 'data_esatta',
    data: '',
    shift: { value: 0, disabled: true },
    shift_type: { value: 'giorni', disabled: true },
  });

  modificaValiditaForm = this.fb.group(
    {
      valido_da: '',
      valido_a: '',
    },
    {
      validators: (control: AbstractControl): ValidationErrors | null => {
        let startControl = control.get('valido_da')!;
        let endControl = control.get('valido_a')!;
        if (!startControl.value || !endControl.value) return null;
        let start = new Date(startControl.value);
        let end = new Date(endControl.value);
        if (start > end) return { error: 'start greater than end' };
        return null;
      },
    }
  );

  constructor(
    private gs: GeneratoreCalendarioService,
    private modalEngine: NgbModal,
    private fb: FormBuilder
  ) { }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['elab']) {
      this.init();
    }
  }

  init() {
    if (this.elab) {
      this.lineeLoading = true;
      this.gs
        .getLineeCalendario(this.elab!.id)
        .subscribe((res) => {
          this.lineeLoading = false;
          this.linee = res.info;
        });
      this.nsLoading = true;
      this.gs
        .getNominativiCalendario(this.elab!.id)
        .subscribe((res) => {
          this.nsLoading = false;
          this.ns = res.info;
        });
    }
  }

  openModal(content: any, size: string = 'xl') {
    return this.modalEngine.open(content, {
      centered: true,
      size: size,
      modalDialogClass: 'system-modal',
    });
  }

  openModaleConferma(config: typeof this.modaleConfermaConf) {
    this.modaleConfermaConf = {
      message: config?.message ?? 'Confermare operazione?',
      context: config?.context ?? undefined,
      confirmAction: config?.confirmAction?.bind(this) ?? console.log('Azione non implementata'),
      cancelAction: config?.cancelAction?.bind(this) ?? this.closeModal.bind(this),
    };
    this.modaleConfermaRef = this.openModal(this.modaleConferma, 'md');
  }

  closeModal(modal?: NgbModalRef) {
    if (modal) modal.close();
    else this.modalEngine.dismissAll();
  }

  associaLinea(linea: any) {
    if (this.checkTabella()) {
      this.gs
        .attAssociaLinea(
          linea.id_linea,
          this.tabella!.selectedData.map((el) => el['id'])
        )
        .subscribe((res) => {
          this.changeEvent.emit();
        });
    }
  }

  eliminaLinea() {
    if (this.checkTabella()) {
      this.gs
        .attEliminaLinea(this.tabella!.selectedData.map((el) => el['id']))
        .subscribe((res) => {
          this.changeEvent.emit();
        });
    }
  }

  associaNominativo(nominativo: any) {
    if (this.checkTabella()) {
      this.gs
        .updAttAssociaNominativo(
          nominativo.id_ns,
          this.tabella!.selectedData.map((el) => el['id'])
        )
        .subscribe((res) => {
          this.changeEvent.emit();
        });
    }
  }

  eliminaNominativo() {
    if (this.checkTabella()) {
      this.gs
        .attEliminaNominativo(this.tabella!.selectedData.map((el) => el['id']))
        .subscribe((res) => {
          this.changeEvent.emit();
        });
    }
  }

  associaPartner(partner: any) {
    if (this.checkTabella()) {
      this.gs.updAttAssociaPartner(
        partner.id_ns,
        this.tabella!.selectedData.map((el) => el['id'])
      ).subscribe((res) => {
        this.changeEvent.emit();
      });
    }
  }

  eliminaPartner() {
    if (this.checkTabella()) {
      this.gs
        .updAttEliminaPartner(this.tabella!.selectedData.map((el) => el['id']))
        .subscribe((res) => {
          this.changeEvent.emit();
        });
    }
  }

  openModificaData(modal: any) {
    this.modificaDataForm = this.fb.group({
      modalita: 'data_esatta',
      data: '',
      shift: { value: 0, disabled: true },
      shift_type: { value: 'giorni', disabled: true },
    });
    this.modaleModificaDataRef = this.openModal(modal);
  }

  modificaData() {
    if (this.checkTabella()) {
      let dateOrShift;
      if (this.modificaDataForm.get('modalita')!.value === 'data_esatta') {
        dateOrShift = this.modificaDataForm.get('data')!.value;
      }
      else {
        dateOrShift = {
          shift: this.modificaDataForm.get('shift')!.value!,
          shiftType: this.modificaDataForm.get('shift_type')!.value!,
        };
      }
      if (dateOrShift) {
        this.gs
          .attCambiaData(
            dateOrShift as any,
            this.tabella!.selectedData.map((el) => el['id'])
          )
          .subscribe((res) => {
            this.changeEvent.emit();
          });
      }
    }
    this.closeModal(this.modaleModificaDataRef);
  }

  eliminaData() {
    if (this.checkTabella()) {
      this.gs
        .attEliminaData(this.tabella!.selectedData.map((el) => el['id']))
        .subscribe((res) => {
          this.changeEvent.emit();
        });
    }
  }

  openModificaValidita(modal: any) {
    this.modificaValiditaForm = this.fb.group(
      {
        valido_da: '',
        valido_a: '',
      },
      {
        validators: (control: AbstractControl): ValidationErrors | null => {
          let startControl = control.get('valido_da')!;
          let endControl = control.get('valido_a')!;
          if (!startControl.value || !endControl.value) return null;
          let start = new Date(startControl.value);
          let end = new Date(endControl.value);
          if (start > end) return { error: 'start greater than end' };
          return null;
        },
      }
    );
    this.modaleModificaValiditaRef = this.openModal(modal);
  }

  modificaValidita() {
    if (this.checkTabella()) {
      this.gs
        .attAssociaValidita(
          this.modificaValiditaForm.get('valido_da')!.value!,
          this.modificaValiditaForm.get('valido_a')!.value!,
          this.tabella!.selectedData.map((el) => el['id'])
        )
        .subscribe((res) => {
          this.changeEvent.emit();
        });
    }
    this.closeModal(this.modaleModificaValiditaRef);
  }

  eliminaValidita() {
    if (this.checkTabella()) {
      this.gs
        .attEliminaValidita(this.tabella!.selectedData.map(el => el['id']))
        .subscribe(res => {
          this.changeEvent.emit();
        })
    }
  }

  //helpers
  checkTabella() {
    if (this.tabella) return true;
    console.error("Referenza tabella mancante");
    return false;
  }

  getPeriodo() {
    const now = new Date();
    return {
      min: `${now.getFullYear()}-01-01`,
      max: `${now.getFullYear()+1}-12-31`,
    }
  }

  onModalitaDataChange() {
    let data = this.modificaDataForm.get('data');
    let shift = this.modificaDataForm.get('shift');
    let shiftType = this.modificaDataForm.get('shift_type');
    if (this.modificaDataForm.get('modalita')!.value === 'data_esatta') {
      data?.enable();
      shift?.disable();
      shiftType?.disable();
    } else {
      data?.disable();
      shift?.enable();
      shiftType?.enable();
    }
  }

  //computed
  public get isEliminaIspettoreEnabled() {
    if (!this.tabella || !this.tabella.selectedData) return false;
    return this.tabella.selectedData.some(el => el['nominativo']);
  }

  public get isEliminaPartnerEnabled() {
    if (!this.tabella || !this.tabella.selectedData) return false;
    return this.tabella.selectedData.some(el => el['nominativo_partner']);
  }

  public get modalitaData() {
    return this.modificaDataForm.get('modalita')!.value;
  }

  public get partnerDisponibili() {
    if (!this.ns) return [];
    return this.ns; //aggiunto per Bug fix #10422
    /* return this.ns.filter((ns: any) => {
      return !(this.tabella?.selectedData.map(att => att['nominativo']).includes(ns.nominativo))
    }); */
  }

}
