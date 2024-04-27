
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_content.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';

part 'todo_task_template.freezed.dart';
part 'todo_task_template.g.dart';

@unfreezed
class TodoTaskTemplate with _$TodoTaskTemplate{

  TodoTaskTemplate._();

  factory TodoTaskTemplate ({
    String? docId,
    String? uid,
    required String workDate,
    @JsonKey(name: 'createdTime')required final DateTime createdTime,
    DateTime? modifyTime,
    required List taskContents,

  }) = _TodoTaskTemplate;

  factory TodoTaskTemplate.fromJson(Map<String, Object?> json) => _$TodoTaskTemplateFromJson(json);

}


