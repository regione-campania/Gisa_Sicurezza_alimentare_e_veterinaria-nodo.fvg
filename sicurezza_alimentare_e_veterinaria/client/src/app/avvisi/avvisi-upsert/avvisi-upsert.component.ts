/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ATreeComponent, BackendCommunicationService, stretchToWindow, toTree, TreeNode } from '@us/utils';
import { formatDate, Location } from '@angular/common';

@Component({
  selector: 'app-avvisi-upsert',
  templateUrl: './avvisi-upsert.component.html',
  styleUrls: ['./avvisi-upsert.component.scss']
})
export class AvvisiUpsertComponent {
  //----------------------VARIABILI------------------
  private _tipo: any;
  private _livello: any;
  private _id_avviso: any;
  operazione: any;
  formAvvisi: FormGroup;
  startMin: string;
  startMax: string;
  endMin: string;
  endMax: string;
  private _today = new Date();
  private _struttura: any;
  struttureTree?: TreeNode;
  @ViewChild('risorsaAvvisiComponent') risorsaAvvisiTree?: ATreeComponent;
  datiSelezionati: any;
  //---------------------COSTRUTTORE-----------------
  constructor(
    private ComunicazioneDB: BackendCommunicationService,
    private route: ActivatedRoute,
    private router: Router,
    private fb: FormBuilder,
    private location: Location,) {
    this.startMin = this.endMin = `${this._today.getFullYear()}-01-01`;
    this.startMax = this.endMax = `${this._today.getFullYear() + 1}-12-31`;
    this.formAvvisi = this.fb.group({
      sigla: this.fb.control(null, [Validators.required]),
      descrizione: this.fb.control(null, [Validators.required]),
      livello: this.fb.control(null, [Validators.required]),
      tipo: this.fb.control(null, [Validators.required]),
      periodo: {
        start: '',
        end: '',
      }
    })
  }
  //---------------------NGONINIT--------------------
  ngOnInit() {
    this.route.queryParams.subscribe((res: any) => {
      console.log(this.route.snapshot.url[0].path)
      this._id_avviso = +res['id_avviso'];
      if (this.route.snapshot.url[0].path == 'aggiungi-avvisi') {
        this.operazione = 'Aggiungi'
        this.ComunicazioneDB.getDati('get_nominativi_avvisi', { struct: 'tree' }).subscribe((res: any) => {
          this._struttura = res.info;
          this.struttureTree = toTree(this._struttura, node => {
            node.expanded = node.parent == null ? true : false;
            node.selectable = true;
            return node;
          }).root;
          setTimeout(() => {
            stretchToWindow(document.getElementById('piani-main-content')!);
          }, 0);
        })
      }
      else {
        this.operazione = 'Modifica'
        this.ComunicazioneDB.getDati('get_nominativi_avvisi', { struct: 'tree', id_avviso: this._id_avviso }).subscribe((res: any) => {
          this._struttura = res.info;
          this.struttureTree = toTree(this._struttura, node => {
            node.expanded = node.parent == null ? true : false;
            node.selectable = true;
            return node;
          }).root;
          setTimeout(() => {
            stretchToWindow(document.getElementById('piani-main-content')!);
          }, 0);
        })
        this.ComunicazioneDB.getDati('get_avviso_singolo', { id_avviso: this._id_avviso }).subscribe((res: any) => {
          const inizioValidita = formatDate(res.info.dati[0].inizio_validita, 'yyyy-MM-ddTHH:mm', 'en');
          const fineValidita = formatDate(res.info.dati[0].fine_validita, 'yyyy-MM-ddTHH:mm', 'en');
          this.formAvvisi.patchValue({
            sigla: res.info.dati[0].sigla,
            descrizione: res.info.dati[0].descrizione,
            livello: res.info.dati[0].id_livello_avviso,
            tipo: res.info.dati[0].id_tipo_avviso,
            periodo: { start: inizioValidita, end: fineValidita }
          })
        })
      }
      this.ComunicazioneDB.getDati('get_tipi_avviso').subscribe((res: any) => {
        if (res.esito) {
          this._tipo = res.info.dati;
        }
      })
      this.ComunicazioneDB.getDati('get_livelli_avviso').subscribe((res: any) => {
        if (res.esito) {
          this._livello = res.info.dati;
        }
      })
    })
  }
  get livello() { return this._livello; }
  get tipo() { return this._tipo; }

  getValoreRisorsa() {
    setTimeout(() => {
      this.datiSelezionati = this.risorsaAvvisiTree?.leafNodes?.filter((node) => node.selected).map((node) => node.data.id)
    });
  }

  //Serve per la modifica
  getValoreRisorsaOnLoad(tree: ATreeComponent) {
    this.risorsaAvvisiTree = tree;
    this.datiSelezionati = this.risorsaAvvisiTree?.leafNodes?.filter((node) => node.selected).map((node) => node.data.id)
  }

  salva() {
    if (!this.formAvvisi.valid ||
      this.risorsaAvvisiTree?.getSelectedLeafNodes().length == 0) {
      return;
    }
    console.log(this.datiSelezionati);
    const params = {
      id_avviso: 0,
      sigla: this.formAvvisi.value.sigla,
      descrizione: this.formAvvisi.value.descrizione,
      id_livello_avviso: +this.formAvvisi.value.livello,
      id_tipo_avviso: +this.formAvvisi.value.tipo,
      periodo: this.formAvvisi.value.periodo
    }
    console.log(params);
    if (this.operazione == 'Aggiungi') {
      this.ComunicazioneDB.updDati('ins_avviso', params).subscribe((res: any) => {
        if (res.esito) {
          this._id_avviso = res.info;
          this.ComunicazioneDB.updDati('upd_risorse_avviso', { id_avviso: this._id_avviso, id_risorse: this.datiSelezionati }).subscribe((res: any) => {
            if (res.esito) {
              this.router.navigate(['avvisi']);
            }
          })
        }
      })
    }
    else {
      params.id_avviso = this._id_avviso
      console.log(this.datiSelezionati);
      this.ComunicazioneDB.updDati('upd_avviso', params).subscribe((res: any) => {
        if (res.esito) {
          this.ComunicazioneDB.updDati('upd_risorse_avviso', { id_avviso: this._id_avviso, id_risorse: this.datiSelezionati }).subscribe((res: any) => {
            if (res.esito) {
              this.router.navigate(['avvisi']);
            }
          })
        }
      })
    }
  }

  goBack() { this.location.back(); }
}
