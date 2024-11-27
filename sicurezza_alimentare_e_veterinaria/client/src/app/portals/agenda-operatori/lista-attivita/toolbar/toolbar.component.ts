/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, EventEmitter, Input, OnChanges, OnInit, Output, SimpleChanges, TemplateRef, ViewChild } from "@angular/core";
import { NgbModal, NgbModalRef } from "@ng-bootstrap/ng-bootstrap";
import { ASmartTableComponent, ATreeNodeComponent } from "@us/utils";
import { AbstractControl, FormBuilder, ValidationErrors } from "@angular/forms";
import { AgendaOperatoriService } from "../../agenda-operatori.service";

@Component({
  selector: 'lista-attivita-toolbar',
  templateUrl: './toolbar.component.html',
  styleUrls: ['./toolbar.component.scss']
})
export class ListaAttivitaToolbarComponent implements OnInit {

  @ViewChild('modaleConferma') modaleConferma!: TemplateRef<any>;

  @Input() disabled = false;
  @Input('tabella') tabella?: ASmartTableComponent;
  @Output('onChange') changeEvent = new EventEmitter<any>();

  linee: any;
  lineeLoading = false;
  ns: any;
  nsLoading = false;
  uos: any;
  uosLoading = false;

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
  modaleNuovaAttivitaRef?: NgbModalRef;

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
    private as: AgendaOperatoriService,
    private modalEngine: NgbModal,
    private fb: FormBuilder
  ) { }

  ngOnInit(): void {
    this.init();
  }

  init() {
    this.nsLoading = true;
    this.as.getNs().subscribe(res => {
      this.nsLoading = false;
      if (res.esito) {
        this.ns = res.info;
      }
    });
    this.lineeLoading = true;
    this.as.getLinee().subscribe(res => {
      this.lineeLoading = false;
      if (res.esito) {
        this.linee = res.info;
      }
    });
    this.uosLoading = true;
    this.as.getUos().subscribe(res => {
      this.uosLoading = false;
      if (res.esito) {
        this.uos = res.info.uos;
      }
    });
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
      this.as
        .updEvAssociaLinea(
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
      this.as
        .updEvEliminaLinea(this.tabella!.selectedData.map((el) => el['id']))
        .subscribe((res) => {
          this.changeEvent.emit();
        });
    }
  }

  associaNominativo(nominativo: any) {
    if (this.checkTabella()) {
      this.as
        .updEvAssociaNominativo(
          nominativo.id_ns,
          this.tabella!.selectedData.map((el) => el['id'])
        )
        .subscribe((res) => {
          this.changeEvent.emit();
        });
    }
  }

  //WARNING: nessuna funzione per eliminare nominativo
  /* eliminaNominativo() {
    if (this.checkTabella()) {
      this.gs
        .attEliminaNominativo(this.tabella!.selectedData.map((el) => el['id']))
        .subscribe((res) => {
          this.changeEvent.emit();
        });
    }
  } */

  associaPartner(partner: any) {
    if (this.checkTabella()) {
      this.as.updEvAssociaPartner(
        partner.id_ns,
        this.tabella!.selectedData.map((el) => el['id'])
      ).subscribe((res) => {
        this.changeEvent.emit();
      });
    }
  }

  eliminaPartner() {
    if (this.checkTabella()) {
      this.as
        .updEvEliminaPartner(this.tabella!.selectedData.map((el) => el['id']))
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
        this.as
          .updEvCambiaData(
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

  //WARNING: nessuna funzione per eliminare la data
  /* eliminaData() {
    if (this.checkTabella()) {
      this.as
        .attEliminaData(this.tabella!.selectedData.map((el) => el['id']))
        .subscribe((res) => {
          this.changeEvent.emit();
        });
    }
  } */

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
      this.as
        .updEvAssociaValidita(
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
      this.as
        .updEvEliminaValidita(this.tabella!.selectedData.map(el => el['id']))
        .subscribe(res => {
          this.changeEvent.emit();
        })
    }
  }

  /* eliminaAttivita() {
    if (this.checkTabella()) {
      this.as.updEvElimina(this.attivitaSelezionate)
        .subscribe(res => {
          this.modalEngine.dismissAll();
          this.changeEvent.emit();
        })
    }
  } */

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
      max: `${now.getFullYear()}-12-31`,
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
    return this.tabella.selectedData.some(el => el['risorsa']);
  }

  public get isEliminaPartnerEnabled() {
    if (!this.tabella || !this.tabella.selectedData) return false;
    return this.tabella.selectedData.some(el => el['partner']);
  }

  public get modalitaData() {
    return this.modificaDataForm.get('modalita')!.value;
  }

  public get partnerDisponibili() {
    if (!this.ns) return [];
    return this.ns; //aggiunto per Bug fix #10422
    /* return this.ns.filter((ns: any) => {
      return !(this.tabella?.selectedData.map(att => att['descrizione']).includes(ns.descrizione))
    }); */
  }

  public get attivitaSelezionate() {
    return this.tabella!.selectedData?.map(x => x['id'])
  }

}
