/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { LoadingDialogService, NotificationService } from '@us/utils';
import { ImportaMovimentazioniService } from '../services';

@Component({
  selector: 'app-importa-movimentazioni',
  templateUrl: './importa-movimentazioni.component.html',
  styleUrls: ['./importa-movimentazioni.component.scss']
})
export class ImportaMovimentazioniComponent implements OnInit {
  private _filename?: string;
  private _movimentazioni?: any;

  formGroup = this.fb.group({
    file: [null, Validators.required]
  });

  constructor(
    private notificationService: NotificationService,
    private loadingService: LoadingDialogService,
    private fb: FormBuilder,
    private ims: ImportaMovimentazioniService
  ) { }

  ngOnInit(): void { }

  onFileChange(evt: any): void {
    console.log("evt:", evt);
    const fReader = new FileReader();

    if (evt.target.files && evt.target.files.length > 0) {
      this._filename = evt.target.files[0].name;
      const file: File = evt.target.files[0];
      fReader.onload = (e: any) => {
        this.formGroup.patchValue({
          file: e.target.result
        });
      }

      fReader.readAsText(file);
    }
  }

  onSubmit(): void {
    console.log("this._filename:", this._filename);
    console.log("this.formGroup.get('file').value:", this.formGroup.get('file')?.value);
    this.ims.importaMovimentazioni({
      filename: this._filename,
      fileString: this.formGroup.get('file')?.value
    }).subscribe((res: any) => {
      console.log("res:", res);
    })
  }

  get filename() { return this._filename; }
  get movimentazioni() { return this._movimentazioni; }
}
