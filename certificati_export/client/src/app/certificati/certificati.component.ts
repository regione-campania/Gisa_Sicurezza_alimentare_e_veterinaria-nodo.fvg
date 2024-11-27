/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild } from '@angular/core';
import { CertificatiService } from './certificati.service';
import { CompilaCertificatoComponent } from './compila-certificato/compila-certificato.component';
import { PreviewCertificatoComponent } from './preview-certificato/preview-certificato.component';
import { ActivatedRoute, Router } from '@angular/router';
import { baseUri } from 'src/environments/environment';
import { Location } from '@angular/common';
import { UserService } from '../user/user.service';
import { formatDate } from '@angular/common';
import Swal from 'sweetalert2';
import { LoadingDialogService } from '@us/utils';
// declare let Swal: any;

@Component({
  selector: 'app-certificati',
  templateUrl: './certificati.component.html',
  styleUrls: ['./certificati.component.scss']
})
export class CertificatiComponent implements OnInit {

  public certificatiArray!: any[];
  public allegatiArray!: any[];
  public idCertificatoCompilato!: any;
  public idAllegatoCorrente: any;
  public paesi!: any;
  public paesiTracciabilita!: any;
  public paeseSelezionato: any = null;
  public paeseSelezionatoGenerico: any = null;
  private _signedPDF?: any;
  private _update?: boolean;
  private _stato?: string;
  _thisCertificato?: any;
  public thisStatiProssimi?: any;
  private _campiCompilati: any[] = [];
  private _userPermissions?: any;
  private _pathFile?: string;
  private _valueChange?: boolean;
  public showEmailButton = false;
  _showRicalendarizzaBtn: boolean = false;
  showDuplicaButton: boolean = false;
  checkUploadPDFPermission: boolean = false;

  startDate?: string;
  endDate?: string;

  startDateControllo?: string;
  endDateControllo?: string;

  private _selectedCertificato?: any;

  @ViewChild('compilaCertificato') compilatore!: CompilaCertificatoComponent;
  @ViewChild('previewCertificato') preview!: PreviewCertificatoComponent;

  constructor(
    private cc: CertificatiService,
    private us: UserService,
    private route: ActivatedRoute,
    private location: Location,
    private ls: LoadingDialogService,
    private router: Router
  ) { }

