import { Component, Input, Output, EventEmitter, OnChanges, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HighlightDirective } from '../../directives/highlight.directive';
import { CreditLabelPipe } from '../../pipes/credit-label.pipe';
import { EnrollmentService } from '../../services/enrollment.service';

@Component({
  selector: 'app-course-card',
  standalone: true,
  imports: [CommonModule, HighlightDirective, CreditLabelPipe],
  templateUrl: './course-card.component.html',
  styleUrl: './course-card.component.css'
})
export class CourseCardComponent implements OnChanges {
  @Input() course!: { id: number, name: string, code: string, credits: number, gradeStatus: 'passed'|'failed'|'pending' };
  @Output() enrollRequested = new EventEmitter<number>();
  
  isExpanded = false;

  constructor(private enrollmentService: EnrollmentService) {}

  get isEnrolled() {
    return this.enrollmentService.isEnrolled(this.course.id);
  }

  onEnrollClick() {
    this.enrollRequested.emit(this.course.id);
    if (this.isEnrolled) {
      this.enrollmentService.unenroll(this.course.id);
    } else {
      this.enrollmentService.enroll(this.course.id);
    }
  }

  // Getters keep templates clean by moving complex logic into the component class
  get cardClasses() {
    return {
      'card--enrolled': this.isEnrolled,
      'card--full': this.course.credits >= 4,
      'expanded': this.isExpanded
    };
  }

  ngOnChanges(changes: SimpleChanges): void {
    console.log('Previous course value:', changes['course']?.previousValue);
    console.log('Current course value:', changes['course']?.currentValue);
  }
}
