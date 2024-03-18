import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/data/task_dummy.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

final taskProvider = StateProvider<List<TodoTask>>(
      (ref) => taskList,
);

class TaskDataHolder extends StateNotifier<List<TodoTask>> {
  TaskDataHolder() : super([]);

  void changeTodoTaksStatus(TodoTask todoTask) async {
    switch(todoTask.todoTaskStatus){

      case TodoTaskStatus.not_yet:
        // TODO: Handle this case.
      case TodoTaskStatus.matched:
        // TODO: Handle this case.
      case TodoTaskStatus.unmatched:
        // TODO: Handle this case.
    }
  }


}
