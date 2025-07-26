import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary.freezed.dart';
part 'diary.g.dart';

@freezed
class Diary with _$Diary {
  const factory Diary({
    int? id,
    required DateTime date, // 날짜
    required String feeling, // 느낀점
    required String regret, // 후회하는 점
    required String resolution, // 각오
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Diary;

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
}
