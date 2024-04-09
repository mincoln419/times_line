import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/data/network/todo_repository.dart';
import 'package:times_line/data/simple_result.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

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
  Future<SimpleResult<void, Error>> addDoneTask(TodoTask todo) async {
    final ref = db.collection("doneTask");
    todo.modifyTime = DateTime.now();

    ref.where('id', isEqualTo: todo.id).get().then((e) {
      if (e.size == 0) {
        print("insert");
        ref.add(todo.toJson());
      } else {
        print("update ${e.docs[0].id}");
        print("${todo.toJson()}");
        ref.doc(e.docs[0].id).update(todo.toJson());
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
        isEqualTo: DateUtils.dateOnly(selectedDate ?? DateTime.now()).formattedDate )
        .orderBy('timeline')
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
      getDoneTodoList() async {
    final ref = db.collection("doneTask");
    final result = await ref
        .where('workDate',
            isEqualTo: DateUtils.dateOnly(DateTime.now()).formattedDate)
        .orderBy('timeline')
        .get();

    print("doneTask: ${result.docs.length}");
    return SimpleResult.success(result);
  }

  void save(TodoTask todoTask) {}

  @override
  Future<SimpleResult<void, Error>> addTodoTask(TodoTask todo) {
    // TODO: implement addTodoTask
    throw UnimplementedError();
  }
}
