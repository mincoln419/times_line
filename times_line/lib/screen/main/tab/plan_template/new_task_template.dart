import 'package:flutter/material.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/plan_template/write_plan_item.dart';

class NewTaskTemplate extends StatefulWidget {
  const NewTaskTemplate({super.key, required this.workDate});

  final String workDate;

  @override
  State<NewTaskTemplate> createState() => _NewTaskTemplateState();
}

class _NewTaskTemplateState extends State<NewTaskTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('신규 템플릿 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return WritePlanItem(
                      tec: TextEditingController(),
                      todoTask: TodoTask(
                        workDate: widget.workDate,
                        title: '',
                        taskType: TaskType.nill,
                        timeline: index,
                      ),
                    );
                  },
                  separatorBuilder: (context, _) {
                    return const Divider();
                  },
                  itemCount: 24),
            )
          ],
        ),
      ),
    );
  }
}