  // Distingue i 3 casi: Nuovo, Modificabile, Visionabile
  ngOnInit(): void {
    this.route.queryParams.subscribe((dati: any) => {
      console.log("dati:", dati);
      this._stato = dati.stato;
      this.idCertificatoCompilato = dati.id_certificato_compilato;
      // this.preview.setIdCertificato = dati.id_certificato_compilato;
      console.log('this.idCertificatoCompilato', this.idCertificatoCompilato);
    });

    // Prende i permessi dell'utente dal localStorage
    let appMap = new Map();

    this.us.getUser().subscribe((res: any) => {
      console.log("getPermission", res);
      res.permission.forEach((perm: any) => {
        appMap.set(perm.descr_permission, true);
        this._userPermissions = Object.fromEntries(appMap);
      });
    })

    /*
    for (const [key, value] of Object.entries(localStorage)) {
      if (key != 'token') appMap.set(key, value == 'true' ? true : false);
    }
    */

    this.cc.getDati('get_countries').subscribe((res: any) => {
      if (res.esito) {
        this.paesi = JSON.parse(res.info).filter((p: any) => { return p.n_moduli_compilati });
        this.paesiTracciabilita = this.paesi.filter((p: any) => { return p.id >= 0 });
      }
    })
    // Crea nuovo certificato
    /*if (this._stato == 'new') {
      this.cc.getDati('get_certificati').subscribe((res: any) => {
        if(res.esito)
          this.certificatiArray = JSON.parse(res.info);
      })
    }
    // Modifica certificato esistente
    else*/
    if (this._stato == 'edit_or_view') {
      this._valueChange = true;
      this.ls.openDialog('Caricamento in corso');
      this.cc.getInfoCertificato(this.idCertificatoCompilato).subscribe((res: any) => {
        console.log("res:", res);
        this.ls.closeDialog();
        this._thisCertificato = res;
        this._pathFile = res.pathname;
        this._campiCompilati = res.fields;

        console.log("this._thisCertificato:", this._thisCertificato);
        console.log("this._campiCompilati:", this._campiCompilati);

        // Scomponi la stringa dell'orario proposto
        var splitted = this._thisCertificato.info.orario_proposto?.split(',');
        var char2Replace: string[] = ['"', '(', ')', '[', ']'];
        if (splitted)
          char2Replace.forEach((c: string) => {
            splitted[0] = splitted[0]?.replaceAll(c, '');
            splitted[1] = splitted[1]?.replaceAll(c, '');
          });

        this.startDate = splitted?.[0].trim();
        this.endDate = splitted?.[1].trim();

        this._thisCertificato.info.orario_proposto_da = this.startDate;
        this._thisCertificato.info.orario_proposto_a = this.endDate;

        splitted = this._thisCertificato.info.orario_controllo?.split(',');
        if (splitted)
          char2Replace.forEach((c: string) => {
            splitted[0] = splitted[0]?.replaceAll(c, '');
            splitted[1] = splitted[1]?.replaceAll(c, '');
          });

        this.startDateControllo = splitted?.[0].trim();
        this.endDateControllo = splitted?.[1].trim();

        this._thisCertificato.info.orario_controllo_da = this.startDateControllo;
        this._thisCertificato.info.orario_controllo_a = this.endDateControllo;

        console.log("this.startDate:", this.startDate);
        console.log("this.endDate:", this.endDate);

        // Mostra la tabella dei campi compilati
        /*
        if (this._campiCompilati)
          this.compilatore.setCampi = this._campiCompilati;
        */



        setTimeout(() => {
          this.compilatore?.setValori(this._campiCompilati, this._thisCertificato.info.id_modulo);
          setTimeout(() => {
            this.compilatore?.preview();
          }, 0)
        }, 1000)

        // Visualizza il PDF inviando i dati al component figlio 'Preview'
        if (this._pathFile && this._campiCompilati) {
          this.setPdfPath(JSON.stringify({ data: this._campiCompilati, path: this._pathFile }));
        }

        // Imposta l'id modulo per la preview
        this.setIdModulo(this._thisCertificato.info.id_modulo);

        // imposta lo stato attuale per la preview
        //if (this._thisCertificato.statiSuccessivi.length > 0) {
        this.preview.setStatoCCAttuale = this._thisCertificato.info.id_stato_certificato_compilato;
        //}

        if (Object.keys(this._thisCertificato).length === 0) this.showDuplicaButton = false;
        else if (this._userPermissions.CAN_CREATE_CERTIFICATE === true) this.showDuplicaButton = true;
        else this.showDuplicaButton = false;

        this.getStatiCertificato()

      })
    } else {
      this.getStatiCertificato()
    }
  }

  getStatiCertificato() {
    setTimeout(() => {
      this.cc.getStatiCertificatoProssimo(this.idCertificatoCompilato).subscribe((res: any) => {
        console.log('res statiCertificato', res);
        if (!this._thisCertificato)
          this._thisCertificato = {};
        if (this._thisCertificato.info?.data_accettazione?.split(' ')[0] != new Date().toISOString().split('T')[0]) {
          res.forEach((stato: any, i: number) => {
            if (!stato.modificabile_stato_attuale && stato.modificabile_stato_prossimo) //annulla e ricompila
              res.splice(i, 1);
          })
        }
        this.thisStatiProssimi = res.reverse();


        if (
          this._userPermissions.CAN_CREATE_CERTIFICATE === true &&
          this.thisStatiProssimi[0].ask_data_proposta_stato_attuale === true &&
          this.idCertificatoCompilato
        )
          this.showEmailButton = true;

        if (
          this._thisCertificato &&
          this.thisStatiProssimi?.[0].ask_conferma_controllo_stato_attuale &&
          Object.keys(this._userPermissions).includes('CAN_CREATE_CERTIFICATE')
        ) this.checkUploadPDFPermission = true
        else
          this.checkUploadPDFPermission = false

        if (
          Object.keys(this._userPermissions).includes('CAN_ACCEPT_CERTIFICATE') &&
          // this.checkModificabile
          this.thisStatiProssimi?.[0].modificabile_stato_attuale
        ) this._showRicalendarizzaBtn = true;
      })
      /*if (this.idCertificatoCompilato) {
        // this.idCertificatoCompilato = this.idCertificatoCompilato;
        this.compilatore.getCertificatoCompilato(this.idCertificatoCompilato);
      }*/
    }, 0);
  }

  changeCertificato(ev: any) {
    const idModulo = this._selectedCertificato = ev.target.value;
    //if (idModulo && this.selectedProduct) this.compilatore.getModulo(idModulo, this.selectedProduct?.data?.id_node);
    if (idModulo) this.compilatore.getModulo(idModulo);
  }

  changeAllegato(ev: any) {
    this.idAllegatoCorrente = ev.target.value;
  }

