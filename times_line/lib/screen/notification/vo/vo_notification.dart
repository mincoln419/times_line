import 'package:times_line/screen/notification/vo/notification_type.dart';

class DangnNotification {
  final NotificationType type;
  final String title;
  final String description;
  final DateTime issueAt;
  bool isRead;

  DangnNotification(
    this.type,
    this.title,
    this.description,
    this.issueAt, {
    this.isRead = false,
  });
}


