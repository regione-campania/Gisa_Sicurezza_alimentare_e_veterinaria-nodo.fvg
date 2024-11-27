/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Input, OnInit } from '@angular/core';
import { baseUri } from 'src/environments/environment';

@Component({
  selector: 'app-preview-certificato',
  templateUrl: './preview-certificato.component.html',
  styleUrls: ['./preview-certificato.component.scss']
})
export class PreviewCertificatoComponent implements OnInit {

  pdfPath!: string;
  private _idModulo?: string;
  private _dataFields?: any;
  private _statoCCAttuale?: any;
  private _canSave?: boolean = false;
  @Input() _id_certificato_compilato?: any;
  @Input() certificatoModificabile?: boolean = true;
  @Input() _stato?: string;

  constructor(
  ) { }

  ngOnInit(): void {
    this.pdfPath = '';
  }

  setPdfPath(data: any) {
    data = JSON.parse(data);
    console.log("data:", data);
    this.pdfPath = data.path;
    this._dataFields = data.data;
    console.log("this.pdfPath:", this.pdfPath);
    console.log("this._dataFields:", this._dataFields);

    let iFrameDiv = document.getElementById("iFrame");
    let ifrm = document.createElement('embed');

    ifrm.setAttribute("id", "frameInterno");
    ifrm.setAttribute("src", baseUri + this.pdfPath + "#toolbar=0&navpanes=0&scrollbar=0");
    ifrm.style.width = "100%";
    ifrm.style.height = "100%";
    if (iFrameDiv?.hasChildNodes()) {
      iFrameDiv?.removeChild(document.getElementById("frameInterno")!);
    }

    iFrameDiv?.appendChild(ifrm);

    setTimeout(() => {
      // console.log("ifrm:", ifrm);
      let selectedFrame = document.querySelector('#frameInterno');
      console.log("selectedFrame:", selectedFrame);
      // console.log("ifrm:", ifrm);
      // let toolbar = ifrm?.contentWindow?.document.querySelector('.toolbar');
      // console.log("toolbar:", toolbar);
      // toolbar.style.display = 'none';
    }, 3000);
  }

  setIdModulo(idModulo: string) {
    this._idModulo = idModulo;
  }

  get idModulo() {
    return this._idModulo;
  }

  get dataFields() {
    return this._dataFields;
  }

  public set setIdCertificato(id_certificato_compilato: any) {
    this._id_certificato_compilato = id_certificato_compilato;
  }

  public get getStatoCCAttuale() {
    return this._statoCCAttuale;
  }

  public get canSave() {
    return this._canSave;
  }

  public set setStatoCCAttuale(stato_attuale: any) {
    this._statoCCAttuale = stato_attuale;
  }

  public set setCanSave(value: boolean) {
    this._canSave = value;
  }

}
