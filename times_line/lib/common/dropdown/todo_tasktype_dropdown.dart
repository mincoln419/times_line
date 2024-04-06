import 'package:flutter/material.dart';
import 'package:times_line/common/common.dart';

import '../../entity/todo_task/task_type.dart';

List<DropdownMenuItem> get dropDownTaskType {
  return TaskType.values
      .map(
        (e) => DropdownMenuItem(
      value: e,
      child: e.name.text.make(),
    ),
  )
      .toList();
}