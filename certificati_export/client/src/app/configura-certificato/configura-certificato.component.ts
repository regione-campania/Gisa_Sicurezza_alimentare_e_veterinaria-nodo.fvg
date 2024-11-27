/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { CertificatiService } from '../certificati/certificati.service';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ConfiguraCertificatoService } from './configura-certificato.service';
import Swal from 'sweetalert2';
import { baseUri } from 'src/environments/environment';

@Component({
  selector: 'app-configura-certificato',
  templateUrl: './configura-certificato.component.html',
  styleUrls: ['./configura-certificato.component.scss']
})
export class ConfiguraCertificatoComponent {

  paesi: any;
  certificatiArray!: any[];
  paeseSelezionato!: number;
  selectedCertificato: any;
  tipiCampo!: any;
  anagrafiche!: any;
  pdf: any;
  private _nomi_campi?: any;
  campiForm?: FormGroup;
  query!: any[];
  bloccaSelect:boolean=true;
  disabled = true;
  _nuovoCertificato: string = "";
  _mode: string = 'certificato';
  anagraficheSelezionate: any[] = [];

  constructor(
    private cc: CertificatiService,
    private fb: FormBuilder,
    private ccs: ConfiguraCertificatoService
  ) { }

  ngOnInit(){
    this.campiForm = this.fb.group({ campi: this.fb.array([]) });
    console.log("this.campiForm:", this.campiForm);

    this.cc.getDati('get_countries').subscribe((res: any) => {
      if (res.esito)
        this.paesi = JSON.parse(res.info);
    })

    this.cc.getDati('get_tipi_campo').subscribe((res:any) => {
      if(!res.esito) return;
      this.tipiCampo = JSON.parse(res.info);
      this.tipiCampo = this.tipiCampo.filter((t: any) => {return t.configurabile_statico})
      console.log("this.tipiCampo:", this.tipiCampo);
    })

    this.cc.getDati('get_liste', {id_asl: true}).subscribe((res:any) => {
      if(!res.esito) return;
      this.anagrafiche = JSON.parse(res.info);
      console.log("this.anagrafiche:", this.anagrafiche);
    })

    this.cc.getDati('get_query').subscribe((res:any) => {
      if(!res.esito) return;
      this.query = JSON.parse(res.info);
      console.log("this.anagrafiche:", this.anagrafiche);
    })
  }

  changePaese(ev?: any, idPaese?: number) {
    if(ev)
      this.paeseSelezionato = parseInt(ev.target.value);
    else 
      this.paeseSelezionato = idPaese!;
    this.cc.getDati('get_certificati', { id_country: this.paeseSelezionato }).subscribe((res: any) => {
      console.log(res);
      if (res.esito)
        this.certificatiArray = JSON.parse(res.info).filter((cc: any) => {
          return cc.id_country == this.paeseSelezionato && ((this.mode == 'allegato' && cc.descr_tipo_modulo == 'statico_allegato') || (this.mode == 'certificato' && cc.descr_tipo_modulo == 'statico'))
        });
    })
  }

  changeCertificato(ev: any) {
    this.selectedCertificato = ev.target.value;
    console.log(this.selectedCertificato);
    if(this.selectedCertificato != -1){
      this.nuovoCertificato = '';
    }
  }

  allegaVerbaleDaConfigurare(event: any) {
    console.log("event.target.files[0]:", event.target.files[0])
    this.pdf = event.target.files[0];
    this.checkPdfSize(this.pdf);
    this.cc.caricaPdfDaConfigurare(this.pdf).subscribe((res:  any) => {
      console.log(res);
      this._nomi_campi = res;
      this.campiFormArray.clear();
      this._nomi_campi.forEach((nc: any, i: number) => {
        console.log("nc.nome_campo:", nc.nome_campo);
        this.addCampoFormGroup({'nome_campo': nc.nome_campo, index: i});
      });
      console.log("this.campiForm:", this.campiForm);
    })

  }

  addCampoFormGroup(fields: any = {}): void {
    this.campiFormArray.push(this.createCampoFormGroup(fields));
  }

  deleteOrClearCampoFormGroup(i: number): void {
    if (this.campiFormArray.length > 1) this.campiFormArray.removeAt(i);
    else this.campiFormArray.reset();
  }

  private createCampoFormGroup(fields: any = {}): FormGroup {
    return new FormGroup({
      'label': new FormControl(fields['nome_campo'] ?? null, Validators.required),
      'font_size': new FormControl(8, Validators.required),
      'nome_campo': new FormControl(fields['nome_campo'] ?? null),
      'id_query': new FormControl(null),
      'id_tipo_campo': new FormControl(null, Validators.required),
      'id_anagrafica_lista': new FormControl(null),
      'campo_traduzione': new FormControl(null),
      'ord': new FormControl(fields['index']),
      'obbligatorio': new FormControl(fields['obbligatorio']?.toString() ?? 'false', Validators.required)
    });
  }

