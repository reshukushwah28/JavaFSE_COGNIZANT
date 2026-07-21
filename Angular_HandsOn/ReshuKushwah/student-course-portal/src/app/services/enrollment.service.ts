import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { CourseService } from './course.service';
import { Course } from '../models/course.model';

@Injectable({
  providedIn: 'root'
})
export class EnrollmentService {
  private enrolledCourseIds: number[] = [];

  constructor(private courseService: CourseService) {}

  enroll(courseId: number): void {
    if (!this.enrolledCourseIds.includes(courseId)) {
      this.enrolledCourseIds.push(courseId);
    }
  }

  unenroll(courseId: number): void {
    this.enrolledCourseIds = this.enrolledCourseIds.filter(id => id !== courseId);
  }

  isEnrolled(courseId: number): boolean {
    return this.enrolledCourseIds.includes(courseId);
  }

  getEnrolledCourses(): Course[] {
    // Placeholder logic since getCourseById now returns Observable
    return [];
  }

  getStudentsByCourse(courseId: number): Observable<any[]> {
    // Mocking an HTTP call to get students
    return of([{ id: 1, name: 'Alice' }, { id: 2, name: 'Bob' }]);
  }
}
