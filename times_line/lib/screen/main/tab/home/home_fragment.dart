import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/streams.dart';
import 'package:times_line/app.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/common/widget/animated_arrow_up_down.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_content.dart';
import 'package:times_line/entity/todo_task/todo_task_template.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.riverpod.dart';
import 'package:times_line/screen/main/tab/home/provider/done_task_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_home_provider.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';
import 'package:times_line/screen/main/tab/home/vo_write_todo.dart';
import 'package:times_line/screen/main/tab/home/w_times_line_item.dart';
import 'package:times_line/screen/notification/s_notification.dart';
import 'package:uuid/uuid.dart';
import 'package:times_line/common/dropdown/todo_tasktype_dropdown.dart';
import '../../../../data/network/todo_api.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  ConsumerState<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  final scrollController = ScrollController();
  String title = "오늘";
  bool isSelected = false;
  double turns = 0.0;
  final uuid = const Uuid();

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
  Widget build(
    BuildContext context,
  ) {
    String selectedDate = ref.watch(selectedHomeDateProvider).formattedDateOnly;
    return Column(
      children: [
        AppBar(
          title: Row(
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
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Nav.push(NotificationScreen());
              },
              icon: const Icon(Icons.notifications_none_rounded),
            )
          ],
        ),
        Expanded(
          child: FutureBuilder(
              future: todoListStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData && context.mounted) {
                  final taskMap = snapshot.data;
                  final List<TodoTask> todoTaskList =
                      ref.watch(todoHomeListProvider);
                  final List<TodoTask> doneTaskList =
                      ref.watch(doneListProvider);

                  //print('stream todolist:: ${todoTaskList}');
                  return ListView.separated(
                    padding: const EdgeInsets.only(
                        bottom: FloatingDaangnButton.height),
                    controller: scrollController,
                    itemBuilder: (context, index) => TimesLineItem(
                      index: index,
                      onTap: () async {
                        //처리한 업무 다이얼로그 호출
                        TextEditingController tec = TextEditingController(
                          text: doneTaskList[index].title,
                        );
                        ref
                            .watch(currentTaskTypeProvider)
                            .currentTypeOnChange(doneTaskList[index].taskType);
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: TextField(
                              controller: tec,
                            ),
                            actions: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  width10,
                                  Container(
                                    width: 120,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                    child: Center(
                                      child: _DropDownWidgetConsumer(),
                                    ),
                                  ),
                                  width10,
                                ],
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (tec.text.isNotEmpty) {
                                    final TodoTask copyItem =
                                        doneTaskList[index];
                                    copyItem.title = tec.text.trim();
                                    copyItem.taskType = ref
                                        .watch(currentTaskTypeProvider)
                                        .currentType;
                                    await addDoneTask(copyItem);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("확인"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("취소"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    itemCount: todoTaskList.length,
                    separatorBuilder: (context, index) =>
                        const Line().pSymmetric(h: 15),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ],
    );
  }

  void _changeRotation() {
    setState(() => turns += 10.0);
  }

  Future<Map<String, dynamic>> todoListStream() async {
    final todayTask = ref.watch(todoHomeListProvider);
    final selectedDate = ref.watch(selectedHomeDateProvider);
    if (todayTask.isEmpty) {
      final writtenTodoTasks =
          await TodoApi.instance.getTodoList(selectedDate).then(
        (e) {
          return e.successData;
        },
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
          : TodoTaskTemplate.fromJson(writtenTodoTasks.docs.first.data()).taskContents.map((ele) {
              final e = TodoContent.fromJson(ele);
              //print('e:: $e');
              return TodoTask(
                  workDate: selectedDate.formattedDateOnly,
                  timeline: e.timeline,
                  createdTime: DateTime.now(),
                  title: e.title,
                  taskType: e.taskType);
            }).toList();

      //print("todoTasks : $todoTasks");
      ref.readTodoHomeHolder.clear();
      for (var ele in todoTasks) {
        ref.readTodoHomeHolder.addTodo(ele.copyWith());
      }
    }

    final todayDoneTask = ref.watch(doneListProvider);

    if (todayDoneTask.isEmpty) {
      final writtenDoneTasks =
          await TodoApi.instance.getDoneTodoList(selectedDate).then(
                (e) => e.successData,
              );

      final List<TodoTask> tempList = [];
      if (writtenDoneTasks.docs.isNotEmpty) {
        tempList.addAll(writtenDoneTasks.docs.map((ele) {
          TodoTask item = TodoTask.fromJson(ele.data());
          return item.copyWith(docId: ele.id);
        }).toList());
      }

      List<TodoTask> doneTasks = await RangeStream(0, 23).map((i) {
        final matchedTask =
            tempList.filter((tmp) => tmp.timeline == i).toList();
        return matchedTask.isEmpty
            ? TodoTask(
                timeline: i,
                workDate: selectedDate.formattedDateOnly,
                createdTime: DateTime.now(),
                title: '',
                taskType: TaskType.nill,
              )
            : matchedTask[0];
      }).toList();
      ref.readDoneHolder.clear();
      for (var ele in doneTasks) {
        ref.readDoneHolder.addTodo(ele);
      }
    }

    final Map<String, dynamic> returnMap = {
      "todo": todayTask,
      "done": todayDoneTask,
    };

    return returnMap;
  }

  Future addDoneTask(TodoTask todoTask) async {
    ref.readDoneHolder.updateTodo(todoTask);
    TodoApi.instance.addDoneTask(todoTask);
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: ref.watch(selectedHomeDateProvider),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (date != null) {
      ref.readSelectHomeDateHolder.changeDate(DateUtils.dateOnly(date));
      ref.readTodoHomeHolder.clear();
      ref.readDoneHolder.clear();
      todoListStream();
    }
  }
}

class _DropDownWidgetConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentType = ref.watch(currentTaskTypeProvider).currentType;
    return DropdownButton(
      padding: const EdgeInsets.all(5),
      value: currentType,
      items: dropDownTaskType,
      onChanged: (value) {
        ref.watch(currentTaskTypeProvider.notifier).currentTypeOnChange(value);
      },
    );
  }
}
