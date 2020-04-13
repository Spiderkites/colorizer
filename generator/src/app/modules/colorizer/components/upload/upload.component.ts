import { Component, OnInit, Input } from '@angular/core';
import { UploadService } from '../../services/upload.service';



@Component({
  selector: 'app-upload',
  templateUrl: './upload.component.html',
  styleUrls: ['./upload.component.scss']
})
export class UploadComponent implements OnInit {

  @Input()
  type: String

  constructor(public uploadService: UploadService) {}
  

  ngOnInit(): void {

  }
}
