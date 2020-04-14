import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ColorizerRoutingModule } from './colorizer-routing.module';
import { ColorizerComponent } from './colorizer.component';
import { UploadComponent } from './components/upload/upload.component';

import {MatCardModule} from '@angular/material/card';
import {MatButtonModule} from '@angular/material/button';
import {MatDividerModule} from '@angular/material/divider';
import {MatProgressBarModule} from '@angular/material/progress-bar';
import {MatInputModule} from '@angular/material/input';
import {ClipboardModule} from '@angular/cdk/clipboard';
import { GenerateComponent } from './components/generate/generate.component';


@NgModule({
  declarations: [ColorizerComponent, UploadComponent, GenerateComponent],
  imports: [
    CommonModule,
    ColorizerRoutingModule,
    MatCardModule,
    MatButtonModule,
    MatDividerModule,
    MatProgressBarModule,
    MatInputModule,
    ClipboardModule
  ]
})
export class ColorizerModule { }
