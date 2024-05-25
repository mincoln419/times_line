import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:times_line/data/network/todo_template_repository.dart';
import 'package:times_line/data/simple_result.dart';
import 'package:times_line/entity/todo_task/todo_task_template.dart';

import '../../entity/todo_task/todo_task_template_sample.dart';

class TodoTemplateApi implements TodoTemplateRepository {
  final ref = FirebaseFirestore.instance.collection("todoTemplate");

  TodoTemplateApi._();

  static TodoTemplateApi instance = TodoTemplateApi._();

  @override
  Future<SimpleResult<TodoTaskTemplateSample, Error>> addTodoTemplate(
      TodoTaskTemplateSample template) async {
    ref.add(template.toJson());
    return SimpleResult.success(template);
  }

  @override
  Future<SimpleResult<QuerySnapshot<Map<String, dynamic>>, Error>>
      getTodoTemplateList(String uid) async {
    final result = await ref.where('uid', isEqualTo: uid).get();
    return SimpleResult.success(result);
  }

  @override
  Future<SimpleResult<void, Error>> removeTemplate(String docId) async {
    return SimpleResult.success();
  }

  Future<SimpleResult<void, Error>> removeTemplateByName(String name) async {
    final result =
        await ref.where('templateName', isEqualTo: name).get().then((value) => {
              if (value.docs.isNotEmpty)
                {
                  for (QueryDocumentSnapshot<Map<String, dynamic>> element
                      in value.docs)
                    {
                      print("remove template :: $name"),
                      ref.doc(element.id).delete(),
                    }
                }
            });

    return SimpleResult.success();
  }

  @override
  Future<SimpleResult<void, Error>> updateTemplate(
      TodoTaskTemplateSample template) async {
    return SimpleResult.success();
  }
}
