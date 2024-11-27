/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, TemplateRef, ViewChild } from '@angular/core';
import { MenuService } from 'src/app/services/menu.service';
import { MenuItem, ToggleableMenu } from '../types';
import { NgbOffcanvas, NgbOffcanvasRef } from '@ng-bootstrap/ng-bootstrap';
import { DESKTOP_BREAKPOINT } from 'src/app/conf';

@Component({
  selector: 'top-bar',
  templateUrl: './top-bar.component.html',
  styleUrls: ['./top-bar.component.scss', '../menu-buttons/menu-buttons.scss'],
})
export class TopBarComponent implements ToggleableMenu {
  @ViewChild('offcanvasContent')
  private _offcanvasContent?: TemplateRef<any>;
  private _offcanvasRef?: NgbOffcanvasRef;

  constructor(
    private menuService: MenuService,
    private offcanvas: NgbOffcanvas
  ) {}

  get menu() {
    return this.menuService.getMenu();
  }

  get pageTitle() {
    return document.title;
  }

  get quickLinks(): MenuItem[] {
    return this.menuService.getMenu();
  }

  openMenu(): void {
    if (!this.offcanvas.hasOpenOffcanvas())
      this._offcanvasRef = this.offcanvas.open(this._offcanvasContent);
  }

  closeMenu(): void {
    this._offcanvasRef?.close();
  }

  isDesktopView(): boolean {
    return window.innerWidth  >= DESKTOP_BREAKPOINT;
  }
}
