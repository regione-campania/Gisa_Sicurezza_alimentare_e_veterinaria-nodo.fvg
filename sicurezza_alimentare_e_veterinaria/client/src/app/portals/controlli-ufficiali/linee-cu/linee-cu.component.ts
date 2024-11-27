/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ASmartTableComponent, BackendCommunicationService, LoadingDialogService } from '@us/utils';
import { ControlliUfficialiService } from '../controlli-ufficiali.service';


@Component({
  selector: 'app-linee-cu',
  templateUrl: './linee-cu.component.html',
  styleUrls: ['./linee-cu.component.scss']
})
export class LineeCuComponent implements OnInit {
  @ViewChild('tabellaLinee') tabellaLinee?: ASmartTableComponent;

  private form_ui: any
  btnMode: any = 'view'

  btnSalva: boolean = false;
  controllo_chiuso: boolean = false;
  follow_up: boolean = false;

  private _id_cu?: any;
  private _cu?: any;
  private _ui?: any;
  private _datiTab?: any;
  private _lineeSelezionate: any[] = [];
  private initSel: any[] = [];

  constructor(
    private ComunicazioneDB: BackendCommunicationService,
    private LoadingService: LoadingDialogService,
    private changeDetector: ChangeDetectorRef,
    private route: ActivatedRoute,
    private cus: ControlliUfficialiService
  ) { }

  ngOnInit(): void {
    this.route.queryParams.subscribe((res: any) => {
      this._id_cu = res['id_cu'];

      this.cus.getCuSingolo(this._id_cu).subscribe((res: any) => {
        this._cu = res.info.dati[0]
        this.form_ui = JSON.parse(res.info.ui_def[0].str_conf)
        this.form_ui = (this.form_ui.find((ele: any) => ele.nome === 'cuLinee')) ?? { mode: 'view' } //se non è definito
        this.btnMode = this.form_ui.mode == 'view'

      });
    })
    this.ComunicazioneDB.getDati('get_cu_linee', { id_cu: parseInt(this._id_cu) }).subscribe((res: any) => {
      this.LoadingService.closeDialog();
      this.controllo_chiuso = res.info.controllo_chiuso
      this.follow_up = res.info.follow_up
      this._ui = res.info.ui;
      this._datiTab = res.info.dati;
      this.initSel = [];
      this.datiTab.forEach((ele: any) => {
        if (ele.selezionato == true)
          this.initSel.push(ele);
      });
    })
  }

  ngAfterViewChecked(): void {
    if (this.tabellaLinee?.selectedData) {
      const diff = [
        ...this.getDifference(this.tabellaLinee?.selectedData, this.initSel),
        ...this.getDifference(this.initSel, this.tabellaLinee?.selectedData),
      ];
      if ((diff.length != 0 && this.tabellaLinee?.selectedData.length > 0) && !this.follow_up && !this.btnMode) this.btnSalva = true; else this.btnSalva = false;
      //console.log(diff);
      this.changeDetector.detectChanges();
    }

  }

  getDifference(array1: any[], array2: any[]) {
    return array1.filter((object1) => {
      return !array2.some((object2) => {
        return object1.id_linea === object2.id_linea;
      });
    });
  }
  //Funzione che prende le linee dalla tabella tramite checkbox e le aggiunge all'array delle linee selezionate
  aggiungiLinee() {
    if(this.btnSalva == false) {
      return;
    }
    this._lineeSelezionate = [];
    this.tabellaLinee?.selectedData.forEach((linea: any) => {
      this._lineeSelezionate.push(linea.id_linea);
    });
    if (this._lineeSelezionate.length != 0) {
      this.LoadingService.openDialog('Salvataggio in corso...');
      this.ComunicazioneDB.updDati('upd_cu_linee', { id_cu: parseInt(this._id_cu), id_linea: this._lineeSelezionate }).subscribe((res: any) => {
        //console.log("dati dall'upd: ", res);
        this.ngOnInit();
      })
    }
    //console.log("linee: ", this._lineeSelezionate);
  }

  get ui() { return this._ui };
  get datiTab() { return this._datiTab };
  get id_cu() { return this._id_cu };
  get cu() { return this._cu };
}
