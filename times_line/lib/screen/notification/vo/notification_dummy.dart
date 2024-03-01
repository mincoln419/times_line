import 'package:times_line/screen/notification/vo/notification_type.dart';
import 'package:times_line/screen/notification/vo/vo_notification.dart';

final notification1 = DangnNotification(
  NotificationType.official,
  '💋2월 발렌타인 축하합니다💋',
  '#당근 #발렌타인 #축하',
  DateTime.now().subtract(const Duration(hours: 3)),
);

final notification2 = DangnNotification(
  NotificationType.local,
  '가족집수리',
  '마음에 드셨다면 다른 이웃들을 위해서 기부하세요!❤️❤️❤️❤️',
  DateTime.now().subtract(const Duration(hours: 24)),
);

final notification3 = DangnNotification(
  NotificationType.legal,
  '당근페이 전자금융거래 이용약관 개정 안내',
  '개정사항 확인',
  DateTime.now().subtract(const Duration(hours: 1)),
  isRead: true,
);

final notification4 = DangnNotification(
  NotificationType.official,
  '지금 새로워진 \'당근\'을 만나보세요 🥕🥕',
  '새로운 이름으로 찾아뵙습니다.',
  DateTime.now().subtract(const Duration(minutes: 30)),
);

final notificationList = [
  notification1,
  notification2,
  notification3,
  notification4
];
