import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/common.dart';
import 'package:flutter/material.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/done_task_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_home_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';

import '../../widget/todo_status_widget.dart';

class TimesLineItem extends ConsumerWidget {
  final VoidCallback onTap;
  final int index;

  const TimesLineItem({required this.onTap, super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoTask = ref.watch(todoHomeListProvider)[index];
    final doneTask = ref.watch(doneListProvider)[index];
    
    double screenWidth = MediaQuery.of(context).size.width;

    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: screenWidth * 0.06,
                    child: todoTask.timeline.toString().text.make(),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.36,
                  height: 40,
                  decoration: BoxDecoration(
                    color: getTaskColor(context, todoTask.taskType),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: todoTask.title.text.make(),
                ),
                emptyExpanded,
                Row(
                  children: [
                    TodoStatusWidget(
                      TodoTask(
                        docId: doneTask.docId,
                        title: todoTask.title,
                        createdTime: DateTime.now(),
                        modifyTime: DateTime.now(),
                        taskType: todoTask.taskType,
                        timeline: todoTask.timeline,
                        todoTaskStatus: doneTask.todoTaskStatus,
                        workDate: todoTask.workDate,
                        uid: ref.watch(userProvider).value!,
                      ),
                      todo: todoTask,
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        margin: const EdgeInsets.only(left: 6),
                        alignment: Alignment.center,
                        width: screenWidth * 0.41,
                        height: 40,
                        decoration: BoxDecoration(
                          color: getTaskColor(context, doneTask.taskType),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: doneTask.title.text.make(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
