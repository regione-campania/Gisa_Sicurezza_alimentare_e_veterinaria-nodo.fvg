/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Input,OnInit, ViewChild,TemplateRef } from '@angular/core';
import {ASmartTableComponent,LoadingDialogService, BackendCommunicationService, Utils ,NotificationService, isValidDate} from '@us/utils';
import { formatDate } from '@angular/common';
import { AnagraficaService } from 'src/app/portals/anagrafica/anagrafica.service';

import {  AppService} from 'src/app/app.service';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { ActivatedRoute, Router } from '@angular/router';
import {  Validators ,FormBuilder} from '@angular/forms';
import { baseUri } from 'src/environments/environment';

import * as XLSX from 'xlsx';


import Swal from 'sweetalert2';
@Component({
  selector: 'tipo-liste',
  templateUrl: './tipo-liste.component.html',
  styleUrls: ['./tipo-liste.component.scss']
})
export class TipoListeComponent implements OnInit {

  @ViewChild(ASmartTableComponent) tabella?: ASmartTableComponent;

  tipoliste?: any;
  tipoimportLista?: any;
  isRuoloAbilitato?:boolean=false;
  private _ui?: any;
  private _ui_old?: any;
  private _tipoimport_ui?: any;
  operazione = 'Import';
  tipoImport:any;
  data_estr_file:any;




  constructor(


    private fb2: FormBuilder,
    private gs: AnagraficaService,
    private ap: AppService,
    private client: BackendCommunicationService,
    private notificationService: NotificationService,
    private modalEngine: NgbModal,
    private loadingService: LoadingDialogService,

  ) { }

  ngOnInit(): void {

    this.loadUtente();
    this.loadTipoImport();
    this._initElencoImportAnagrafica();

  }

  private loadUtente() {
    this.ap.getUser().subscribe((res) => {
      console.log(res);
 //    if(res.esito) {
        console.log("res.info.user_info.id_ruolo",res.idRuolo);
      if( res.id_ruolo == 0) {
       this.isRuoloAbilitato=true;

      }
   // }
     });
  }

  private loadTipoImport() {
    this.gs.getTipoImport().subscribe((res) => {
      console.log(res);
      if(res.esito) {
      this._tipoimport_ui = res?.info?.ui;
      this.tipoimportLista = res?.info?.dati;
      }
    });
  }

  private _initElencoImportAnagrafica() {

    this.loadingService.openDialog();
    this.gs.getElencoImportAnagrafica().subscribe((res) => {
      console.log(res);
      if(res.esito) {
      this.tipoliste = res.info.dati;

      if( this._ui_old==null){
       this._ui = res.info.ui;
       this._ui_old=this._ui ;
     }else{
       this._ui =this._ui_old;
     }
    }

     this.loadingService.closeDialog();
    });


  }


  get ui() { return this._ui; }


  openPopup(event: any, modalRef: any, op: string) {
    console.log("operazione"+op);
    return this.modalEngine.open(modalRef, { modalDialogClass: 'system-modal modal-xl' });
  }

  finestraTipoLista?: NgbModalRef;



  closePopup() {
   this.finestraTipoLista?.close();
   this._initElencoImportAnagrafica();
  }




  @ViewChild('importFileModalTemplateClassy') importFileModalTemplateClassy!: TemplateRef<any>;
  importFileModalRef?: NgbModalRef;
  fileSelezionato = null;
  filenameControl = this.fb2.control('', Validators.required);

  listaSelezionata: any = null;

  disableImportButton=false;


  openImportFilenameModalClassy(idLista: any) {
    this.listaSelezionata = idLista;
    this.fileSelezionato = null;
    this.filenameControl.reset();
    this.importFileModalRef = this.modalEngine.open(this.importFileModalTemplateClassy, {
      modalDialogClass: 'system-modal', centered: true
    })
  }

