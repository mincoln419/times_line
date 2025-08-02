import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:times_line/data/models/template.dart';
import 'package:times_line/data/models/daily_task.dart';
import 'package:times_line/domain/entities/task_type.dart';

class DatabaseService {
  static late Isar _isar;
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      TemplateSchema,
      DailyTaskSchema,
    ], directory: dir.path);
    _initialized = true;
  }

  static Isar get instance {
    if (!_initialized) {
      throw Exception(
        'Database not initialized. Call DatabaseService.initialize() first.',
      );
    }
    return _isar;
  }

  static Future<void> close() async {
    if (_initialized) {
      await _isar.close();
      _initialized = false;
    }
  }

  // 템플릿 관련 메서드
  static Future<List<Template>> getAllTemplates() async {
    return await _isar.templates.where().findAll();
  }

  static Future<Template?> getTemplateById(String id) async {
    return await _isar.templates.filter().idEqualTo(int.parse(id)).findFirst();
  }

  static Future<void> saveTemplate(Template template) async {
    await _isar.writeTxn(() async {
      await _isar.templates.put(template);
    });
  }

  static Future<void> deleteTemplate(String id) async {
    await _isar.writeTxn(() async {
      await _isar.templates.filter().idEqualTo(int.parse(id)).deleteAll();
    });
  }

  // 일일 태스크 관련 메서드
  static Future<List<DailyTask>> getDailyTasks(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return await _isar.dailyTasks
        .filter()
        .dateBetween(startOfDay, endOfDay)
        .sortByHour()
        .findAll();
  }

  static Future<DailyTask?> getDailyTask(DateTime date, int hour) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return await _isar.dailyTasks
        .filter()
        .dateBetween(startOfDay, endOfDay)
        .and()
        .hourEqualTo(hour)
        .findFirst();
  }

  static Future<void> saveDailyTask(DailyTask task) async {
    await _isar.writeTxn(() async {
      await _isar.dailyTasks.put(task);
    });
  }

  static Future<void> updateDailyTaskCompletion(
    DateTime date,
    int hour,
    bool isCompleted,
  ) async {
    final task = await getDailyTask(date, hour);
    if (task != null) {
      task.isCompleted = isCompleted;
      task.updatedAt = DateTime.now();
      await saveDailyTask(task);
    }
  }

  static Future<void> deleteDailyTasks(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    await _isar.writeTxn(() async {
      await _isar.dailyTasks
          .filter()
          .dateBetween(startOfDay, endOfDay)
          .deleteAll();
    });
  }

  static Future<void> updateDailyTaskActualContent(
    DateTime date,
    int hour,
    String actualContent,
  ) async {
    final task = await getDailyTask(date, hour);
    if (task != null) {
      task.actualContent = actualContent;
      task.updatedAt = DateTime.now();
      await saveDailyTask(task);
    }
  }

  static Future<void> createDailyTasksFromTemplate(
    DateTime date,
    Template template,
  ) async {
    await _isar.writeTxn(() async {
      for (final templateTask in template.tasks) {
        final dailyTask = DailyTask()
          ..date = date
          ..hour = templateTask.hour
          ..content = templateTask.content
          ..taskType = templateTask.taskType
          ..isCompleted = false
          ..templateId = template.id.toString()
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now();

        await _isar.dailyTasks.put(dailyTask);
      }
    });
  }

  // 초기 데이터 생성
  static Future<void> createInitialData() async {
    final templates = await getAllTemplates();
    if (templates.isNotEmpty) return; // 이미 데이터가 있으면 생성하지 않음

    // 기본 템플릿 생성
    final defaultTemplate = Template()
      ..name = '기본 템플릿'
      ..isDefault = true
      ..tasks = [
        TemplateTask()
          ..hour = 0
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 1
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 2
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 3
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 4
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 5
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 6
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 7
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 8
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 9
          ..content = '아침 운동'
          ..taskType = TaskType.physical,
        TemplateTask()
          ..hour = 10
          ..content = '독서'
          ..taskType = TaskType.intellectual,
        TemplateTask()
          ..hour = 11
          ..content = '기도'
          ..taskType = TaskType.spiritual,
        TemplateTask()
          ..hour = 12
          ..content = '점심 식사'
          ..taskType = TaskType.physical,
        TemplateTask()
          ..hour = 13
          ..content = '친구와 통화'
          ..taskType = TaskType.social,
        TemplateTask()
          ..hour = 14
          ..content = '업무'
          ..taskType = TaskType.intellectual,
        TemplateTask()
          ..hour = 15
          ..content = '업무'
          ..taskType = TaskType.intellectual,
        TemplateTask()
          ..hour = 16
          ..content = '업무'
          ..taskType = TaskType.intellectual,
        TemplateTask()
          ..hour = 17
          ..content = '운동'
          ..taskType = TaskType.physical,
        TemplateTask()
          ..hour = 18
          ..content = '저녁 식사'
          ..taskType = TaskType.physical,
        TemplateTask()
          ..hour = 19
          ..content = '가족과 시간'
          ..taskType = TaskType.social,
        TemplateTask()
          ..hour = 20
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 21
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 22
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 23
          ..content = '잠'
          ..taskType = TaskType.sleep,
      ]
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await saveTemplate(defaultTemplate);

    // 주말 템플릿 생성
    final weekendTemplate = Template()
      ..name = '주말 템플릿'
      ..isDefault = false
      ..tasks = [
        TemplateTask()
          ..hour = 0
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 1
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 2
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 3
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 4
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 5
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 6
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 7
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 8
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 9
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 10
          ..content = '독서'
          ..taskType = TaskType.intellectual,
        TemplateTask()
          ..hour = 11
          ..content = '기도'
          ..taskType = TaskType.spiritual,
        TemplateTask()
          ..hour = 12
          ..content = '점심 식사'
          ..taskType = TaskType.physical,
        TemplateTask()
          ..hour = 13
          ..content = '가족과 시간'
          ..taskType = TaskType.social,
        TemplateTask()
          ..hour = 14
          ..content = '가족과 시간'
          ..taskType = TaskType.social,
        TemplateTask()
          ..hour = 15
          ..content = '운동'
          ..taskType = TaskType.physical,
        TemplateTask()
          ..hour = 16
          ..content = '운동'
          ..taskType = TaskType.physical,
        TemplateTask()
          ..hour = 17
          ..content = '저녁 식사'
          ..taskType = TaskType.physical,
        TemplateTask()
          ..hour = 18
          ..content = '가족과 시간'
          ..taskType = TaskType.social,
        TemplateTask()
          ..hour = 19
          ..content = '가족과 시간'
          ..taskType = TaskType.social,
        TemplateTask()
          ..hour = 20
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 21
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 22
          ..content = '잠'
          ..taskType = TaskType.sleep,
        TemplateTask()
          ..hour = 23
          ..content = '잠'
          ..taskType = TaskType.sleep,
      ]
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await saveTemplate(weekendTemplate);
  }

  // 오늘 날짜의 일일 태스크가 없으면 기본 템플릿으로 생성
  static Future<void> ensureTodayTasks() async {
    final today = DateTime.now();
    final todayTasks = await getDailyTasks(today);

    // 오늘 날짜의 태스크가 없으면 기본 템플릿으로 생성
    if (todayTasks.isEmpty) {
      final defaultTemplate = await _getDefaultTemplate();
      if (defaultTemplate != null) {
        await createDailyTasksFromTemplate(today, defaultTemplate);
      }
    }
  }

  // 기본 템플릿 가져오기
  static Future<Template?> _getDefaultTemplate() async {
    return await _isar.templates.filter().isDefaultEqualTo(true).findFirst();
  }
}
