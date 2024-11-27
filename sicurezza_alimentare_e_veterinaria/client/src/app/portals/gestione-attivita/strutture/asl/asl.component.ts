/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit, Output, ViewChild, EventEmitter, Input } from '@angular/core';
import { ATreeComponent, ATreeNodeComponent, TreeNode, toTree } from '@us/utils';
import { GestioneAttivitaService } from '../../gestione-attivita.service';

@Component({
  selector: 'strutture-asl',
  templateUrl: './asl.component.html',
  styleUrls: ['./asl.component.scss'],
})
export class AslComponent implements OnInit {
  @ViewChild(ATreeComponent) aslTree!: ATreeComponent;
  @Input() asl?: TreeNode;
  @Output('aslLoaded') aslLoadedEvent = new EventEmitter<void>();
  @Output('onTreeStatusChange') treeStatusChange = new EventEmitter<ATreeComponent>();
  @Output('onClick') clickEvent = new EventEmitter<ATreeNodeComponent>();

  constructor(private gs: GestioneAttivitaService) {}

  ngOnInit(): void {
    this.gs.getStrutturaAsl().subscribe((res) => {
      console.log(res);
      this.asl = toTree(res).root;
    });
  }
}
