import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

final userProvider = FutureProvider<String>((ref) => 'abc');

final todoDataProvider = StateNotifierProvider<TaskDataHolder, List<TodoTask>>((ref) {
  final userID = ref.watch(userProvider);
  debugPrint(userID.value!);
  return TaskDataHolder();
});

class TaskDataHolder extends StateNotifier<List<TodoTask>> {
  TaskDataHolder() : super([]);

  void changeTodoTaksStatus(TodoTask todoTask) async {
    switch(todoTask.todoTaskStatus){
      case TodoTaskStatus.not_yet:
        todoTask.todoTaskStatus = TodoTaskStatus.matched;
      case TodoTaskStatus.matched:
        todoTask.todoTaskStatus = TodoTaskStatus.unmatched;
      case TodoTaskStatus.unmatched:
        todoTask.todoTaskStatus = TodoTaskStatus.not_yet;
    }
  }


}
