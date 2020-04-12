import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ColorizerRoutingModule } from './colorizer-routing.module';
import { ColorizerComponent } from './colorizer.component';


@NgModule({
  declarations: [ColorizerComponent],
  imports: [
    CommonModule,
    ColorizerRoutingModule
  ]
})
export class ColorizerModule { }
