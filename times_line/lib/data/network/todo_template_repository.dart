
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:times_line/entity/todo_task/todo_task_template.dart';

import '../../entity/todo_task/todo_task_template_sample.dart';
import '../simple_result.dart';

abstract interface class TodoTemplateRepository {

  Future<SimpleResult<QuerySnapshot<Map<String, dynamic>>, Error>> getTodoTemplateList(String docId);

  Future<SimpleResult<void, Error>> addTodoTemplate(TodoTaskTemplateSample template);
  Future<SimpleResult<void, Error>> updateTemplate(TodoTaskTemplateSample template);
  Future<SimpleResult<void, Error>> removeTemplate(String docId);
}