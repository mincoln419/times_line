import 'dart:math';

import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

DateTime generateCreateDtm() {
  return DateTime.now().subtract(Duration(minutes: Random().nextInt(1000)));
}

final TodoTask task1 = TodoTask(
  1,
  4,
  '잠자기',
  '잠자기',
  TaskType.sleep,
  generateCreateDtm(),
);
final TodoTask task2 = TodoTask(
  2,
  5,
  '잠자기',
  '잠자기',
  TaskType.sleep,
  generateCreateDtm(),
);
final TodoTask task3 = TodoTask(
  3,
  6,
  '명상하기',
  'Daily Calm',
  TaskType.soul,
  generateCreateDtm(),
);
final TodoTask task4 = TodoTask(
  4,
  7,
  '운동하기',
  '헬스장-가슴,등 파트',
  TaskType.physical,
  generateCreateDtm(),
);
final TodoTask task5 = TodoTask(
  5,
  8,
  '타임트래킹',
  '타임트래킹, 자기계발도서 독서',
  TaskType.soul,
  generateCreateDtm(),
);

final TodoTask task6 = TodoTask(
  6,
  9,
  '공부하기',
  'Spring Security 공부',
  TaskType.knowledge,
  generateCreateDtm(),
);

final TodoTask task7 = TodoTask(
  7,
  10,
  '업무모니터링',
  '업무모니터링',
  TaskType.social,
  generateCreateDtm(),
);

final TodoTask task8 = TodoTask(
  8,
  11,
  '업무개발',
  '업무개발',
  TaskType.social,
  generateCreateDtm(),
);

final TodoTask task9 = TodoTask(
  9,
  12,
  '점심식사',
  '김치찌개, 제육볶음',
  TaskType.etc,
  generateCreateDtm(),
);

final TodoTask task10 = TodoTask(
  10,
  13,
  '업무개발',
  '업무개발',
  TaskType.social,
  generateCreateDtm(),
);

final TodoTask task11 = TodoTask(
  11,
  14,
  '업무개발',
  '업무개발',
  TaskType.social,
  generateCreateDtm(),
);

final TodoTask task12 = TodoTask(
  12,
  15,
  '업무개발',
  '업무개발',
  TaskType.social,
  generateCreateDtm(),
);

final TodoTask task13 = TodoTask(
  13,
  16,
  '업무개발',
  '업무개발',
  TaskType.social,
  generateCreateDtm(),
);

final TodoTask task14 = TodoTask(
  14,
  17,
  '주간보고',
  '주간보고',
  TaskType.social,
  generateCreateDtm(),
);

final TodoTask task15 = TodoTask(
  15,
  18,
  '공부하기',
  'flutter 공부',
  TaskType.knowledge,
  generateCreateDtm(),
);

final TodoTask task16 = TodoTask(
  16,
  19,
  '독서',
  '피터드러커 자기개발론',
  TaskType.knowledge,
  generateCreateDtm(),
);

final TodoTask task17 = TodoTask(
  17,
  20,
  '야채 식단 식사',
  '야채 식단 식사',
  TaskType.physical,
  generateCreateDtm(),
);

final TodoTask task18 = TodoTask(
  18,
  21,
  '아들과 몸놀이',
  '아들과 몸놀이',
  TaskType.etc,
  generateCreateDtm(),
);

final TodoTask task19 = TodoTask(
  19,
  22,
  '독서하기',
  'IT 도서',
  TaskType.knowledge,
  generateCreateDtm(),
);

final TodoTask task20 = TodoTask(
  20,
  23,
  '잠자기',
  '잠자기',
  TaskType.sleep,
  generateCreateDtm(),
);

final TodoTask task21 = TodoTask(
  21,
  0,
  '잠자기',
  '잠자기',
  TaskType.sleep,
  generateCreateDtm(),
);

final TodoTask task22 = TodoTask(
  22,
  1,
  '잠자기',
  '잠자기',
  TaskType.sleep,
  generateCreateDtm(),
);

final TodoTask task23 = TodoTask(
  23,
  2,
  '잠자기',
  '잠자기',
  TaskType.sleep,
  generateCreateDtm(),
);

final TodoTask task24 = TodoTask(
  24,
  3,
  '잠자기',
  '잠자기',
  TaskType.sleep,
  generateCreateDtm(),
);

final taskList = [
  task1,
  task2,
  task3,
  task4,
  task5,
  task6,
  task7,
  task8,
  task9,
  task10,
  task11,
  task12,
  task13,
  task14,
  task15,
  task16,
  task17,
  task18,
  task19,
  task20,
  task21,
  task22,
  task23,
  task24,
];
