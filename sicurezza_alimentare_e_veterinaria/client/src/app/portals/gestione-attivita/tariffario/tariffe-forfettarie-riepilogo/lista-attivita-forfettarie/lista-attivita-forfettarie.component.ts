/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { BackendCommunicationService, LoadingDialogService } from '@us/utils';
import { DocumentiService } from 'src/app/portals/gestione-attivita/documenti.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-lista-attivita-forfettarie',
  templateUrl: './lista-attivita-forfettarie.component.html',
  styleUrls: ['./lista-attivita-forfettarie.component.scss']
})
export class ListaAttivitaForfettarieComponent {

  public attivita: any;
  public ui: any;
  public fields: any;
  public anno!: number;
  private stati: any;

  constructor(
    private client: BackendCommunicationService,
    private route: ActivatedRoute,
    private vs: DocumentiService,
    private ls: LoadingDialogService,
  ) { }

  ngOnInit(): void {

    this.route.queryParams.subscribe(params => {
      console.log(params);
      this.anno = parseInt(params['anno']);
      this.ls.openDialog('Caricamento in corso');
      this.client.getDati('get_attivita_forfet', {anno: this.anno}).subscribe(res => {
        this.ls.closeDialog();
        this.attivita = res.info.dati;
        this.ui = res.info.ui;
        this.fields = res.info.ui.colonne;
        console.log(this.attivita)
      })
    })

    this.client.getDati('get_stati_forfet').subscribe(res => {
      this.stati = res.info.dati;
      console.log(res.info.dati);
    })

  }


  async cambiaStato(){
    var daAggiornare: string | any[] = [];
    daAggiornare = this.attivita.filter((a: any) => {return a.selected}).map((a: any) => {return a.id_trf_attivita});
    console.log(daAggiornare);
    if(!daAggiornare.length){
      Swal.fire('Selezionare almeno un\'attività');
    }else{

      let statiOptions = '';
      this.stati.forEach((s: any) => {
        statiOptions += `<option value="${s.id_stato}"> ${s.descr} </option>`
      })

      await Swal.fire({
        icon: 'info',
        html: `
          <p> Selezionare nuovo stato per le attività selezionate: </p>
          <select id="stati" name="stati" style="width: -webkit-fill-available">
            ${statiOptions}
          </select>
          <br> <br>
          `,
        showCancelButton: true,
        confirmButtonText: 'Cambia',
        cancelButtonText: 'Annulla',
      }).then((res: any) => {
        let idStato = parseInt((document.querySelector('#stati') as HTMLInputElement).value);
        console.log(idStato);
        if(res.isConfirmed && idStato){
          this.client.updDati('upd_att_forfet_stato', {id_stato: idStato, attivita: daAggiornare}).subscribe(res => {
            console.log(res);
            if(res.esito){
              Swal.fire('', 'Aggiornamento avvenuto con successo', 'success');
              this.ngOnInit();
            }else{
              Swal.fire('', res.msg!, 'error');
            }
          })
        }

      });
    }
  }

  stampaFattura(attivita: any){
    console.log(attivita);
    this.vs.generaPdf('fattura_tariffa_forfettaria', attivita.id, 'fatturaTariffaForfettaria'+attivita.id+'.pdf', attivita)
  }


}