  addAllegato() {
    this.compilatore.addModuloAllegato(this.idAllegatoCorrente);
  }

  changePaese(ev: any) {
    this.paeseSelezionato = parseInt(ev.target.value);
    this.cc.getDati('get_certificati', { id_country: this.paeseSelezionato }).subscribe((res: any) => {
      if (res.esito) {
        this.certificatiArray = JSON.parse(res.info)?.filter((c: any) => { return c.descr_tipo_modulo == 'statico' });
        this.allegatiArray = JSON.parse(res.info)?.filter((c: any) => { return c.descr_tipo_modulo == 'statico_allegato' });
      }
    })
    if (this.paeseSelezionato > 0) {
      this.paeseSelezionatoGenerico = null;
    }
  }

  changePaeseGenrico(ev: any) {
    this.paeseSelezionatoGenerico = parseInt(ev.target.value);
  }


  setPdfPath(data: string) {
    this.preview.setPdfPath(data);
    this._pathFile = JSON.parse(data).path;
  }

  setIdModulo(idModulo: string) { this.preview.setIdModulo(idModulo); }
  canSave(value: boolean) { this.preview.setCanSave = value; }
  valueChange(val: boolean) {
    this._valueChange = val;
    console.log("this._valueChange:", this._valueChange);
  }

  // Rinnova la data controllo
  recalendarizzaDataControllo(): void {
    let newDataControllo: any;

    Swal.fire({
      title: 'Ricalendarizza',
      html: `
        <span> Inserisci la nuova data controllo: </span> <br style="margin-bottom: 0.5rem">
        <input type="date" id="new-date" value=${this._thisCertificato.info?.data_controllo} min=${this.oggi}>
        <span> Orario: </span> <br style="margin-bottom: 0.5rem">
        Da: <input type="time" id="swal-input2"><br>
        A: <input type="time" id="swal-input3"><br>
        <br>
      `,
      showDenyButton: true,
      confirmButtonText: 'Invia',
      denyButtonText: 'Annulla',
      allowOutsideClick: false
    }).then((result) => {
      if (result.isConfirmed) {
        newDataControllo = (document.getElementById('new-date') as HTMLInputElement).value;
        console.log("newDataControllo:", newDataControllo);
        let new_orario_proposto_da = newDataControllo + " " + (document.getElementById('swal-input2') as HTMLInputElement).value;
        let new_orario_proposto_a = newDataControllo + " " + (document.getElementById('swal-input3') as HTMLInputElement).value;
        if (new_orario_proposto_a < new_orario_proposto_da) {
          Swal.fire({
            title: 'Attenzione!',
            text: 'Orario fine inferiore a orario inizio',
            icon: 'error',
          })
          this._update = false;
        }

        if (new Date(new Date(newDataControllo).setHours(0, 0, 0, 0)) < new Date(new Date().setHours(0, 0, 0, 0))) {
          Swal.fire({
            title: 'Attenzione!',
            icon: 'warning',
            text: `La data proposta è inferiore alla data odierna`,
            timer: 2000,
            timerProgressBar: true,
            showConfirmButton: false
          });
          return;
        }
        if (new Date(newDataControllo) >= new Date('2099-12-31')) {
          Swal.fire({
            icon: 'warning',
            title: 'Attenzione',
            text: 'Data supera limite consentito',
            timer: 2000,
            timerProgressBar: true,
            showConfirmButton: false
          });
          return        
        }

        let shallowCertificato: any = { ...this._thisCertificato.info };
        shallowCertificato.data_controllo = newDataControllo;
        shallowCertificato.orario_controllo_da = new_orario_proposto_da;
        shallowCertificato.orario_controllo_a = new_orario_proposto_a;
        console.log("shallowCertificato:", shallowCertificato);

        shallowCertificato.flags = {
          ricalendarizza: true
        }

        // Crea oggetto da passare al metodo
        const datiCertificato = {
          pdfPath: this._pathFile,
          idModulo: this.preview.idModulo,
          fields: this.preview.dataFields,
          id_certificato_compilato: this.idCertificatoCompilato,
          certificato: shallowCertificato,
          //id_denominazione_prodotto: this.selectedProduct?.data?.id_node ?? this.thisCertificato.info.id_node_denominazione_prodotto
        };

        console.log("datiCertificato:", datiCertificato);


        this.cc.salvaCertificato(datiCertificato, this.checkModificabile).subscribe((res: any) => {
          console.log("res:", res);

          if (res.info != true) {
            console.log("error!");
            Swal.fire({
              title: 'Attenzione!',
              text: res.msg ? res.msg : 'Problemi durante inoltro file',
              icon: 'error',
            });
            return;
          }

          Swal.fire({
            title: 'Successo',
            text: 'Inoltro avvenuto con successo',
            icon: 'success',
            allowOutsideClick: false
          }).then((result: any) => {
            this.location.back();
          });
        });
      }
    });
  }

