// Notification model
class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  // final NotificationType type;
  final bool isRead;
  final String? imageUrl;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    // required this.type,
    this.isRead = false,
    this.imageUrl,
  });
}

// enum NotificationType {
//   general,
//   success,
//   warning,
//   error,
//   info,
// }
List<NotificationItem> notifications = [
  NotificationItem(
    id: '1',
    title: 'Welcome to the App!',
    message:
        'Thanks for joining us. Explore all the amazing features we have to offer.',
    time: '2 min ago',
    // type: NotificationType.success,
    isRead: false,
  ),
  NotificationItem(
    id: '2',
    title: 'Profile Update Required',
    message:
        'Please update your profile information to get the best experience.',
    time: '1 hour ago',
    // type: NotificationType.warning,
    isRead: false,
  ),
  NotificationItem(
    id: '3',
    title: 'New Feature Available',
    message:
        'Check out our latest feature that will help you stay more organized.',
    time: '3 hours ago',
    // type: NotificationType.info,
    isRead: true,
  ),
  NotificationItem(
    id: '4',
    title: 'Payment Successful',
    message: 'Your subscription has been renewed successfully. Thank you!',
    time: '1 day ago',
    // type: NotificationType.success,
    isRead: true,
  ),
  NotificationItem(
    id: '5',
    title: 'Server Maintenance',
    message:
        'We\'ll be performing maintenance tonight from 2-4 AM. Some features may be unavailable.',
    time: '2 days ago',
    // type: NotificationType.warning,
    isRead: true, 
  ),
  NotificationItem(
    id: '6',
    title: 'Security Alert',
    message:
        'New login detected from an unrecognized device. Please verify if this was you.',
    time: '3 days ago',
    // type: NotificationType.error,
    isRead: true,
  ),
];
