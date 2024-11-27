/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Input, OnInit, TemplateRef, ViewChild } from '@angular/core';
import { InfoStrutturaPrimaria } from '../../types';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { FormBuilder, Validators } from '@angular/forms';
import {ASmartTableComponent,LoadingDialogService, BackendCommunicationService, Utils ,NotificationService} from '@us/utils';
import { baseUri } from 'src/environments/environment';
import Swal from 'sweetalert2';
import { ActivatedRoute, Router } from '@angular/router';
import { ListaDetComponent } from './listadet.component';
import * as XLSX from 'xlsx';

@Component({
  selector: 'lista',
  templateUrl: './lista.component.html',
  styleUrls: ['./lista.component.scss']
})
export class ListaComponent implements OnInit {
  @ViewChild('importFileModalTemplateClassy') importFileModalTemplateClassy!: TemplateRef<any>;
  @ViewChild('listadet') listadet!: ListaDetComponent; 

  @Input() info?: InfoStrutturaPrimaria;
  importFileModalRef?: NgbModalRef;
  fileSelezionato = null;
  filenameControl = this.fb2.control('', Validators.required);
  ui: any = null;
  listaDati= [];
  listaSelezionata: any = null;
  _idTipoLista?: string;
  _descr?: string;
  _formatoLista?: number;
  _formatoDescr?: string;
  tipolista?:any;
  disableImportButton=false;
  

  constructor(
    private loadingService: LoadingDialogService,
    private modalEngine: NgbModal,
    private fb2: FormBuilder,
    private bc: BackendCommunicationService,
    private route: ActivatedRoute,
    private notificationService: NotificationService,
     private router2: Router
  ) { }

  

  ngOnInit(): void {
  }
  
 getConfiguraListe(tipolista:any){

    this.loadingService.openDialog('Caricamento in corso');
    this.tipolista=tipolista;
    this.route.queryParams.subscribe((params: any) => {
      console.log("tipolista open",tipolista);
      this._idTipoLista=tipolista.id_tipo_lista;
      this._formatoLista=tipolista.formato;
      this._formatoDescr=tipolista.formato_descr;   
      this._descr= tipolista.descr;
 
      this.bc.getDati('get_dettaglio_lista', { id_tipo_lista:  this._idTipoLista,formato:this._formatoLista }).subscribe((risultato: any) => {
        if (risultato.esito) {
          this.ui = risultato.info.ui;
          this.listaDati = risultato.info.dati;
          this.loadingService.closeDialog();
        }
        else{
          this.ui = null;
          this.listaDati= [];
          this.loadingService.closeDialog();
          return;

        }


      })
    })
  }


  async addAnno() {
    let currAnno = new Date().getFullYear();
    const { value: anno } = await Swal.fire({
      title: '',
      input: 'number',
      inputValue: currAnno,
      inputLabel: 'Anno da importare',
      inputPlaceholder: 'YYYY'
    })

    if (!anno) {
      return;
    }
   /*  if (anno < currAnno || isNaN(anno)) {
      Swal.fire(`Anno non valido`);
      return;
    } */
    let found = false;
    this.listaDati.forEach((l: any) => {
      if (l.anno == anno)
        found = true;
    })
    if (found) {
      Swal.fire(`Anno già inserito`);
      return;
    }
   
    this.bc.updDati('ins_lista_import', { anno: parseInt(anno), idTipoLista: this._idTipoLista }).subscribe(risultato => {
      if (risultato.esito) {
          console.log(this.tipolista);
          this.getConfiguraListe(this.tipolista);
        
      }
      else{
   
        return;

      }

    })
  }

  openImportFilenameModalClassy(idLista: any) {
    this.listaSelezionata = idLista;
    this.fileSelezionato = null;
    this.filenameControl.reset();
    this.importFileModalRef = this.modalEngine.open(this.importFileModalTemplateClassy, {
      modalDialogClass: 'system-modal', centered: true
    })
  }

