
const ipcRenderer = (<any>window).require('electron').ipcRenderer;

import { Injectable, NgZone } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { MatSnackBar } from '@angular/material/snack-bar';

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


  constructor(private zone: NgZone, private _snackBar: MatSnackBar) {
    this.initIpc();
  }

  private initIpc() {
    ipcRenderer.on('file-uploaded', (event, type, filePath) => {

      if (type === 'product') {
        this._productFilePath$.next(filePath);
      } if (type === 'color') {
        this._colorFilePath$.next(filePath);
      }

      this.zone.run(() => {
        this._isPending$.next(false);
      });

    });

    ipcRenderer.on('filechooser-canceld', () => {
      this.zone.run(() => {
        this._isPending$.next(false);
      });

    });

    ipcRenderer.on('generate-finished', (event, colorizerHtml) => {
      this._template$.next(colorizerHtml);

      this.zone.run(() => {
        this._isPending$.next(false);
      });
    })

    ipcRenderer.on('generate-error', (event, error) => {
      this._snackBar.open(error, 'Error', { duration: 5000 });
    })
  }

  upload(type: String): void {
    this._isPending$.next(true);
    ipcRenderer.send('file-upload', type);
  }

  generate(): void {
    this._isPending$.next(true);
    ipcRenderer.send('generate', this._productFilePath$.value, this._colorFilePath$.value);
  }
}


