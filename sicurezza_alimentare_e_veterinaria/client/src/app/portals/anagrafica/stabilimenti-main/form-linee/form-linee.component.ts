/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { sliceEventStore } from '@fullcalendar/core/internal';
import { ATreeComponent, ATreeNodeComponent, LoadingDialogService, NotificationService, TreeNode, toTree } from '@us/utils';
import { AnagraficaService } from '../../anagrafica.service';

@Component({
  selector: 'app-form-linee',
  templateUrl: './form-linee.component.html',
  styleUrls: ['./form-linee.component.scss']
})
export class FormLineeComponent implements OnInit {
  //------------------------VARIABILI-------------------------------
  @ViewChild('lineeTree') lineeTree?: ATreeComponent;
  formLinea: FormGroup;
  dataMin: any;
  _id_stabilimento: any;
  private stabilimento: any;
  private _tipoLinee: any;
  private _tipoLineeParsed?: TreeNode;
  private _selectedNodo?: any;
  private _retDatiLinee?: any;
  tipoOperazione: any;
  nodiArray: any = [];
  public hasLineaPrincipale: boolean = false;
  //-----------------------COSTRUTTORE------------------------------
  constructor(private cus: AnagraficaService,
    private LoadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private router: Router,
    private fb: FormBuilder) {
    this.formLinea = this.fb.group({
      //valore: this.fb.control(null, [Validators.required]),
      //data_ultima_visita: this.fb.control(null, [Validators.required]),
      data_inizio_validita: this.fb.control(null, [Validators.required]),
      data_fine_validita: this.fb.control(null),
    })
  }
  //------------------------NGONINIT--------------------------------
  ngOnInit(): void {
    this.route.queryParams.subscribe((res: any) => {
      this._id_stabilimento = res['id_stabilimento'];
      console.log("path form linee:", this.route.snapshot.url[0].path)
      this.tipoOperazione = this.route.snapshot.url[0].path;
      this.cus.getStabilimentoSingolo(this._id_stabilimento).subscribe((res: any) => {
        if (res.esito) {
          this.stabilimento = res.info.dati[0]
          console.log(this.stabilimento)
          this.dataMin = (this.stabilimento.inizio_validita).split('T')[0]
        }
      })
      // this.cus.getStabilimentiLinee(this._id_stabilimento).subscribe((res: any) => {
      //   if (!res.esito) {
      //     this.LoadingService.closeDialog();
      //     return;
      //   }
      //   if (!res.info) {
      //     return;
      //   }
      //   console.log("dati linee", res);
      //   this._retDatiLinee = res.info.dati;
      //   this._retDatiLinee.forEach((l: any) => {
      //     if (l.linea_principale && !l.fine_validita)
      //       this.hasLineaPrincipale = true;
      //   })
      // })
      this.cus.getTipiLinee(this._id_stabilimento).subscribe((res: any) => {
        if (!res.esito) {
          this.LoadingService.closeDialog();
          return;
        }
        if (!res.info) {
          return;
        }
        console.log("dati tipo linee", res);
        this._tipoLinee = res.info.dati;
        this._tipoLineeParsed = toTree(this._tipoLinee, node => {
          //Serve per vedere se c'è la radice, se si all'inizio della pagina mostra già i nodi foglia.
          node.selectable = true;
          node.expanded = node.parent == null ? true : false;
          return node;
        }).root
      })
    })
  }
  //----------------------FUNZIONI-----------------------------------
  checkDate(event: any, form: any) {

    const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
    let src = event.srcElement as HTMLInputElement;
    let nomeForm = null;
    nomeForm = src.getAttribute('formControlName');
    if (!src.validity.valid || !regex.test(src.value)) form.get(nomeForm).setValue("")

    if (src.getAttribute('formControlName') === 'data_fine_validita') {
      if (src.value < form.value.data_inizio_validita)
        form.controls.data_fine_validita.setValue(form.value.data_inizio_validita)
    }

    form.updateValueAndValidity()
  }

  /*prendiValoreAlbero(nodo: ATreeNodeComponent) {
    //console.log("nodo preso: ", nodo.data);
    if (nodo.isLeafNode()) {
      // if (this._selectedNodo) this._selectedNodo.htmlElement.classList.remove('selected');
      // this._selectedNodo = nodo;
      // this._selectedNodo?.htmlElement.classList.add('selected');

    }
  } */
  //----------------------------GETTER E SETTER----------------------
  get tipoLineeParsed() { return this._tipoLineeParsed; }
  get selectedNodo() { return this._selectedNodo; }
}
