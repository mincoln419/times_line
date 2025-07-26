
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_task_template.freezed.dart';
part 'todo_task_template.g.dart';

@unfreezed
class TodoTaskTemplate with _$TodoTaskTemplate{

  TodoTaskTemplate._();

  factory TodoTaskTemplate ({
    String? docId,
    String? uid,
    required String workDate,
    DateTime? createdTime,
    DateTime? modifyTime,
    required List taskContents,

  }) = _TodoTaskTemplate;

  factory TodoTaskTemplate.fromJson(Map<String, Object?> json) => _$TodoTaskTemplateFromJson(json);

}


