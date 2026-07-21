import { Component, OnInit } from '@angular/core';
import { CourseService } from '../../services/course.service';

@Component({
  selector: 'app-course-summary-widget',
  standalone: true,
  imports: [],
  template: `
    <div class="widget">
      <h4>Course Summary Widget</h4>
      <p>Total Courses via Service: {{ totalCourses }}</p>
    </div>
  `,
  styles: [`
    .widget { border: 1px dashed #666; padding: 10px; margin-top: 20px; }
  `]
})
export class CourseSummaryWidgetComponent implements OnInit {
  totalCourses = 0;

  constructor(private courseService: CourseService) {}

  ngOnInit(): void {
    this.totalCourses = this.courseService.getCourses().length;
  }
}
