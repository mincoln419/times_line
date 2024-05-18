import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/entity/todo_task/todo_task_template_sample.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';

import '../../../../../entity/todo_task/task_type.dart';

final todoTemplateSampleListProvider =
StateNotifierProvider<TodoTemplateSampleHolder, List<TodoTaskTemplateSample>>((ref) => TodoTemplateSampleHolder());

class TodoTemplateSampleHolder extends StateNotifier<List<TodoTaskTemplateSample>> {
  TodoTemplateSampleHolder() : super([]);

  void addTodo(TodoTaskTemplateSample todo) async {
    state.add(todo);
    state = List.of(state);
  }

  void clear() async{
    state.clear();
  }
}

extension TodoTemplateSampleHolderProvider on WidgetRef {
  TodoTemplateSampleHolder get readTemplateSampleHolder =>
      read(todoTemplateSampleListProvider.notifier);
}


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

  void changeType(int index, TaskType taskType, List<TextEditingController> tecList) async {
    TodoTask tmp = state[index].copyWith();
    tmp.taskType = taskType;
    if (taskType == TaskType.sleep) {
      tmp.title = 'sleep';
    }else{
      tmp.title = '';
    }

    for(int i = 0 ; i < tecList.length; i++){
      state[i].title = tecList[i].text;
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
  TodoTemplateDataHolder get readTodoTemplateHolder =>
      read(todoTemplateProvider.notifier);
}
