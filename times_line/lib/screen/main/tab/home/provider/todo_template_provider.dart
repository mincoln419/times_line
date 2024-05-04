import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

import '../../../../../entity/todo_task/task_type.dart';

final todoTemplateProvider =
StateNotifierProvider<TodoTemplateDataHolder, List<TodoTask>>(
        (ref) => TodoTemplateDataHolder());
class TodoTemplateDataHolder extends StateNotifier<List<TodoTask>> {
  TodoTemplateDataHolder() : super([]);

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
    print("template clear");
    state.clear();
  }

  void changeWorkDate(DateTime date) {
    for (var element in state) {
      element.workDate = date.formattedDateOnly;
    }
  }
}
extension TodoTemplateDataHolderProvider on WidgetRef {
  TodoTemplateDataHolder get readTodoTemplateHolder => read(todoTemplateProvider.notifier);
}