import 'package:isar/isar.dart';
import 'package:times_line/domain/entities/task_type.dart';

part 'daily_task.g.dart';

@collection
class DailyTask {
  Id id = Isar.autoIncrement;

  late DateTime date;

  late int hour;

  late String content;

  @enumerated
  late TaskType taskType;

  late bool isCompleted;

  String? templateId;

  // 예정된 일 (템플릿에서 가져온 내용)
  String? plannedContent;

  // 실제 한 일
  String? actualContent;

  // 예정된 일의 TaskType (기본값으로 waste 사용)
  @enumerated
  TaskType plannedTaskType = TaskType.waste;

  DateTime? createdAt;

  DateTime? updatedAt;
}
