import { Component, OnInit } from '@angular/core';
import { UploadService } from '../../services/upload.service';

@Component({
  selector: 'app-generate',
  templateUrl: './generate.component.html',
  styleUrls: ['./generate.component.scss']
})
export class GenerateComponent implements OnInit {

  constructor(public uploadService: UploadService) {}

  ngOnInit(): void {
  }

}
