/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { BackendCommunicationService, LoadingDialogService } from '@us/utils';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-tariffe-forfettarie-riepilogo',
  templateUrl: './tariffe-forfettarie-riepilogo.component.html',
  styleUrls: ['./tariffe-forfettarie-riepilogo.component.scss']
})
export class TariffeForfettarieRiepilogoComponent {

  public tariffe: any;
  public ui: any
  public fields: any;

  constructor(
    private client: BackendCommunicationService,
    private ls: LoadingDialogService
  ) { }

  ngOnInit(): void {

    this.ls.openDialog('Caricamento in corso');
    this.client.getDati('get_att_forf_riep').subscribe(res => {
      this.ls.closeDialog();
      this.tariffe = res.info.dati;
      this.ui = res.info.ui;
      this.fields = res.info.ui.colonne;
      this.tariffe.sort((a: any, b: any) => a.anno - b.anno);
      console.log(this.tariffe)
    })
  }

  crea() {
    var max = new Date().getFullYear();
    this.tariffe?.forEach((t: any) => {
      if (parseInt(t.anno) > max)
        max = parseInt(t.anno);
    })
    if (max == new Date().getFullYear()) { // non è cambiato
      max++
    };

    Swal.fire({
      title: 'Inserire anno',
      input: 'number',
      inputValue: max,
      inputAttributes: {
        autocapitalize: 'off',
      },
      showCancelButton: true,
      confirmButtonText: 'OK',
    }).then((result) => {
      if (result.isConfirmed) {
        let anno = result.value
        let error = false;
        this.tariffe?.every((t: any) => {
          if(parseInt(t.anno) == parseInt(anno)){
            error = true;
            return false;
          }
          return true;
        })
        if(error){
          alert('Anno già presente');
          this.crea();
        }else if(Number.isNaN(anno)){
          alert("Anno non valido!");
          this.crea();
        }
        else if(anno < max){
          alert("Anno deve essere almeno " + max);
          this.crea();
        }else{ //OK
          this.client.updDati('build_att_forfet', {anno: anno}).subscribe(res => {
            console.log(res);
            if(res.esito){
              Swal.fire('', res.msg!, 'success');
              this.ngOnInit();
            }else{
              Swal.fire('', res.msg!, 'error');
            }
          })
        }
      }
    })
  }

}


