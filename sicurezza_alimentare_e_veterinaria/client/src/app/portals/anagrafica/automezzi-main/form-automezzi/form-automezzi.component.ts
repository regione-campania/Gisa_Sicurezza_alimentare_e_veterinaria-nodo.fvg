/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { BackendCommunicationService, LoadingDialogService, NotificationService } from '@us/utils';

@Component({
  selector: 'app-form-automezzi',
  templateUrl: './form-automezzi.component.html',
  styleUrls: ['./form-automezzi.component.scss']
})
export class FormAutomezziComponent {
 //----------------------VARIABILI-----------------------------
 dataMin: any;
 formAutomezzo: FormGroup;
 tipoOperazione: any;
 //-------------------COSTRUTTORE------------------------------
 constructor(
   private ComunicazioneDB: BackendCommunicationService,
   private LoadingService: LoadingDialogService,
   private route: ActivatedRoute,
   private router: Router,
   private fb: FormBuilder,
   private notificationService: NotificationService
 ) {
   this.formAutomezzo = this.fb.group({
     marca: this.fb.control(null, [Validators.required]),
     modello: this.fb.control(null, [Validators.required]),
     targa: this.fb.control(null, [Validators.required]),
    //  data_inizio_validita: this.fb.control(null, [Validators.required]),
    //  data_fine_validita: this.fb.control(null),
   })
 }
 //----------------------------NGONINIT--------------------------------
 ngOnInit(): void {
   console.log(this.route.snapshot.url[0].path)
   this.tipoOperazione = this.route.snapshot.url[0].path;
   if (this.tipoOperazione === 'modifica') {
    this.formAutomezzo.controls['targa'].disable();
   }
 }
 //------------------------FUNZIONI---------------------------
 checkDate(event: any, form: any) {
   const regex = /^(19|20)\d{2}-\d{2}-\d{2}$/
   let src = event.srcElement as HTMLInputElement;
   let nomeForm = null;
   nomeForm = src.getAttribute('formControlName');
   if (!src.validity.valid || !regex.test(src.value)) form.get(nomeForm).setValue("")


   // Object.keys(form.controls).forEach((controlName) => {
   //   if (controlName === 'data_inizio_validita' || controlName === 'data_fine_validita') {
   //     nomeForm = controlName;
   //     console.log("nomeForm:",nomeForm);
   //     if (!src.validity.valid || !regex.test(src.value)) {
   //       console.log(nomeForm);
   //       form.get(nomeForm).setValue("")
   //       console.log("entrato");
   //     }
   //   }
   // })

 }

 
 //------------------------------GET E SETTER----------------------------

}
