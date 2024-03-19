import 'dart:io';

import 'package:dio/dio.dart';
import 'package:times_line/data/network/todo_repository.dart';
import 'package:times_line/data/simple_result.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

import 'client/todo_client.dart';

class TodoApi implements TodoRepository{

  final client = TodoClient(Dio(BaseOptions(
      baseUrl: Platform.isAndroid ? 'http://10.0.2.2:9000/' : 'http://localhost:9000/')));

  @override
  Future<SimpleResult<void, Error>> addTodo(TodoTask todo) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<SimpleResult<List<TodoTask>, Error>> getTodoList() {
    // TODO: implement getTodoList
    throw UnimplementedError();
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
  
}