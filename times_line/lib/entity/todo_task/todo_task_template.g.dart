// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_task_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoTaskTemplateImpl _$$TodoTaskTemplateImplFromJson(
        Map<String, dynamic> json) =>
    _$TodoTaskTemplateImpl(
      docId: json['docId'] as String?,
      uid: json['uid'] as String?,
      workDate: json['workDate'] as String,
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
      modifyTime: json['modifyTime'] == null
          ? null
          : DateTime.parse(json['modifyTime'] as String),
      taskContents: (json['taskContents'] as List<dynamic>?)
              ?.map((e) => TodoContent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TodoTaskTemplateImplToJson(
        _$TodoTaskTemplateImpl instance) =>
    <String, dynamic>{
      'docId': instance.docId,
      'uid': instance.uid,
      'workDate': instance.workDate,
      'createdTime': instance.createdTime?.toIso8601String(),
      'modifyTime': instance.modifyTime?.toIso8601String(),
      'taskContents': instance.taskContents,
    };
