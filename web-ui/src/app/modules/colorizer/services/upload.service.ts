

import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UploadService {

  private _productFilePath$ = new BehaviorSubject<string>(undefined);
  private _colorFilePath$ = new BehaviorSubject<string>(undefined);

  productFilePath$ = this._productFilePath$.asObservable();
  colorFilePath$ = this._colorFilePath$.asObservable();

  constructor() {
    this.initIpc();
  }

  private initIpc() {

  }

  upload(type: String): void {
    if (type === 'product') {
      console.log("type === product")
      this._productFilePath$.next('filePath');
    } if (type === 'color') {
      this._colorFilePath$.next("afeeffw");
    }
  }

  generate(): void {
    console.log('generate');
  }
}


