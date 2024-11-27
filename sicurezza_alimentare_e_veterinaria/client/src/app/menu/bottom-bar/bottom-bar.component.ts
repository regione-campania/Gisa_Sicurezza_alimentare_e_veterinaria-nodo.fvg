/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component } from '@angular/core';
import { MenuItem } from '../types';
import { MenuService } from 'src/app/services/menu.service';
import { TABLET_BREAKPOINT } from 'src/app/conf';

@Component({
  selector: 'bottom-bar',
  templateUrl: './bottom-bar.component.html',
  styleUrls: ['./bottom-bar.component.scss', '../menu-buttons/menu-buttons.scss']
})
export class BottomBarComponent {

  constructor(
    private menuService: MenuService,
  ) {}

  get quickLinks(): MenuItem[] {
    return this.menuService.getMenu();
  }

  areQuickLinksVisible(): boolean {
    return window.innerWidth >= TABLET_BREAKPOINT;
  }

}
