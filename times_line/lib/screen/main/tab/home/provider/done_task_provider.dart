import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';

final doneListProvider = StateNotifierProvider<DoneDataHolder, List<TodoTask>>((ref) {
  final userID = ref.watch(userProvider);
  debugPrint(userID.value!);
  return DoneDataHolder();
});

class DoneDataHolder extends StateNotifier<List<TodoTask>>{
  DoneDataHolder() : super([]);

  void changeTodoStatus(TodoTask todo) async {
    state = List.of(state);
  }

  void addTodo(TodoTask todo) async {
    state.add(todo);
    state = List.of(state);
  }

  void updateTodo(TodoTask todo) async {
    state[todo.timeline!] = todo.copyWith();
    state = List.of(state);
  }

  void changeType(int index, TaskType taskType) async {
    TodoTask tmp = state[index].copyWith();
    tmp.taskType = taskType;

    if(taskType == TaskType.sleep){
      tmp.title = 'sleep';
    }
    state[index] = tmp;
    state = List.of(state);
  }

  void removeTodo(TodoTask todo) {
    state.remove(todo);
    state = List.of(state);
  }

  void clear(){
    state.clear();
  }
}

extension DoneListHolderProvider on WidgetRef {
  DoneDataHolder get readDoneHolder => read(doneListProvider.notifier);
}

final currentTaskTypeProvider =
    ChangeNotifierProvider<TaskTypeProvider>((ref) => TaskTypeProvider());

class TaskTypeProvider extends ChangeNotifier {
  TaskType _currentType = TaskType.nill;

  TaskType get currentType => _currentType;

  currentTypeOnChange(TaskType value) {
    _currentType = value;
    print(_currentType);
    return notifyListeners();
  }
}


