/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { LoadingDialogService, Utils } from '@us/utils';
import { InfoStrutture } from './types';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import * as XLSX from "xlsx";
import Swal from 'sweetalert2';
import { GestioneAttivitaService } from '../gestione-attivita.service';
import { PianiComponent } from './piani/piani.component';

@Component({
  selector: 'app-configurazioni',
  templateUrl: './configurazioni.component.html',
  styleUrls: ['./configurazioni.component.scss']
})
export class ConfigurazioniComponent implements OnInit {
  //import/export templates
  @ViewChild('exportModalTemplate') exportModalTemplate!: TemplateRef<any>;
  @ViewChild('exportInfoModalTemplate') exportInfoModalTemplate!: TemplateRef<any>;
  @ViewChild('exportFilenameModalTemplate') exportFilenameModalTemplate!: TemplateRef<any>;
  @ViewChild('importModalTemplate') importModalTemplate!: TemplateRef<any>;
  @ViewChild('importFileModalTemplate') importFileModalTemplate!: TemplateRef<any>;

  @ViewChild('pianiConf') pianiConfCmp?: PianiComponent;

  //form controls
  exportChecklist?: FormGroup;
  importChecklist?: FormGroup;
  filenameControl = this.fb.control('', Validators.required);
  fileSelezionato = null;


  //modal references
  exportModalRef?: NgbModalRef;
  exportFilenameModalRef?: NgbModalRef;
  exportInfoModalRef?: NgbModalRef;
  importModalRef?: NgbModalRef;
  importFileModalRef?: NgbModalRef;

  datiEsportazione: any;
  fogliDaImportare: Record<string, XLSX.WorkSheet> = {};
  readonly nomiFogli = [
    'UOS_COMUNI',
    'UOC_PIANI',
    'PERSONE_COMUNI',
    'PERSONE_PIANI',
    'PERSONE_LINEE',
    'PIANI_TIPOLINEA',
    'PIANI_FREQUENZE',
    'PIANI_TARIFFE',
  ]

  infoStrutture: InfoStrutture = [];

  constructor(
    private gs: GestioneAttivitaService,
    private loading: LoadingDialogService,
    private fb: FormBuilder,
    private modalEngine: NgbModal
  ){}

  ngOnInit(): void {
    this.loading.openDialog();
    this.gs.getMenu('config').subscribe(res => {
      this.loading.closeDialog();
      //parsing voci menu
      let info = res.info as Array<any>;
      let temp: any, i: number = 0;
      info.forEach((x: any) => {
        let cod = x.cod.substring(0, x.cod.indexOf('-'));
        if (cod == temp) return;
        //calcolo strutture associate
        let struttureAssociate =
          info
            .filter((y: any) => y.cod.substring(0, y.cod.indexOf('-')) == cod)
            .map((y: any, i: number) => {
              return {
                ord: i,
                label: y.descr.substring(y.descr.indexOf('-')+2),
                descr: y.descr.substring(y.descr.indexOf('-')+2),
                modality: y.modality,
                active: i == 0
              }
            });
        //calcolo descrizione
        let descr = "";
        switch(cod) {
          case 'uos': descr = 'Unità Operative Semplici'; break;
          case 'uoc': descr = 'Unità Operative Complesse'; break;
          case 'persone': descr = 'Risorse'; break;
          default: descr = x.descr.substring(0, x.descr.indexOf(' -'));
        }
        this.infoStrutture.push({
          ord: i,
          label: x.descr.substring(0, x.descr.indexOf(' -')),
          descr: descr,
          struttureAssociate: struttureAssociate,
          active: i == 0
        });
        //incremento variabili
        temp = cod;
        i++;
      });
    })
  }

  getInfoStruttura(primariaLabel: string, secondariaLabel?: string) {
    let sp = this.infoStrutture.find(s => s.label == primariaLabel);
    if (!secondariaLabel) return sp;
    let ss = sp?.struttureAssociate.find(s => s.label == secondariaLabel);
    return ss;
  }

  setStrutturaAttiva(primariaLabel: string, secondariaLabel?: string) {
    let struttura = this.getInfoStruttura(primariaLabel, secondariaLabel);
    if (struttura) {
      if ('struttureAssociate' in struttura) { //è una struttura primaria
        if (struttura != this.strutturaPrimariaAttiva) {
          this.strutturaPrimariaAttiva!.active = false;
          struttura.active = true;
        }
      } else { //è una struttura secondaria
        if (struttura != this.strutturaSecondariaAttiva) {
          this.strutturaSecondariaAttiva!.active = false;
          struttura.active = true;
        }
      }
    }
  }

  /*** metodi import/export - START ***/

