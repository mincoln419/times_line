import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

import '../../entity/todo_task/todo_content.dart';
import '../simple_result.dart';

abstract interface class TodoRepository {
  Future<SimpleResult<QuerySnapshot<Map<String, dynamic>>, Error>> getTodoList(DateTime dateTime);
  Future<SimpleResult<QuerySnapshot<Map<String, dynamic>>, Error>> getDoneTodoList(DateTime dateTime);

  Future<SimpleResult<void, Error>> addDoneTask(TodoTask todo);
  Future<SimpleResult<List<TodoContent>, Error>> addTodoTask(List<TodoContent> todoTasks, String workDate, String uid);
  Future<SimpleResult<void, Error>> updateTodo(TodoTask todo);
  Future<SimpleResult<void, Error>> removeTodo(int id);
}
