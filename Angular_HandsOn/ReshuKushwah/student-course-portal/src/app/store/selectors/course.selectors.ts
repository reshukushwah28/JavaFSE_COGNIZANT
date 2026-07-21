import { createFeatureSelector, createSelector } from '@ngrx/store';
import { CourseState } from '../reducers/course.reducer';

export const selectCourseState = createFeatureSelector<CourseState>('courses');

export const selectCourses = createSelector(
  selectCourseState,
  (state: CourseState) => state.courses
);

export const selectCoursesLoading = createSelector(
  selectCourseState,
  (state: CourseState) => state.loading
);

export const selectCoursesError = createSelector(
  selectCourseState,
  (state: CourseState) => state.error
);
