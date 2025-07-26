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

  DateTime? createdAt;

  DateTime? updatedAt;
}
