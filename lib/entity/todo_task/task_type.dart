import 'package:flutter/cupertino.dart';
import 'package:times_line/common/common.dart';

enum TaskType {
  soul,
  physical,
  knowledge,
  social,
  etc,
  sleep,
  waste,
  nill,
}

Color getTaskColor(BuildContext context, TaskType taskType ){

  switch(taskType){
    case TaskType.soul:
      return context.appColors.soulColor;
    case TaskType.physical:
      return context.appColors.physicalColor;
    case TaskType.knowledge:
      return context.appColors.knowlegeColor;
    case TaskType.social:
      return context.appColors.socialColor;
    case TaskType.etc:
      return context.appColors.etcColor;
    case TaskType.sleep:
      return context.appColors.sleepColor;
    case TaskType.waste:
      return context.appColors.wasteColor;

    case TaskType.nill:
      return context.appColors.hintText;
  }
}