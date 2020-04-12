import { Component, OnInit } from '@angular/core';

const ipc = (<any>window).require('electron').ipcRenderer; 

@Component({
  selector: 'app-upload',
  templateUrl: './upload.component.html',
  styleUrls: ['./upload.component.scss']
})
export class UploadComponent implements OnInit {

  abc= false;

  constructor() {}
  

  ngOnInit(): void {
     ipc.on('svg-file', (event, svg)=>{
        this.abc = true;

        console.log(svg);
     } );
  }


  upload(){
    ipc.send('upload-file');
  }

}
