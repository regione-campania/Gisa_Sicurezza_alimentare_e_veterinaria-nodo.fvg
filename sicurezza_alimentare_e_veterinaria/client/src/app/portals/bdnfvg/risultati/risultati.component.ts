/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NotificationService, LoadingDialogService, ASmartTableComponent } from '@us/utils';
import { InterventiService } from '../services';
import { Location, formatDate } from '@angular/common';
import Swal from 'sweetalert2';
import { BdnfvgService } from '../bdnfvg.service';

@Component({
  selector: 'app-risultati',
  templateUrl: './risultati.component.html',
  styleUrls: ['./risultati.component.scss']
})
export class RisultatiComponent implements OnInit {
  private _risultati?: any;
  private _ui?: any;
  private _tipiEsito?: any[];
  private _percentage?: any = {};
  private _notAnalyzed?: number;
  private _piano?: string;
  private _nomeAllevamento?: string;
  private _qualificheSanitarie?: any;
  private _qualificheSanitarieGrouped: any[] = [];
  private _infoIntervento?: any;
  private _idPianiIntervento?: any;
  disponibileRdp = null;
  pianiConQualifica?: any = [];

  @ViewChild('risTable') tabella_ris?: ASmartTableComponent;
 // btnInvia?: boolean = false;

  @ViewChild(ASmartTableComponent) tabella?: ASmartTableComponent;

  constructor(
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private route: ActivatedRoute,
    private _location: Location,
    private _is: InterventiService,
    private _bdn: BdnfvgService
  ) {
  }