  changeQuery(q: any, index: any){
    this.getAnagraficheSelezionate();
    console.log("changeQuery"+q.target.value);

    console.log("INPUT ",q.srcElement.attributes.formcontrolname.value);
  /* this.campiFormArray.controls[index].get('id_tipo_campo')?.disable();
  this.campiFormArray.controls[index].get('id_anagrafica_lista')?.disable(); */

   if(q.srcElement.attributes.formcontrolname.value=="id_query"){
    console.log("sono nel IF id_query");
   if(q.target.value =="null"){
      console.log("sono nel null");
      this.campiFormArray.controls[index].get('id_tipo_campo')?.enable();
      this.campiFormArray.controls[index].get('id_anagrafica_lista')?.enable();
      this.campiFormArray.controls[index].get('campo_traduzione')?.enable();
    }else{
      this.campiFormArray.controls[index].get('id_tipo_campo')?.reset();
      this.campiFormArray.controls[index].get('id_tipo_campo')?.disable();
      this.campiFormArray.controls[index].get('id_anagrafica_lista')?.reset();
      this.campiFormArray.controls[index].get('id_anagrafica_lista')?.disable();
      this.campiFormArray.controls[index].get('campo_traduzione')?.reset();
      this.campiFormArray.controls[index].get('campo_traduzione')?.disable();
     
    }  
    if(q.target.value){
          this.campiFormArray.controls[index].get('id_query')?.clearValidators();
    }else{
          this.campiFormArray.controls[index].get('id_query')?.addValidators([Validators.required]);
    }
  
  }
  if(q.srcElement.attributes.formcontrolname.value=="id_tipo_campo"){
 
    if(q.target.value =="null"){      
       this.campiFormArray.controls[index].get('id_query')?.enable();
       this.campiFormArray.controls[index].get('id_anagrafica_lista')?.enable();
       this.campiFormArray.controls[index].get('campo_traduzione')?.enable();
     }else{
       this.campiFormArray.controls[index].get('id_query')?.reset();
       this.campiFormArray.controls[index].get('id_query')?.disable();
       this.campiFormArray.controls[index].get('id_anagrafica_lista')?.reset();
       this.campiFormArray.controls[index].get('id_anagrafica_lista')?.disable();
       this.campiFormArray.controls[index].get('campo_traduzione')?.reset();
       this.campiFormArray.controls[index].get('campo_traduzione')?.disable();
     }  
     if(q.target.value){
             this.campiFormArray.controls[index].get('id_tipo_campo')?.clearValidators();
     }else{
           this.campiFormArray.controls[index].get('id_tipo_campo')?.addValidators([Validators.required]);
     }
   
   }
   if(q.srcElement.attributes.formcontrolname.value=="id_anagrafica_lista"){
   
    if(q.target.value =="null"){
   
       this.campiFormArray.controls[index].get('id_tipo_campo')?.enable();
       this.campiFormArray.controls[index].get('id_query')?.enable();
       this.campiFormArray.controls[index].get('campo_traduzione')?.enable();
     }else{
       this.campiFormArray.controls[index].get('id_query')?.reset();
       this.campiFormArray.controls[index].get('id_query')?.disable();
       this.campiFormArray.controls[index].get('id_tipo_campo')?.reset();
       this.campiFormArray.controls[index].get('id_tipo_campo')?.disable();
       this.campiFormArray.controls[index].get('campo_traduzione')?.reset();
       this.campiFormArray.controls[index].get('campo_traduzione')?.disable();
      
     }  
     if(q.target.value){
             this.campiFormArray.controls[index].get('id_anagrafica_lista')?.clearValidators();
     }else{
           this.campiFormArray.controls[index].get('id_anagrafica_lista')?.addValidators([Validators.required]);
     }
   
   }
   if(q.srcElement.attributes.formcontrolname.value=="campo_traduzione"){
   
    if(q.target.value =="null"){
   
       this.campiFormArray.controls[index].get('id_tipo_campo')?.enable();
       this.campiFormArray.controls[index].get('id_query')?.enable();
       this.campiFormArray.controls[index].get('id_anagrafica_lista')?.enable();
     }else{
       this.campiFormArray.controls[index].get('id_query')?.reset();
       this.campiFormArray.controls[index].get('id_query')?.disable();
       this.campiFormArray.controls[index].get('id_tipo_campo')?.reset();
       this.campiFormArray.controls[index].get('id_tipo_campo')?.disable();
       this.campiFormArray.controls[index].get('id_anagrafica_lista')?.reset();
       this.campiFormArray.controls[index].get('id_anagrafica_lista')?.disable();

      
     }  
     if(q.target.value){
             this.campiFormArray.controls[index].get('id_anagrafica_lista')?.clearValidators();
     }else{
           this.campiFormArray.controls[index].get('id_anagrafica_lista')?.addValidators([Validators.required]);
     }
   
   }
  
  }

