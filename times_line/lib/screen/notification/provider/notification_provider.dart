import 'package:times_line/data/network/dangn_api.dart';
import 'package:times_line/screen/notification/vo/vo_notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteNotificationProvider = FutureProvider((ref) async {
  final result = await DangnApi.getNotification();
  return result.successData;
});

final notificationProvider = StateProvider<List<DangnNotification>?>((ref){
  final list = ref.watch(remoteNotificationProvider);
  if(list.hasValue){
    return list.requireValue;
  }
  return null;
});