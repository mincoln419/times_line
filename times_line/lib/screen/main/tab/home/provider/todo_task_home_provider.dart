import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';

final selectedHomeDateProvider =
    StateNotifierProvider<SelectHomeDateDataHolder, DateTime>(
        (ref) => SelectHomeDateDataHolder());

class SelectHomeDateDataHolder extends StateNotifier<DateTime> {
  SelectHomeDateDataHolder() : super(DateUtils.dateOnly(DateTime.now()));

  void changeDate(DateTime dateTime) {
    state = dateTime;
  }
}

extension SelectHomeDateHolderProvider on WidgetRef {
  SelectHomeDateDataHolder get readSelectHomeDateHolder =>
      read(selectedHomeDateProvider.notifier);
}




final todoHomeListProvider =
    StateNotifierProvider<TodoHomeDataHolder, List<TodoTask>>((ref) {
  final userID = ref.watch(userProvider);
  debugPrint(userID.value!);
  return TodoHomeDataHolder();
});

class TodoHomeDataHolder extends StateNotifier<List<TodoTask>> {
  TodoHomeDataHolder() : super([]);

  void changeTodoStatus(TodoTask todo) async {
    state = List.of(state);
  }

  void addTodo(TodoTask todo) async {
    state.add(todo);
    state = List.of(state);
  }

  void changeType(int index, TaskType taskType) async {
    TodoTask tmp = state[index].copyWith();
    tmp.taskType = taskType;

    if (taskType == TaskType.sleep) {
      tmp.title = 'sleep';
    }
    state[index] = tmp;
    state = List.of(state);
  }

  void removeTodo(TodoTask todo) {
    state.remove(todo);
    state = List.of(state);
  }

  void clear() {
    state.clear();
  }

  void copy(List<TodoTask> lists) {
    state = lists;
  }

  void changeWorkDate(DateTime date) {
    for (var element in state) {
      element.workDate = date.formattedDateOnly;
    }
  }
}

extension TodoListHolderProvider on WidgetRef {
  TodoHomeDataHolder get readTodoHomeHolder =>
      read(todoHomeListProvider.notifier);
}
