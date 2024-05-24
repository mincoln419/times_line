import 'package:flutter/material.dart';
import 'package:times_line/common/common.dart';

enum DiaryType {
  feeling,
  thanks,
  adapt,

}

Color getDiaryColor(BuildContext context, DiaryType diaryType ){

  switch(diaryType){
    case DiaryType.feeling:
      return context.appColors.feeling;
    case DiaryType.thanks:
      return context.appColors.thanks;
    case DiaryType.adapt:
      return context.appColors.adapt;

  }
}