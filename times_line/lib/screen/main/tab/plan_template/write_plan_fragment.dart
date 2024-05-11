import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/entity/todo_task/todo_content.dart';
import 'package:times_line/entity/todo_task/todo_task_template.dart';
import 'package:times_line/entity/todo_task/todo_task_template_sample.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.riverpod.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';
import 'package:times_line/screen/main/tab/plan_template/template_type.dart';
import 'package:times_line/screen/main/tab/plan_template/write_plan_item.dart';
import 'package:uuid/uuid.dart';

import '../../../../app.dart';
import '../../../../common/widget/animated_arrow_up_down.dart';
import '../../../../data/network/todo_api.dart';
import '../../../../data/network/todo_template_api.dart';
import '../../../../data/simple_result.dart';
import '../../../../entity/todo_task/task_type.dart';
import '../../../../entity/todo_task/vo_todo_task.dart';
import '../../../dialog/d_message.dart';
import '../../fab/w_floating_daangn_button.dart';
import '../../w_menu_drawer.dart';
import '../home/provider/todo_task_editor_provider.dart';
import '../home/provider/todo_template_editor_provider.dart';
import '../home/provider/todo_template_provider.dart';
import 'new_task_template.dart';

class WritePlanFragment extends ConsumerStatefulWidget {
  final String? selectedData;

  const WritePlanFragment({super.key, this.selectedData});

  @override
  ConsumerState<WritePlanFragment> createState() => _LocalLifeFragmentState();
}

