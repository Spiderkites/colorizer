import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';


const routes: Routes = [
  { path: '',
  redirectTo: '/colorizer',
  pathMatch: 'full'
},
  {
    path: 'colorizer',
    loadChildren: () => import('./modules/colorizer/colorizer.module').then(m => m.ColorizerModule)
  }
];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
