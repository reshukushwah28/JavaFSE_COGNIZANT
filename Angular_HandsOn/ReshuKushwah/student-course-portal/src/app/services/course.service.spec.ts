import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { CourseService } from './course.service';
import { Course } from '../models/course.model';

describe('CourseService', () => {
  let service: CourseService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [CourseService]
    });
    service = TestBed.inject(CourseService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify(); // Ensure that there are no outstanding requests
  });

  it('should retrieve courses from the API via GET', () => {
    const dummyCourses: Course[] = [
      { id: 1, name: 'Angular Basics', code: 'CS101', credits: 3, gradeStatus: 'passed' },
      { id: 2, name: 'Advanced RxJS', code: 'CS102', credits: 4, gradeStatus: 'failed' }
    ];

    service.getCourses().subscribe(courses => {
      expect(courses.length).toBe(2);
      expect(courses).toEqual(dummyCourses);
    });

    const request = httpMock.expectOne('http://localhost:3000/courses');
    expect(request.request.method).toBe('GET');
    request.flush(dummyCourses);
  });
});
