
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';

part 'vo_todo_task.freezed.dart';

@freezed
class TodoTask with _$TodoTask {
  const factory TodoTask(
      final int id,
      final int timeline,
      final String title,
      final String description,
      final TodoTaskStatus todoTaskStatus,
      final TaskType taskType,
      final DateTime createdTime,
      ) = _TodoTask;
}


