import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

import '../simple_result.dart';

abstract interface class TodoRepository {
  Future<SimpleResult<QuerySnapshot<Map<String, dynamic>>, Error>> getTodoList(DateTime dateTime);
  Future<SimpleResult<QuerySnapshot<Map<String, dynamic>>, Error>> getDoneTodoList();

  Future<SimpleResult<void, Error>> addDoneTask(TodoTask todo);
  Future<SimpleResult<void, Error>> addTodoTask(TodoTask todo);
  Future<SimpleResult<void, Error>> updateTodo(TodoTask todo);
  Future<SimpleResult<void, Error>> removeTodo(int id);
}
