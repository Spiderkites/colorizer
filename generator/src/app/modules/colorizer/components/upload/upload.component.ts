import { Component, OnInit } from '@angular/core';

const ipc = (<any>window).require('electron').ipcRenderer; 

@Component({
  selector: 'app-upload',
  templateUrl: './upload.component.html',
  styleUrls: ['./upload.component.scss']
})
export class UploadComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
  }

  upload(){
    ipc.send('upload-file');
  }

}
