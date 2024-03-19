import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:times_line/app.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/widget/animated_arrow_up_down.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.riverpod.dart';
import 'package:times_line/screen/main/tab/home/provider/task_provider.dart';
import 'package:times_line/screen/main/tab/home/vo_write_todo.dart';
import 'package:times_line/screen/main/tab/home/w_times_line_item.dart';
import 'package:times_line/screen/notification/s_notification.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  ConsumerState<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  final scrollController = ScrollController();
  String title = "상일동";
  bool isSelected = false;
  double turns = 0.0;

  @override
  void initState() {
    scrollController.addListener(() {
      final floatingState = ref.read(floatingButtonStateProvider);

      if (scrollController.position.pixels > 100 && !floatingState.isSmall) {
        ref.read(floatingButtonStateProvider.notifier).changeButtonSize(true);
      } else if (scrollController.position.pixels < 100 &&
          floatingState.isSmall) {
        ref.read(floatingButtonStateProvider.notifier).changeButtonSize(false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskList = ref.watch(todoDataProvider);

    return Column(
      children: [
        AppBar(
          title: PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            onOpened: () {
              _changeRotation();
              setState(() {
                isSelected = true;
              });
            },
            onCanceled: () {
              _changeRotation();
              setState(() {
                isSelected = false;
              });
            },
            onSelected: (value) {
              _changeRotation();
              setState(() {
                isSelected = false;
                title = value;
              });
            },
            itemBuilder: (BuildContext context) => ["천호동", "잠실", "역삼동"]
                .map((e) => PopupMenuItem(
                      value: e,
                      child: Text(e, style: TextStyle(fontSize: 20)),
                    ))
                .toList(),
            child: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    Text(
                      title,
                    ),
                    AnimatedArrowUpDown(isSelected, turns),
                  ],
                )),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Nav.push(NotificationScreen());
              },
              icon: const Icon(Icons.notifications_none_rounded),
            )
          ],
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: FloatingDaangnButton.height),
            controller: scrollController,
            itemBuilder: (context, index) => TimesLineItem(taskList[index], taskList[index]
              , onTap: () async {
                print("tap");
                //처리한 업무 다이얼로그 호출

                WriteTodoResult? result = await GoRouter.of(context)
                    .pushNamed<WriteTodoResult>('writeTask', extra: null);
                if (result != null) {
                  //   String text = result.text;
                  //   DateTime dueDtm = result.dateTime;
                  debugPrint(result.text);
                }
              },),
            itemCount: taskList.length,
            separatorBuilder: (context, index) =>
                const Line().pSymmetric(h: 15),
          ),
        ),
      ],
    );
  }

  void _changeRotation() {
    setState(() => turns += 10.0);
  }
}
