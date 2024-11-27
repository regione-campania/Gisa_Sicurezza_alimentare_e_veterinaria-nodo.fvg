/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Input } from '@angular/core';
import { MenuItem } from '../types';
import { Router } from '@angular/router';
import { MenuService } from 'src/app/services/menu.service';

@Component({
  selector: 'quick-link-button',
  styleUrls: ['./menu-buttons.scss'],
  template: `
    <button [ngbTooltip]="config?.label" type="button" class="quick-link-button" (click)="executeAction()">
      <div class="icon-box">
        <span
          *ngIf="config?.icon?.includes('png-icon')"
          class="png-icon quick-menu-icon"
          [ngClass]="config?.icon"
        ></span>
        <i
          *ngIf="config?.icon?.includes('fa-')"
          class="icon quick-menu-icon"
          [ngClass]="config?.icon"
        ></i>
        <svg-icon
          *ngIf="config?.icon?.includes('svg-icon')"
          [src]="
            'assets/icons/' +
            config?.icon?.substring((config?.icon || '').indexOf(' ') + 1) +
            '.svg'
          "
          [svgClass]="'quick-menu-icon ' + config?.icon"
        ></svg-icon>
      </div>
    </button>
  `,
})
export class QuickLinkButtonComponent {
  @Input() config?: MenuItem;

  constructor(private router: Router, private menu: MenuService) { }

  executeAction() {
    if (this.config?.link) {
      this.router.navigateByUrl(
        `${this.menu.getMenuBase() || this.router.url}/${this.config?.link}`
      );
    } else if (this.config?.action) {
      this.config.action();
    }
  }
}
