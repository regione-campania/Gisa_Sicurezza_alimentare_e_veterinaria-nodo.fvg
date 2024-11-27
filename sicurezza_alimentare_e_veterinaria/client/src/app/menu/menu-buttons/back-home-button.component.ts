/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Input } from '@angular/core';
import { PromptService } from 'src/app/services/prompt.service';

@Component({
  selector: 'back-home-button',
  styleUrls: ['./menu-buttons.scss'],
  template: `
    <button
      type="button"
      [ngClass]="buttonClass"
      (click)="backHome()"
      [ngbTooltip]="showTooltip ? tooltip : null"
    >
      <div class="icon-box">
        <i class="icon quick-menu-icon fa-solid fa-house"></i>
      </div>
      <span class="button-label" *ngIf="showLabel">{{ label }}</span>
    </button>
  `,
})
export class BackHomeButtonComponent {
  @Input() label = 'Home';
  @Input() showLabel = false;
  @Input() tooltip = 'Home';
  @Input() showTooltip = true;
  @Input() buttonClass = 'nav-link-button';

  constructor(private prompt: PromptService) {}

  backHome(): void {
    this.prompt.requestGoHome();
  }
}
