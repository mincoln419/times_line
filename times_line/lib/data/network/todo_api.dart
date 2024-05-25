import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/data/network/todo_repository.dart';
import 'package:times_line/data/simple_result.dart';
import 'package:times_line/entity/todo_task/todo_content.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

import '../../entity/todo_task/todo_task_template.dart';
import 'client/todo_client.dart';

class TodoApi implements TodoRepository {
  final db = FirebaseFirestore.instance;

  TodoApi._();

  static TodoApi instance = TodoApi._();

  final client = TodoClient(Dio(BaseOptions(
      baseUrl: Platform.isAndroid
          ? 'http://10.0.2.2:9000/'
          : 'http://localhost:9000/')));

  @override
  Future<SimpleResult<TodoTask, Error>> addDoneTask(TodoTask todo) async {
    final ref = db.collection("doneTask");
    todo.modifyTime = DateTime.now();

    ref.where('uid', isEqualTo: todo.uid)
    .where('workDate', isEqualTo: todo.workDate)
    .where('timeline', isEqualTo: todo.timeline)
        .get()
        .then((e) {
      if (e.size == 0) {
        ref.add(todo.toJson());
      } else {
        ref.doc(e.docs.first.id).update(todo.toJson());
      }
    });

    return SimpleResult.success(todo);
  }

  @override
  Future<SimpleResult<QuerySnapshot<Map<String, dynamic>>, Error>>
      getTodoList(DateTime? selectedDate) async {
    final ref = db.collection("todoTask");
    final result = await ref
        .where('workDate',
        isEqualTo: (selectedDate ?? DateTime.now()).formattedDateOnly)
        .get();

    return SimpleResult.success(result);
  }

  @override
  Future<SimpleResult<void, Error>> removeTodo(int id) {
    // TODO: implement removeTodo
    throw UnimplementedError();
  }

  @override
  Future<SimpleResult<void, Error>> updateTodo(TodoTask todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }

  @override
  Future<SimpleResult<QuerySnapshot<Map<String, dynamic>>, Error>>
      getDoneTodoList(DateTime? selectedDate) async {
    final ref = db.collection("doneTask");
    final result = await ref
        .where('workDate',
            isEqualTo: (selectedDate ?? DateTime.now()).formattedDateOnly)
        .orderBy('timeline')
        .get();

    return SimpleResult.success(result);
  }

  void save(TodoTask todoTask) {}

  @override
  Future<SimpleResult<List<TodoContent>, Error>> addTodoTask(List<TodoContent> todoTasks, String workDate) async {

    CollectionReference<Map<String, dynamic>> db = FirebaseFirestore.instance
        .collection("todoTask");

    final docId = await db
        .where('workDate',
        isEqualTo: workDate)
    .where('uid', isEqualTo: 'abc')
        .get()
        .then((value) => value.docs.isNotEmpty
        ? value.docs[0].id
        : null);

    if (docId == null) {
      db.add(TodoTaskTemplate(
        workDate: workDate,
        uid: 'abc',
        modifyTime: DateTime.now(),
        createdTime: DateTime.now(),
        taskContents: todoTasks
            .map((e) => e.toJson())
            .toList(),
      ).toJson());
    } else {
      db.doc(docId).update(TodoTaskTemplate(
        workDate: workDate,
        modifyTime: DateTime.now(),
        taskContents: todoTasks
            .map((e) => e.toJson())
            .toList(),
      ).toJson());
    }
    return SimpleResult.success(todoTasks);
  }
}
