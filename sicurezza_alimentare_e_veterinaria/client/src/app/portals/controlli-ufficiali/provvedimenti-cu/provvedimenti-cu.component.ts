/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, ViewChild } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NotificationService, LoadingDialogService, BackendCommunicationService, ATreeComponent, ATreeNodeComponent } from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';
import { AppService } from 'src/app/app.service';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'app-provvedimenti-cu',
  templateUrl: './provvedimenti-cu.component.html',
  styleUrls: ['./provvedimenti-cu.component.scss']
})
export class ProvvedimentiCuComponent {

  @ViewChild('risorseTree') risorseTree?: ATreeComponent;

  _risorse_tree: any

  mappaturaAlberi = ((node: any) => {
    node.selectable = false
    return node
  })

  btnMode: any
  private form_ui: any
  private modalSelezionaVet?: bootstrap.Modal

  private _id_cu: any;
  private _cu: any;
  private _ui: any;
  private _norme: any;

  private _veterinario: any
  private _ui_veterinario: any

  constructor(
    private route: ActivatedRoute,
    private notificationService: NotificationService,
    private fb: FormBuilder,
    private LoadingService: LoadingDialogService,
    private changeDetector: ChangeDetectorRef,
    private client: BackendCommunicationService,
    private router: Router,
    private app: AppService,
    private cus: ControlliUfficialiService
  ) { }


  formVet = this.fb.group({
    id_cu: this.fb.control("", Validators.required),
    id_nominativo: this.fb.control("", Validators.required)
  });

  ngOnInit() {
    this.route.queryParams.subscribe(params => {
      this._id_cu = parseInt(params['id_cu']);

      this.cus.getCuSingolo(this._id_cu).subscribe((res: any) => {
        if (res.info) {
          this._cu = res.info.dati[0]
          this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
          this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'cuProvvedimenti')) ?? { mode: 'view' } //se non è definito
          this.btnMode = this.form_ui.mode == 'view'

          this.cus.getNormeViolate(this._id_cu).subscribe((res: any) => {
            if (res.esito) {
              this._ui = res.info.ui;
              this._norme = res.info.dati;

              this.cus.getNominativoProvvedimenti(this._id_cu).subscribe((res: any) => {
                if (res.info) {
                  this._veterinario = res.info.dati
                  this._ui_veterinario = res.info.ui
                }
              })
            }
          });
        }
      });
    });

    this.modalSelezionaVet = new bootstrap.Modal('#modal-vet');
  }

  openVet() {
    if (this.btnMode == true) {
      return;
    }
    this.formVet.controls.id_cu.setValue(this._id_cu)
    this.app.getNominativiUosByAsl().subscribe((res: any) => {
      if (res.esito) {
        this._risorse_tree = res.info;
        this.modalSelezionaVet?.toggle()
      }
    })
  }

  onTreeNodeClick(node: ATreeNodeComponent) {
    let sel: true | false = true;
    if (node.isLeafNode()) {

      //deseleziona tutti i nodi
      this.risorseTree?.getSelectedLeafNodes().forEach((ele) => {
        ele.selected = false;
        ele.htmlElement.className = '';
      })

      //seleziona quello cliccato
      node.selected = true
      node.htmlElement.className = 'selected'

      //this._risorsaSel = node.data
      //console.log(node.data)
      this.formVet.controls.id_nominativo.setValue(node.data.id_nominativo)

    }
  }

  updVet() {
    if (!this.formVet.valid) {
      return;
    }
    this.modalSelezionaVet?.hide()
    this.LoadingService.openDialog()
    this.client.updDati('upd_cu_upd_nominativo_provv', { ...this.formVet.value }).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      if (res.esito) {
        this.ngOnInit();
        //window.location.reload()
      }
    });
  }

  toProvvedimenti(ar: any) {
    this.router.navigate(["portali/controlli-ufficiali/lista/dettaglio/provvedimenti/aggiungi"], { queryParams: { id_cu: ar.id_cu, id_norma_violata: ar.id_norma_violata} });
  }

  get id_cu() { return this._id_cu }
  get cu() { return this._cu }
  get ui() { return this._ui }
  get norme() { return this._norme }
  get veterinario() { return this._veterinario }
  get ui_veterinario() { return this._ui_veterinario }
}
