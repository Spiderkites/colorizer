import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ColorizerComponent } from './colorizer.component';

const routes: Routes = [{ path: '', component: ColorizerComponent }];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ColorizerRoutingModule { }
