import 'dart:math';

import 'package:times_line/data/user_dummy.dart';
import 'package:times_line/entity/post/vo_simple_product_post.dart';
import 'package:times_line/data/product_dummy.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/entity/user/vo_address.dart';

DateTime generateCreateDtm() {
  return DateTime.now().subtract(Duration(minutes: Random().nextInt(1000)));
}

final TodoTask task1 = TodoTask(
  1,
  9,
  '공부하기',
  'flutter 공부',
  TaskType.knowledge,
  generateCreateDtm(),
);
final TodoTask task2 = TodoTask(
  2,
  10,
  '공부하기',
  'flutter 공부',
  TaskType.knowledge,
  generateCreateDtm(),
);
final TodoTask task3 = TodoTask(
  3,
  11,
  '공부하기',
  'flutter 공부',
  TaskType.knowledge,
  generateCreateDtm(),
);
final TodoTask task4 = TodoTask(
  4,
  12,
  '공부하기',
  'flutter 공부',
  TaskType.knowledge,
  generateCreateDtm(),
);
final TodoTask task5 = TodoTask(
  5,
  13,
  '공부하기',
  'flutter 공부',
  TaskType.knowledge,
  generateCreateDtm(),
);



final taskList = [
  task1,
  task2,
  task3,
  task4,
];
