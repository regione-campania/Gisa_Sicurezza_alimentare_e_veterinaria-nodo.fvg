/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  AfterViewChecked,
  ChangeDetectorRef,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { GeneratoreCalendarioService } from './generatore-calendario.service';
import { SettaggiComponent } from './settaggi/settaggi.component';
import { concat, of, tap, timer } from 'rxjs';
import Swal from 'sweetalert2';
import { ActivatedRoute, Router } from '@angular/router';
import { CalendarioComponent } from './calendario/calendario.component';
import { LoadingDialogService, NotificationService, stretchHeight } from '@us/utils';
import { StruttureComponent } from './strutture/strutture.component';
import { LineeComponent } from './linee/linee.component';

@Component({
  selector: 'app-generatore-calendario',
  templateUrl: './generatore-calendario.component.html',
  styleUrls: ['./generatore-calendario.component.scss'],
})
export class GeneratoreCalendarioComponent implements OnInit, AfterViewChecked {
  @ViewChild(StruttureComponent, { static: true }) struttureComponent!: StruttureComponent;
  @ViewChild(SettaggiComponent, { static: true }) settaggiComponent!: SettaggiComponent;
  @ViewChild(LineeComponent, { static: true }) lineeComponent!: LineeComponent;
  @ViewChild(CalendarioComponent) calendarioComponent?: CalendarioComponent;

  elab?: { id: number, descr: string, bloccato: boolean, elaborato: boolean };

  readonly vociMenu = [
    { id: 'strutture', label: 'Risorse e Piani', disabled: false },
    { id: 'settaggi', label: 'Settaggi', disabled: false },
    { id: 'linee', label: 'Linee', disabled: false },
    { id: 'riepilogo', label: 'Riepilogo', disabled: true },
    { id: 'calendario', label: 'Calendario', disabled: true },
    { id: 'riversa', label: 'Riversa', disabled: true }
  ];

  private _voceSelezionata = this.vociMenu[0];
  private _hasPendingChanges = false;

  constructor(
    private gs: GeneratoreCalendarioService,
    private loadingService: LoadingDialogService,
    private notification: NotificationService,
    private router: Router,
    private route: ActivatedRoute,
    private changeDetector: ChangeDetectorRef,
    private elementRef: ElementRef,
  ) { }

  ngOnInit(): void {
    this.init();
    setTimeout(() => {
      let mainContent = document.querySelector('#main-content') as HTMLElement;
      if (mainContent) stretchHeight(mainContent, document.body, 20, true)
    });
  }

  ngAfterViewChecked(): void {
    this.changeDetector.detectChanges();
  }

  init() {
    this.route.queryParams.subscribe(params => {
      this.gs
        .getCalendarioInfo(params['elab'])
        .subscribe(res => {
          if (!res.esito) {
            this.notification.push({
              notificationClass: 'error',
              content: 'Nessuna elaborazione trovata!'
            });
            this.router.navigate(['portali', 'gestione-attivita', 'lista-calendari']);
            return;
          }
          this.elab = res.info;
          if (this.elaborazioneGenerata || this.elaborazioneBloccata)
            this.vociMenu.forEach((_, i) => this.abilitaVoceMenu(i));
        })
    });
  }

  selezionaVoceMenu(idOrIndex: string | number) {
    let curr = this.voceSelezionata;
    let next: typeof curr | undefined;
    if (typeof idOrIndex === 'number')
      next = this.vociMenu[idOrIndex];
    else
      next = this.vociMenu.find(v => v.id === idOrIndex);
    if (next && next.id != curr.id) {
      if (!this.elaborazioneGenerata) { //effettuo salvataggi solo se l'elaborazione non è stata già generata
        switch (curr.id) {
          case 'strutture': this.salvaStrutture().subscribe(_ => this.lineeComponent.initLinee()); break;
          case 'settaggi': this.salvaSettaggi().subscribe(_ => this.lineeComponent.initLinee()); break;
          case 'linee': this.salvaLinee().subscribe(); break;
        }
      }
      this.voceSelezionata = next;
    } else if(!next) {
      console.error('Nessuna voce nel menu con id: %s.', idOrIndex);
    }
  }

  abilitaVoceMenu(idOrIndex: string | number) {
    if (typeof idOrIndex === 'number')
      this.vociMenu[idOrIndex].disabled = false;
    else {
      const voce = this.vociMenu.find(v => v.id === idOrIndex);
      if (voce) voce.disabled = false;
      else console.error('Nessuna voce nel menu con id: %s.', idOrIndex);
    }
  }

  disabilitaVoceMenu(idOrIndex: string | number) {
    if (typeof idOrIndex === 'number')
      this.vociMenu[idOrIndex].disabled = true;
    else {
      const voce = this.vociMenu.find(v => v.id === idOrIndex);
      if (voce) voce.disabled = true;
      else console.error('Nessuna voce nel menu con id: %s.', idOrIndex);
    }
  }

  salvaStrutture() {
    return this.struttureComponent.updStrutture();
  }

  salvaSettaggi() {
    return this.settaggiComponent.updSettaggi();
  }

  salvaLinee() {
    return this.lineeComponent.updLinee();
  }

  salvaTutto() {
    return concat(
      this.salvaStrutture(),
      this.salvaSettaggi(),
      this.gs.getElabLinee(this.elab!.id),
      this.salvaLinee(),
    )
  }

