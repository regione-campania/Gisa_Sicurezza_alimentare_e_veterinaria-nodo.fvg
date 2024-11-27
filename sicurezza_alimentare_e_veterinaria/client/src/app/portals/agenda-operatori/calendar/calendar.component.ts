/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import {
  AfterViewInit,
  Component,
  EventEmitter,
  OnInit,
  Output,
  ViewChild,
  ViewContainerRef,
} from '@angular/core';
import {
  Calendar,
  CalendarOptions,
  EventApi,
  EventClickArg,
  EventInput,
} from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';
import interactionPlugin from '@fullcalendar/interaction';
import itLocale from '@fullcalendar/core/locales/it';
import { CalendarService } from './calendar.service';
import {
  NgbModal,
  NgbModalOptions,
  NgbModalRef,
} from '@ng-bootstrap/ng-bootstrap';
import { EventDetailsPopupComponent } from './popup/event-details-popup/event-details-popup.component';
import { ActivatedRoute, Router } from '@angular/router';
import {
  BackendCommunicationService,
  LoadingDialogService,
  NotificationService,
} from '@us/utils';
import { FullCalendarComponent } from '@fullcalendar/angular';
import { AgendaOperatoriService } from '../agenda-operatori.service';
import { CalendarEventsParser } from './lib/calendar-events-parser';

@Component({
  selector: 'app-calendar',
  templateUrl: './calendar.component.html',
  styleUrls: ['./calendar.component.scss'],
})
export class CalendarComponent implements OnInit, AfterViewInit {
  @ViewChild('calendar') calendarComponent?: FullCalendarComponent;
  calendarApi?: Calendar;
  calendarInfo: any;
  modalRef?: NgbModalRef;
  legendaModalRef?: NgbModalRef;
  nuovaAttivitaModalRef?: NgbModalRef;
  userId: any;
  statoEventi: any;

  @Output() eventClicked = new EventEmitter<EventClickArg>();

