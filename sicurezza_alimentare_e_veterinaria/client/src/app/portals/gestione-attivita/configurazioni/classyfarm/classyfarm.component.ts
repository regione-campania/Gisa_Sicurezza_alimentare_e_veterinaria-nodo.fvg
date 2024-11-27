/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Input, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { InfoStrutturaPrimaria } from '../types';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { FormBuilder, Validators } from '@angular/forms';
import { BackendCommunicationService, Utils } from '@us/utils';
import { baseUri } from 'src/environments/environment';
import Swal from 'sweetalert2';

@Component({
  selector: 'classyfarm-conf',
  templateUrl: './classyfarm.component.html',
  styleUrls: ['./classyfarm.component.scss']
})
export class ClassyfarmComponent implements OnInit {
  @ViewChild('importFileModalTemplateClassy') importFileModalTemplateClassy!: TemplateRef<any>;
  @Input() info?: InfoStrutturaPrimaria;
  importFileModalRef?: NgbModalRef;
  fileSelezionato = null;
  filenameControl = this.fb2.control('', Validators.required);
  ui: any = null;
  liste = [];
  listaSelezionata: any = null;

  constructor(
    private modalEngine: NgbModal,
    private fb2: FormBuilder,
    private bc: BackendCommunicationService
  ) { }

  ngOnInit(): void {
    this.info!.active = true;
    this.bc.getDati('get_cf_liste').subscribe(res => {
      console.log('get_cf_liste', res);
      this.ui = res.info.ui;
      this.liste = res.info.dati;

    })
  }

  async addAnno() {
    let currAnno = new Date().getFullYear();
    const { value: anno } = await Swal.fire({
      title: '',
      input: 'number',
      inputValue: currAnno,
      inputLabel: 'Anno da importare',
      inputPlaceholder: 'YYYY'
    })

    if (!anno) {
      return;
    }
    if (anno < currAnno || isNaN(anno)) {
      Swal.fire(`Anno non valido`);
      return;
    }
    let found = false;
    this.liste.forEach((l: any) => {
      if (l.anno == anno)
        found = true;
    })
    if (found) {
      Swal.fire(`Anno già inserito`);
      return;
    }

    this.bc.updDati('ins_cf_lista', { anno: parseInt(anno) }).subscribe(res => {
      console.log(res);
      this.ngOnInit();
    })
  }

  openImportFilenameModalClassy(idLista: any) {
    this.listaSelezionata = idLista;
    this.fileSelezionato = null;
    this.filenameControl.reset();
    this.importFileModalRef = this.modalEngine.open(this.importFileModalTemplateClassy, {
      modalDialogClass: 'system-modal', centered: true
    })
  }

  importFile(idLista: any) {
    if (this.fileSelezionato) {
      Utils.importXlsxWithSheetJS(this.fileSelezionato)
        .then(wb => {
          let datiDaCaricare = [];
          console.log(wb);
          let ref = wb.Sheets[wb.SheetNames[0]]?.['!ref'];
          let maxRow = parseInt(ref?.split(':')[1].split('B')[1]!);
          console.log(maxRow);
          for(let i = 2; i <= maxRow; i++){
            datiDaCaricare.push({
              cod_allevamento: wb.Sheets[wb.SheetNames[0]]?.[`A${i}`].v, 
              attributo: wb.Sheets[wb.SheetNames[0]]?.[`B${i}`].v
            })
          }
          console.log(datiDaCaricare);
          this.bc.updDati('load_cf_allevamenti', {id_lista: idLista, lista_cf: datiDaCaricare}).subscribe(res => {
            console.log(res);
            this.ngOnInit();
            this.importFileModalRef?.dismiss();
          })
        })
    }
  }

  exportAllevamenti(idLista: any,  anno: any){
    this.bc.getDati('get_cf_allevamenti', {id_lista: idLista}).subscribe(res => {
      console.log(res);
      let dati: any[] = [];
      res.info.dati.forEach((d: any) => {
        dati.push([d.cod_allevamento, d.attributo]);
      })
      Utils.exportXlsxWithSheetJs([{
          intestazione: "",
          nome_foglio: "Allevamenti ClassyFarm",
          intestazione_colonne: ["Allevamento", "Attributo"],
          dati: dati
        }],
        'Allevamenti ClassyFarm ' + anno
      )
    })
  }

  async downloadTemplateXLSX() {
    const filename: string = 'template_classyfarm_allevamenti.xlsx';
    const pathfile: string = 'excel\\template_classyfarm_allevamenti.xlsx';

    // Recupera il blob file
    let blob = await fetch(baseUri + pathfile).then(r => r.blob());

    // Crea un tag node fittizio per effettuare il download
    let link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = filename!;
    link.click();
    link.remove();
    URL.revokeObjectURL(baseUri + pathfile);
  }

}



