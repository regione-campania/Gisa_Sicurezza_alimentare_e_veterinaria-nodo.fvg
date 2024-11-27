/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component,  OnInit ,TemplateRef, ViewChild} from '@angular/core';
import { ATreeNodeComponent } from '@us/utils/lib/modules/a-tree/a-tree-node/a-tree-node.component';

import * as XLSX from 'xlsx';
import { TipoListeService } from '../tipo-liste.service';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { FormBuilder, Validators } from '@angular/forms';
import { TreeNode,LoadingDialogService, toTree, NotificationService ,Utils} from '@us/utils';
import { baseUri } from 'src/environments/environment';
import Swal from 'sweetalert2';
import { ActivatedRoute, Router } from '@angular/router';
import { UserService } from '../../user/user.service';
import { ATreeComponent } from '@us/utils/lib/modules/a-tree/a-tree.component';
import { CertificatiService } from '../../certificati/certificati.service';
@Component({
  selector: 'lista',
  templateUrl: './lista.component.html',
  styleUrls: ['./lista.component.scss']
})
export class ListaComponent implements OnInit {

  @ViewChild('treeProdotti') treeProdotti?: ATreeComponent;
  @ViewChild('importFileModalTemplateClassy') importFileModalTemplateClassy!: TemplateRef<any>;
  @ViewChild('importRigaModalTemplateClassy') importRigaModalTemplateClassy!: TemplateRef<any>;
   
  importFileModalRef?: NgbModalRef;    
  importRigaModalRef?: NgbModalRef;
  fileSelezionato = null;
  filenameControl = this.fb2.control('', Validators.required);
  ui: any = null;
  _ui_old: any = null;
  listaDati= [];
  disabilitaElm:boolean=true;
  disabilitaImp:boolean=false;
  listaSelezionata: any = null;
  _idTipoLista?: string;
  _descr?: string;
  _idAsl?: string;
  tipoProdotto: any = null;
  _idStab: any = null;
  
  private _rifTipoProdotto=null;
  recordDaEliminare:any= [];
  private _prodottiTreeRoot?: TreeNode;
  private _prodotti?: any;
  private _selectedProdotto?: ATreeNodeComponent;

  constructor(
    private cs: CertificatiService,
    private loadingService: LoadingDialogService,
    private modalEngine: NgbModal,
    private fb2: FormBuilder,
    private app: TipoListeService,
    private route: ActivatedRoute,
    private notificationService: NotificationService,
     private router2: Router,
     private us: UserService
  ) { }

   

  ngOnInit(): void {
  
    this.route.queryParams.subscribe((params: any) => {
     
      this._idTipoLista=params['idTipoLista'];
      this._descr=params['descr'];   
      this._rifTipoProdotto=params['rifTipoProdotto'];
     
      console.log("this._rifTipoProdotto"+this._rifTipoProdotto);
      
      this.us.getUser().subscribe((res: any) => {      
      if(res.id_asl!=null)  {
          this._idAsl=res.id_asl;
          console.log("_idAsl"+  this._idAsl);
      }    
      else{
        this._idStab=res.id_stabilimento;
      }
      this._get_dettaglio_liste(this._idTipoLista,this._idStab); 
      });
     
 
    });
    this.cs.getTreeDenominazioneProdotti().subscribe((res: any) => {
      console.log("res:", res);
      this._prodotti = res.info;
      console.log("this._prodotti:", this._prodotti);
  
      this._prodottiTreeRoot = toTree(this._prodotti, node => {
        node.expanded = node.parent == null ? true : false;
        return node;
      }).root;
    });
  
 }

 

 get rifTipoProdotto() { return this._rifTipoProdotto; }


