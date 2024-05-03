import 'package:times_line/common/common.dart';
import 'package:times_line/screen/notification/f_notification_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notificationEditModeProvider = StateProvider((ref) => false);

class NotificationScreen extends HookConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    final isEditMode = ref.watch(notificationEditModeProvider);

    return Material(
      child: Column(
        children: [
          AppBar(
            title: '알림'.text.make(),
            actions: [
              Tap(
                onTap: () {
                  ref.read(notificationEditModeProvider.notifier).state =
                      !isEditMode;
                },
                child: (isEditMode ? '완료' : '편집').text.make().p(10),
              ),
            ],
          ),
          TabBar(
            onTap: (value) {},
            controller: tabController,
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            indicatorColor: Colors.white,
            labelPadding: const EdgeInsets.symmetric(vertical: 20),
            tabs: [
              '활동 알림'.text.make(),
              '키워드 알림'.text.make(),
            ],
          ),
          Expanded(child: TabBarView(
            controller: tabController,
            children: [const NotificationFragment(),

              Container(
                color: AppColors.green,
              )
            ],
          ))
        ],
      ),
    );
  }
}
