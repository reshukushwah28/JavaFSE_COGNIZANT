import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { CourseService } from '../../services/course.service';
import { CourseSummaryWidgetComponent } from '../../components/course-summary-widget/course-summary-widget.component';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [FormsModule, CommonModule, CourseSummaryWidgetComponent],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent implements OnInit, OnDestroy {
  portalName = 'Student Course Portal';
  isPortalActive = true;
  message = '';
  searchTerm = '';

  /* 
   * Difference between [property] and [(ngModel)]:
   * [property] is one-way data binding from component to DOM.
   * [(ngModel)] is two-way data binding, synchronising DOM and component in both directions.
   */

  coursesCount = 0;

  constructor(private courseService: CourseService, private router: Router) {}

  onSearchChange(): void {
    if (this.searchTerm) {
      this.router.navigate(['/courses'], { queryParams: { search: this.searchTerm } });
    }
  }

  ngOnInit(): void {
    console.log('HomeComponent initialised — courses loaded');
    this.coursesCount = this.courseService.getCourses().length;
  }

  ngOnDestroy(): void {
    console.log('HomeComponent destroyed');
  }

  onEnrollClick(): void {
    this.message = 'Enrollment opened!';
  }
}