  private _get_dettaglio_liste(id :any,idStab:any) {
 
    this.app.getDettaglioTipoListe(id,idStab).subscribe((res) => {
      console.log("_initTipoListe");      
      
      if (!res.esito) {
        this.loadingService.closeDialog();
        Swal.fire({
          icon: 'warning',
          title: 'Non sono presenti dati.'
        });
        return;
      } 
      this.ui = res.info.ui; 
      console.log("len",res.info.dati.length);
      console.log(res.info.dati.length==0 );
      /* if(res.info.dati.length==0 ){
        this.disabilitaElm=true;
        this.disabilitaImp=false;
        
      } 
      else{ */
        this.disabilitaElm=true;
        this.disabilitaImp=false;
      // }
      
      this.listaDati = res.info.dati; 
      console.log("res.esito", res.esito);
      console.log("listaDati", this.listaDati);       
          
      if(this._rifTipoProdotto != 'SI' && this._rifTipoProdotto != 'true'){        
      
      for (let i = 0; i < this.ui.colonne.length; i++) {
        if(this.ui.colonne[i].campo=="prodotto_descr"){
          this.ui.colonne.pop(i);
        }
      }
  
    }
    
    
       
              
    });
   
  }

   
  get prodottiTreeRoot() { return this._prodottiTreeRoot; }

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
    if (anno < currAnno || isNaN(anno)) {
      Swal.fire(`Anno non valido`);
      return;
    }
    let found = false;
    this.listaDati.forEach((l: any) => {
      if (l.anno == anno)
        found = true;
    })
    if (found) {
      Swal.fire(`Anno già inserito`);
      return;
    }
    console.log("idTipoLista"+this._idTipoLista );
    console.log("anno"+parseInt(anno) );
    // this.bc.updDati('ins_lista_import', { anno: parseInt(anno), idTipoLista: this._idTipoLista }).subscribe(res => {
      
