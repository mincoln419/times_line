
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';

part 'vo_todo_task.freezed.dart';
part 'vo_todo_task.g.dart';

@unfreezed
class TodoTask with _$TodoTask{

  TodoTask._();

  factory TodoTask ({
    String? docId,
    required String workDate,
    @JsonKey(name: 'created_time')
    DateTime? createdTime,
    DateTime? modifyTime,
    required String title,
    int? timeline,
    required TaskType taskType,
    @Default(TodoTaskStatus.not_yet) TodoTaskStatus todoTaskStatus,
  }) = _TodoTask;

  factory TodoTask.fromJson(Map<String, Object?> json) => _$TodoTaskFromJson(json);

}


