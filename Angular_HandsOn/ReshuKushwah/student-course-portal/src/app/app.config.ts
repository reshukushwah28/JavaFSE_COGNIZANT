import { ApplicationConfig } from '@angular/core';
import { provideRouter } from '@angular/router';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { routes } from './app.routes';
import { authInterceptor } from './interceptors/auth.interceptor';
import { errorHandlerInterceptor } from './interceptors/error-handler.interceptor';
import { loadingInterceptor } from './interceptors/loading.interceptor';
import { provideStore } from '@ngrx/store';
import { provideEffects } from '@ngrx/effects';
import { provideStoreDevtools } from '@ngrx/store-devtools';
import { courseReducer } from './store/reducers/course.reducer';
import { CourseEffects } from './store/effects/course.effects';

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes),
    provideHttpClient(withInterceptors([authInterceptor, errorHandlerInterceptor, loadingInterceptor])),
    provideStore({ courses: courseReducer }),
    provideEffects([CourseEffects]),
    provideStoreDevtools({ maxAge: 25 })
  ]
};
