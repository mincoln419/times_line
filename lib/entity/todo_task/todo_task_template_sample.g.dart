// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_task_template_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoTaskTemplateSampleImpl _$$TodoTaskTemplateSampleImplFromJson(
        Map<String, dynamic> json) =>
    _$TodoTaskTemplateSampleImpl(
      docId: json['docId'] as String?,
      uid: json['uid'] as String?,
      templateName: json['templateName'] as String?,
      createdTime: DateTime.parse(json['createdTime'] as String),
      modifyTime: json['modifyTime'] == null
          ? null
          : DateTime.parse(json['modifyTime'] as String),
      taskContents: json['taskContents'] as List<dynamic>,
      orderSort: (json['orderSort'] as num).toInt(),
    );

Map<String, dynamic> _$$TodoTaskTemplateSampleImplToJson(
        _$TodoTaskTemplateSampleImpl instance) =>
    <String, dynamic>{
      'docId': instance.docId,
      'uid': instance.uid,
      'templateName': instance.templateName,
      'createdTime': instance.createdTime.toIso8601String(),
      'modifyTime': instance.modifyTime?.toIso8601String(),
      'taskContents': instance.taskContents,
      'orderSort': instance.orderSort,
    };
