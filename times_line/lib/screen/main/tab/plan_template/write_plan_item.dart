import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/provider/todo_task_provider.dart';

import '../../../../common/dropdown/todo_tasktype_dropdown.dart';

class WritePlanItem extends ConsumerStatefulWidget {
  final TodoTask todoTask;
  final TextEditingController tec;

  const WritePlanItem({
    super.key,
    required this.tec,
    required this.todoTask,
  });

  @override
  ConsumerState<WritePlanItem> createState() => _WritePlanItemState();
}

class _WritePlanItemState extends ConsumerState<WritePlanItem>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (context.mounted) {
        widget.tec.text = widget.todoTask.title;
        final taskType = widget.todoTask.taskType;

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
                    child: widget.todoTask.timeline!.text.make()),
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: DropdownButton(
                    padding: const EdgeInsets.all(5),
                    value: taskType,
                    items: dropDownTaskType,
                    onChanged: (value) {
                      ref.readTodoHolder
                          .changeType(widget.todoTask.timeline!, value);
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: widget.tec,
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return CircularProgressIndicator();
    });
  }
}
