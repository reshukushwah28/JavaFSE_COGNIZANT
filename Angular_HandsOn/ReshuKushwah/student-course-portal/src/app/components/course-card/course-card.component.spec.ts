import { ComponentFixture, TestBed } from '@angular/core/testing';
import { CourseCardComponent } from './course-card.component';
import { By } from '@angular/platform-browser';
import { EnrollmentService } from '../../services/enrollment.service';
import { of } from 'rxjs';

describe('CourseCardComponent', () => {
  let component: CourseCardComponent;
  let fixture: ComponentFixture<CourseCardComponent>;
  let mockEnrollmentService: any;

  beforeEach(async () => {
    mockEnrollmentService = {
      isEnrolled: jasmine.createSpy('isEnrolled').and.returnValue(false),
      enroll: jasmine.createSpy('enroll'),
      unenroll: jasmine.createSpy('unenroll')
    };

    await TestBed.configureTestingModule({
      imports: [CourseCardComponent],
      providers: [
        { provide: EnrollmentService, useValue: mockEnrollmentService }
      ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CourseCardComponent);
    component = fixture.componentInstance;
    
    // Provide initial @Input value
    component.course = { id: 1, name: 'Angular Basics', code: 'CS101', credits: 3, gradeStatus: 'passed' };
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should display the course name', () => {
    const titleElement = fixture.debugElement.query(By.css('h3')).nativeElement;
    expect(titleElement.textContent).toContain('Angular Basics');
  });

  it('should emit enrollRequested event when enroll button is clicked', () => {
    spyOn(component.enrollRequested, 'emit');
    
    const button = fixture.debugElement.query(By.css('button')).nativeElement;
    button.click();
    
    expect(component.enrollRequested.emit).toHaveBeenCalledWith(1);
    expect(mockEnrollmentService.enroll).toHaveBeenCalledWith(1);
  });
});
