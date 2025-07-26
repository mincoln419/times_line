import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:times_line/data/models/todo_task.dart';

part 'task_template.freezed.dart';
part 'task_template.g.dart';

@freezed
class TaskTemplate with _$TaskTemplate {
  const factory TaskTemplate({
    int? id,
    required String name, // 템플릿 이름
    required List<TodoTask> tasks, // 24시간 태스크 목록
    @Default(false) bool isDefault, // 기본 템플릿 여부
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TaskTemplate;

  factory TaskTemplate.fromJson(Map<String, dynamic> json) =>
      _$TaskTemplateFromJson(json);
}
