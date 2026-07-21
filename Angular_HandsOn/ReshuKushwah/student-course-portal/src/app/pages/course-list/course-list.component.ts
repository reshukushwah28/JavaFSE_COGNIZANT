import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { CourseCardComponent } from '../../components/course-card/course-card.component';
import { EnrollmentService } from '../../services/enrollment.service';
import { Course } from '../../models/course.model';
import { switchMap, catchError } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { Store } from '@ngrx/store';
import { selectCourses, selectCoursesLoading, selectCoursesError } from '../../store/selectors/course.selectors';
import { loadCourses } from '../../store/actions/course.actions';

@Component({
  selector: 'app-course-list',
  standalone: true,
  imports: [CommonModule, CourseCardComponent],
  templateUrl: './course-list.component.html',
  styleUrl: './course-list.component.css'
})
export class CourseListComponent implements OnInit {
  courses$: Observable<Course[]>;
  isLoading$: Observable<boolean>;
  error$: Observable<string | null>;
  selectedCourseId: number | null = null;

  constructor(
    private route: ActivatedRoute, 
    private router: Router,
    private enrollmentService: EnrollmentService,
    private store: Store
  ) {
    this.courses$ = this.store.select(selectCourses);
    this.isLoading$ = this.store.select(selectCoursesLoading);
    this.error$ = this.store.select(selectCoursesError);
  }

  ngOnInit(): void {
    const searchParam = this.route.snapshot.queryParamMap.get('search');
    if (searchParam) {
      console.log('Search parameter found:', searchParam);
    }
    this.store.dispatch(loadCourses());
  }

  onEnroll(courseId: number): void {
    console.log('Enrolling in course: ' + courseId);
    this.selectedCourseId = courseId;
    
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
