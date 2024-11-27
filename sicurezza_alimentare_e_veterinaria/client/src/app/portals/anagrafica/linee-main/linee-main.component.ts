/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, ViewChild } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { ATreeComponent, FormConfig, LoadingDialogService } from '@us/utils';
import { AnagraficaService } from '../anagrafica.service';
import { map, of } from 'rxjs';
import { SharedService } from 'src/app/shared/shared.service';

@Component({
  selector: 'app-linee-main',
  templateUrl: './linee-main.component.html',
  styleUrls: ['./linee-main.component.scss'],
})
export class LineeMainComponent {
  @ViewChild('tipo_linee_tree') tipo_linee_tree?: ATreeComponent;

  private _strutture_asl: any;
  private _ui_linee: any;
  private _linee: any;
  tipi_linee: any;

  ready = false;
  loadingLinee = false;

  formConfig: any;

  constructor(
    private LoadingService: LoadingDialogService,
    private fb: FormBuilder,
    private ans: AnagraficaService,
    private router: Router,
    private route: ActivatedRoute,
    private sharedService: SharedService
  ) {}

  ngOnInit() {
    this.LoadingService.openDialog();
    this.ans.getStruttureAsl().subscribe((res: any) => {
      if (res.info) {
        this._strutture_asl = res.info.dati;
        this.ans
          .getTipiLinee({ id_stabilimento: null })
          .subscribe((res: any) => {
            this.ready = true;
            if (res.info) {
              this.tipi_linee = res.info.dati;
              this.formConfig = this.sharedService
                .getFormDefinition('cu/', 'cu.sel_linee')
                .pipe(
                  map((res) => {
                    let info = JSON.parse(res.info[0]['configurazione']);
                    let aslControl = info['controls'].find(
                      (c: any) => c.name == 'id_asl'
                    );
                    if (aslControl) {
                      aslControl.options.push({
                        value: null,
                        innerText: '',
                        selected: true,
                      });
                      aslControl.options.push(
                        ...this._strutture_asl.map((obj: any) => {
                          return {
                            value: obj.id_asl,
                            innerText: obj.descrizione,
                          };
                        })
                      );
                    }
                    let treeControl = info['controls'].find(
                      (c: any) => c.name == 'id_tipo_linea'
                    );
                    if (treeControl) {
                      treeControl.options.config = this.tipi_linee;
                    }
                    this.LoadingService.closeDialog();
                    return { info: info };
                  })
                );
            }
          });
      }
    });
  }

  ricercaLinea(params: any) {
    this.loadingLinee = true;
    this._linee = null;
    this._ui_linee = null;
    params.id_tipo_linea = params.id_tipo_linea.map((id: any) => +id);
    this.ans.getLineeBySel(params).subscribe((res: any) => {
      this.loadingLinee = false;
      if (res.info) {
        this._linee = res.info.dati;
        this._ui_linee = res.info.ui;
      }
    });
  }

  goToDettaglio(id_linea: any) {
    this.router.navigate(['portali/anagrafica/stabilimenti/linee'], {
      queryParams: { id_linea: id_linea },
    });
  }

  get strutture_asl() {
    return this._strutture_asl;
  }
  get ui_linee() {
    return this._ui_linee;
  }
  get linee() {
    return this._linee;
  }
}
