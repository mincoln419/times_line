import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/dart/extension/num_duration_extension.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';

import '../../../../common/dropdown/todo_tasktype_dropdown.dart';
import '../home/provider/todo_task_editor_provider.dart';

class WritePlanItem extends ConsumerStatefulWidget {
  final int index;

  const WritePlanItem({super.key, required this.index});

  @override
  ConsumerState<WritePlanItem> createState() => _WritePlanItemState();
}

class _WritePlanItemState extends ConsumerState<WritePlanItem>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchTecList(widget.index),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TodoTask> todoList = ref.watch(todolistProvider);
            //print("write_plan todotask:: $todoList");
            final tec = snapshot.data;
            tec!.text = todoList.isEmpty ? "" : todoList[widget.index].title;
            final taskType = todoList.isEmpty ? TaskType.nill: todoList[widget.index].taskType;

            return Container(
              height: 80,
              decoration: BoxDecoration(
                color: getTaskColor(context, taskType),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: widget.index.text.make()),
                    Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: DropdownButton(
                        padding: EdgeInsets.all(5),
                        value: taskType,
                        items: dropDownTaskType,
                        onChanged: (value) {
                          ref.readTodoHolder.changeType(widget.index, value);
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: tec,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Future<TextEditingController> _fetchTecList(int index) async {
    //sleepAsync(1000.ms);
    ref.watch(tecListProvider.notifier);
    ref.watch(todolistProvider);
    return ref.watch(tecListProvider)[index];
  }
}
