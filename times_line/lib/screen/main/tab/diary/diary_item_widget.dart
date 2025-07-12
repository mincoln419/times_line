import 'package:flutter/material.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/entity/diary/diary_content.dart';

import '../../../../common/widget/widget_constant.dart';
import '../../../../entity/diary/diary_type.dart';

class DiaryItem extends StatelessWidget {
  final TextEditingController tec;
  final DiaryContent content;
  final Function(String)? onChanged;

  const DiaryItem({
    super.key, 
    required this.tec, 
    required this.content,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: getDiaryColor(context, content.diaryType),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getDiaryIcon(content.diaryType),
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                _getDiaryTitle(content.diaryType),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: tec,
            onChanged: onChanged,
            maxLines: 3,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: _getDiaryHint(content.diaryType),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white, width: 2),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getDiaryIcon(DiaryType diaryType) {
    switch (diaryType) {
      case DiaryType.feeling:
        return Icons.favorite;
      case DiaryType.thanks:
        return Icons.thumb_up;
      case DiaryType.adapt:
        return Icons.psychology;
      default:
        return Icons.edit;
    }
  }

  String _getDiaryTitle(DiaryType diaryType) {
    switch (diaryType) {
      case DiaryType.feeling:
        return '오늘의 감정';
      case DiaryType.thanks:
        return '감사한 일';
      case DiaryType.adapt:
        return '적응한 일';
      default:
        return '일기';
    }
  }

  String _getDiaryHint(DiaryType diaryType) {
    switch (diaryType) {
      case DiaryType.feeling:
        return '오늘 느낀 감정을 자유롭게 적어보세요...';
      case DiaryType.thanks:
        return '오늘 감사했던 일을 적어보세요...';
      case DiaryType.adapt:
        return '오늘 적응했던 일을 적어보세요...';
      default:
        return '오늘 있었던 일을 적어보세요...';
    }
  }
}



