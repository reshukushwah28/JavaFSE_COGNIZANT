import { Injectable } from '@angular/core';

@Injectable()
export class NotificationService {
  getNotification(): string {
    return 'This is a local notification service instance!';
  }
}
