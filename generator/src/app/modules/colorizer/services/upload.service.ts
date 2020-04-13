
const ipcRenderer = (<any>window).require('electron').ipcRenderer;

import { Injectable, NgZone } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UploadService {

  private _productFilePath$ = new BehaviorSubject<string>(undefined);
  private _colorFilePath$ = new BehaviorSubject<string>(undefined);

  productFilePath$ = this._productFilePath$.asObservable();
  colorFilePath$ = this._colorFilePath$.asObservable();

  constructor(private zone: NgZone) {
    this.initIpc();
  }

  private initIpc() {
    ipcRenderer.on('file-uploaded', (event, type, filePath) => {
      console.log('file-uploaded', event, type, filePath);


      if (type === 'product') {
        console.log("type === product")
        this._productFilePath$.next(filePath);
      } if (type === 'color') {
        this._colorFilePath$.next(filePath);
      }

      this.zone.run(() => {
        console.log('enabled time travel');
      });

    });
  }

  upload(type: String): void {
    ipcRenderer.send('file-upload', type);
    console.log(type);
  }
}


