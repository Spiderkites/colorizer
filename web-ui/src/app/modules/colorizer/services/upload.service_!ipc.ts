

import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UploadService {

  private _productFilePath$ = new BehaviorSubject<string>(undefined);
  private _colorFilePath$ = new BehaviorSubject<string>(undefined);
  private _template$ = new BehaviorSubject<string>('');
  private _isPending$ = new BehaviorSubject<boolean>(false);

  productFilePath$ = this._productFilePath$.asObservable();
  colorFilePath$ = this._colorFilePath$.asObservable();
  template$ = this._template$.asObservable();
  isPending$ = this._isPending$.asObservable();

  constructor() {
    this.initIpc();
  }

  private initIpc() {

  }

  upload(type: String): void {
    this._isPendingToggle();

    setTimeout(() => {

      if (type === 'product') {
        console.log("type === product")
        this._productFilePath$.next('C:\Users\lukas\OneDrive\Documents\Spiderkites\Wordpress\Anleitungen');
      } if (type === 'color') {
        this._colorFilePath$.next("afeeffw");
      }
      this._isPendingToggle();

    }, 1000);
  }

  generate(): void {
    this._isPendingToggle();

    setTimeout(() => {

      this._template$.next('template text');
      this._isPendingToggle();

    }, 1000);
  }

  private _isPendingToggle(): void {
    this._isPending$.next(!this._isPending$.value);
  }
}


