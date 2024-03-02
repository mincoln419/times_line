import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:times_line/common/cli_common.dart';
import 'package:times_line/common/common.dart';
import 'package:flutter/material.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/d_write_task.dart';

class TimesLineItem extends StatefulWidget {
  final TodoTask todoTask;
  final TodoTask doneTask;
  final VoidCallback onTap;

  const TimesLineItem(this.todoTask, this.doneTask, {required this.onTap, super.key});

  @override
  State<TimesLineItem> createState() => _TimesLineItemState();
}

class _TimesLineItemState extends State<TimesLineItem> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.08,
                  child: widget.todoTask.timeline.text.make(),
                ),
                Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.45,
                  height: 40,
                  color: getTaskColor(context, widget.todoTask.taskType),
                  child: widget.todoTask.title.text.make(),
                ),
                emptyExpanded,
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.45,
                    height: 40,
                    color: getTaskColor(context, widget.doneTask.taskType),
                    child: widget.doneTask.title.text.make(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
