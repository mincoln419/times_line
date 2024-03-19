import 'package:times_line/entity/todo_task/vo_todo_task.dart';

import '../simple_result.dart';

abstract interface class TodoRepository {
  Future<SimpleResult<List<TodoTask>, Error>> getTodoList();
  Future<SimpleResult<void, Error>> addTodo(TodoTask todo);
  Future<SimpleResult<void, Error>> updateTodo(TodoTask todo);
  Future<SimpleResult<void, Error>> removeTodo(int id);
}