  // Aggiorna lo stato del CC
  async updateCertificato(certificato: any, statoSuccessivo: any, saveValues: boolean) {
    console.log("statoSuccessivo:", statoSuccessivo);
    let shallowCertificato: any = { ...certificato.info };
    console.log("shallowCertificato:", shallowCertificato);

    if (statoSuccessivo.ask_conferma_controllo_stato_prossimo) {
      for (let modulo of this.preview.dataFields) {
        for (let campo of modulo) {
          console.log(campo);
          if (campo.obbligatorio && (campo.valore == null || campo.valore.trim() == '') && !campo.calcolo_a_posteriori) {
            Swal.fire({
              title: 'Attenzione',
              icon: 'warning',
              text: `Attenzione! È necessario compilare tutti i campi obbligatori contrassegnati dall'asterisco (${campo.label.toUpperCase()}).`,
              allowOutsideClick: true,
              showConfirmButton: true
            });
            return;
          }

          if (campo.dipende_tipo_certificato && !campo.id_tipo_prodotto) {
            Swal.fire({
              title: 'Attenzione',
              icon: 'warning',
              text: `Attenzione! È necessario selezionare il tipo prodotto per il campo (${campo.label.toUpperCase()}).`,
              allowOutsideClick: true,
              showConfirmButton: true
            });
            return;
          }
        }
      }
    }

    this._update = true;

    console.log("canUnlock:", this.us.getCanUnlock())
    let unlocked = false;

    if (!this._thisCertificato.info?.descr)
      shallowCertificato = await this.aggiungiDescrizione(shallowCertificato);
    if (statoSuccessivo.ask_data_proposta_stato_prossimo && this._update)
      shallowCertificato = await this.inoltraCertificato(shallowCertificato);
    if (statoSuccessivo.ask_data_controllo_stato_prossimo)
      shallowCertificato = await this.accettaCertificato(shallowCertificato);
    if (statoSuccessivo.ask_durata_controllo_stato_prossimo && this.us.getCanUnlock()) {
      unlocked = true;
      shallowCertificato = await this.autorizzaCertificato(shallowCertificato);
    }
    if (statoSuccessivo.descr_stato_prossimo == 'Da integrare')
      shallowCertificato = await this.descriviIntegrazione(shallowCertificato);
    if (statoSuccessivo.ask_conferma_controllo_stato_prossimo && !this.us.getCanUnlock() && !unlocked) {
      //unlocked = true //rimuovere prima del commit
      this.us.logoutSPID(null);
      const res = await Swal.fire({
        icon: 'question',
        text: 'Verrà ora richiesta l\'autenticazione tramite LoginFVG di un veterinario per il rilascio del certificato',
        showCancelButton: true,
        confirmButtonText: 'Continua',
        cancelButtonText: 'Annulla',
        allowOutsideClick: false
      });
      if (res.isConfirmed)
        this.us.sbloccaCertificatoSPID();
      return;
    }
    if (statoSuccessivo.is_annulla_stato_prossimo) {
      const res = await Swal.fire({
        icon: 'question',
        text: 'Sei sicuro di voler annullare il certificato?',
        showCancelButton: true,
        confirmButtonText: 'Continua',
        cancelButtonText: 'Annulla',
        allowOutsideClick: false
      });
      if (!res.isConfirmed)
        return

      console.log("----- Descrivi Annullamento -----");

      const { value: annullamento } = await Swal.fire({
        title: 'Motivo annullamento',
        input: 'textarea',
        inputPlaceholder: 'Inserisci la annullamento qui...',
        confirmButtonText: 'Continua',
        allowOutsideClick: false
      });
  
      console.log("motivoEliminazione:", annullamento);
      shallowCertificato.motivo_annullamento = annullamento;

      const res2 = await Swal.fire({
        icon: 'question',
        text: 'Eliminare anche la prestazione?',
        showCancelButton: true,
        confirmButtonText: 'Elimina prestazione',
        cancelButtonText: 'Mantieni prestazione',
        allowOutsideClick: false
      });
      shallowCertificato.flags = {
        eliminaAttivita: res2.isConfirmed
      }
    } else if (statoSuccessivo.delete_prestazione_stato_prossimo) {
      if (!unlocked && !this.us.getCanUnlock()) {
        this.us.logoutSPID(null);
        const res = await Swal.fire({
          icon: 'question',
          text: 'Verrà ora richiesta l\'autenticazione tramite LoginFVG di un veterinario per l\'annullamento del certificato',
          showCancelButton: true,
          confirmButtonText: 'Continua',
          cancelButtonText: 'Annulla',
          allowOutsideClick: false
        });
        if (res.isConfirmed)
          this.us.sbloccaCertificatoSPID();
        return;
      } else {
        const res = await Swal.fire({
          icon: 'question',
          text: 'Eliminare la prestazione e tornare allo stato precedente?',
          showCancelButton: true,
          confirmButtonText: 'Continua',
          cancelButtonText: 'Annulla',
          allowOutsideClick: false
        });
        if (!res.isConfirmed)
          return
        shallowCertificato.flags = {
          eliminaAttivita: true
        }
        this.us.resetCanUnlock();
      }
    }
    else if (statoSuccessivo.ask_conferma_controllo_stato_attuale)
      this.rilasciaCertificato();



    if (statoSuccessivo.send_email_eliminazione_stato_prossimo) {
      const res = await Swal.fire({
        icon: 'question',
        text: 'Sei sicuro di voler eliminare il certificato?',
        showCancelButton: true,
        confirmButtonText: 'Continua',
        cancelButtonText: 'Annulla',
        allowOutsideClick: false
      });
      if (!res.isConfirmed)
        return
    }

    if (!this._update) return;

    console.log("shallowCertificato:", shallowCertificato);

    // Cambia lo stato con lo stato successivo
    shallowCertificato.id_stato_certificato_compilato = statoSuccessivo.id_stato_prossimo;
    shallowCertificato.id_country_generico = this.paeseSelezionatoGenerico;

    // Crea oggetto da passare al metodo
    const datiCertificato = {
      pdfPath: this._pathFile,
      idModulo: this.preview.idModulo,
      fields: this.preview.dataFields,
      id_certificato_compilato: this.idCertificatoCompilato,
      certificato: shallowCertificato,
      //id_denominazione_prodotto: this.selectedProduct?.data?.id_node ?? this.thisCertificato.info.id_node_denominazione_prodotto,
    };

    console.log("datiCertificato:", datiCertificato);
    //    if(saveValues){
    // Richiama la route per salvare le info su DB
    if (datiCertificato.certificato.valoriTariffazione) {
      let resTrf = await this.cc.inviaDatiTariffazione(datiCertificato.certificato.valoriTariffazione);
      console.log(resTrf);
      if (!resTrf?.esito) {
        alert('Errore invio dati tariffazione');
        return;
      }
      await this.compilatore.preview(true);
    }
    if (statoSuccessivo.ask_conferma_controllo_stato_prossimo) {
      const filename = this._pathFile?.split('\\').pop();
      // Effettua il download del certificato
      console.log("baseUri + this._pathFile:", baseUri + this._pathFile);
      let blob = await fetch(baseUri + this._pathFile).then(r => r.blob());
      let link = document.createElement('a');
      link.href = URL.createObjectURL(blob);
      link.download = filename!;
      link.click();
      link.remove();
      URL.revokeObjectURL(baseUri + this._pathFile);
      // await this.compilatore.preview();
    }
    this.ls.openDialog('Salvataggio in corso');
    this.cc.salvaCertificato(datiCertificato, saveValues).subscribe(async (res: any) => {
      console.log(res);
      this.ls.closeDialog();
      if (res.info != true) {
        console.log("error!");
        Swal.fire({
          title: 'Attenzione!',
          text: res.msg ? res.msg : 'Problemi durante inoltro file',
          icon: 'error',
        });
        return;
      }

      console.log("success!");
      Swal.fire({
        title: 'Successo',
        text: 'Salvataggio avvenuto con successo',
        icon: 'success',
        allowOutsideClick: false
      }).then((result: any) => {
        if (statoSuccessivo.send_email_eliminazione_stato_prossimo) {
          this.cc.sendEmailEliminazione(this._thisCertificato.info.id).subscribe((res: any) => {
            console.log("res:", res);
          });
        }
        if(!this.idCertificatoCompilato)
          this.location.back();
        else
          window.location.reload();
      });
    })
    /*}else{
      // Effettua l'aggiornamento
      this.cc.updateCertificato(shallowCertificato).subscribe((res: any) => {
        console.log("res:", res);
        if (!res.info) return;
        Swal.fire({
          title: 'Successo',
          icon: 'success',
          text: 'Aggiornamento avvenuto con successo!',
          showConfirmButton: false,
          timer: 1000
        }).then((result: any) => {
          if (result.dismiss == Swal.DismissReason.timer) {
            window.location.reload();
          }
        });
      })
    }*/
  }

