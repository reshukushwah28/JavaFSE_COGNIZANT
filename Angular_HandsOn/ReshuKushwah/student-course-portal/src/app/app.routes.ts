import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { EnrollmentFormComponent } from './pages/enrollment-form/enrollment-form.component';

export const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'enroll', component: EnrollmentFormComponent }
];
