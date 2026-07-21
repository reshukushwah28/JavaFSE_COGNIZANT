import { HttpInterceptorFn, HttpErrorResponse } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

export const errorHandlerInterceptor: HttpInterceptorFn = (req, next) => {
  return next(req).pipe(
    catchError((error: HttpErrorResponse) => {
      if (error.status === 401) {
        console.error('Unauthorized request - 401');
        // Handle redirect to login
      } else if (error.status === 500) {
        console.error('Server error - 500');
        // Show generic error notification
      }
      return throwError(() => error);
    })
  );
};