  ngOnInit(): void {
    this.route.data.subscribe((data: any) => {
      this.loadingService.closeDialog();
      console.log("data:", data);
      if (!data.risultati.esito) {
        this.notificationService.push({
          notificationClass: 'error',
          content: 'Attenzione! Errore durante il caricamento dei dati.'
        });
        return;
      }


      this._risultati = data.risultati?.info.dati;
      console.log("this._risultati:", this._risultati);

      this._ui = data.risultati?.info.ui;
      console.log("this._ui:", this._ui);

      this._tipiEsito = data.risultati.info.tipi_esito;
      console.log("this._tipiEsito:", this._tipiEsito);

      if (this.lengthRis === 0) return;

      // Aggiunge i dati presenti
      this.disponibileRdp =  data.risultati?.info.rdp;
      console.log('this.disponibileRdp', this.disponibileRdp)

      // Recupera le informazioni dell'intervento
      this.loadingService.openDialog('Caricamento qualifiche sanitarie');
      this._is.getInfoIntervento(this.id_intervento).subscribe((resInfoIntervento: any) => {
        this.loadingService.closeDialog();
        console.log("resInfoIntervento:", resInfoIntervento);
        if (!resInfoIntervento.esito) {
          this.notificationService.push({
            notificationClass: 'error',
            content: 'Attenzione! Errore durante il caricamento delle informazioni intervento.'
          });
          return;
        }

        this._infoIntervento = resInfoIntervento.info.dati_info;
        console.log("Info Intervento: ", this._infoIntervento);

        this._idPianiIntervento = [...new Set(this._infoIntervento.map((ii: any) => ii.idpiano))];
        console.log("Piani Intervento:", this._idPianiIntervento);

        this._piano =  [... new Set(this._infoIntervento.map((ii: any) => ii.piano.toUpperCase()))].join(', ');
        this._nomeAllevamento = this._infoIntervento[0].name;

        console.log("this._piano:", this._piano);
        console.log("this._nomeAllevamento:", this._nomeAllevamento);

        // Recupera le qualifiche sanitarie
        this.loadingService.openDialog('Caricamento qualifiche sanitatarie');
        this._is.getQualificheSanitarie(this.id_intervento).subscribe((resQ: any) => {
          console.log("getQualificheSanitarie resQ:", resQ);
          this.loadingService.closeDialog();
          if (!resQ.esito) {
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Attenzione! Errore durante il caricamento dei dati'
            });
            return;
          }
          this._qualificheSanitarie = resQ.info;

          // Filtra solamente le qualifiche sanitarie in base ai piani dell'intervento
          this._qualificheSanitarie = [...new Set(this._qualificheSanitarie?.filter((qs: any) => this._idPianiIntervento.includes(qs.id_piano)))];
          console.log("Qualifiche Sanitarie: ", this._qualificheSanitarie);

          for (let p of [...new Set(this._infoIntervento.map((ii: any) => ii.piano))]) {
            const app: any[] = [];
            let found = false
            for (let qs of this._qualificheSanitarie) {
              if (qs.piano === p){
                app.push(qs);
                found = true;
              }
            }
            if(found)
              this._qualificheSanitarieGrouped.push(app);
          }
          console.log("Qualifiche Sanitarie Raggruppate:", this._qualificheSanitarieGrouped);
          // console.log("Qualifiche Sanitarie Raggruppate:", this.groupBy(this._qualificheSanitarie, 'piano'));

          this._infoIntervento.map((ii: any) => ii.malattia)
          /*for (let m of this._infoIntervento.map((ii: any) => ii.malattia)) {
            this.esitoGroup?.addControl(m, this.fb.control(null, Validators.required));
          }

          console.log("Esito Group Controls:", this.esitoGroup?.controls);*/
        });
      });
    });
    

  }

  chooseEsito(evt: any, qualificaSanitaria: any, idPiano: number) {
    console.log("Qualifica Sanitaria:", qualificaSanitaria);

    Swal.fire({
      title: 'Conferma?',
      text: "Sicuro di voler modificare l'esito dell'intervento?",
      showConfirmButton: true,
      showDenyButton: true,
      confirmButtonText: 'Si',
      denyButtonText: 'No',
      allowOutsideClick: false
    }).then((result) => {
      if (result.isConfirmed) {
        const params: any = {};
        params.p_id_piano = idPiano;
        params.id_intervento = this._infoIntervento[0].id_intervento;
        params.id_qualifica = qualificaSanitaria.id_qualifica;
        params.p_aziende_codice = this._infoIntervento[0].account_number;
        params.p_specie_codice = this._infoIntervento[0].specie_allev;
        params.p_malattia_codice = qualificaSanitaria.codice_malattia;
        params.p_data_rilevazione = formatDate(this._infoIntervento[0].dt, 'yyyy-MM-dd', 'IT-it');
        params.p_qualifica_san_codice = qualificaSanitaria.codice_qualifica;

        console.log("Params:", params);

        this._is.insertInfoSanitarie(params).subscribe((res: any) => {
          console.log("res:", res);
          if(!res.info.esito){
            this.notificationService.push({
              notificationClass: 'error',
              content: res.info.error
            });
            return;
          }
          this.notificationService.push({
            notificationClass: 'success',
            content: 'Invio dati al SANAN avvenuto correttamente!'
          });
          setTimeout(() => { window.location.reload(); }, 1500);
        });

      }
    });
  }


  // Torna alla pagina precedente
  goBack(): void { this._location.back(); }

  // Controlla quale colore dare al bottone
  checkClass(n: number): string {
    let s: string = 'btn-primary';
    switch (n) {
      case 1:
        s = 'btn-outline-success';
        break;
      case 2:
        s = 'btn-outline-info';
        break;
      case 3:
        s = 'btn-outline-warning';
        break;
    }
    return s;
  }

  // Accepts the array and key
  private groupBy(array: any[], key: string | number) {
    // Return the end result
    return array?.reduce((result, currentValue) => {
      // If an array already present for key, push it to the array. Else create an array and push the object
      (result[currentValue[key]] = result[currentValue[key]] || []).push(
        currentValue
      );
      // Return the current iteration `result` value, this will be taken as next iteration `result` value and accumulate
      return result;
    }, {}); // empty object is the initial value for result object
  };

  getIndex(ds: any): number { return this._risultati.indexOf(ds); }

  // Controlla che la proprietà sia false per tutti gli elementi dell'array
  isPropertyFalseForAll(arr: Array<{[key: string]: any}>, property: string): boolean {
    let notQualifica =  arr.every(obj => obj[property] === false);
    if(!notQualifica && this.pianiConQualifica.indexOf(arr[0]['id_piano']) < 0)
      this.pianiConQualifica.push(arr[0]['id_piano']);
    //console.log("this.pianiConQualifica", this.pianiConQualifica)
    return notQualifica;
  }

  isPianoConQualifica(idPiano: any){
    //console.log("isPianoConQualifica", idPiano);
    return this.pianiConQualifica.indexOf(idPiano) > -1;
  }

  //Upd per i risultati dei capi
  changeRisultati(evt : any, index: number, tipo: string) {
    // if(evt.target.value){
    //   this.btnInvia = true;
    // }
    console.log("indice: ", index);
    //Prendo i valori dagli attr
    let _id_capo_intervento = evt.target.attributes.id_capo_intervento.value;
    console.log("id_capo_intervento: ", _id_capo_intervento);
    //Per prendere i due piani singolarmente utilizzo split per levare le virgole
    // e prendo gli indici tramite index che vado a passare
    let _id_piano = evt.target.attributes.id_piano.value.split(',')[index].trim();
    console.log("_id_piano: ", _id_piano);
    //Risultato preso dalla checkbox
    let risultatoPreso = evt.target.value;
    console.log("risultatoPreso: ", risultatoPreso);
    let risultato = risultatoPreso;
    //Costruisco il risultato da mandare
    if(risultatoPreso === 'N') {
      risultato = 'OK';
      console.log("risultato finale di N:", risultato);
    }
    else if (risultatoPreso === 'P') {
      risultato = 'KO'
      console.log("risultato finale di P:", risultato);
    }
    console.log(tipo);
    this._is.updRisultatoCapo(_id_capo_intervento,_id_piano, risultato, tipo).subscribe((res : any) =>{
      console.log("res risultato capi:", res);
    })
  }

  unlock(idRisultato: any, tipo: any){
    this._is.unlockRisultati(idRisultato, tipo).subscribe((res: any) => {
      console.log(this.risultati?.filter((ris: any) => {return ris.id == idRisultato}))
      if(res.esito){
        (this.risultati?.filter((ris: any) => {return ris.id == idRisultato}))[0].unlock_risultati = true;
      }
    })
  }

  //Invio dei risultati al SANAN
  SendDataToSanan(){
    console.log("id_intervento: ", this._risultati[0].id_intervento);
    this.loadingService.openDialog('Invio dati a Sanan');
    this._bdn.invioSanan(this._risultati[0].id_intervento).subscribe((res : any) => {
      this.loadingService.closeDialog();
      if(!res.esito){
        this.notificationService.push({
          notificationClass: 'error',
          content: res.info.error
        });
        return;
      }
      this.notificationService.push({
        notificationClass: 'success',
        content: 'Invio dati al SANAN avvenuto correttamente!'
      });
      setTimeout(() => { window.location.reload(); }, 1500);
    })
  }

  scaricaRdp(rdp_cod: any) {
    this._bdn.getRdpFirmato(rdp_cod)
  }

  get risultati() { return this._risultati; }
  get ui() { return this._ui; }
  get colonne() { return this._ui.colonne; }
  get percentage() { return this._percentage; }
  get notAnalyzed() { return this._notAnalyzed ?? 0; }
  get id_intervento() { return this._risultati[0]?.id_intervento; }
  get lengthRis() { return this._risultati.length; }
  get tipiEsito() { return this._tipiEsito; }
  get tipiEsitoLength() { return this._tipiEsito?.length; }
  get arrPercentage() { return Object.entries(this._percentage); }
  get piano() { return this._piano; }
  get nomeAllevamento() { return this._nomeAllevamento; }
  get qualificheSanitarie() { return this._qualificheSanitarie; }
  get qualificheSanitarieGrouped() { return this._qualificheSanitarieGrouped; }
  get qualificheSanitarieRaggruppate() { return this.groupBy(this._qualificheSanitarie, 'piano'); }
  get rdp_id_sanan () { return this._risultati[0].rdp_id_sanan; }
}
