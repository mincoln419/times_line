import 'package:times_line/common/constant/app_colors.dart';
import 'package:flutter/material.dart';

export 'package:times_line/common/constant/app_colors.dart';

typedef ColorProvider = Color Function();

abstract class AbstractThemeColors {
  const AbstractThemeColors();

  Color get seedColor => const Color(0xff26ff8c);

  Color get veryBrightGrey => AppColors.brightGrey;

  Color get drawerBg => const Color.fromARGB(255, 255, 255, 255);

  Color get scrollableItem => const Color.fromARGB(255, 57, 57, 57);

  Color get iconButton => const Color.fromARGB(255, 0, 0, 0);

  Color get iconButtonInactivate => const Color.fromARGB(255, 162, 162, 162);

  Color get inActivate => const Color.fromARGB(255, 200, 207, 220);

  Color get activate => const Color.fromARGB(255, 63, 72, 95);

  Color get badgeBg => AppColors.blueGreen;

  Color get textBadgeText => Colors.white;

  Color get badgeBorder => Colors.transparent;

  Color get divider => const Color.fromARGB(255, 228, 228, 228);

  Color get text => AppColors.darkGrey;

  Color get hintText => AppColors.middleGrey;

  Color get focusedBorder => AppColors.darkGrey;

  Color get confirmText => AppColors.blue;

  Color get drawerText => text;

  Color get snackbarBgColor => AppColors.mediumBlue;

  Color get blueButtonBackground => AppColors.darkBlue;

  Color get floatingActionLayer => const Color.fromARGB(255, 37, 37, 39);

  Color get lessImportantColor => AppColors.brightBlue;

  Color get unreadColor => AppColors.darkGrey;

  Color get lessImportant => const Color.fromARGB(255, 77, 77, 79);

  Color get knowlegeColor => const Color.fromARGB(255, 236, 105, 105);

  Color get soulColor => const Color.fromARGB(255, 12, 126, 33);

  Color get physicalColor => const Color.fromARGB(255, 53, 118, 203);

  Color get socialColor => const Color.fromARGB(255, 218, 112, 56);

  Color get etcColor => const Color.fromARGB(255, 176, 47, 239);

  Color get sleepColor => const Color.fromARGB(255, 86, 62, 10);

  Color get wasteColor => const Color.fromARGB(255, 117, 110, 87);

  Color get checkBoxColor => const Color.fromARGB(255, 159, 229, 83);

  Color get feeling => const Color.fromARGB(255, 229, 83, 127);

  Color get thanks => const Color.fromARGB(255, 70, 136, 190);

  Color get adapt => const Color.fromARGB(255, 210, 189, 146);



}
