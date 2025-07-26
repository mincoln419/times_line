import 'package:flutter/material.dart';

enum TaskType {
  spiritual, // 영적
  intellectual, // 지적
  social, // 사회적
  physical, // 신체적
  waste, // 낭비
  sleep, // 잠
}

Color getTaskColor(BuildContext context, TaskType taskType) {
  switch (taskType) {
    case TaskType.spiritual:
      return Colors.purple;
    case TaskType.intellectual:
      return Colors.blue;
    case TaskType.social:
      return Colors.green;
    case TaskType.physical:
      return Colors.orange;
    case TaskType.waste:
      return Colors.red;
    case TaskType.sleep:
      return Colors.indigo;
  }
}

String getTaskTypeName(TaskType taskType) {
  switch (taskType) {
    case TaskType.spiritual:
      return '영적';
    case TaskType.intellectual:
      return '지적';
    case TaskType.social:
      return '사회적';
    case TaskType.physical:
      return '신체적';
    case TaskType.waste:
      return '낭비';
    case TaskType.sleep:
      return '잠';
  }
}
