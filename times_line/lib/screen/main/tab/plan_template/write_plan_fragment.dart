import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/screen/main/fab/w_floating_daangn_button.riverpod.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';
import 'package:times_line/screen/main/tab/plan_template/template_type.dart';
import 'package:times_line/screen/main/tab/plan_template/write_plan_item.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/widget/animated_arrow_up_down.dart';
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

class _LocalLifeFragmentState extends ConsumerState<WritePlanFragment>
    with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();

  double turns = 0.0;
  bool isSelected = false;

  TemplateType templateType =
      DateTime.now().weekday >= 6 ? TemplateType.holiday : TemplateType.normal;

  DateTime _selectedDate = DateUtils.dateOnly(DateTime.now());

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
            Row(
              children: [
                _selectedDate.formattedDateOnly.text.size(15).make(),
                IconButton(
                  onPressed: _selectDate,
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PopupMenuButton<TemplateType>(
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
                      templateType = value;
                    });
                  },
                  itemBuilder: (BuildContext context) => TemplateType.values
                      .map((e) => PopupMenuItem(
                            value: e,
                            child: Text(e.name, style: TextStyle(fontSize: 20)),
                          ))
                      .toList(),
                  child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Text(
                            templateType.name,
                          ),
                          AnimatedArrowUpDown(isSelected, turns),
                        ],
                      )),
                ),
                IconButton(
                    onPressed: () {

                      //TODO 신규 템플릿 생성 다이얼로그 구현 필요

                      showAdaptiveDialog(
                          context: context,
                          builder: (context) => Placeholder());
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
              List<int> list = snapshot.data ?? [];
              if (list.isNotEmpty) {
                return ListView.separated(
                  padding: const EdgeInsets.only(
                      bottom: FloatingDaangnButton.height),
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
    final selectedDate =  ref.watch(selectedDateProvider).value;
    if (todayTask.isEmpty) {
      final writtenTodoTasks = await TodoApi.instance.getTodoList(selectedDate).then(
            (e) => e.successData,
          );
      List<TodoTask> todoTasks = writtenTodoTasks.docs.isEmpty
          ? await RangeStream(0, 23).map((i) {
              return TodoTask(
                id: uuid.v1(),
                timeline: i,
                workDate: selectedDate!,
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
    return await RangeStream(0, 23).map((i) {
      textTecList.add();
      return i;
    }).toList();
  }

  void _changeRotation() {
    setState(() => turns += 10.0);
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }
}