class _LocalLifeFragmentState extends ConsumerState<WritePlanFragment>
    with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();

  double turns = 0.0;
  bool isSelected = false;
  TodoTaskTemplateSample? nowTemplate;

  @override
  void initState() {
    scrollController.addListener(() {
      final floatingState = ref.read(floatingButtonStateProvider);

      if (scrollController.position.pixels > 100 && !floatingState.isSmall) {
        ref.read(floatingButtonStateProvider.notifier).changeButtonSize(true);
      } else if (scrollController.position.pixels < 100 &&
          floatingState.isSmall) {
        ref.read(floatingButtonStateProvider.notifier).changeButtonSize(false);
      }
    });



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider).formattedDateOnly;

    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                selectedDate.text.size(15).make(),
                IconButton(
                  onPressed: () {
                    _selectDate();
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: _futureTemplateList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final templateListNew = snapshot.data;
                      return PopupMenuButton<TodoTaskTemplateSample>(
                        position: PopupMenuPosition.under,
                        onOpened: () {
                          _changeRotation();
                          setState(() {
                            isSelected = true;
                          });
                        },
                        onCanceled: () {
                          _changeRotation();
                          setState(() {
                            isSelected = false;
                          });
                        },
                        onSelected: (value) {
                          _changeRotation();
                          setState(() {
                            isSelected = false;
                            nowTemplate = value;
                          });
                          ref.readTodoHolder
                              .changeAll(value.taskContents.map((e) {
                            return TodoTask.fromJson(e);
                          }).toList());
                        },
                        itemBuilder: (BuildContext context) {
                          return templateListNew!
                              .map((e) => PopupMenuItem(
                                    value: e,
                                    child: Text(e.templateName!,
                                        style: const TextStyle(fontSize: 20)),
                                  ))
                              .toList();
                        },
                        child: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                Text(nowTemplate == null
                                    ? "now"
                                    : nowTemplate!.templateName!.length > 5
                                        ? nowTemplate!.templateName!
                                            .substring(0, 5)
                                        : nowTemplate!.templateName!),
                                AnimatedArrowUpDown(isSelected, turns),
                              ],
                            )),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                IconButton(
                    onPressed: () async {

                      if(ref.watch(todoTemplateSampleListProvider).length > 10){
                        showDialog<SimpleResult>(
                            builder: (context) {
                              if(context.mounted){
                                return MessageDialog(
                                    '템플릿 수는 최대 10개 입니다',
                                    buttonText: '확인'
                                );
                              }
                              return
                                const CircularProgressIndicator();
                            }, context: App.navigatorKey.currentContext ?? context);

                        return ;
                      }

                      await showAdaptiveDialog(
                          context: context,
                          builder: (context) =>
                              NewTaskTemplate(workDate: selectedDate));
                    },
                    icon: const Icon(Icons.add_circle)),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: FutureBuilder(
          future: dailyTodoList(ref.readTodoHolder),
          builder: (context, snapshot) {
            List<TodoTask> todoList = snapshot.data ?? [];

            final textTecList = ref.watch(tecListProvider);



            if (snapshot.hasData) {
              return ListView.separated(
                padding:
                    const EdgeInsets.only(bottom: FloatingDaangnButton.height),
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return WritePlanItem(
                      tec: textTecList[index],
                      todoTask: todoList[index],
                      onChanged: (value) {
                        ref.readTodoHolder
                            .changeType(todoList[index].timeline, value);
                      });
                },
                separatorBuilder: (context, index) =>
                    const Line().pSymmetric(h: 15),
                itemCount: todoList.length,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<List<TodoTask>> dailyTodoList(TodoDataHolder readTodoHolder) async {
    final ControllerList textTecList =
        ref.watch(tecListProvider.notifier);
    textTecList.clear();
    await RangeStream(0, 23).map((i) {
      textTecList.add();
      return i;
    }).toList();

    //template 세팅
    final db = FirebaseFirestore.instance.collection("todoTemplate");
    final uid = ref.watch(userProvider);
    final result = await db.where('uid', isEqualTo: uid.value).orderBy("orderSort").get();


    final templates = ref.watch(todoTemplateSampleListProvider);
    templates.clear();
    for (var element in result.docs) {
      print("result: ${element.data()}");
      final sample = TodoTaskTemplateSample.fromJson(element.data());
      templates.add(sample);
    }



    return await selectedDateTaskList();
  }

  Future<List<TodoTask>> selectedDateTaskList() async {
    const uuid = Uuid();
    final selectedDate = ref.watch(selectedDateProvider);
    final todayTask = ref.watch(todolistProvider);
    if (todayTask.isEmpty) {
      final writtenTodoTasks =
          await TodoApi.instance.getTodoList(selectedDate).then(
                (e) => e.successData,
              );
      List<TodoTask> todoTasks = writtenTodoTasks.docs.isEmpty
          ? await RangeStream(0, 23).map((i) {
              return TodoTask(
                timeline: i,
                workDate: selectedDate.formattedDateOnly,
                createdTime: DateTime.now(),
                title: '',
                taskType: TaskType.nill,
              );
            }).toList()
          : TodoTaskTemplate.fromJson(writtenTodoTasks.docs.first.data())
              .taskContents
              .map((ele) {
              final e = TodoContent.fromJson(ele);
              return TodoTask(
                  workDate: selectedDate.formattedDateOnly,
                  timeline: e.timeline,
                  createdTime: DateTime.now(),
                  title: e.title,
                  taskType: e.taskType);
            }).toList();
      for (var ele in todoTasks) {
        ref.readTodoHolder.addTodo(ele);
      }

      final template = TodoTaskTemplateSample(
          templateName: "now",
          uid: "abc",
          createdTime: todoTasks.first.createdTime!,
          orderSort: 0,
          taskContents: todoTasks.map((e) => e.toJson()).toList());

      print("delete & insert");
      final result = await TodoTemplateApi.instance.removeTemplateByName(template.templateName!);
      if(result.isSuccess){
        TodoTemplateApi.instance.addTodoTemplate(template);
      }

    } else {
      //todo task 일자 변경
      ref.readTodoHolder.changeWorkDate(selectedDate);
    }

    return todayTask;
  }

  void _changeRotation() {
    setState(() => turns += 10.0);
  }

  void _selectDate() async {
    final selectedDate = ref.watch(selectedDateProvider.notifier);

    final date = await showDatePicker(
      context: context,
      initialDate: ref.watch(selectedDateProvider),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (date != null) {
      ref.readTodoHolder.clear();
      selectedDate.changeDate(DateUtils.dateOnly(date));
      selectedDateTaskList();

    }
  }

  Future<List<TodoTaskTemplateSample>> _futureTemplateList() async {

    return ref.watch(todoTemplateSampleListProvider);
  }
}
