import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CourseCardComponent } from '../../components/course-card/course-card.component';

@Component({
  selector: 'app-course-list',
  standalone: true,
  imports: [CommonModule, CourseCardComponent],
  templateUrl: './course-list.component.html',
  styleUrl: './course-list.component.css'
})
export class CourseListComponent implements OnInit {
  isLoading = true;
  courses: any[] = [];
  selectedCourseId: number | null = null;

  ngOnInit(): void {
    setTimeout(() => {
      this.courses = [
        { id: 1, name: 'Angular Basics', code: 'CS101', credits: 3, gradeStatus: 'passed' },
        { id: 2, name: 'Advanced RxJS', code: 'CS102', credits: 4, gradeStatus: 'failed' },
        { id: 3, name: 'NgRx State Management', code: 'CS103', credits: 4, gradeStatus: 'pending' },
        { id: 4, name: 'Web Components', code: 'CS104', credits: 2, gradeStatus: 'passed' },
        { id: 5, name: 'Testing in Angular', code: 'CS105', credits: 3, gradeStatus: 'pending' }
      ];
      this.isLoading = false;
    }, 1500);
  }

  onEnroll(courseId: number): void {
    console.log('Enrolling in course: ' + courseId);
    this.selectedCourseId = courseId;
  }

  // trackBy improves performance by helping Angular identify which items have changed,
  // been added, or removed, avoiding re-rendering the entire list.
  trackByCourseId(index: number, course: any): number {
    return course.id;
  }
}