  openExportModal() {
    this.exportChecklist?.reset();
    this.exportModalRef = this.modalEngine.open(this.exportModalTemplate, {
      modalDialogClass: 'system-modal', size: 'xl', centered: true
    });
    this.gs.getExpConf().subscribe(res => {
      if (res.esito) {
        let controls = this.fb.array<FormGroup>([]);
        res.info.dati.forEach((el: any) => {
          let mapped = { ...el, selezionato: false };
          controls.push(this.fb.group(mapped));
        });
        this.exportChecklist = this.fb.group({ dati: controls }, {
          validators: (group) => {
            let array = group.get('dati') as FormArray;
            if (array.controls.some(c => c.get('selezionato')?.value === true))
              return null;
            return { error: 'Selezionare almeno un elemento!' }
          }
        });
      }
    })
  }

  closeExportModal() {
    this.exportModalRef?.close();
  }

  openExportFilenameModal() {
    this.filenameControl.reset();
    this.exportFilenameModalRef = this.modalEngine.open(this.exportFilenameModalTemplate, {
      modalDialogClass: 'system-modal', centered: true
    });
  }

  closeExportFilenameModal() {
    this.exportFilenameModalRef?.close();
  }

  esportaConfigurazioni() {
    this.datiEsportazione = null;
    this.loading.openDialog('Esportazione in corso...');
    let ids = (this.exportChecklist?.get('dati')! as FormArray).controls
      .filter(c => c.get('selezionato')!.value === true)
      .map(c => c.get('id')!.value);
    this.gs.getExpDati(ids).subscribe(res => {
      if (res.esito) {
        this.datiEsportazione = res.info;
        this.datiEsportazione.forEach((x: any) => {
          x.intestazione = `${x.nome_foglio} ${new Date().toLocaleString()}`;
        })
        Utils.exportXlsxWithSheetJs(this.datiEsportazione, this.filenameControl.value!);
        this.loading.closeDialog();
        this.modalEngine.dismissAll();
        this.openExportInfoModal();
      }
    });
  }

  openExportInfoModal() {
    this.exportInfoModalRef = this.modalEngine.open(this.exportInfoModalTemplate, {
      modalDialogClass: 'system-modal', centered: true, size: 'md'
    });
  }

  closeExportInfoModal() {
    this.exportInfoModalRef?.close();
  }

  openImportFileModal() {
    this.fileSelezionato = null;
    this.fogliDaImportare = {};
    this.importChecklist?.reset();
    this.importFileModalRef = this.modalEngine.open(this.importFileModalTemplate, {
      modalDialogClass: 'system-modal', centered: true
    })
  }

  closeImportFileModal() {
    this.importFileModalRef?.close();
  }

  openImportModal() {
    this.importModalRef = this.modalEngine.open(this.importModalTemplate, {
      modalDialogClass: 'system-modal', centered: true
    })
  }

  closeImportModal() {
    this.importModalRef?.close();
  }

  importaConfigurazioni() {
    if (this.fileSelezionato) {
      Utils.importXlsxWithSheetJS(this.fileSelezionato)
        .then(wb => {
          console.log(wb);
          this.fogliDaImportare = wb.Sheets;
          for (let key of this.fogliDaImportareKeys) {
            if (!this.nomiFogli.includes(key)) {
              Swal.fire({
                title: 'Errore nomi foglio',
                text: 'Questo accade quando si modifica il nome di un foglio, mettendone uno non valido. Cambiare il nome dei fogli errati e riprovare',
                confirmButtonText: 'OK',
              });
              return;
            }
          }
          this.importChecklist = this.fb.group({});
          this.fogliDaImportareKeys.forEach(key => {
            this.importChecklist?.addControl(key, this.fb.control(false));
          })
          this.importChecklist.addValidators((control) => {
            let group = control as FormGroup;
            for (let key in group.controls) {
              if (group.get(key)?.value === true)
                return null;
            }
            return { error: 'Selezionare almeno un elemento!' };
          })
          this.openImportModal();
        })
        .finally(() => {
          this.closeImportFileModal();
        })
    }
  }

  confermaImportazione() {
    this.closeImportModal();
    if (this.importChecklist) {
      console.log('CONFERMATO');
      let configurazioni =
        Object.entries(this.importChecklist.controls)
          .filter((el) => el[1].value === true)
          .map(el => el[0]);
      console.log(configurazioni);
      //TODO: api call alla funzione del db che importa le configurazioni
      Swal.fire({
        icon: 'success',
        text: 'Configurazioni importate correttamente.',
      })
    }
  }

  /*** metodi import/export - END ***/

  //computed

  get strutturaPrimariaAttiva() {
    return this.infoStrutture.find(s => s.active);
  }

  get strutturaSecondariaAttiva() {
    return this.strutturaPrimariaAttiva?.struttureAssociate.find(s => s.active);
  }

  get exportChecklistControls() {
    return (this.exportChecklist?.get('dati') as FormArray).controls;
  }

  get fogliDaImportareKeys() {
    return Object.keys(this.fogliDaImportare);
  }
}
