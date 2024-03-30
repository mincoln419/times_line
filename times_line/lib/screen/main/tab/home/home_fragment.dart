import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/streams.dart';
import 'package:times_line/app.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/widget/animated_arrow_up_down.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.riverpod.dart';
import 'package:times_line/screen/main/tab/home/provider/task_provider.dart';
import 'package:times_line/screen/main/tab/home/vo_write_todo.dart';
import 'package:times_line/screen/main/tab/home/w_times_line_item.dart';
import 'package:times_line/screen/notification/s_notification.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/network/todo_api.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  ConsumerState<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  final scrollController = ScrollController();
  String title = "상일동";
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
  Widget build(BuildContext context) {
    final taskList = ref.watch(todoDataProvider);

    return Column(
      children: [
        AppBar(
          title: PopupMenuButton<String>(
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
                title = value;
              });
            },
            itemBuilder: (BuildContext context) => ["어제", "오늘", "내일"]
                .map((e) => PopupMenuItem(
                      value: e,
                      child: Text(e, style: TextStyle(fontSize: 20)),
                    ))
                .toList(),
            child: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    Text(
                      title,
                    ),
                    AnimatedArrowUpDown(isSelected, turns),
                  ],
                )),
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
                if (snapshot.hasData) {
                  final taskMap = snapshot.data;
                  final List<TodoTask> todoTaskList = taskMap!["todo"];
                  final List<TodoTask> doneTaskList = taskMap["done"];
                  print(taskList);
                  return ListView.separated(
                    padding: const EdgeInsets.only(
                        bottom: FloatingDaangnButton.height),
                    controller: scrollController,
                    itemBuilder: (context, index) => TimesLineItem(
                      todoTaskList[index],
                      doneTaskList[index],
                      onTap: () async {
                        print("tap");
                        //처리한 업무 다이얼로그 호출

                        TextEditingController tec = TextEditingController(
                          text: doneTaskList[index].title,
                        );
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: TextField(
                              controller: tec,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  if (tec.text.isNotEmpty) {
                                    final TodoTask copyItem = doneTaskList[index];
                                    copyItem.title = tec.text.trim();
                                    await addDoneTask(copyItem);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("확인"),
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
    final writtenTodoTasks = await TodoApi.instance.getTodoList().then(
          (e) => e.successData,
        );
    final writtenDoneTasks = await TodoApi.instance.getDoneTodoList().then(
          (e) => e.successData,
        );

    List<TodoTask> todoTasks = writtenTodoTasks.docs.isEmpty
        ? await RangeStream(1, 24).map((i) {
            return TodoTask(
              id: uuid.v1(),
              timeline: i,
              workDate: DateUtils.dateOnly(DateTime.now()),
              createdTime: DateTime.now(),
              title: '',
              taskType: TaskType.nill,
            );
          }).toList()
        : writtenTodoTasks.docs.map((ele) {
            TodoTask item = TodoTask.fromJson(ele.data());
            return item.copyWith();
          }).toList();

    final List<TodoTask> tempList = [];
    if (writtenDoneTasks.docs.isNotEmpty) {
      tempList.addAll(writtenDoneTasks.docs.map((ele) {
        TodoTask item = TodoTask.fromJson(ele.data());
        return item.copyWith();
      }).toList());
      print("tempList: $tempList");
    }

    List<TodoTask> doneTasks = await RangeStream(1, 24).map((i) {
      final matchedTask = tempList.filter((tmp) => tmp.timeline == i).toList();


      return matchedTask.isEmpty
          ? TodoTask(
              id: uuid.v1(),
              timeline: i,
              workDate: DateUtils.dateOnly(DateTime.now()),
              createdTime: DateTime.now(),
              title: '',
              taskType: TaskType.nill,
            )
          : matchedTask[0];
    }).toList();
    print("hello");

    final Map<String, dynamic> returnMap = {
      "todo": todoTasks,
      "done": doneTasks
    };

    debugPrint("returnMap : $returnMap");

    return returnMap;
  }

  Future addDoneTask(TodoTask todoTask) async {
    TodoApi.instance.addDoneTask(todoTask);
  }
}
