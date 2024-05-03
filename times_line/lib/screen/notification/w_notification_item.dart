import 'package:times_line/common/common.dart';
import 'package:times_line/screen/notification/provider/notification_provider.dart';
import 'package:times_line/screen/notification/s_notification.dart';

import 'package:times_line/screen/notification/vo/vo_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationItem extends ConsumerStatefulWidget {
  final DangnNotification notification;
  final Function onTap;

  const NotificationItem(
      {super.key, required this.notification, required this.onTap});

  @override
  ConsumerState<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends ConsumerState<NotificationItem> {
  static const leftPadding = 10.0;
  static const iconWidth = 25.0;

  @override
  Widget build(BuildContext context) {
    final isEditMode = ref.watch(notificationEditModeProvider);
    return Tap(
      onTap: () {
        print(widget.notification.title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: widget.notification.isRead
            ? context.backgroundColor
            : context.appColors.unreadColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Width(leftPadding),
                Image.asset(
                  widget.notification.type.iconPath,
                  width: iconWidth,
                ),
                Expanded(
                  child: widget.notification.title.text.bold.make(),
                ),
                if (isEditMode)
                  IconButton(onPressed: () {
                    final list = ref.read(notificationProvider);
                    if(list != null){
                      list.remove(widget.notification);
                      ref.read(notificationProvider.notifier).state = List.of(list);
                    }
                  }, icon: const Icon(Icons.delete)),
              ],
            ),
            height10,
            widget.notification.description.text
                .color(context.appColors.lessImportant)
                .make()
                .pOnly(left: leftPadding + iconWidth),
            timeago
                .format(widget.notification.issueAt,
                    locale: context.locale.languageCode)
                .text
                .size(13)
                .color(context.appColors.lessImportant)
                .make()
                .pOnly(left: leftPadding + iconWidth),
          ],
        ),
      ),
    );
  }
}