  importFile(idLista: any) {
    console.log("importFil disableImportButton",this.disableImportButton); 
    this.disableImportButton=true;
    console.log("importFile disableImportButton",this.disableImportButton); 

    if(((this.fileSelezionato! as File).size / 1024 / 1024) > 20){
      this.notificationService.push({
        notificationClass: 'warning',
        content: 'Attenzione! Dimensione massima consentita 20mb'
      });
      this.disableImportButton=false;
      return;
    }

    if (this.fileSelezionato) {
      
      
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
         console.log("ref"+ref);
         console.log("formato"+this._formatoLista);
       
          let funzioneload='';
          if(this._formatoLista==1){
            var sheet1:any = wb.Sheets[wb.SheetNames[0]];
            var range = XLSX.utils.decode_range(sheet1['!ref']);
            maxRow=range.e.r;
             
            console.log("range r"+range.e.r);
            console.log("range c"+range.e.c);
            if(range.e.c==1){
            //B PERCHE CI SONO DUE COLONNE
        //    console.log(wb.Sheets[wb.SheetNames[0]]?.[`B${i}`].v    );
            
            maxRow=range.e.r;
           
            console.log("maxRow"+maxRow);
            funzioneload='load_import_formato_cf';       
            for(let i = 2; i <= maxRow+1; i++){
              let a = wb.Sheets[wb.SheetNames[0]]?.[`A${i}`]?.v;

              if(a)
              datiDaCaricare.push({

                cod_allevamento: wb.Sheets[wb.SheetNames[0]]?.[`A${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`A${i}`].v:"", 
                attributo: wb.Sheets[wb.SheetNames[0]]?.[`B${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`B${i}`].v:""
               
              })
            }
           }
            else{
              this.loadingService.closeDialog();
              this.notificationService.push({
                notificationClass: 'error',
                content: 'Attenzione! Formato file non valido. Rispettare formato del template fornito.'
              });
              this.disableImportButton=false;
              
    
              return;
            }
          }
          if(this._formatoLista==2){
            var sheet1:any = wb.Sheets[wb.SheetNames[0]];
            var range = XLSX.utils.decode_range(sheet1['!ref']);
            maxRow=range.e.r;
             
            console.log("range r"+range.e.r);
            console.log("range c"+range.e.c);
            if(range.e.c==2){
           // maxRow=parseInt(ref?.split(':')[1].split('C')[1]!);
             maxRow=range.e.r;
            console.log("maxRow"+maxRow);
            funzioneload='load_import_formato_linea';   
            for(let i = 2; i <= maxRow+1; i++){
              datiDaCaricare.push({
               
                denominazione_sede_operativa: wb.Sheets[wb.SheetNames[0]]?.[`A${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`A${i}`].v:"", 
                piva: wb.Sheets[wb.SheetNames[0]]?.[`B${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`B${i}`].v:"", 
                cod_tipo_linea:wb.Sheets[wb.SheetNames[0]]?.[`C${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`C${i}`].v:""
             
              })    
            }
          }
          else{
            this.loadingService.closeDialog();
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Attenzione! Formato file non valido. Rispettare formato del template fornito.'
            });
            this.disableImportButton=false;
            return;
          }
          }        
        // IdUA	Nome	Cod. Regionale	Comune	Attivita Controllate

          if(this._formatoLista==3){
            
          var sheet1:any = wb.Sheets[wb.SheetNames[0]];
          var range = XLSX.utils.decode_range(sheet1['!ref']);
          maxRow=range.e.r;
           
          console.log("range"+range.e.r);
          console.log("range"+range.e.c);
          if(range.e.c==4){
            console.log("maxRow"+maxRow);
            funzioneload='load_import_formato_sicer';   
            for(let i = 2; i <= maxRow+1; i++){
              datiDaCaricare.push({
                idua: wb.Sheets[wb.SheetNames[0]]?.[`A${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`A${i}`].v:"", 
                nome: wb.Sheets[wb.SheetNames[0]]?.[`B${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`B${i}`].v:"", 
                cod_regionale:wb.Sheets[wb.SheetNames[0]]?.[`C${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`C${i}`].v:"", 
                comune: wb.Sheets[wb.SheetNames[0]]?.[`D${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`D${i}`].v:"", 
                attivita_controllate: wb.Sheets[wb.SheetNames[0]]?.[`E${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`E${i}`].v:""
              })    
            }

          }
          else{
            this.loadingService.closeDialog();
            this.notificationService.push({
              notificationClass: 'error',
              content: 'Attenzione! Formato file non valido. Rispettare formato del template fornito.'
            });
            this.disableImportButton=false;
            return;
          }
            
          }        
          if(this._formatoLista==4){
            
            var sheet1:any = wb.Sheets[wb.SheetNames[0]];
            var range = XLSX.utils.decode_range(sheet1['!ref']);


            maxRow=range.e.r;
             
            console.log("range"+range.e.r);
            console.log("range"+range.e.c);
            if(range.e.c==1){
              console.log("maxRow"+maxRow);
              funzioneload='load_import_formato_profilassi';   
              for(let i = 2; i <= maxRow+1; i++){
                datiDaCaricare.push({
                  cod_azienda: wb.Sheets[wb.SheetNames[0]]?.[`A${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`A${i}`].v:"", 
                  cod_grp_specie: wb.Sheets[wb.SheetNames[0]]?.[`B${i}`]!=null?wb.Sheets[wb.SheetNames[0]]?.[`B${i}`].v:"" 
                })    
              }
  
            }
            else{
              this.loadingService.closeDialog();
              this.notificationService.push({
                notificationClass: 'error',
                content: 'Attenzione! Formato file non valido. Rispettare formato del template fornito.'
              });
              this.disableImportButton=false;
              return;
            }
              
            }      

          this.bc.updDati(funzioneload,  {id_lista: idLista, lista: datiDaCaricare}).subscribe(res => {         
         // this.bc.updDati('load_cf_allevamenti', {id_lista: idLista, lista_cf: datiDaCaricare}).subscribe(res => {
            console.log(res);
          //  this.ngOnInit();
          this.importFileModalRef?.dismiss();
          
         // this.getConfiguraListe(this.tipolista);
          this.disableImportButton=false;
          //Creazioe loading dialog per quando l'attività è stata inviata
          this.loadingService.hideSpinner();
          this.loadingService.setMessage('Invio Completato!');
          //creo tasto OK
          let okButton = document.createElement('button');
          okButton.type = 'button';
          okButton.className = 'btn btn-primary d-block mb-3 mx-auto';
          okButton.innerText = 'OK';
          okButton.style.minWidth = '100px';
          okButton.addEventListener('click', () => {
            this.loadingService.closeDialog();
      //     window.location.reload()
      this.getConfiguraListe(this.tipolista);
          })
          this.loadingService.dialog.htmlElement.querySelector('.loading-dialog')?.append(okButton);
       
          })
        })
    }
  }
   update_sheet_range(ws:XLSX.WorkSheet) {
    var range = {s:{r:Infinity, c:Infinity},e:{r:0,c:0}};
    Object.keys(ws).filter(function(x) { return x.charAt(0) != "!"; }).map(XLSX.utils.decode_cell).forEach(function(x) {
      range.s.c = Math.min(range.s.c, x.c); range.s.r = Math.min(range.s.r, x.r);
      range.e.c = Math.max(range.e.c, x.c); range.e.r = Math.max(range.e.r, x.r);
    });
    ws['!ref'] = XLSX.utils.encode_range(range);
  }

  export(idLista: any,  anno: any, tipo_desc:any,tipo:any){
  if(this._formatoLista==1){
    return this.exportFormatoCF(idLista,anno,tipo_desc,tipo);       
   }
   if(this._formatoLista==2){
    return this.exportFormatoLINEA (idLista,anno,tipo_desc,tipo);     
   }     
   if(this._formatoLista==3){
    return this.exportFormatoSICER(idLista,anno,tipo_desc,tipo);     
   }   
   if(this._formatoLista==4){
    return this.exportFormatoPRF(idLista,anno,tipo_desc,tipo);     
   }   
   
  }


  

  exportFormatoCF(idLista: any,  anno: any,tipo_desc:any,tipo_estr:any){
   // let name= this._descr+"".replace(/[\?\*\/\[\]\\]/g, '-');
   
   
//    var re=///;
console.log("this._descr",this._descr);
    var re=this._descr+"";
   // let name= re.replace(/[\/]/g,'-');
   var pattern = /[\/\[\]\?\*\\]/g ;
 
  
    let name= re.replace(pattern,'-');
 
    console.log("name",name);
    this.bc.getDati('get_cf_allevamenti', {id_lista: idLista,tipo:tipo_estr}).subscribe(res => {
    /* console.log(res);
      let dati: any[] = [];
      res.info.dati.forEach((d: any) => {
        dati.push([d.cod_allevamento, d.attributo]);
      })
      Utils.exportXlsxWithSheetJs([{
          intestazione: "",
          nome_foglio: this._descr+"_",
          intestazione_colonne: ["Allevamento", "Attributo"],
          dati: dati
        }],
        this._descr+"_"+ this._formatoDescr+"_" +tipo_desc+"_"+ anno
      )
    })
*/


    console.log(res);
    let dati: any[] = [];
    let app :any[]=[];
    let intestaz: any[] = [];
    console.log("get_cf_allevamenti");
    console.log(res.info.ui.colonne.length);    
    res.info.ui.colonne.forEach((c: any) => {
      console.log(c.intestazione);
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
      name+"_"+ this._formatoDescr+"_" +tipo_desc+"_"+ anno
    )
  })
}
  

  exportFormatoLINEA(idLista: any,  anno: any,tipo_desc:any,tipo_estr:any){
    var re=this._descr+"";
    var pattern = /[\/\[\]\?\*\\]/g ;  
    let name= re.replace(pattern,'-');
    this.bc.getDati('get_import_formato_linea', {id_lista: idLista,tipo:tipo_estr}).subscribe(res => {
      console.log(res);
      let dati: any[] = [];
      let app :any[]=[];
      let intestaz: any[] = [];
      console.log("get_import_formato_linea");
      console.log(res.info.ui.colonne.length);

      

      console.log(res.info.ui.colonne.length);

      res.info.ui.colonne.forEach((c: any) => {
        console.log(c.intestazione);
        intestaz.push( c.intestazione);
      })

      res.info.dati.forEach((d: any) => {
     

        res.info.ui.colonne.forEach((c: any) => {
          //   console.log(key);
         console.log(d[c.campo]);
         app.push(d[c.campo]);
      
        })
        dati.push(app);
        app=[];
      
      //  dati.push([d.sd_id,d.denominazione_sede_operativa, d.piva,d.cod_tipo_linea]);
      })
      Utils.exportXlsxWithSheetJs([{
          intestazione: "",
      //    nome_foglio: this._descr+"",
          nome_foglio:name,
          intestazione_colonne:intestaz,
          dati: dati
        }],
        name+"_"+ this._formatoDescr+"_" +tipo_desc+"_"+ anno
      )
    })
  }

  
  exportFormatoSICER(idLista: any,  anno: any,tipo_desc:any,tipo_estr:any){
    var re=this._descr+"";
    var pattern = /[\/\[\]\?\*\\]/g ;  
    let name= re.replace(pattern,'-');
   console.log("name",name);
    this.bc.getDati('get_import_formato_sicer', {id_lista: idLista,tipo:tipo_estr}).subscribe(res => {
      console.log(res);
      let dati: any[] = [];
      let app :any[]=[];
      let intestaz: any[] = [];
      console.log("get_import_formato_sicer");
      console.log(res.info.ui.colonne.length);

      

      console.log(res.info.ui.colonne.length);

      res.info.ui.colonne.forEach((c: any) => {
        console.log(c.intestazione);
        intestaz.push( c.intestazione);
      })

      res.info.dati.forEach((d: any) => {
     

        res.info.ui.colonne.forEach((c: any) => {
               console.log(c.campo);
          console.log(d[c.campo]);
         if(c.tipo=='text'){

          console.log('prima'); 
          console.log( encodeURIComponent(d[c.campo]));
    


         }
         app.push(d[c.campo]);
      
        })
        dati.push(app);
        app=[];
      
      //  dati.push([d.sd_id,d.denominazione_sede_operativa, d.piva,d.cod_tipo_linea]);
      })
      Utils.exportXlsxWithSheetJs([{
          intestazione: "",
     //     nome_foglio: this._descr+"",
            nome_foglio: name,
          intestazione_colonne:intestaz,
          dati: dati
        }],
        name+"_"+ this._formatoDescr+"_" +tipo_desc+"_"+ anno
      )
    })
  }


  exportFormatoPRF(idLista: any,  anno: any,tipo_desc:any,tipo_estr:any){    
    console.log("exportFormatoPRF" );
     console.log("this._descr",this._descr);
     var re=this._descr+"";   
     var pattern = /[\/\[\]\?\*\\]/g ;
     let name= re.replace(pattern,'-');
  
     console.log("name",name);
     this.bc.getDati('get_import_formato_profilassi', {id_lista: idLista,tipo:tipo_estr}).subscribe(res => {     
 
 
     console.log(res);
     let dati: any[] = [];
     let app :any[]=[];
     let intestaz: any[] = [];
     console.log("get_import_formato_profilassi");
     console.log(res.info.ui.colonne.length);    
     res.info.ui.colonne.forEach((c: any) => {
       console.log(c.intestazione);
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
         nome_foglio:name, 
         intestazione_colonne:intestaz,
         dati: dati
       }],
       name+"_"+ this._formatoDescr+"_" +tipo_desc+"_"+ anno
     )
   })
 }


  visualizza(lista :any){
  console.log("lista.id_lista"+lista.id_lista);
  console.log("formato:lista.formato"+ lista.formato);
  
    this.router2.navigate(
      ["../listadet"],
      {relativeTo: this.route, queryParams:  { idLista: lista.id_lista ,formato:lista.formato}}
    );
  
  }

 
 
 
  openPopup(event: any, lista:any,tag_lista_det: any) {

    this.listadet = tag_lista_det;
   console.log("id"+lista.id);
   console.log("liid_listasta"+lista.id_lista);
   console.log("_formatoLista"+this._formatoLista);
    this.listadet.getdettaglio(lista.id_lista ,this._formatoLista);
  
 
  } 

  closePopup() {
    this.modalEngine.dismissAll();
  }
 
  async downloadTemplate() {
   let filename : string; 
   let pathfile : string=''; 

   filename = 'template_'+this._formatoDescr+'.xlsx';
   pathfile = 'excel\\' +'template_'+this._formatoDescr+'.xlsx';

 
    

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

}