  importFile(idLista: any) {



    if ((<HTMLInputElement>document.querySelector('input[name="tipoimport"]:checked ')) ==null) {
      this.notificationService.push({
        notificationClass: 'error',
        content: `Attenzione! Inserire il formato.`
      });
      return;
    }
    else{
     this.tipoImport=(<HTMLInputElement>document.querySelector('input[name="tipoimport"]:checked')).id;
    }
   let startDate :any;
   startDate= document.getElementById('dt_sintesis')
   this.data_estr_file=startDate.value;
   console.log("startDate.value",startDate.value);

    console.log("startDate.value cf ",   startDate.value==='' );

    if (   this.data_estr_file ==='' || this.data_estr_file==null )
         {
      this.notificationService.push({
        notificationClass: 'error',
        content: `Attenzione! Inserire la data sintesis.`
      });
      return;
    }




    if(((this.fileSelezionato! as File).size / 1024 / 1024) > 20){
      this.notificationService.push({
        notificationClass: 'warning',
        content: 'Attenzione! Dimensione massima consentita 20mb'
      });

      return;
    }

    console.log("this.fileSelezionato", this.fileSelezionato);

    if (this.fileSelezionato &&  this.tipoImport!="" && this.data_estr_file!=null) {
      console.log("this.fileSelezionato", this.fileSelezionato);

      this.loadingService.openDialog('Invio in corso');
      Utils.importXlsxWithSheetJS(this.fileSelezionato)
        .then(wb => {
          console.log("importFile" );

          var ws:any = wb.Sheets[wb.SheetNames[0]];

          var range = {s:{r:Infinity, c:Infinity},e:{r:0,c:0}};
          Object.keys(ws).filter(function(x) { return x.charAt(0) != "!"; }).map(XLSX.utils.decode_cell).forEach(function(x) {
            range.s.c = Math.min(range.s.c, x.c); range.s.r = Math.min(range.s.r, x.r);
            range.e.c = Math.max(range.e.c, x.c); range.e.r = Math.max(range.e.r, x.r);
          });
          ws['!ref'] = XLSX.utils.encode_range(range);

          let datiDaCaricare = [];
          console.log("wb"+wb);
          let ref = wb.Sheets[wb.SheetNames[0]]?.['!ref'];
          let maxRow =0;




          let funzioneload='';
       //   if(    this.tipoImport==19||this.tipoImport==20 || this.tipoImport==21 ||  this.tipoImport==22   ){
           if 	(  this.tipoImport == '852I' || this.tipoImport ==  'AAE'  || this.tipoImport == '853'|| this.tipoImport == '1069')  {
            console.log("sono nel tipoimport",this.tipoImport );
            var sheet1:any = wb.Sheets[wb.SheetNames[0]];
            var range = XLSX.utils.decode_range(sheet1['!ref']);
            maxRow=range.e.r;

            console.log("range r"+range.e.r);
            console.log("range c"+range.e.c);
            if(range.e.c==23){
            maxRow=range.e.r;

            console.log("maxRow"+maxRow);
            funzioneload='load_import_anagrafica';



            for(let i = 2; i <= maxRow+1; i++){

                let data_inizioA ="";

             //   console.log ("colonna data inizio att",wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`].v);
                if(wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`]!=null &&  wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`]!== undefined
                &&  wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`].v!=='' ) {
                  if( wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`].t =='n'){

                    data_inizioA= formatDate( new Date(Math.round(( wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`].v) - 25569) * 86400 * 1000) ,'dd/MM/yyyy',"it-IT") ;
              //     console.log("data inizio att dopo ",wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`].v);
                  }
                  else{
              //     console.log ("sono primo else");
                    data_inizioA =wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`].v =='-'?"":  wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`].v  ;
                  //  console.log("data inizio att dopo",wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`].v);
                  }
                }

                let data_fine_A ="";
                if( wb.Sheets[wb.SheetNames[0]]?.[`R${i}`]!=null && wb.Sheets[wb.SheetNames[0]]?.[`R${i}`]!== undefined   &&
                 wb.Sheets[wb.SheetNames[0]]?.[`R${i}`].v!=='') {
                  if( wb.Sheets[wb.SheetNames[0]]?.[`R${i}`].t =='n'){
                    data_fine_A= formatDate( new Date(Math.round(( wb.Sheets[wb.SheetNames[0]]?.[`R${i}`].v) - 25569) * 86400 * 1000) ,'dd/MM/yyyy',"it-IT") ;
                    console.log("data fine att",wb.Sheets[wb.SheetNames[0]]?.[`R${i}`].v);
                  }
                  else{
                    data_fine_A =wb.Sheets[wb.SheetNames[0]]?.[`R${i}`].v=='-'?"":  wb.Sheets[wb.SheetNames[0]]?.[`R${i}`].v  ;
                    console.log("data fine att",wb.Sheets[wb.SheetNames[0]]?.[`R${i}`].v);
                  }


                  console.log("data_fine_A", data_fine_A);
                }
              datiDaCaricare.push({

                stato_sede_operativa: wb.Sheets[wb.SheetNames[0]]?.[`A${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`A${i}`].v:"",
                approval_number: wb.Sheets[wb.SheetNames[0]]?.[`B${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`B${i}`].v:"",
                denominazione_sede_operativa : wb.Sheets[wb.SheetNames[0]]?.[`C${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`C${i}`].v:"",
                ragione_sociale_impresa : wb.Sheets[wb.SheetNames[0]]?.[`D${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`D${i}`].v:"",
                partita_iva : wb.Sheets[wb.SheetNames[0]]?.[`E${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`E${i}`].v:"",
                codice_fiscale : wb.Sheets[wb.SheetNames[0]]?.[`F${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`F${i}`].v:"",
                indirizzo : wb.Sheets[wb.SheetNames[0]]?.[`G${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`G${i}`].v:"",
                comune : wb.Sheets[wb.SheetNames[0]]?.[`H${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`H${i}`].v:"",
                sigla_provincia : wb.Sheets[wb.SheetNames[0]]?.[`I${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`I${i}`].v:"",
                provincia : wb.Sheets[wb.SheetNames[0]]?.[`J${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`J${i}`].v:"",
                regione : wb.Sheets[wb.SheetNames[0]]?.[`K${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`K${i}`].v:"",
                cod_ufficio_veterinario : wb.Sheets[wb.SheetNames[0]]?.[`L${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`L${i}`].v:"",
                ufficio_veterinario : wb.Sheets[wb.SheetNames[0]]?.[`M${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`M${i}`].v:"",
                attivita : wb.Sheets[wb.SheetNames[0]]?.[`N${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`N${i}`].v:"",
                stato_attivita : wb.Sheets[wb.SheetNames[0]]?.[`O${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`O${i}`].v:"",
                descrizione_sezione : wb.Sheets[wb.SheetNames[0]]?.[`P${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`P${i}`].v:"",
                data_inizio_attivita : data_inizioA,
                data_fine_attivita : data_fine_A,

                tipo_autorizzazione : wb.Sheets[wb.SheetNames[0]]?.[`S${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`S${i}`].v:"",
                imballaggio : wb.Sheets[wb.SheetNames[0]]?.[`T${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`T${i}`].v:"",
                paesi_abilitati_export : wb.Sheets[wb.SheetNames[0]]?.[`U${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`U${i}`].v:"",
                remark : wb.Sheets[wb.SheetNames[0]]?.[`V${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`V${i}`].v:"",
                species : wb.Sheets[wb.SheetNames[0]]?.[`W${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`W${i}`].v:"",
                informazion_aggiuntive : wb.Sheets[wb.SheetNames[0]]?.[`X${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`X${i}`].v:""

              })

           }
           }
            else{
              this.loadingService.closeDialog();
              this.notificationService.push({
                notificationClass: 'error',
                content: 'Attenzione! Formato file non valido. Rispettare formato del template fornito.'
              });

              return;
            }
          }
          if(  this.tipoImport=='183' ){
            console.log("sono nel tipoimport" );
            var sheet1:any = wb.Sheets[wb.SheetNames[0]];
            var range = XLSX.utils.decode_range(sheet1['!ref']);
            maxRow=range.e.r;

            console.log("range r"+range.e.r);
            console.log("range c"+range.e.c);
            if(range.e.c==29){
            maxRow=range.e.r;

            console.log("maxRow"+maxRow);
            funzioneload='load_import_anagrafica';
            for(let i = 2; i <= maxRow+1; i++){
              let a = wb.Sheets[wb.SheetNames[0]]?.[`A${i}`]?.v;

              if(a){
         //     console.log("wb.Sheets[wb.SheetNames[0]]?.[`S${i}`]!== undefined",wb.Sheets[wb.SheetNames[0]]?.[`S${i}`]!== undefined);

               let val=  wb.Sheets[wb.SheetNames[0]]?.[`S${i}`]!=null &&  wb.Sheets[wb.SheetNames[0]]?.[`S${i}`]!== undefined
               &&  wb.Sheets[wb.SheetNames[0]]?.[`S${i}`].v!==''?"1":"2";

                console.log("val",val);
                if(val=='1'){
             //     console.log("wb.Sheets[wb.SheetNames[0]]?.[`S${i}`]",wb.Sheets[wb.SheetNames[0]]?.[`S${i}`].v);
                  console.log("t AA", wb.Sheets[wb.SheetNames[0]]?.[`AA${i}`].t)   ;
                  console.log("t S", wb.Sheets[wb.SheetNames[0]]?.[`S${i}`].t)   ;

                }
                let data_inizioA ="";

               // console.log("sheet O DI INIZIO",wb.Sheets[wb.SheetNames[0]]?.[`N${i}`]);
                if(wb.Sheets[wb.SheetNames[0]]?.[`N${i}`]!=null &&  wb.Sheets[wb.SheetNames[0]]?.[`N${i}`]!== undefined
                &&  wb.Sheets[wb.SheetNames[0]]?.[`N${i}`].v!=='' ) {

                  if( wb.Sheets[wb.SheetNames[0]]?.[`N${i}`].t =='n'){
                    data_inizioA= formatDate( new Date(Math.round(( wb.Sheets[wb.SheetNames[0]]?.[`N${i}`].v) - 25569) * 86400 * 1000) ,'dd/MM/yyyy',"it-IT") ;
                  }
                  else{
                    data_inizioA =  wb.Sheets[wb.SheetNames[0]]?.[`N${i}`].v !='-'?wb.Sheets[wb.SheetNames[0]]?.[`N${i}`].v:""   ;
                  }
                }

                console.log("data_inizioA",data_inizioA);



                let data_fine_A ="";

                console.log("sheet data_fine_A",wb.Sheets[wb.SheetNames[0]]?.[`O${i}`]);
                console.log("sheet data_fine_A !=null",wb.Sheets[wb.SheetNames[0]]?.[`O${i}`]!=null);

              //  console.log("wb.Sheets[wb.SheetNames[0]]?.[`0${i}`]!== undefined ",wb.Sheets[wb.SheetNames[0]]?.[`0${i}`]!== undefined );

            //    console.log("wb.Sheets[wb.SheetNames[0]]?.[`0${i}`]!==' ",wb.Sheets[wb.SheetNames[0]]?.[`O${i}`].v!=='' );
            if(wb.Sheets[wb.SheetNames[0]]?.[`O${i}`]!=null &&  wb.Sheets[wb.SheetNames[0]]?.[`O${i}`]!== undefined
            &&  wb.Sheets[wb.SheetNames[0]]?.[`O${i}`].v!=='' ) {

              if( wb.Sheets[wb.SheetNames[0]]?.[`O${i}`].t =='n'){
                data_fine_A= formatDate( new Date(Math.round(( wb.Sheets[wb.SheetNames[0]]?.[`O${i}`].v) - 25569) * 86400 * 1000) ,'dd/MM/yyyy',"it-IT") ;
              }
              else{
                data_fine_A =  wb.Sheets[wb.SheetNames[0]]?.[`O${i}`].v !='-'?wb.Sheets[wb.SheetNames[0]]?.[`O${i}`].v:""   ;
              }
            }
            console.log("data_fine_A",data_fine_A);

                let data_notificaR ="";
                if( wb.Sheets[wb.SheetNames[0]]?.[`S${i}`]!=null
                 &&  wb.Sheets[wb.SheetNames[0]]?.[`S${i}`]!== undefined  &&  wb.Sheets[wb.SheetNames[0]]?.[`S${i}`].v!=='' ){
                  if( wb.Sheets[wb.SheetNames[0]]?.[`S${i}`].t =='n'){
                    data_notificaR= formatDate( new Date(Math.round(( wb.Sheets[wb.SheetNames[0]]?.[`S${i}`].v) - 25569) * 86400 * 1000) ,'dd/MM/yyyy',"it-IT") ;
                  }
                  else{
                    data_notificaR = wb.Sheets[wb.SheetNames[0]]?.[`S${i}`].v=='-'?"" :wb.Sheets[wb.SheetNames[0]]?.[`S${i}`].v ;
                  }
                }
                let data_inizioI ="";
                if(wb.Sheets[wb.SheetNames[0]]?.[`AA${i}`]!=null  &&
                  wb.Sheets[wb.SheetNames[0]]?.[`AA${i}`]!== undefined &&  wb.Sheets[wb.SheetNames[0]]?.[`AA${i}`].v!=='') {
                  if( wb.Sheets[wb.SheetNames[0]]?.[`AA${i}`].t =='n'){
                    data_inizioI = formatDate( new Date(Math.round(( wb.Sheets[wb.SheetNames[0]]?.[`AA${i}`].v) - 25569) * 86400 * 1000) ,'dd/MM/yyyy',"it-IT") ;
                  }
                  else{
                    data_inizioI = wb.Sheets[wb.SheetNames[0]]?.[`AA${i}`].v=='-'?"": wb.Sheets[wb.SheetNames[0]]?.[`AA${i}`].v  ;
                  }
                }
               console.log("data_inizioI",data_inizioI);

              datiDaCaricare.push({

                settore: wb.Sheets[wb.SheetNames[0]]?.[`A${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`A${i}`].v:"",
                ragione_sociale: wb.Sheets[wb.SheetNames[0]]?.[`B${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`B${i}`].v:"",
                rappresentante_legale : wb.Sheets[wb.SheetNames[0]]?.[`C${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`C${i}`].v:"",
                codice_fiscale : wb.Sheets[wb.SheetNames[0]]?.[`D${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`D${i}`].v:"",
                partita_iva : wb.Sheets[wb.SheetNames[0]]?.[`E${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`E${i}`].v:"",
                indirizzo_sede_legale : wb.Sheets[wb.SheetNames[0]]?.[`F${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`F${i}`].v:"",
                asl_di_competenza : wb.Sheets[wb.SheetNames[0]]?.[`G${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`G${i}`].v:"",
                indirizzo_sede_produttiva  : wb.Sheets[wb.SheetNames[0]]?.[`H${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`H${i}`].v:"",
                comune : wb.Sheets[wb.SheetNames[0]]?.[`I${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`I${i}`].v:"",
                prov : wb.Sheets[wb.SheetNames[0]]?.[`J${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`J${i}`].v:"",
                regione : wb.Sheets[wb.SheetNames[0]]?.[`K${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`K${i}`].v:"",
                numero_di_registrazione_cun : wb.Sheets[wb.SheetNames[0]]?.[`L${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`L${i}`].v:"",
                denominazione_sede : wb.Sheets[wb.SheetNames[0]]?.[`M${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`M${i}`].v:"",
                data_inizio_attivita :   data_inizioA ,

                data_fine_attivita :    data_fine_A,

                codice_norma : wb.Sheets[wb.SheetNames[0]]?.[`P${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`P${i}`].v:"",
                riconosciuta_registrata : wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`Q${i}`].v:"",
                numero_di_registrazione_riconoscimento : wb.Sheets[wb.SheetNames[0]]?.[`R${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`R${i}`].v:"",

                data_notifica_registrazione : data_notificaR,

                codice_sezione : wb.Sheets[wb.SheetNames[0]]?.[`T${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`T${i}`].v:"",
                sezione : wb.Sheets[wb.SheetNames[0]]?.[`U{i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`U${i}`].v:"",
                codice_attivita : wb.Sheets[wb.SheetNames[0]]?.[`V${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`V${i}`].v:"",
                descrizione_attivita : wb.Sheets[wb.SheetNames[0]]?.[`W${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`W${i}`].v:"",

                dettaglio_attivita : wb.Sheets[wb.SheetNames[0]]?.[`X${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`X${i}`].v:"",
                remarks : wb.Sheets[wb.SheetNames[0]]?.[`Y${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`Y${i}`].v:"",
                stato : wb.Sheets[wb.SheetNames[0]]?.[`Z${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`Z${i}`].v:"",
                data_inizio : data_inizioI,
                attivita_principale : wb.Sheets[wb.SheetNames[0]]?.[`AB${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`AB${i}`].v:"",
                vendita_diretta : wb.Sheets[wb.SheetNames[0]]?.[`AC${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`AC${i}`].v:"",
                note : wb.Sheets[wb.SheetNames[0]]?.[`AD${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`AD${i}`].v:""



              })

            }
              }
           }
            else{
              this.loadingService.closeDialog();
              this.notificationService.push({
                notificationClass: 'error',
                content: 'Attenzione! Formato file non valido. Rispettare formato del template fornito.'
              });

              return;
            }
          }
          console.log("funzioneload",funzioneload);
          console.log("funzioneload   this.tipoImport",  this.tipoImport);
          this.client.updDati(funzioneload,  {   data_estr_file:  this.data_estr_file, tipo :   this.tipoImport  , lista: datiDaCaricare}).subscribe(res => {
            console.log("res",res);
          this.importFileModalRef?.dismiss();

          this.loadingService.hideSpinner();
          if(res.esito){
           this.loadingService.setMessage('Invio Completato Con Successo!');

          }
          else{
            this.loadingService.setMessage('Problema.Invio Non Completato!');
          }

          this.data_estr_file = null;
          //creo tasto OK
          let okButton = document.createElement('button');
          okButton.type = 'button';
          okButton.className = 'btn btn-primary d-block mb-3 mx-auto';
          okButton.innerText = 'OK';
          okButton.style.minWidth = '100px';
          okButton.addEventListener('click', () => {
            this.loadingService.closeDialog();
          this.finestraTipoLista?.close();
            this._initElencoImportAnagrafica();


          })
          this.loadingService.dialog.htmlElement.querySelector('.loading-dialog')?.append(okButton);

          })
        })
    }
  }


  async downloadTemplate() {
    let filename : string;
    let pathfile : string='';

    let tipoImport :any ;

    if ((<HTMLInputElement>document.querySelector('input[name="tipoimport"]:checked ')) ==null) {
      this.notificationService.push({
        notificationClass: 'error',
        content: `Attenzione! Inserire il tipo import.`
      });
    //  this.disableAddButton = false;
      return;
    }
    else{
      tipoImport=(<HTMLInputElement>document.querySelector('input[name="tipoimport"]:checked')).value;
    }


    tipoImport=(<HTMLInputElement>document.querySelector('input[name="tipoimport"]:checked')).value;

    filename = 'template_'+tipoImport+'.xlsx';
    pathfile = 'excel\\' +'template_'+tipoImport+'.xlsx';
    console.log("tipoImport",tipoImport);



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




  export(tipolista: any,   descr:any){

     var re=descr+"";
     var pattern = /[\/\[\]\?\*\\]/g ;
     let name= re.replace(pattern,'-');

     let funzioneload='';
     if(tipolista.tipo_cod=='183'){
      funzioneload ='get_import_file_mangimifici';
     }
     else{
      funzioneload ='get_import_file_sintesis';
     }
     this.client.getDati(funzioneload, {id_import:tipolista.id,tipo:tipolista.tipo_cod}).subscribe(res => {


      console.log(",res.info",res.info.ui);
      let dati: any[] = [];
      let app :any[]=[];
      let intestaz: any[] = [];

      if(res.esito){

      res.info.ui.colonne.forEach((c: any) => {
     //  console.log(c.intestazione);
        intestaz.push( c.intestazione);
      })
      res.info.dati.forEach((d: any) => {

        res.info.ui.colonne.forEach((c: any) => {
      //  console.log(d[c.campo]);
         app.push(d[c.campo]);

        })
        dati.push(app);
        app=[];

      })
      Utils.exportXlsxWithSheetJs([{
          intestazione: "",
         // nome_foglio: this._descr+"",  \ / ? * [ ]

          nome_foglio:name,

          intestazione_colonne:intestaz,
          dati: dati
        }],
        name+"_"+ tipolista.tipo_descr+"_" +tipolista.data_inserimento
      )

    }
    else{

      this.notificationService.push({
        notificationClass: 'error',
        content: `Attenzione! Si sono verificati dei problemi.`
      });

      return;

    }
    })



  }








  exportEsclusi(tipolista: any,   descr:any){

    var re=descr+"";
    var pattern = /[\/\[\]\?\*\\]/g ;
    let name= re.replace(pattern,'-');
    console.log("dataIns",tipolista.data_inserimento);
    console.log("tipo_cod",tipolista.tipo_cod);
    console.log("tipo_descr",tipolista.tipo_descr);
    console.log("dataS",tipolista.data_sintesis);
    console.log("id",tipolista.id);
    let funzioneload='';
    if(tipolista.tipo_cod=='183'){
      funzioneload ='get_esclusi_import_mang';
     }
     else{
      funzioneload ='get_esclusi_import_sintesis';
     }

    this.client.getDati(funzioneload, {id_import:tipolista.id,tipo:tipolista.tipo_cod}).subscribe(res => {


     console.log(res);
     let dati: any[] = [];
     let app :any[]=[];
     let intestaz: any[] = [];

     if(res.esito){

     console.log(res.info.ui.colonne.length);
     res.info.ui.colonne.forEach((c: any) => {
    //  console.log(c.intestazione);
       intestaz.push( c.intestazione);
     })
     res.info.dati.forEach((d: any) => {

       res.info.ui.colonne.forEach((c: any) => {
       console.log(d[c.campo]);
        app.push(d[c.campo]);

       })
       dati.push(app);
       app=[];

     })
     Utils.exportXlsxWithSheetJs([{
         intestazione: "",
        // nome_foglio: this._descr+"",  \ / ? * [ ]

         nome_foglio:name,

         intestazione_colonne:intestaz,
         dati: dati
       }],
       name+"_"+ tipolista.tipo_descr+"_" +tipolista.data_inserimento
     )

   }
   else{

     this.notificationService.push({
       notificationClass: 'error',
       content: `Attenzione! Si sono verificati dei problemi.`
     });

     return;

   }
   })



 }








}
