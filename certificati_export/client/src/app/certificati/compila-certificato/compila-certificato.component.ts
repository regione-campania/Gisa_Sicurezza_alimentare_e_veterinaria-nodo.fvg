/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ElementRef, Output, Input, EventEmitter, OnChanges, SimpleChanges, ViewChild } from '@angular/core';
import { CertificatiService } from '../certificati.service';
import { ATreeNodeComponent } from '@us/utils/lib/modules/a-tree/a-tree-node/a-tree-node.component';
import { ATreeComponent } from '@us/utils/lib/modules/a-tree/a-tree.component';
import { TreeNode, toTree, LoadingDialogService } from '@us/utils';
import { ActivatedRoute } from '@angular/router';
declare let Swal: any;

@Component({
  selector: 'app-compila-certificato',
  templateUrl: './compila-certificato.component.html',
  styleUrls: ['./compila-certificato.component.scss']
})
export class CompilaCertificatoComponent implements OnInit, OnChanges {

  stato: any;
  campi!: any[];
  idModuloCorrente!: number;
  idModuliAllegati: number[] = [];
  @Output() sendPdfPath = new EventEmitter<string>();
  @Output() idModulo = new EventEmitter<string>();
  @Output() canSave = new EventEmitter<boolean>();
  @Output() _valueChange = new EventEmitter<boolean>();
  @Input() certificatoModificabile?: boolean;
  @Input() idCertificatoCompilato?: any;
  @ViewChild('treeProdotti') treeProdotti?: ATreeComponent;

  isCertificatoModificabile: boolean = false;
  private indexArray = new Map();
  autofillers: any = {};
  private _prodottiTreeRoot?: TreeNode;
  private _prodotti?: any;
  private _selectedProduct?: any;
  private _currentCampo: any = null;