  private async aggiungiDescrizione(certificato: any) {
    let descr: string = this._thisCertificato.info?.descr == undefined ? '' : this._thisCertificato.info?.descr;

    // Prima di salvare inserisce info aggiuntive
    await Swal.fire({
      title: 'Aggiungi Informazioni',
      html: `
        <span> Inserisci una descrizione: </span> <br style="margin-bottom: 0.5rem">
        <input id="swal-input2" value='${descr}'>
      `,
      showDenyButton: true,
      confirmButtonText: 'Invia',
      denyButtonText: 'Annulla',
    }).then((result: any) => {
      console.log("result:", result);
      if (result.isConfirmed) {
        certificato.descr = (document.getElementById('swal-input2') as HTMLInputElement).value;
      } else {
        console.log("Richiesta Annullata");
        this._update = false;
      }
    });

    return certificato;
  }

  private async inoltraCertificato(certificato: any) {
    // Prima di salvare inserisce info aggiuntive
    await Swal.fire({
      title: 'Aggiungi Informazioni',
      html: `
        <span> Inserisci la data proposta: </span> <br style="margin-bottom: 0.5rem">
        <input type="date" id="swal-input1" value=${this._thisCertificato.info?.data_proposta} min=${this.oggi}><br>
        <span> Orario: </span> <br style="margin-bottom: 0.5rem">
        Da: <input type="time" id="swal-input2"><br>
        A: <input type="time" id="swal-input3"><br>
        <br>
      `,
      showDenyButton: true,
      confirmButtonText: 'Invia',
      denyButtonText: 'Annulla',
    }).then((result: any) => {
      console.log("result:", result);
      if (result.isConfirmed) {
        certificato.data_proposta = (document.getElementById('swal-input1') as HTMLInputElement).value;
        console.log("Data Proposta:", new Date(new Date(certificato.data_proposta).setHours(0, 0, 0, 0)));

        console.log("Today:", new Date(new Date().setHours(0, 0, 0, 0)));
        certificato.orario_proposto_da = certificato.data_proposta + " " + (document.getElementById('swal-input2') as HTMLInputElement).value;
        certificato.orario_proposto_a = certificato.data_proposta + " " + (document.getElementById('swal-input3') as HTMLInputElement).value;
        if (certificato.orario_proposto_a < certificato.orario_proposto_da) {
          Swal.fire({
            title: 'Attenzione!',
            text: 'Orario fine inferiore a orario inizio',
            icon: 'error',
          })
          this._update = false;
        }
        if (new Date(new Date(certificato.data_proposta).setHours(0, 0, 0, 0)) < new Date(new Date().setHours(0, 0, 0, 0))) {
          Swal.fire({
            title: 'Attenzione!',
            icon: 'warning',
            text: `La data proposta è inferiore alla data odierna`,
            timer: 2000,
            timerProgressBar: true,
            showConfirmButton: false
          });
          this._update = false;
        }
        if (new Date(certificato.data_proposta) >= new Date('2099-12-31')) {
          Swal.fire({
            icon: 'warning',
            title: 'Attenzione',
            text: 'Data supera limite consentito',
            timer: 2000,
            timerProgressBar: true,
            showConfirmButton: false
          });
          this._update = false;
        }
      } else {
        console.log("Richiesta Annullata");
        this._update = false;
      }
    });

    certificato.flags = {
      insEvento: true
    }
    return certificato;
  }

