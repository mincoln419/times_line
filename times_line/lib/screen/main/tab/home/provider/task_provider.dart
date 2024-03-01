import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/data/task_dummy.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

final taskProvider = StateProvider<List<TodoTask>>(
      (ref) => taskList,
);
