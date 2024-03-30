
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';

part 'vo_todo_task.freezed.dart';
part 'vo_todo_task.g.dart';

@unfreezed
class TodoTask with _$TodoTask{

  TodoTask._();

  factory TodoTask ({
    required final String id,
    required final DateTime workDate,
    @JsonKey(name: 'created_time')required final DateTime createdTime,
    DateTime? modifyTime,
    required String title,
    int? timeline,
    required TaskType taskType,
    @Default(TodoTaskStatus.not_yet) TodoTaskStatus todoTaskStatus,
  }) = _TodoTask;

  factory TodoTask.fromJson(Map<String, Object?> json) => _$TodoTaskFromJson(json);

}


