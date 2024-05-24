import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:times_line/common/dart/extension/datetime_extension.dart';
import 'package:times_line/entity/diary/diary_content.dart';

import '../../simple_result.dart';

class DiaryApi {
  final db = FirebaseFirestore.instance;
  DiaryApi._();

  static DiaryApi instance = DiaryApi._();


  Future<SimpleResult<DiaryContent, Error>> addDiary(DiaryContent diary) async {
    final ref = db.collection("workDiary");
    diary.modifyTime = DateTime.now();

    ref.where('uid', isEqualTo: diary.uid)
        .where('workDate', isEqualTo: diary.workDate)
        .where('diaryType', isEqualTo: diary.diaryType)
        .get()
        .then((e) {
      if (e.size == 0) {
        ref.add(diary.toJson());
      } else {
        ref.doc(e.docs.first.id).update(diary.toJson());
      }
    });

    return SimpleResult.success(diary);
  }

  Future<SimpleResult<QuerySnapshot<Map<String, dynamic>>, Error>> getSelectDateDiary(DateTime selectedDate) async {
    final ref = db.collection("workDiary");
    final result = await ref
        .where('workDate',
        isEqualTo: (selectedDate ?? DateTime.now()).formattedDateOnly)
        .get();

    return SimpleResult.success(result);
  }

}