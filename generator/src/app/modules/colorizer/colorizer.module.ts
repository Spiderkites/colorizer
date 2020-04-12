import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ColorizerRoutingModule } from './colorizer-routing.module';
import { ColorizerComponent } from './colorizer.component';
import { UploadComponent } from './components/upload/upload.component';

import {MatCardModule} from '@angular/material/card';


@NgModule({
  declarations: [ColorizerComponent, UploadComponent],
  imports: [
    CommonModule,
    ColorizerRoutingModule,
    MatCardModule
  ]
})
export class ColorizerModule { }