  generaCalendario() {
    if (this.checkPeriodo()) {
      this.loadingService.openDialog('Generazione in corso...');
      let sub = this.salvaTutto().subscribe({
        next: (res) => {
          if (res && !res.esito) {
            this.notification.push({
              notificationClass: 'error',
              content: 'Errore salvataggio. Generazione annullata.',
            });
            sub.unsubscribe();
            this.loadingService.closeDialog();
          }
        },
        error: (err) => {
          this.notification.push({
            notificationClass: 'error',
            content: 'Errore salvataggio. Generazione annullata.',
          });
          sub.unsubscribe();
          this.loadingService.closeDialog();
        },
        complete: () => {
          //inizio generazione
          this.gs.generaCalendario(this.elab!.id).subscribe(res => {
            if (!res.esito) {
              this.notification.push({
                notificationClass: 'error',
                content: 'Errore in fase di generazione',
              });
              this.loadingService.closeDialog();
              return;
            } else {
              this.hasPendingChanges = false;
              this.loadingService.hideSpinner();
              this.loadingService.setMessage('Generazione Completata!');
              //creo tasto OK per chiudere il log
              let okButton = document.createElement('button');
              okButton.type = 'button';
              okButton.className = 'btn btn-primary d-block mb-3 mx-auto';
              okButton.innerText = 'OK';
              okButton.style.minWidth = '100px';
              okButton.addEventListener('click', () => {
                this.loadingService.closeDialog();
              })
              this.loadingService.dialog.htmlElement.querySelector('.loading-dialog')?.append(okButton);
              //reinizializzo calendario
              this.gs
                .getCalendarioInfo(this.elab!.id)
                .subscribe(res => {
                  this.elab = res.info;
                  this.bloccaEditing();
                  this.vociMenu.forEach((_, i) => this.abilitaVoceMenu(i));
                  this.selezionaVoceMenu('riepilogo');
                })
            }
          });

          //crezione log generazione
          let log = document.createElement('div');
          log.className = 'log box-3d rounded mt-2';
          this.loadingService.dialog.htmlElement.append(log);
          let timerSub = timer(0, 2000).subscribe(_ => {
            this.gs.getElabLog(this.elab!.id).subscribe(res => {
              log.innerHTML = 'log:\n';
              if (res.info && (typeof res.info === 'object')) {
                res.info.forEach((x: any) => {
                  log.innerHTML += (x.value + '\n');
                });
                if (res.info.at(-1).elaborato) {
                  timerSub.unsubscribe();
                }
              } else {
                this.notification.push({
                  notificationClass: 'error',
                  content: 'Errore log generazione.'
                })
                timerSub.unsubscribe();
              }
            })
          })
        }
      })
    }
  }

  annulla() {
    this.gs.annullaElabCal(this.elab!.id).subscribe(res => {
      if (!res.esito) {
        this.notification.push({
          content: 'Annullamento non riuscito, riprovare',
          notificationClass: 'error'
        })
      } else {
        this.notification.push({
          content: 'Generazione annullata',
          notificationClass: 'info'
        })
        this.disabilitaVoceMenu('riepilogo');
        this.disabilitaVoceMenu('calendario');
        this.disabilitaVoceMenu('riversa');
        this.elab = res.info;
        this.sbloccaEditing();
        setTimeout(() => this.selezionaVoceMenu(0));
      }
    });
  }

  onAnnullaButtonClick() {
    Swal.fire({
      titleText: 'Annullare la generazione?',
      confirmButtonText: 'SI',
      denyButtonText: 'NO',
      showDenyButton: true,
    }).then((res) => {
      if (res.isConfirmed) this.annulla();
    });
  }

  onRiversa() {
    this.hasPendingChanges = false;
    this.bloccaEditing();
    this.init();
  }

  checkPeriodo() {
    let periodo_da = this.settaggiComponent.settaggiParams.filter((settaggio: any) => settaggio.tag === 'periodo_da')[0];
    let periodo_a = this.settaggiComponent.settaggiParams.filter((settaggio: any) => settaggio.tag === 'periodo_a')[0];
    if (new Date(periodo_da?.val) >= new Date(periodo_a?.val)) {
      this.notification.push({
        content: 'La data di inizio periodo deve essere minore della data di fine periodo.',
        notificationClass: 'warning'
      });
      return false;
    }
    return true;
  }

  bloccaEditing() {
    this.struttureComponent.aslTree.nodes?.forEach(node => node.readonly = true);
    this.struttureComponent.pianiTree.nodes?.forEach(node => node.readonly = true);
    this.lineeComponent.lineeTable?.disableAllSelectors();
    this.settaggiComponent.form.disable();
  }

  sbloccaEditing() {
    this.struttureComponent.aslTree.nodes?.forEach(node => node.readonly = false);
    this.struttureComponent.pianiTree.nodes?.forEach(node => node.readonly = false);
    this.lineeComponent.lineeTable?.enableAllSelectors();
    this.settaggiComponent.form.enable();
  }

  //accessors
  get voceSelezionata() {
    return this._voceSelezionata;
  }

  private set voceSelezionata(value) {
    this._voceSelezionata = value;
  }

  get hasPendingChanges() {
    return this._hasPendingChanges;
  }

  private set hasPendingChanges(value) {
    this._hasPendingChanges = value;
  }

  //computed
  get elaborazioneBloccata() { return this.elab?.bloccato; }
  get elaborazioneGenerata() { return this.elab?.elaborato; }
  get generazioneAbilitata() {
    return (
      this.struttureComponent?.aslSelezionate?.length > 0 &&
      this.struttureComponent?.pianiSelezionati?.length > 0 &&
      this.settaggiComponent?.isPeriodoValid
      ) ?? false;
  }
  get isChildComponentLoading() {
    return (
      this.struttureComponent.loading ||
      this.settaggiComponent.loading ||
      this.lineeComponent.loading
    )
  }
}
