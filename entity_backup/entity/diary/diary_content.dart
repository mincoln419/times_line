import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:times_line/entity/diary/diary_type.dart';

part 'diary_content.freezed.dart';
part 'diary_content.g.dart';

@unfreezed
class DiaryContent with _$DiaryContent{
  DiaryContent._();

  factory DiaryContent ({
    required String uid,
    required String contents,
    required DiaryType diaryType,
    required String workDate,
    DateTime? createTime,
    DateTime? modifyTime,
    required int sortOrder,

  }) = _DiaryContent;

  factory DiaryContent.fromJson(Map<String, Object?> json) => _$DiaryContentFromJson(json);

}