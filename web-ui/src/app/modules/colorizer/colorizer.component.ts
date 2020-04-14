import { Component, OnInit } from '@angular/core';
import { UploadService } from './services/upload.service';

@Component({
  selector: 'app-colorizer',
  templateUrl: './colorizer.component.html',
  styleUrls: ['./colorizer.component.scss']
})
export class ColorizerComponent implements OnInit {

  constructor(public uploadService: UploadService) { }

  ngOnInit(): void {
  }

}
