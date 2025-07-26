import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:times_line/domain/entities/task_type.dart';

part 'todo_task.freezed.dart';
part 'todo_task.g.dart';

@freezed
class TodoTask with _$TodoTask {
  const factory TodoTask({
    int? id,
    required DateTime date, // 날짜
    required int hour, // 시간 (0-23)
    required String title, // 제목
    required TaskType taskType, // 태스크 타입
    @Default(false) bool isCompleted, // 완료 여부
    String? alternativeActivity, // 대체 활동 (완료하지 않았을 때)
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TodoTask;

  factory TodoTask.fromJson(Map<String, dynamic> json) =>
      _$TodoTaskFromJson(json);
}
