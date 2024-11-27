/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { UsUtilsModule } from '@us/utils';
import { UsFriuliModule } from '@us/friuli';
import { FvgComponentsModule } from './fvg-components/fvg-components.module';
import { FvgFormsModule } from './fvg-forms/fvg-forms.module';



@NgModule({
  declarations: [
  ],
  imports: [
    CommonModule,
    NgbModule,
    UsUtilsModule,
    UsFriuliModule,
    FvgComponentsModule,
    FvgFormsModule
  ],
  exports: [
    FvgComponentsModule,
    FvgFormsModule
  ],
})
export class SharedModule { }
