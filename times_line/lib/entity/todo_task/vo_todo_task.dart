
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';


class TodoTask {
  TodoTask(
      this.id,
      this.timeline,
      this.title,
      this.description,
      this.todoTaskStatus,
      this.taskType,
      this.createdTime,
  );

  int id;
  int timeline;
  String title;
  String description;
  TodoTaskStatus todoTaskStatus;
  TaskType taskType;
  DateTime createdTime;


}


