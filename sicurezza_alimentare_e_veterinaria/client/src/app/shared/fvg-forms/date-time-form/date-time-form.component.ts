/*
Copyright (C) AGPL-3.0  

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.*/
import { Component, Input, OnChanges, Output, SimpleChanges } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, ValidatorFn, Validators } from '@angular/forms';
import { Observable } from 'rxjs';

@Component({
  selector: 'date-time-form',
  templateUrl: './date-time-form.component.html',
  styleUrls: ['./date-time-form.component.scss']
})
export class DateTimeFormComponent implements OnChanges {

  @Input() type: 'single' | 'interval' = 'single';
  @Input() required = false;

  form: FormGroup = this.fb.group({});

  constructor(
    private fb: FormBuilder
  ) {}

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['type'])
      this._initForm();
    //TODO: fixare FormGroup innestato
    /* if (changes['required']) {
      if (this.required) this._setValidators();
      else this._unsetValidators();
    } */
  }

  toString(): string {
    if (this.type == 'single') {
      return `${this.value['date']}T${this.value['time']}`;
    } else {
      return `${this.value['start']['date']}T${this.value['start']['time']}::${this.value['end']['date']}T${this.value['end']['time']}`;
    }
  }

  private _initForm() {
    if (this.type == 'single') {
      this.form = this.fb.group({
        date: this.fb.control('', this.required ? Validators.required : null),
        time: this.fb.control('', this.required ? Validators.required : null),
      })
    } else {
      this.form = this.fb.group({
        start: this.fb.group({
          date: this.fb.control('', this.required ? Validators.required : null),
          time: this.fb.control('', this.required ? Validators.required : null),
        }),
        end: this.fb.group({
          date: this.fb.control('', this.required ? Validators.required : null),
          time: this.fb.control('', this.required ? Validators.required : null),
        })
      }, {validators: dateIntervalValidator})
    }
  }

  private _setValidators() {
    //TODO: fixare FormGroup innestato
    for (let control in this.form.controls) {
      this.form.get(control)?.setValidators(Validators.required);
    }
    this.form.updateValueAndValidity();
  }

  private _unsetValidators() {
    //TODO: fixare FormGroup innestato
    for (let control in this.form.controls) {
      this.form.get(control)?.removeValidators(Validators.required);
    }
    this.form.updateValueAndValidity();
  }

  get value(): any {
    return this.form.value;
  }

  get isValid(): boolean {
    return this.form.valid;
  }

  get hasIntervalError(): boolean {
    if (!this.form.errors) return false;
    return 'intervalError' in this.form.errors;
  }
}

//validators
const dateIntervalValidator: ValidatorFn = (control: AbstractControl) => {
  const start = control.get('start');
  const end = control.get('end');
  if (!start || !end) return null;
  const startDate = start.get('date')?.value;
  const startTime = start.get('time')?.value;
  if (!startDate || !startTime) return null;
  const endDate = end.get('date')?.value;
  const endTime = end.get('time')?.value;
  if (!endDate || !endTime) return null;
  if(new Date(`${startDate}T${startTime}`) > new Date(`${endDate}T${endTime}`))
    return {intervalError: 'start greater than end'}
  return null;
}
