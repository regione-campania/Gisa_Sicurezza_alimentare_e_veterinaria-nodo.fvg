/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { ChangeDetectorRef, Component } from '@angular/core';
import {
  NgbOffcanvasConfig,
  NgbTooltipConfig,
} from '@ng-bootstrap/ng-bootstrap';
import { environment, gisaSpid } from 'src/environments/environment';
import { UserService } from './services/user.service';
import { DESKTOP_BREAKPOINT } from './conf';
import  packageInfo  from '../../package.json';
import { ActivatedRoute, Router, RouterStateSnapshot } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent {

  appVersion = packageInfo.version;

  constructor(
    private userService: UserService,
    private tooltipConfig: NgbTooltipConfig,
    private offcanvasConfig: NgbOffcanvasConfig,
    private changeDetector: ChangeDetectorRef,
    private router: Router
  ) {
    //esegue la change detection al 'resize' della finestra
    //necessario per direttive come *ngIf="window.innerWidth > {valore}"
    window.addEventListener('resize', () => this.changeDetector.detectChanges());
    //aggiunge lo script gisaSpid all'app
    const script = document.createElement('script');
    script.src = gisaSpid;
    script.async = false;
    document.head.appendChild(script);
    //configura i componenti ng-bootstrap a livello globale
    this.tooltipConfig.container = 'body';
    this.offcanvasConfig.panelClass = 'app-menu-offcanvas';
  }

  isUserLogged() {
    return this.userService.isUserLogged();
  }

  isDesktopView() {
    return window.innerWidth > DESKTOP_BREAKPOINT;
  }

  shouldShowSidebar() {
    return !(this.router.url.endsWith('portali'));
  }
}
