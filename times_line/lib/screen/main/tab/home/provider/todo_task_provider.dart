import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/data/network/todo_api.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_content.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

final userProvider = FutureProvider<String>((ref) => 'abc');

final selectedDateProvider =
    StateNotifierProvider<SelectDateDataHolder, DateTime>(
        (ref) => SelectDateDataHolder());

class SelectDateDataHolder extends StateNotifier<DateTime> {
  SelectDateDataHolder() : super(DateUtils.dateOnly(DateTime.now()));

  void changeDate(DateTime dateTime) {
    state = dateTime;
  }
}
extension SelectDateDataHolderProvider on WidgetRef {
  SelectDateDataHolder get readSelectDateHolder => read(selectedDateProvider.notifier);
}

final todoDataProvider = FutureProvider(
    (ref) => TodoApi.instance.getTodoList(ref.watch(selectedDateProvider)).then(
          (e) => e.successData,
        ));

final todolistProvider =
    StateNotifierProvider<TodoDataHolder, List<TodoTask>>((ref) {
  final userID = ref.watch(userProvider);
  debugPrint(userID.value!);
  return TodoDataHolder();
});

class TodoDataHolder extends StateNotifier<List<TodoTask>> {
  TodoDataHolder() : super([]);

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

  void changeWorkDate(DateTime date) {
    for (var element in state) {
      element.workDate = date.formattedDateOnly;
    }
  }
}

extension TodoListHolderProvider on WidgetRef {
  TodoDataHolder get readTodoHolder => read(todolistProvider.notifier);
}

