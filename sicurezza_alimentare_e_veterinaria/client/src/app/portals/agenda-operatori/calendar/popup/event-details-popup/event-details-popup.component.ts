/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  animate,
  state,
  style,
  transition,
  trigger,
} from '@angular/animations';
import {
  Component,
  ElementRef,
  EventEmitter,
  Input,
  OnInit,
  Output,
} from '@angular/core';
import { NavigationStart, Router } from '@angular/router';
import { EventApi } from '@fullcalendar/core';
import { LoadingDialogService } from '@us/utils';
import { AgendaOperatoriService } from 'src/app/portals/agenda-operatori/agenda-operatori.service';

const ANIMATION_TIME = 300;

/** Contains information about a calendar event. It's content will be projected into a Popper popover. */
@Component({
  selector: 'event-details-popup',
  templateUrl: './event-details-popup.component.html',
  styleUrls: ['../calendar-popup.scss', './event-details-popup.component.scss'],
  animations: [
    trigger('switchMode', [
      state(
        'open',
        style({
          height: '*',
          opacity: '1',
          overflowY: 'hidden',
        })
      ),
      state(
        'close',
        style({
          height: '0px',
          opacity: '0',
          overflowY: 'hidden',
        })
      ),
      transition('open <=> close', [
        style({ overflowY: 'hidden' }),
        animate(`${ANIMATION_TIME}ms ease-in-out`),
      ]),
    ]),
  ],
})
export class EventDetailsPopupComponent implements OnInit {
  @Input() event?: EventApi;
  @Output('onClose') closeEvent = new EventEmitter<void>();
  @Output('onWrite') writeEvent = new EventEmitter<EventApi>();
  @Output('onDelete') deleteEvent = new EventEmitter<EventApi>();

  element: HTMLElement;
  popupAnimationState: 'open' | 'close' = 'open';
  private _mode: 'read' | 'write' | 'delete' = 'read';
  private _pendingChanges = { effettuata: '' };

  constructor(
    private elementRef: ElementRef,
    private router: Router,
    private as: AgendaOperatoriService,
    private loading: LoadingDialogService
  ) {
    this.element = this.elementRef.nativeElement;
  }

  ngOnInit(): void {
    this.router.events.subscribe(ev => {
      if (ev instanceof NavigationStart) {
        this.closeEvent.emit();
      }
    })
  }

  switchMode(mode: 'read' | 'write' | 'delete') {
    this.popupAnimationState = 'close';
    setTimeout(() => {
      this._mode = mode;
      this.popupAnimationState = 'open';
    }, ANIMATION_TIME);
  }

  enterWriteMode() {
    this._mode = 'write';
    this._pendingChanges.effettuata = this.event!.extendedProps['effettuata'];
  }

  enterDeleteMode() {
    this.switchMode('delete');
  }

  cancelAction() {
    if (this.mode === 'delete')
      this.switchMode('read');
    else
      this._mode = 'read'; //no animation
  }

  confirmAction() {
    switch (this.mode) {
      case 'write':
        this._mode = 'read';
        this._confirmChanges();
        break;
      case 'delete':
        this.deleteEvent.emit(this.event);
        this.switchMode('read');
        break;
      default:
        this.switchMode('read');
    }
  }

  private _confirmChanges() {
    console.log('--- updating event:', this.event);
    this.event?.setExtendedProp('effettuata', this.pendingChanges.effettuata);
    this.writeEvent.emit(this.event);
  }

  apriCu() {
    if (this.event?.extendedProps['sigla_tipo_evento'] == 'PL') {
      this.router.navigate(['portali', 'bdnfvg', 'interventi', 'gestione-intervento'], {
        queryParams: { id_intervento: this.event?.extendedProps['id_cu'] }
      })
    } else if (this.event) {
      this.router.navigate(['portali', 'controlli-ufficiali', 'lista', 'dettaglio'], {
        queryParams: { id_cu: this.event?.extendedProps['id_cu'] }
      })
    }
  }

  creaCu() {
    if (this.event?.extendedProps['sigla_tipo_evento'] == 'PL') {
      this.loading.openDialog('Creazione ' + this.event?.extendedProps['sigla_tipo_evento'] + ' in corso...');
      this.as.creaContrUffFromEvento(this.event.id).subscribe(res => {
        this.loading.closeDialog();
        if (res.esito) {
          this.router.navigate(['portali', 'bdnfvg', 'interventi', 'gestione-intervento'], {
            queryParams: { id_intervento: res.info['id_cu'] }
          })
        }
      });
    } else if (this.event) {
      this.as.creaContrUffFromEvento(this.event.id).subscribe(res => {
        this.loading.closeDialog();
        if (res.esito) {
          this.router.navigate(['portali', 'controlli-ufficiali', 'lista', 'dettaglio'], {
            queryParams: { id_cu: res.info['id_cu'] }
          })
        }
      });
    }
  }

  //accessors
  public get mode() {
    return this._mode;
  }

  public get pendingChanges() {
    return this._pendingChanges;
  }
}
