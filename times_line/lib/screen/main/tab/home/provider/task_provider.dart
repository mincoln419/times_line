import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/data/network/todo_api.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

final userProvider = FutureProvider<String>((ref) => 'abc');

final todoDataProvider =
    FutureProvider((ref) => TodoApi.instance.getTodoList().then(
          (e) => e.successData,
        ));
