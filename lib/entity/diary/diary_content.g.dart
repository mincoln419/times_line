// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiaryContentImpl _$$DiaryContentImplFromJson(Map<String, dynamic> json) =>
    _$DiaryContentImpl(
      uid: json['uid'] as String,
      contents: json['contents'] as String,
      diaryType: $enumDecode(_$DiaryTypeEnumMap, json['diaryType']),
      workDate: json['workDate'] as String,
      createTime: json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String),
      modifyTime: json['modifyTime'] == null
          ? null
          : DateTime.parse(json['modifyTime'] as String),
      sortOrder: (json['sortOrder'] as num).toInt(),
    );

Map<String, dynamic> _$$DiaryContentImplToJson(_$DiaryContentImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'contents': instance.contents,
      'diaryType': _$DiaryTypeEnumMap[instance.diaryType]!,
      'workDate': instance.workDate,
      'createTime': instance.createTime?.toIso8601String(),
      'modifyTime': instance.modifyTime?.toIso8601String(),
      'sortOrder': instance.sortOrder,
    };

const _$DiaryTypeEnumMap = {
  DiaryType.feeling: 'feeling',
  DiaryType.thanks: 'thanks',
  DiaryType.adapt: 'adapt',
};