    //   console.log(res);
    //   this.ngOnInit();
    // })
  }


  closePopup() {
    this.modalEngine.dismissAll();
  }
 
  
    
  openImport(idLista: any,idasl:any) {
    console.log("idLista"+idLista);
    this.listaSelezionata = idLista;
    this.fileSelezionato = null;
    this.filenameControl.reset();
    this.tipoProdotto=null;
    // SE E' UN UTENTE OSA
    if(idasl !=null){
    
      this.importFileModalRef = this.modalEngine.open(this.importFileModalTemplateClassy, {
        modalDialogClass: 'system-modal', centered: true
      })

    }else{
    // SE E' UN UTENTE ASL
      this.importRigaModalRef = this.modalEngine.open(this.importRigaModalTemplateClassy, {
      modalDialogClass: 'system-modal', centered: true
    })
    }
   
  }
  onChange(e:any,id: number){
   
      if(e.target.checked) 
       { 
         // alert(id);
          this.recordDaEliminare.push(id);
        
          this.disabilitaElm =false;
          this.disabilitaImp =true;
       }  else{
         //alert(data);
          this.recordDaEliminare.pop(id);
          if(this.recordDaEliminare.length==0){
            this.disabilitaElm= true;
            this.disabilitaImp=false;
          }
      
       }
       console.log("this.recordDaEliminare",this.recordDaEliminare);
  }
 

  deleteRecordLista (idLista: any) {
    console.log("this.recordDaEliminare.size",this.recordDaEliminare.length);
      if(this.recordDaEliminare.length >=1){
      this.app.deleteRecordLista(idLista,this.recordDaEliminare).subscribe(res => {         
        console.log(res);
        this.recordDaEliminare=[];
        if(res.esito){
          
          Swal.fire(`Cancellazione avvenuta`);
         
          this._get_dettaglio_liste(this._idTipoLista,this._idStab); 
     
        }else{
         
          Swal.fire({
            icon: 'warning',
            title: 'Attenzione'    ,
            text:`Errore durante la cancellazione`
          });
         return;
        }
       
      
    });
   } 
  }

  importFile(idLista: number) {
    console.log("fileSelezionato"+this.fileSelezionato);
    if (this.fileSelezionato) {
      Utils.importXlsxWithSheetJS(this.fileSelezionato)
        .then(wb => {
          let datiDaCaricare = [];
          console.log("wb"+wb);
          let ref = wb.Sheets[wb.SheetNames[0]]?.['!ref'];
          let maxRow =0;
           
           
          var sheet1:any = wb.Sheets[wb.SheetNames[0]];
          var range = XLSX.utils.decode_range(sheet1['!ref']);

          console.log("range"+range.e.c);
          if(range.e.c==1){
            //B perche ci sono due colonne
            maxRow=parseInt(ref?.split(':')[1].split('B')[1]!);
            console.log("maxRow"+maxRow);
        
            for(let i = 2; i <= maxRow+1; i++){

              let a = wb.Sheets[wb.SheetNames[0]]?.[`A${i}`]?.v;

              if(a)
                datiDaCaricare.push({
                  valore: wb.Sheets[wb.SheetNames[0]]?.[`A${i}`]?.v ,
                  traduzione: wb.Sheets[wb.SheetNames[0]]?.[`B${i}`]?.v 
                })
            }
       
            this.app.loadImportLista(idLista,datiDaCaricare).subscribe(res => {         
                   console.log(res);
            /*      this.ngOnInit();
                 this.importFileModalRef?.dismiss(); */
                   window.location.reload();
               });
             
           }else{
            Swal.fire(`Formato template non conforme`);
            return;
          }
        })
      
     
    
    }
  }

  

  async downloadTemplate() {
    let filename : string; 
    let pathfile : string=''; 
 
    filename = 'template'+'.xlsx';
    pathfile = 'certificatiExportTemplates\\' +'template'+'.xlsx';
 
  
     
 
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



selectProdotto(node: ATreeNodeComponent): void {
    
    if (!node.isLeafNode()){
      // (<HTMLInputElement>document.getElementById("rifprodotto")).setAttribute('value','');
      return;
    }
    else{

    console.log(node.id);
    console.log(node.name);
    this.treeProdotti?.nodes?.map(node => node.selected);
    this.tipoProdotto=node.id;
    
    (<HTMLInputElement>document.getElementById("rifprodotto")).setAttribute('value',node.name!);
    this.selectedProdotto=node;
  }
  }

   
//  //accessors
  public get selectedProdotto(): ATreeNodeComponent | undefined {
   return this._selectedProdotto;
 }

public set selectedProdotto(value: ATreeNodeComponent | undefined) {
   if (this._selectedProdotto) this._selectedProdotto.htmlElement.classList.remove('selected');
   this._selectedProdotto = value;
   this._selectedProdotto?.htmlElement.classList.add('selected');
 }

  save(idLista: any,idStab:string) {
    let datiDaCaricare = [];
  //   event.preventDefault();
   const val: string = (<HTMLInputElement>document.getElementById('valore')).value;    
   const trad: string = (<HTMLInputElement>document.getElementById('traduzione')).value;  
 /*   console.log("valore",val);
   console.log("traduzione",trad);
   console.log("idLista",idLista);
   console.log("tipoProdotto",this.tipoProdotto);
   console.log("rifTipoProdotto",this._rifTipoProdotto); */
  
   if(val == null || val =='' ){
     Swal.fire(`Campo Valore Obbligatorio`);
    //if(this.rifTipoProdotto ){
  }
   else{
    if(this._rifTipoProdotto =='true'){
      if (this.tipoProdotto ==null || this.tipoProdotto  ==''){
        Swal.fire(`Campo Tipo Prodotto Obbligatorio`);
        return;
      }
    }
     
    datiDaCaricare.push({
    valore: val,
    traduzione: trad ,
    tipoprodotto: this.tipoProdotto
    })
     
  // const traduzione: string = (<HTMLInputElement>document.querySelector('input[name="gestore"]:checked')).id;
  //    var  rifTipoProd: string='false';

  //  if(<HTMLInputElement>document.querySelector('input[name="rifTipoProd"]')!=null){
  //   rifTipoProd= (<HTMLInputElement>document.querySelector('input[name="rifTipoProd"]:checked')).value;
  //  }
      this.app.loadImportListaRecord(idLista,datiDaCaricare,idStab).subscribe(res => {         
        console.log(res);
        window.location.reload();
    }); 
   }
  }
   
  }



