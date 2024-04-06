import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.riverpod.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';
import 'package:times_line/screen/main/tab/local_life/write_plan_item.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/widget/animated_arrow_up_down.dart';
import '../../../../common/widget/w_line.dart';
import '../../../../data/network/todo_api.dart';
import '../../../../entity/todo_task/task_type.dart';
import '../../../../entity/todo_task/vo_todo_task.dart';
import '../../fab/w_floating_daangn_button.dart';
import '../../w_menu_drawer.dart';
import '../home/provider/todo_task_editor_provider.dart';

class WritePlanFragment extends ConsumerStatefulWidget {
  const WritePlanFragment({super.key});

  @override
  ConsumerState<WritePlanFragment> createState() => _LocalLifeFragmentState();
}

class _LocalLifeFragmentState extends ConsumerState<WritePlanFragment> with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();

  double turns = 0.0;
  bool isSelected = false;

  String title = "오늘";


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

    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            '일일계획'.text.make(),
            PopupMenuButton<String>(
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
              itemBuilder: (BuildContext context) => ["평일", "주말"]
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
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: FutureBuilder(
            future: dailyTodoList(ref.readTodoHolder),
            builder: (context, snapshot) {
              List<int> list = snapshot.data ?? [];
              if (list.isNotEmpty) {
                return ListView.separated(
                  padding:
                      const EdgeInsets.only(bottom: FloatingDaangnButton.height),
                  controller: scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return WritePlanItem(index: index);
                  },
                  separatorBuilder: (context, index) =>
                      const Line().pSymmetric(h: 15),
                  itemCount: list.length,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  Future<List<int>> dailyTodoList(TodoDataHolder readTodoHolder) async {
    const uuid = Uuid();
    final todayTask = ref.watch(todolistProvider);
    if(todayTask.isEmpty){
      final writtenTodoTasks = await TodoApi.instance.getTodoList().then(
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
      for (var ele in todoTasks) {
        ref.readTodoHolder.addTodo(ele);
      }
    }

    final textTecList = ref.watch(tecListProvider.notifier);
    return await RangeStream(1, 24).map((i) {
      textTecList.add();
      return i;
    }).toList();
  }

  void _changeRotation() {
    setState(() => turns += 10.0);
  }
}
