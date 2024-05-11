
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/done_task_provider.dart';

import '../../../common/widget/w_tap.dart';
import '../../../data/network/todo_api.dart';

class TodoStatusWidget extends ConsumerWidget {
  final TodoTask todo;

  const TodoStatusWidget(this.todo, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tap(
      onTap: () {
        final newTodo = todo.copyWith();
        print("newTodo: $newTodo");
        ref.readDoneHolder.updateTodo(newTodo);
        TodoApi.instance.addDoneTask(newTodo);
      },
      child: SizedBox(
          width: 50,
          height: 50,
          child: switch (todo.todoTaskStatus) {
            TodoTaskStatus.matched => Checkbox(
                value: true,
                onChanged: null,
                fillColor: MaterialStateProperty.all(
                  context.appColors.checkBoxColor,
                ),
              ),
            TodoTaskStatus.unmatched => const Checkbox(
                value: false,
                onChanged: null,
              ),
            TodoTaskStatus.not_yet => const Checkbox(
              value: false,
              onChanged: null,
            ),
          }),
    );
  }
}