  async downloadTemplateCorrente(){
    console.log("downloadTemplateCorrente")
      let filename = null
      this.certificatiArray.every((c: any) => {
        if(c.id == this.selectedCertificato){
          filename = c.filename_template;
          return false;
        }
        return true;
      })
      if(filename){
        // Effettua il download del certificato
        filename = 'certificatiExportTemplates/'+filename
        console.log("baseUri + this._pathFile:", baseUri + filename);
        let blob = await fetch(baseUri + filename).then(r => r.blob());
        let link = document.createElement('a');
        link.href = URL.createObjectURL(blob);
        link.download = filename!;
        link.click();
        link.remove();
        URL.revokeObjectURL(baseUri + filename);
      }else{
        Swal.fire({
          icon: 'warning',
          text: 'Nessun template trovato per il certificato selezionato'
        })
      }
  }

  checkPdfSize(file: any) {
    if(file.size / 1024 / 1024 > 20){
      Swal.fire({
        text: 'Il pdf non può superare i 20mb',
        icon: 'warning'
      })
      return;
    }
  }

  // Salva le modifiche per i campi
  saveCampi(): void {
    console.log("this.campiForm?.value:", this.campiForm?.value);
    console.log("this.selectedCertificato:", this.selectedCertificato);
    console.log("this.pdf.name:", this.pdf.name);
    console.log("this._nuovoCertificato:", this._nuovoCertificato?.length);

    if(!this._nuovoCertificato?.trim().length && this.selectedCertificato < 0){
      Swal.fire({
        text: 'Specificare un nome per il nuovo certificato/allegato',
        icon: 'error'
      })
      return;
    }

    if (this.campiForm?.invalid || !this.selectedCertificato || !this.pdf.name) return;

    const params = {
      ...this.campiForm?.value,
      filename: this.pdf.name,
      id_certificato: this.selectedCertificato,
      tipo_certificato: this.mode,
      nuovo_nome: this._nuovoCertificato,
      paese: this.paeseSelezionato
    };

    this.checkPdfSize(this.pdf);

    this.ccs.insertModuloCampi(params).subscribe((res: any) => {
      console.log("res:", res);
      if (!res.esito) {
        Swal.fire({
          text: 'Errore durante la configurazione',
          icon: 'error'
        })
        return;
      }
      Swal.fire({
        text: 'Configurazione salvata con successo',
        icon: 'success'
      })
      this.ccs.memorizzaPDFConfigurato({filename: this.pdf.name}).subscribe((res: any) => {
        console.log("res", res);
        setTimeout(()=>{
          window.location.reload();
        },2000)
      })
    });
  }

  /******************************** ACCESSORS *********************************/
  get nomi_campi() { return this._nomi_campi; }
  get campiFormArray() { return this.campiForm?.get('campi') as FormArray; }
  /****************************************************************************/

  get nuovoCertificato() {
    return this._nuovoCertificato;
  }

  set nuovoCertificato(v: string) {
    this._nuovoCertificato = v;
  }

  get mode() {
    return this._mode;
  }

  set mode(v: string) {
    this._mode = v;
  }

  getAnagraficheSelezionate(): any {
    this.anagraficheSelezionate = this.campiForm?.get('campi')?.value
    .filter((f: any) => {return f.id_anagrafica_lista && f.id_anagrafica_lista != 'null'}).map((a: any) => {return {descr: a.label}});
    console.log(this.anagraficheSelezionate);
  }

  setNuovoCertificato(evt: any){
    this.nuovoCertificato = (evt.target?.value);
  }

  changeTipo(v: any){
    this.mode = v.target.value
    this.changePaese(null, this.paeseSelezionato)
  }

  eliminaCertificato(idCertificato: any){
    this.ccs.eliminaCertificato({id_certificato: idCertificato}).subscribe((res: any) => {
      if(res.esito){
        this.certificatiArray = this.certificatiArray.filter((el: any) => el.id != idCertificato);
        this.selectedCertificato = -1;
      }
    })
  }



}

