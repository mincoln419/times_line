import 'package:flutter/material.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/entity/diary/diary_content.dart';

import '../../../../common/widget/widget_constant.dart';
import '../../../../entity/diary/diary_type.dart';

class DiaryItem extends StatelessWidget {

  final TextEditingController tec;
  final DiaryContent content;
  const DiaryItem({super.key, required this.tec, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: getDiaryColor(context, content.diaryType),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '일기 내용을 적으세요'.text.bold.make(),
          height5,
          TextField(
            controller: tec,
            decoration: const InputDecoration(
              hintText: '제목',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  )),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  )),
            ),
          ),
        ],
      ),
    );;
  }
}



