import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CourseCardComponent } from '../../components/course-card/course-card.component';

@Component({
  selector: 'app-course-list',
  standalone: true,
  imports: [CommonModule, CourseCardComponent],
  templateUrl: './course-list.component.html',
  styleUrl: './course-list.component.css'
})
export class CourseListComponent {
  courses = [
    { id: 1, name: 'Angular Basics', code: 'CS101', credits: 3 },
    { id: 2, name: 'Advanced RxJS', code: 'CS102', credits: 4 },
    { id: 3, name: 'NgRx State Management', code: 'CS103', credits: 4 },
    { id: 4, name: 'Web Components', code: 'CS104', credits: 2 },
    { id: 5, name: 'Testing in Angular', code: 'CS105', credits: 3 }
  ];

  selectedCourseId: number | null = null;

  onEnroll(courseId: number): void {
    console.log('Enrolling in course: ' + courseId);
    this.selectedCourseId = courseId;
  }
}