  calendarOptions: CalendarOptions = {
    plugins: [dayGridPlugin, listPlugin, timeGridPlugin, interactionPlugin],
    initialView: 'timeGridWeek',
    locale: itLocale,
    firstDay: 1, //lunedì
    /* businessHours: { //commentato per rimuovere il focus sull'orario di lavoro
      startTime: '08:00',
      endTime: '18:00',
    }, */
    nowIndicator: true,
    //eventConstraint: "businessHours", //commentato per poter permettere lo spostamento degli eventi in qualsiasi orario
    themeSystem: 'bootstrap5',
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth',
    },
    eventClick: (info) => this.showEventInfo(info.event),
    eventDrop: (info) => this.updateEvent(info.event),
    eventResize: (info) => this.updateEvent(info.event),
  };

  constructor(
    public viewContainer: ViewContainerRef,
    public modalService: NgbModal,
    private calendarService: CalendarService,
    private route: ActivatedRoute,
    private router: Router,
    private loadingService: LoadingDialogService,
    private client: BackendCommunicationService,
    private notification: NotificationService,
    private agendaService: AgendaOperatoriService
  ) {
    this.calendarService.calendarComponent = this;
    console.log('--- constructed: ', this);
  }

  ngOnInit(): void {
    this._init();
  }

  ngAfterViewInit(): void {
    this.route.queryParams.subscribe((params) => {
      this.userId = params['id'];
      //se non viene passato un id utente, allora prende l'id dell'utente connesso
      if (!this.userId) {
        this.client.getDati('get_user_info').subscribe((res) => {
          if (!res.esito) {
            this.notification.push({
              content: 'Errore! Utente non trovato.',
            });
            this.router.navigate(['portali', 'agenda-operatori', 'lista-attivita']);
            return;
          }
          this.userId = res.info.user_info.id_utente;
          this._initCalendar();
        });
      } else {
        this._initCalendar();
      }
    });
  }

  _init() {
    this.calendarService.getStatoEventi().subscribe((res) => {
      if (res.esito) {
        this.statoEventi = res.info;
      }
    });
  }

  _initCalendar() {
    this.loadingService.openDialog('Caricamento in corso...');
    this.calendarApi = this.calendarComponent?.getApi() as Calendar;
    this.calendarApi.removeAllEvents();
    this.calendarService.getCalendario(this.userId).subscribe((res) => {
      if (!res.info) {
        this.notification.push({
          notificationClass: 'error',
          content: 'Errore! Calendario non trovato.',
        });
        this.router.navigate(['portali', 'agenda-operatori', 'lista-attivita']);
        return;
      }
      this.calendarInfo = res.info;
      this.loadingService.hideSpinner();
      this.loadingService.setMessage('Caricamento completato!');
      //ritarda di poco l'inserimento degli eventi per permettere di mostrare il messaggio di avvenuto caricamento
      setTimeout(() => {
        this.calendarInfo.calendario.eventi.forEach((ev: EventInput) =>
          this.calendarApi!.addEvent(ev)
        );
        this.loadingService.closeDialog();
        console.log('--- events added');
      });
    });
    //configura le businessHours del calendario
    this.agendaService.getAgConf().subscribe((res) => {
      if (res.esito) {
        let conf = res.info.dati;
        let startHours = conf.find((x: any) => x.cod == 'cal_start_ora').value;
        let startMinutes = conf.find((x: any) => x.cod == 'cal_start_minuti').value;
        let endHours = conf.find((x: any) => x.cod == 'cal_end_ora').value;
        let endMinutes = conf.find((x: any) => x.cod == 'cal_end_minuti').value;
        //commentato in attesa di approvazione
        /* this.calendarApi?.setOption('businessHours', {
          startTime: `${startHours.padStart(2, '0')}:${startMinutes.padEnd(2, '0')}`,
          endTime: `${endHours.padStart(2, '0')}:${endMinutes.padEnd(2, '0')}`,
        }); */
      }
    });
  }

  openModal(template: any, options?: NgbModalOptions) {
    return this.modalService.open(template, options);
  }

  showEventInfo(eventInfo: EventApi) {
    this.modalRef = this.modalService.open(EventDetailsPopupComponent, {
      centered: true,
      modalDialogClass: 'calendar-popup',
      backdropClass: 'opacity-0',
      animation: false,
    });
    const popup = this.modalRef.componentInstance as EventDetailsPopupComponent;
    popup.event = eventInfo;
    if (eventInfo.backgroundColor !== 'null')
      popup.element.style.setProperty(
        '--cal-pop-accent-color',
        eventInfo.backgroundColor
      );
    popup.closeEvent.subscribe(() => {
      this.modalRef?.close();
    });
    popup.writeEvent.subscribe((info) => {
      this.updateEvent(info);
      this.modalRef?.close();
    });
    popup.deleteEvent.subscribe((info) => {
      this.deleteEvent(info);
      this.modalRef?.close();
    });
  }

  updateEvent(eventInfo: EventApi) {
    this.loadingService.openDialog('Aggiornamento in corso...');
    this.invalidateListaAttivita();
    this.calendarService.updateEvento(eventInfo).subscribe((res) => {
      this.loadingService.closeDialog();
      if (!res.info) {
        this.notification.push({
          notificationClass: 'error',
          content: 'Errore! Evento non aggiornato.',
        });
      } else {
        //aggiorna l'evento nel calendario
        this.calendarApi?.getEventById(eventInfo.id)?.remove();
        this.calendarApi?.addEvent(CalendarEventsParser.parse(res.info)[0]);
      }
    });
  }

  deleteEvent(eventInfo: EventApi) {
    this.loadingService.openDialog('Aggiornamento in corso...');
    this.invalidateListaAttivita();
    this.agendaService.updEvElimina([eventInfo.id]).subscribe((res) => {
      this.loadingService.closeDialog();
      if (!res.esito) {
        this.notification.push({
          notificationClass: 'error',
          content: 'Errore! Evento non eliminato.',
        });
      } else {
        this.notification.push({
          notificationClass: 'info',
          content: 'Evento eliminato correttamente.',
        });
        if (this.calendarApi) {
          let event = this.calendarApi.getEventById(eventInfo.id);
          event?.remove();
        }
      }
    });
  }

  //invalida la cache di ListaAttivita in modo che possa ricaricare le attività alla sua inizializzazione
  invalidateListaAttivita() {
    this.agendaService.storage.removeItem('infoAttivita');
  }
}
