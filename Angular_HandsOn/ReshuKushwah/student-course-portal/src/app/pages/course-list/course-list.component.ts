import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { CourseCardComponent } from '../../components/course-card/course-card.component';
import { CourseService } from '../../services/course.service';
import { EnrollmentService } from '../../services/enrollment.service';
import { Course } from '../../models/course.model';
import { switchMap, catchError } from 'rxjs/operators';
import { of } from 'rxjs';

@Component({
  selector: 'app-course-list',
  standalone: true,
  imports: [CommonModule, CourseCardComponent],
  templateUrl: './course-list.component.html',
  styleUrl: './course-list.component.css'
})
export class CourseListComponent implements OnInit {
  isLoading = true;
  courses: Course[] = [];
  selectedCourseId: number | null = null;
  errorMessage = '';

  constructor(
    private courseService: CourseService, 
    private route: ActivatedRoute, 
    private router: Router,
    private enrollmentService: EnrollmentService
  ) {}

  ngOnInit(): void {
    const searchParam = this.route.snapshot.queryParamMap.get('search');
    if (searchParam) {
      console.log('Search parameter found:', searchParam);
    }

    this.courseService.getCourses().subscribe({ 
      next: courses => this.courses = courses, 
      error: err => {
        this.errorMessage = err.message;
        this.isLoading = false;
      },
      complete: () => this.isLoading = false 
    });
  }

  onEnroll(courseId: number): void {
    console.log('Enrolling in course: ' + courseId);
    this.selectedCourseId = courseId;

    // switchMap cancels the previous inner Observable when a new courseId arrives.
    // This is useful here to avoid race conditions if the user selects multiple courses quickly.
    of(courseId).pipe(
      switchMap(id => this.enrollmentService.getStudentsByCourse(id)),
      catchError(err => {
        console.error('Failed to load enrolled students');
        return of([]);
      })
    ).subscribe(students => {
      console.log('Enrolled students for course:', students);
    });
  }

  goToCourseDetails(courseId: number): void {
    this.router.navigate(['courses', courseId]);
  }

  trackByCourseId(index: number, course: any): number {
    return course.id;
  }
}
