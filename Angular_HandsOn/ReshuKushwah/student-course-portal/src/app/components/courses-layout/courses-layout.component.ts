import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-courses-layout',
  standalone: true,
  imports: [RouterOutlet],
  template: `
    <div class="courses-layout">
      <h2>Courses Section</h2>
      <router-outlet></router-outlet>
    </div>
  `,
  styles: ``
})
export class CoursesLayoutComponent {}
