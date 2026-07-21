import { Component, OnInit } from '@angular/core';
import { NotificationService } from '../../services/notification.service';

@Component({
  selector: 'app-notification',
  standalone: true,
  imports: [],
  template: `<div class="notification">{{ message }}</div>`,
  styles: [`.notification { padding: 10px; background-color: #ffeeba; border: 1px solid #ffeeba; border-radius: 4px; margin-top: 15px; }`],
  providers: [NotificationService] 
  /* 
   * Component-level providers create a new instance of the service specifically for this component 
   * and its children. This is useful for component-scoped state, meaning multiple instances of 
   * NotificationComponent would each have their own independent NotificationService instance.
   */
})
export class NotificationComponent implements OnInit {
  message = '';
  constructor(private notificationService: NotificationService) {}
  
  ngOnInit() {
    this.message = this.notificationService.getNotification();
  }
}
