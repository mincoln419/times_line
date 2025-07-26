import 'package:isar/isar.dart';
import 'package:times_line/domain/entities/task_type.dart';

part 'template.g.dart';

@collection
class Template {
  Id id = Isar.autoIncrement;

  late String name;

  late bool isDefault;

  @embedded
  List<TemplateTask> tasks = [];

  DateTime? createdAt;

  DateTime? updatedAt;
}

@embedded
class TemplateTask {
  late int hour;

  late String content;

  @enumerated
  late TaskType taskType;
}
