/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, ViewChild, Output, EventEmitter, Input } from '@angular/core';
import { GestioneAttivitaService } from '../../gestione-attivita.service';
import { ATreeComponent, ATreeNodeComponent, TreeNode, toTree } from '@us/utils';

@Component({
  selector: 'strutture-piani',
  templateUrl: './piani.component.html',
  styleUrls: ['./piani.component.scss'],
})
export class PianiComponent implements OnInit {
  piani?: TreeNode;

  @ViewChild(ATreeComponent) pianiTree?: ATreeComponent;
  @Input() enableCheckbox: boolean = false;
  @Output('pianiLoaded') pianiLoadedEvent = new EventEmitter<void>();
  @Output('onTreeStatusChange') treeStatusChange = new EventEmitter<ATreeComponent>()
  @Output('onClick') clickEvent = new EventEmitter<ATreeNodeComponent>();

  constructor(private gs: GestioneAttivitaService) {}

  ngOnInit(): void {
    this.gs.getStrutturaPiani().subscribe((res: any) => {
      this.piani = toTree(res).root;
    });
  }
}
