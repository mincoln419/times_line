import 'package:times_line/common/common.dart';
import 'package:times_line/screen/main/tab/chat/f_chat.dart';
import 'package:times_line/screen/main/tab/home/f_home.dart';
import 'package:times_line/screen/main/tab/local_life/f_local_life.dart';
import 'package:times_line/screen/main/tab/my/f_my.dart';
import 'package:times_line/screen/main/tab/diary/f_three_line_diary.dart';
import 'package:flutter/material.dart';

enum TabItem {
  localLife(Icons.add_circle, '일정추가', LocalLifeFragment()),
  nearMe(Icons.note_alt, '세줄일기', ThreeLineDiary()),
  home(Icons.format_list_bulleted, '일정', HomeFragment()),
  chat(Icons.stacked_bar_chart, '통계', ChatFragment()),
  my(Icons.settings, '설정', MyFragment()),
  ;

  final IconData activeIcon;
  final IconData inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.activeIcon, this.tabName, this.firstPage, {IconData? inActiveIcon})
      : inActiveIcon = inActiveIcon ?? activeIcon;

  static find(String? name){
    return values.asNameMap()[name] ?? TabItem.home;
  }

  BottomNavigationBarItem toNavigationBarItem(BuildContext context, {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(tabName),
          isActivated ? activeIcon : inActiveIcon,
          color:
              isActivated ? context.appColors.iconButton : context.appColors.iconButtonInactivate,
        ),
        label: tabName);
  }
}
