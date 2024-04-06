import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/task_provider.dart';

import '../../../../common/dropdown/todo_tasktype_dropdown.dart';
import '../home/provider/todo_task_editor_provider.dart';

class WritePlanItem extends ConsumerStatefulWidget {
  final int index;

  const WritePlanItem(
      {super.key,
      required this.index});

  @override
  ConsumerState<WritePlanItem> createState() => _WritePlanItemState();
}

class _WritePlanItemState extends ConsumerState<WritePlanItem> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TextEditingController tec =  ref.read(tecListProvider)[widget.index];
    List<TodoTask> todoList =  ref.watch(todolistProvider);
    tec.text = todoList[widget.index].title;
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: getTaskColor(context, todoList[widget.index].taskType)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: widget.index.text.make()),
            Container(
              height: 80,
              alignment: Alignment.center,
              child: DropdownButton(
                padding: EdgeInsets.all(5),
                value: todoList[widget.index].taskType,
                items: dropDownTaskType,
                onChanged: (value) {
                  setState(() {
                    todoList[widget.index].taskType = value;
                  });
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
}
