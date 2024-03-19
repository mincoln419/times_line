
import 'dart:io';


import 'package:dio/dio.dart' hide Headers;

import 'package:retrofit/http.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

part 'todo_client.g.dart';

@RestApi()
abstract class TodoClient {

  factory TodoClient(Dio dio, {String? baseUrl}) {
    return _TodoClient(dio,
        baseUrl: Platform.isAndroid ? 'http://10.0.2.2:9000/' : 'http://localhost:9000/');
  }


  @GET('/todos')
  Future<List<TodoTask>> getTodoList();

  @POST('/todos')
  Future<void> addTodo(@Body() TodoTask todo);

  @PUT('/todos/{id}')
  Future<void> updateTodo(@Path("id") int id, @Body() TodoTask todo);

  @DELETE('/todos/{id}')
  @Headers(<String, dynamic>{
    "Content-Type": "text/plain",
    "Content-Length": 0,
  })
  Future<void> removeTodo(@Path("id") int id);
}