  // Da approvare -> Calendarizzato
  private async accettaCertificato(certificato: any) {
    console.log("----- accettaCertificato -----");
    console.log("certificato:", certificato);
    let dataControllo: any;
    await Swal.fire({
      title: 'Data Controllo',
      html: `
          <span> Inserisci la data controllo: </span> <br style="margin-bottom: 0.5rem">
          <input type="date" id="swal-input1" value=${this._thisCertificato.info?.data_controllo}>
        `,
      showDenyButton: true,
      confirmButtonText: 'Invia',
      denyButtonText: 'Annulla',
    }).then((result: any) => {
      console.log("result:", result);
      if (result.isConfirmed) {
        dataControllo = (document.getElementById('swal-input1') as HTMLInputElement).value;
        console.log("dataControllo:", dataControllo);
        // if (!certificato.data_controllo)
        certificato.data_controllo = dataControllo;
      } else {
        console.log("Richiesta Annullata");
        this._update = false;
      }
    });

    console.log("certificato:", certificato);

    return certificato;
  }

  // Calendarizzato -> Autorizzato in attesa di Conferma
  private async autorizzaCertificato(certificato: any) {
    console.log("----- autorizzaCertificato -----");

    this._update = false;

    let repeat: boolean = true;
    let minuti: any;


    let chiusuraResult = await this.cc.chiudiAttivita(this.idCertificatoCompilato)
    console.log("chiusura:", chiusuraResult)
    console.log("apro modale");
    if (!chiusuraResult?.esito || !chiusuraResult?.id_attivita) {
      alert('Errore chiusura attivita calendario');
      return;
    }

    let _html = '';
    let i = 0;
    for (let voci of chiusuraResult.voci) {
      _html += `
      <label>${voci.descr_voce}: </label>
      <input type='number' min="0" id="voce_${i}" class="swal2-input">
      `;
      i++;
    }

    while (repeat) {
      const { value: formValues } = await Swal.fire({
        title: 'Minuti prestazione',
        html: _html,
        allowOutsideClick: false,
        focusConfirm: true,
        preConfirm: () => {
          let ret: any[] = [];
          let i = 0;
          for (let voci of chiusuraResult.voci) {
            ret.push({
              id_tariffa: voci.id_voce,
              valore: (document.getElementById("voce_" + i) as HTMLInputElement).valueAsNumber,
            });
            if(Number.isNaN(ret[i].valore))
              ret[i].valore = 0;
            i++;
          }
          return ret;
        }
      });

      console.log("formValues:", formValues);
      if (Object.values(formValues!)?.every((el) => !Number.isNaN(el.valore) && parseInt(el.valore) >= 0)) {
        repeat = false;
        minuti = formValues;
      } else {
        await Swal.fire(({
          title: 'Attenzione!',
          icon: 'warning',
          text: 'Bisogna inserire solamente numeri maggiori di 0',
          timer: 2000,
          timerProgressBar: true,
          allowOutsideClick: false
        }));
      }
    }

    for (const [key, value] of Object.entries(minuti)) {
      certificato[key] = value;
    }

    certificato.valoriTariffazione = {
      id_trf_attivita: parseInt(chiusuraResult.id_attivita),
      valori: minuti
    };

    console.log(certificato.valoriTariffazione);

    /*
    const { value: numOre } = await Swal.fire({
      title: 'Minuti Controllo',
      input: 'number',
      inputLabel: 'Inserisci minuti:',
      showCancelButton: true,
      cancelButtonText: 'Annulla',
      allowOutsideClick: false,
      inputValidator: (value: string) => {
        return new Promise((resolve: any) => {
          if (!isNaN(parseInt(value))) { resolve() } else {
            this._update = false;
            resolve('Devi inserire un numero');
          }
        })
      }
    });

    // Se si annulla ritorna
    if (!numOre) return certificato;

    const inputOptions = {
      true: 'Si',
      false: 'No'
    };

    const { value: isMaggiorata } = await Swal.fire({
      title: 'Fatturazione Maggiorata?',
      icon: 'question',
      input: 'radio',
      showCancelButton: true,
      cancelButtonText: 'Annulla',
      allowOutsideClick: false,
      inputOptions: inputOptions,
      inputValidator: (value) => {
        return new Promise((resolve: any) => {
          if (!value) {
            resolve('Devi selezionare qualcosa');
          } else {
            resolve();
          }
        })
      }
    });

    if (numOre && isMaggiorata) {
      certificato.ore_controllo = numOre;
      certificato.tariffazione_maggiorata = isMaggiorata === 'true';
      this._update = true;
    }
    */

    this._update = true;
    console.log("certificato:", certificato);
    certificato.codiceSblocco = true;
    certificato.id_access_sblocco = this.us.getIdAccessSblocco()
    this.us.resetCanUnlock();
    return certificato;
  }

