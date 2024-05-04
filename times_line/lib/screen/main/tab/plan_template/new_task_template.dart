import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_task_template_sample.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_template_provider.dart';
import 'package:times_line/screen/main/tab/plan_template/write_plan_item.dart';

import '../../../../data/network/todo_template_api.dart';

class NewTaskTemplate extends ConsumerStatefulWidget {
  const NewTaskTemplate({super.key, required this.workDate});

  final String workDate;

  @override
  ConsumerState<NewTaskTemplate> createState() => _NewTaskTemplateState();
}

class _NewTaskTemplateState extends ConsumerState<NewTaskTemplate> {

  TextEditingController templateNameTec = TextEditingController();
  @override
  void initState() {

    ref.readTodoTemplateHolder.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('신규 템플릿 추가'),
            IconButton(onPressed: (){
              final uid = ref.watch(userProvider);
              
              TodoTemplateApi.instance.addTodoTemplate(
              TodoTaskTemplateSample(
                  templateName: templateNameTec.text,
                  uid: ref.read(userProvider).value,
                  taskContents: ref.watch(todoTemplateProvider).map((e)=>e.toJson()).toList(),
                  createdTime: DateTime.now(),
                modifyTime: DateTime.now(),
              ));
            }, icon: Icon(Icons.save_outlined))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Container(
                    height: 50,
                      width: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: '템플릿이름'.text.bold.size(18).make()),
                  width10,
                  Expanded(
                    child: TextField(
                      controller: templateNameTec,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: templateTodoList(),
                  builder: (context, snapshot) {
                    if (context.mounted && snapshot.hasData) {
                      final todoTaskList = ref.read(todoTemplateProvider);
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return WritePlanItem(
                              tec: TextEditingController(),
                              todoTask: todoTaskList[index],
                              onChanged: (value) {
                                ref.readTodoTemplateHolder
                                    .changeType(index, value);
                              },
                            );
                          },
                          separatorBuilder: (context, _) {
                            return const Divider();
                          },
                          itemCount: todoTaskList.length);
                    }
                    return const Center(child: CircularProgressIndicator(),);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<List<TodoTask>> templateTodoList() async {
    List<TodoTask> todoList = ref.watch(todoTemplateProvider);
    print('$todoList');
    if(todoList.length > 23) return todoList;

    return await RangeStream(0, 23).map((i) {
      final todoTask =
           TodoTask(
              workDate: widget.workDate,
              title: '',
              taskType: TaskType.nill,
              timeline: i,
            );
      ref.readTodoTemplateHolder.addTodo(todoTask);
      return todoTask;
    }).toList();
  }
}
