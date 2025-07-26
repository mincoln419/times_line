// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoContentImpl _$$TodoContentImplFromJson(Map<String, dynamic> json) =>
    _$TodoContentImpl(
      title: json['title'] as String,
      timeline: (json['timeline'] as num?)?.toInt(),
      taskType: $enumDecode(_$TaskTypeEnumMap, json['taskType']),
    );

Map<String, dynamic> _$$TodoContentImplToJson(_$TodoContentImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'timeline': instance.timeline,
      'taskType': _$TaskTypeEnumMap[instance.taskType]!,
    };

const _$TaskTypeEnumMap = {
  TaskType.soul: 'soul',
  TaskType.physical: 'physical',
  TaskType.knowledge: 'knowledge',
  TaskType.social: 'social',
  TaskType.etc: 'etc',
  TaskType.sleep: 'sleep',
  TaskType.waste: 'waste',
  TaskType.nill: 'nill',
};