  constructor(
    private cs: CertificatiService,
    private elementRef: ElementRef,
    private route: ActivatedRoute,
    private ls: LoadingDialogService
  ) { }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes?.['certificatoModificabile'].currentValue) {
      this.isCertificatoModificabile = changes['certificatoModificabile'].currentValue;
    }
  }

  ngOnInit(): void {
    this.route.queryParams.subscribe((dati: any) => {
      console.log("dati:", dati);
      this.stato = dati.stato;
    });
    this.campi = [];
    this.cs.getDati('get_stabilimenti_sintesis', {}).subscribe((res: any) => {
      if (!res.esito) return;
      this.autofillers['stabilimentiSintesis'] = JSON.parse(res.info);
      console.log(this.autofillers);
    });
    this.cs.getDati('get_countries', {}).subscribe((res: any) => {
      this.autofillers['countries'] = JSON.parse(res.info);
      console.log(this.autofillers);
    })
    this.cs.getTreeDenominazioneProdotti().subscribe((res: any) => {
      console.log("res:", res);
      this._prodotti = res.info;
      console.log("this._prodotti:", this._prodotti);
  
      this._prodottiTreeRoot = toTree(this._prodotti, node => {
        node.expanded = node.parent == null;
        return node;
      }).root;
    });
  }

  getAutofiller(c: any) { return this.autofillers[c]; }

  patchValue(evt: Event, campo: string, autofillerValues?: string[]) {

    console.log(evt);
    let idCampo: number;
    
    this.campi.forEach((campiModulo, i) => {
      campiModulo.forEach((c: any) => {
      if (c.nome_campo == campo) {
        let el = this.elementRef.nativeElement.querySelector(`[name=${this.getNameTag(c, i)}]`);
        el.value = evt;
        idCampo = c.id;
      }
    })
    campiModulo.forEach((c: any) => {
      if (c.id_campo_traduzione == idCampo!) {
        autofillerValues?.forEach((a: any) => {
          if (a.descr == evt) {
            let el = this.elementRef.nativeElement.querySelector(`[name=${this.getNameTag(c, i)}]`);
            el.value = a.traduzione
          }
        })

      }
    })
  })
  }

  getModulo(idModulo: any) {
    console.log("getModulo", idModulo);
    this.idModulo.emit(idModulo);
    this.idModuloCorrente = idModulo;
    this.campi = [];
    this.getCampiByIdModulo(idModulo, []);
  }

  addModuloAllegato(idModulo: any) {
    console.log("getModulo", idModulo);
    this.idModuliAllegati.push(idModulo);
    //this.campi = [];
    this.getCampiByIdModulo(this.idModuloCorrente, this.idModuliAllegati, true);
  }

  removeModuloAllegato(index: number){
    console.log('removeModuloAllegato', index)
    this.idModuliAllegati.splice(index - 1, 1);
    this.campi.splice(index, 1);
  }

  duplicaModuloAllegato(index: number){
    this.idModuliAllegati.push(this.idModuliAllegati[index - 1]);
    this.campi.push(this.campi[index]);
    let indexNew = this.campi.length - 1;
    setTimeout(() => {
      this.campi[index].forEach((c: any) =>  {
        let old = this.elementRef.nativeElement.querySelector(`[name=${this.getNameTag(c, index)}]`);
        let new_ = this.elementRef.nativeElement.querySelector(`[name=${this.getNameTag(c, indexNew)}]`);
        new_.value = old.value;
      })
    }, 100);
    
  }

  getCampiByIdModulo(idModulo: number, idModuliAllegati: number[], keepModuliCorrenti?: boolean){
    if(idModuliAllegati?.length && !idModulo){
      Swal.fire({
        title: 'Attenzione',
        icon: 'warning',
        text: `Attenzione! È necessario selezionare prima un certicato prima di aggiungere un allegato.`,
        allowOutsideClick: true,
        showConfirmButton: true
      });
      return;
    }
    this.ls.openDialog('Caricamento in corso');
    this.cs.getCampiByModulo(idModulo, idModuliAllegati).subscribe((res: any) => {
      this.ls.closeDialog();
      console.log("res:", res);

      let oldLength = this.campi.length;

      res.forEach((elem: any, i: number) => {
        if(!keepModuliCorrenti || (i + 1 > oldLength)){ //se voglio tenermi i valori precedenent
          this.campi.push(elem);
          if (elem.descr == 'object') {
            this.indexArray.set(elem.id, 0);
            elem.children.forEach((child: any) => {
              child.index = this.indexArray.get(elem.id);
              // this.campi.push({ ...child, index: this.indexArray.get(elem.id) });
            });
            // console.log("this.makeChildrenArray(elem):", this.makeChildrenArray(elem));
            elem.children = this.makeChildrenArray(elem);
          }
        }
        });
        console.log("this.campi:", this.campi);
      })
      // this.campi = res;
    }
  

  getCertificatoCompilato(idCertificatoCompilato: any) {
    console.log(idCertificatoCompilato);
    this.idCertificatoCompilato = idCertificatoCompilato;
    //TO-DO dopo salvataggio valori
    //this.cs.getCampiCompilati(idCertificatoCompilato).subscribe()
  }

  async preview(calcoloAPosteriori?: boolean) {
    
    console.log('salvo');
    var data: any[] = [];

    // Recupera i dati flat
    var i = -1;
    for (let campiModulo of this.campi) {
      let campi = []
      i++;
      for (let c of campiModulo) {

        let valore = <any>this.elementRef.nativeElement.querySelector(`[name=${this.getNameTag(c, i)}]`)?.value?.trim();
        let valoreStat = <any>this.elementRef.nativeElement.querySelector(`[name=${this.getNameTag(c, i)}_stat]`)?.value?.trim();

        if(!valoreStat?.length)
          valoreStat = null;

        let check = null;
        let tipoProdottoDescr = '';
        if(c.id_tipo_prodotto){
          check = <any>this.elementRef.nativeElement.querySelector(`[name=check_${this.getNameTag(c, i)}]`)?.checked;
          if(check){
            tipoProdottoDescr = c.descr_tipo_prodotto;
          }
        }

        console.log(c);
        campi.push({
          nome: c.nome_campo,
          id: c.id,
          valore: c.descr == 'object' ? null : valore,
          id_modulo_campo_ref: c.id_modulo_campo_ref,
          index: c.index === undefined || c.index === null ? null : c.index,
          type: c.descr,
          idLista: c.id_anagrafica_lista,
          id_tipo_prodotto: c.id_tipo_prodotto ?? null,
          font_size: c.font_size,
          riporta_tipo_prodotto: check,
          tipo_prodotto_descr: tipoProdottoDescr,
          obbligatorio: c.obbligatorio,
          label: c.label,
          dipende_tipo_certificato: c.dipende_tipo_certificato,
          valore_statistico: valoreStat ?? null,
          calcolo_a_posteriori: c.calcolo_a_posteriori
        });
        if (c.descr == 'object') {
          c.children.forEach((child: any) => {
            for (const key of Object.keys(child)) {
              data.push({
                nome_campo: child[key].nome_campo,
                id: child[key].id,
                valore: child[key].descr == 'object' ? null : <HTMLElement>this.elementRef.nativeElement.querySelector(`[name=${this.getNameTag(child[key], i)}]`).value,
                id_modulo_campo_ref: child[key].id_modulo_campo_ref,
                index: child[key].index === undefined || child[key].index === null ? null : child[key].index,
                type: child[key].descr
              })
            }
          })
        }
      }
      data.push(campi);
  }
    console.log("data:", data);

    console.log("this.idModuloCorrente:", this.idModuloCorrente);
    //if(!calcoloAPosteriori)
    this.ls.openDialog('Generazione certificato');
    let res = await this.cs.compilaCertificato(this.idModuloCorrente, this.idModuliAllegati, data, this.idCertificatoCompilato, calcoloAPosteriori)//.subscribe((res: any) => {
    console.log(res);
    console.log(res.path);
    let valueToEmit = {
      path: res.path,
      data: data
    }
    this.ls.closeDialog();
    this.sendPdfPath.emit(JSON.stringify(valueToEmit));
    this.canSave.emit(true);
    this._valueChange.emit(true);
    //})
    return;

  }

  changeCertificato(ev: any) {
    console.log("ev.target.value:", ev.target.value);
    // const idModulo = ev.target.value;
  }

  addChild(campo: any): void {
    // Aggiorna index figli
    this.indexArray.set(campo.id, this.indexArray.get(campo.id) + 1);

    // Recupera la struttura da aggiungere (Deep copy)
    let addingValues = JSON.parse(JSON.stringify(campo.children[0]));

    // Resetta i valori
    for (const key of Object.keys(addingValues)) {
      addingValues[key].valore = null;
      addingValues[key].index = this.indexArray.get(campo.id);
    }

    // Aggiungi figlio
    campo.children.push(addingValues);
    console.log("campo:", campo);
  }

  // Rimuovi figlio da campo tipo object
  removeChild(campo: any, child: any): void {
    console.log("JSON.stringfy(child):", JSON.stringify(child));

    // Trova il figlio da eliminare
    campo.children.forEach((innerChild: any) => {
      console.log("JSON.stringify(innerChild):", JSON.stringify(innerChild));
      if (JSON.stringify(child) == JSON.stringify(innerChild)) {
        const i = campo.children.indexOf(innerChild, 0);
        if (i > -1) campo.children.splice(i, 1);
      }
    })
  }

  // Restituisce il campo a cui fa riferimento
  getRef(id: string): string {
    let refString: string = '';
    this.campi.forEach((value: any) => {
      if (value.id == id) refString = value.nome_campo;
    });
    return refString;
  }

  getNameTag(campo: any, index: number): string {
    const returnString = campo.index 
      ? `campo_${campo.nome_campo.split(' ').join('_').split('.').join('_')}_${campo.index}` 
      : `campo_${campo.nome_campo.split(' ').join('_').split('.').join('_')}_${index}`;
    return returnString;
  }

  getArray(obj: any): any { return Object.values(obj); }

  /**
   * Permette la visualizzazione dei bottoni azione solamente
   * quando il tasto "preview" viene cliccato
   * @param evt evento che si verifica
   */
  onChange(evt: any): void { this._valueChange.emit(false); }

  // Raggruppa i campi sottoforma di oggetti
  private makeChildrenArray(obj: any): any[] {
    let mapChildren = new Map();
    let appChildren: any[] = [];

    // Raggruppa gli array dei figli
    obj.children.forEach((child: any) => {
      if (!mapChildren.get(child.index)) mapChildren.set(child.index, []);
      mapChildren.get(child.index).push(child);
    });

    // Converti gli array in oggetti e inseriscili in un array
    mapChildren.forEach((value: any) => {
      appChildren.push(Object.assign({}, value));
    });
    console.log("appChildren:", appChildren);
    return appChildren;
  }

  /**
   * Completa i campi del certificato scelto
   * @param fields Campi Compilati del Certificato
   * @param idModulo L'id del modulo da utilizzare
   */
  setValori(fields: any, idModulo: any) {
    if(idModulo)
      this.setIdModulo = idModulo;
    console.log(fields);
    this.idModuliAllegati = [];
    let i = 0;
    for(let field of fields){
      if(i > 0)
        this.idModuliAllegati.push(field[0].id_modulo);
      i++;
    }
    /*this.cs.getCampiByModulo(idModulo).subscribe((res: any) => {
      console.log(res);
      for (let i = 0; i < res.length; i++) {
        for (const [key, value] of Object.entries(res[i])) {
          fields[i][key] = value;
        }
      }
      this.campi = fields;
    });*/
    console.log('idModuliAllegati', this.idModuliAllegati);
    this.campi = fields;
  }

  /**
   * Annulla il valore di input se l'input è un numero negativo o se è di tipo
   * testo. Problema relativo a FireFox.
   * @param evt evento deblur
   */
  checkTypeNumber(evt: any): void {
    console.log("evt:", evt);
    const id: string = evt.target.attributes.id.value;
    const valueAsNumber: number = evt.target.valueAsNumber;
    let DOMElem: HTMLInputElement = <HTMLInputElement>document.querySelector(`#${id}`);
    console.log("valueAsNumber:", valueAsNumber);

    if (valueAsNumber < 0 || Number.isNaN(valueAsNumber)) {
      evt.target.value = null;
      DOMElem.value = 'null';
      DOMElem.dispatchEvent(new Event('input'));
    }
  }

  /*
  public set setCampi(fields: any) {
    console.log("fields:", fields);
    this.campi = fields.filter((field: any) => {return field.id_modulo_campo_ref === null});

    // Recupera i campi di tipo object
    const objectFields = [...this.campi.filter(({ descr }) => descr === 'object')];

    // Imposta l'index attuale in base all'ultimo figlio
    objectFields.forEach((field: any) => {
      this.indexArray.set(field.id, Math.max(...field.children.map((child: any) => {return child.index})));
    });

    // Raggruppa i figli in oggetti
    objectFields.forEach((field: any) => {
      field.children = this.makeChildrenArray(field);
    })
    console.log("this.campi:", this.campi);
    //this.preview();
  }*/

  public set setIdModulo(idModulo: any) {
    this.idModuloCorrente = idModulo;
  }

  get prodottiTreeRoot() { return this._prodottiTreeRoot; }

  get selectedProduct() { return this._selectedProduct; }
  private set selectedProduct(value) {
    this._selectedProduct?.htmlElement.classList.remove('selected');
    this._selectedProduct = value;
    this._selectedProduct?.htmlElement.classList.add('selected');
  }

  set currentCampo( value: any ) {
    this._currentCampo = value;
  }
  get currentCampo(){
    return this._currentCampo;
  }

  selectProdotto(node: ATreeNodeComponent): void {
    console.log(node.id);
    if (!node.isLeafNode()) return;
    for(let campiModulo of this.campi){
      console.log(campiModulo.filter((c: any) => {return c.id == this.currentCampo}));
      campiModulo.filter((c: any) => {return c.id == this.currentCampo})[0]['id_tipo_prodotto'] = node.id
      campiModulo.filter((c: any) => {return c.id == this.currentCampo})[0]['descr_tipo_prodotto'] = node.name
      let valoriFiltrati = campiModulo.filter((c: any) => {return c.id == this.currentCampo})[0].autofiller?.valori.filter((v: any ) => {return v.id_tipo_prodotto == node.id});
      campiModulo.filter((c: any) => {return c.id == this.currentCampo})[0].autofiller['valoriFiltrati'] = valoriFiltrati;
    }
    console.log(this.campi)
    this._valueChange.emit(false)
  }

}