  private async descriviIntegrazione(certificato: any) {
    console.log("----- Descrivi Integrazione -----");

    const { value: text } = await Swal.fire({
      title: 'Descrivi Integrazione',
      input: 'textarea',
      inputLabel: 'Descrizione',
      inputPlaceholder: 'Inserisci la descrizione qui...',
      showDenyButton: false,
      showCancelButton: true,
      confirmButtonText: 'Invia',
      cancelButtonText: 'Annulla',
      allowOutsideClick: false
    });

    if (text) {
      console.log("text:", text);
      certificato.motivo_integrazione = text;
    } else {
      this._update = false;
    }

    return certificato;
  }

  async downloadPDF(filename?: string): Promise<void> {
    // Scarica PDF
    if (!this._pathFile) {
      this._update = false;
      return;
    }

    if (!filename)
      filename = this._thisCertificato.info.descr;

    filename = `${filename}.pdf`;


    // Effettua il download del certificato
    let blob = await fetch(baseUri + this._pathFile).then(r => r.blob());
    let link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = filename!;
    link.click();
    link.remove();
    URL.revokeObjectURL(baseUri + this._pathFile);
  }

  // Autorizzato Confermato -> Rilasciato
  private rilasciaCertificato() {
    if (!this._signedPDF) {
      Swal.fire({
        title: 'Attenzione!',
        text: 'Bisogna selezionare prima il PDF firmato!',
        icon: 'warning',
        allowOutsideClick: false
      });
      this._update = false;
      return;
    }

    this.cc.rilasciaCertificato(this._signedPDF, { idCertificato: this._thisCertificato.info.id }).subscribe((res: any) => {
      console.log("res:", res);
      if (!res.info) {
        Swal.fire({
          title: 'Attenzione!',
          text: `Errore durante l'elabrazione`,
          icon: 'error',
          allowOutsideClick: false
        });
        return;
      }
    })
  }

