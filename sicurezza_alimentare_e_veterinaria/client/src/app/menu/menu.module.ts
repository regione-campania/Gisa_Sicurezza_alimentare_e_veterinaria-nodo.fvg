/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TopBarComponent } from './top-bar/top-bar.component';
import { BottomBarComponent } from './bottom-bar/bottom-bar.component';
import { MenuComponent } from './menu.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { LogoutButtonComponent } from './menu-buttons/logout-button.component';
import { BackHomeButtonComponent } from './menu-buttons/back-home-button.component';
import { BackButtonComponent } from './menu-buttons/back-button.component';
import { QuickLinkButtonComponent } from './menu-buttons/quick-link-button.component';
import { AngularSvgIconModule } from 'angular-svg-icon';
import { MenuOffcanvasComponent } from './menu-offcanvas/menu-offcanvas.component';
import { SideBarComponent } from './side-bar/side-bar.component';


/**
 * Contiene i componenti per le top/bottom/side bar.
 */
@NgModule({
  declarations: [
    MenuComponent,
    TopBarComponent,
    BottomBarComponent,
    LogoutButtonComponent,
    BackHomeButtonComponent,
    BackButtonComponent,
    QuickLinkButtonComponent,
    MenuOffcanvasComponent,
    SideBarComponent
  ],
  imports: [
    CommonModule,
    NgbModule,
    AngularSvgIconModule
  ],
  exports: [
    MenuComponent,
    TopBarComponent,
    BottomBarComponent,
    SideBarComponent
  ]
})
export class MenuModule { }
