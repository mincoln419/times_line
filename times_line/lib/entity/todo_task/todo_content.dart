
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:times_line/entity/todo_task/task_type.dart';

part 'todo_content.freezed.dart';
part 'todo_content.g.dart';

@unfreezed
class TodoContent with _$TodoContent{

  TodoContent._();

  factory TodoContent ({
    required String title,
    int? timeline,
    required TaskType taskType,

  }) = _TodoContent;

  factory TodoContent.fromJson(Map<String, Object?> json) => _$TodoContentFromJson(json);

}


