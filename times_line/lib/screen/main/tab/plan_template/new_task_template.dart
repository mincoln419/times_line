import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_task_template_sample.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_template_editor_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_template_provider.dart';
import 'package:times_line/screen/main/tab/plan_template/write_plan_item.dart';

import '../../../../app.dart';
import '../../../../data/network/todo_template_api.dart';
import '../../../../data/simple_result.dart';
import '../../../dialog/d_message.dart';
import '../home/provider/todo_task_editor_provider.dart';

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

              if(templateNameTec.text.isEmpty){
                showDialog<SimpleResult>(
                    builder: (context) {
                      if(context.mounted){
                        return MessageDialog(
                            '템플릿이름을 입력하세요',
                            buttonText: '확인'
                        );
                      }
                      return
                        const CircularProgressIndicator();
                    }, context: App.navigatorKey.currentContext ?? context);

                return ;
              }

              if(ref.watch(todoTemplateSampleListProvider).map((e) => e.templateName).toList().contains(templateNameTec.text)){
                showDialog<SimpleResult>(
                    builder: (context) {
                      if(context.mounted){
                        return MessageDialog(
                            '이미 입력한 템플릿 이름입니다.',
                            buttonText: '확인'
                        );
                      }
                      return
                        const CircularProgressIndicator();
                    }, context: App.navigatorKey.currentContext ?? context);

                return ;
              }

              final uid = ref.watch(userProvider);
              final tecList = ref.watch(tecTemplateListProvider);
              final Queue<TextEditingController> queue = Queue();
              queue.addAll(tecList);
              final template = TodoTaskTemplateSample(
                templateName: templateNameTec.text,
                uid: ref.read(userProvider).value,
                taskContents: ref.watch(todoTemplateProvider).map((e){
                  e.title = queue.removeFirst().text;
                  return e;
                }).map((e)=>e.toJson()).toList(),
                createdTime: DateTime.now(),
                modifyTime: DateTime.now(),
                orderSort: ref.watch(todoTemplateSampleListProvider).length + 1,
              );
              TodoTemplateApi.instance.addTodoTemplate(template
              );
              ref.readTemplateSampleHolder.addTodo(template);
              Navigator.of(context).pop();
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
                            List<TextEditingController> tecList = ref.watch(tecTemplateListProvider);
                            tecList[index].addListener(() {

                            });
                            return WritePlanItem(
                              tec: tecList[index],
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


    await RangeStream(0, 23).map((i) {

      return i;
    }).toList();

    List<TodoTask> todoList = ref.watch(todoTemplateProvider);
    print('$todoList');
    if(todoList.length > 23) return todoList;
    final textTecList = ref.watch(tecTemplateListProvider.notifier);
    textTecList.clear();
    return await RangeStream(0, 23).map((i) {
      final todoTask =
           TodoTask(
             createdTime: DateTime.now(),
              modifyTime: DateTime.now(),
              workDate: widget.workDate,
              title: '',
              taskType: TaskType.nill,
              timeline: i,
             uid: ref.watch(userProvider).value!,
            );
      ref.readTodoTemplateHolder.addTodo(todoTask);
      textTecList.add();
      return todoTask;
    }).toList();
  }
}
