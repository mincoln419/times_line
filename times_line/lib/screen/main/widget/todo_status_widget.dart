
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/done_task_provider.dart';

import '../../../common/widget/w_tap.dart';
import '../../../data/network/todo_api.dart';

class TodoStatusWidget extends ConsumerWidget {
  final TodoTask todo;
  final TodoTask done;

  const TodoStatusWidget(this.done, {required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tap(
      onTap: () {
        final newTodo = done.copyWith();
        if(newTodo.todoTaskStatus == TodoTaskStatus.matched){
          newTodo.todoTaskStatus =  TodoTaskStatus.not_yet;
          newTodo.taskType = TaskType.nill;
          newTodo.title= '';
        }else{
          newTodo.todoTaskStatus =  TodoTaskStatus.matched;
        }
        ref.readDoneHolder.updateTodo(newTodo);
        TodoApi.instance.addDoneTask(newTodo);
      },
      child: SizedBox(
          width: 50,
          height: 50,
          child: switch (done.todoTaskStatus) {
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