  allegaVerbaleCompleto(event: any) {
    console.log("event.target.files[0]:", event.target.files[0])
    this._signedPDF = event.target.files[0];
  }


  // Invia l'email di emergenza
  sendEmailUrgenza(): void {
    if (!this._thisCertificato) return;
    this.cc.sendEmailUrgenza(this._thisCertificato.info.id).subscribe((res: any) => {
      console.log("res:", res);
    });
  }

  duplicaCertificato(): void {
    if (!this._thisCertificato) return;
    this.cc.duplicaCertificato('duplica_certificato', {
      id_certificato: this._thisCertificato.info.id
    }).subscribe((res: any) => {
      console.log("res:", res);
      this.location.back();
    });
  }

  // GETTERS METHODS
  get thisCertificato() { return this._thisCertificato; }
  get userPermissions() { return this._userPermissions; }
  get getStato() { return this._stato; }
  get getValueChange() { return this._valueChange; }

  // Se l'utente ha il permesso di creare i certificati e il certificato è modificabile
  // allora fai comparire il bottone per la modifica
  public get checkModificabile(): boolean {
    if (!this._thisCertificato?.info) return true;

    let modificabile: boolean = false;
    if (this._userPermissions && Object.keys(this._userPermissions).includes('CAN_CREATE_CERTIFICATE')) {
      this.thisStatiProssimi?.forEach((singleState: any) => {
        if (singleState.modificabile_stato_attuale == true || singleState.modificabile_stato_attuale == 'true')
          modificabile = true;
      });
    }
    return modificabile;
  }

  // public get checkUploadPDFPermission(): boolean {
  //   // console.log("this._userPermissions:", this._userPermissions);
  //   //console.log("this.thisStatiProssimi:", this.thisStatiProssimi);
  //   if (
  //     this._thisCertificato &&
  //     this.thisStatiProssimi?.[0].ask_conferma_controllo_stato_attuale &&
  //     Object.keys(this._userPermissions).includes('CAN_CREATE_CERTIFICATE')
  //   ) return true
  //   else
  //     return false
  // }

  public get checkDownloadButton(): boolean {
    return (
      this.thisCertificato &&
        this._stato == 'edit_or_view' &&
        this._thisCertificato.getStatoCCAttuale == '4' ? true : false
    );
  }

  get oggi() {
    return formatDate(new Date().setHours(0, 0, 0, 0).toString(), 'yyyy-MM-dd', 'en');
  }

  /*// Visualizza il bottoncino sotto determinate condizioni
  get showEmailButton(): boolean {
    //return this._userPermissions.CAN_CREATE_CERTIFICATE && this.thisStatiProssimi[0].ask_data_proposta_stato_attuale;
    if (
      this._userPermissions.CAN_CREATE_CERTIFICATE === true &&
      this.thisStatiProssimi[0].ask_data_proposta_stato_attuale === true
    ) return true;
    return false;
  }*/

  // Visualizza il bottoncino per duplicare
  // get showDuplicaButton(): boolean {
  //   if (Object.keys(this._thisCertificato).length === 0) return false;
  //   else if (this._userPermissions.CAN_CREATE_CERTIFICATE === true) return true;
  //   else return false;
  // }

}
