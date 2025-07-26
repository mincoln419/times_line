
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

part 'todo_task_template_sample.freezed.dart';
part 'todo_task_template_sample.g.dart';

@unfreezed
class TodoTaskTemplateSample with _$TodoTaskTemplateSample{

  TodoTaskTemplateSample._();

  factory TodoTaskTemplateSample ({
    String? docId,
    String? uid,
    String? templateName,
    @JsonKey(name: 'createdTime')required final DateTime createdTime,
    DateTime? modifyTime,
    required List taskContents,
    required int orderSort,

  }) = _TodoTaskTemplateSample;

  factory TodoTaskTemplateSample.fromJson(Map<String, Object?> json) => _$TodoTaskTemplateSampleFromJson(json);

}


