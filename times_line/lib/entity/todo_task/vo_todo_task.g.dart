// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vo_todo_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoTaskImpl _$$TodoTaskImplFromJson(Map<String, dynamic> json) =>
    _$TodoTaskImpl(
      id: json['id'] as String,
      workDate: DateTime.parse(json['workDate'] as String),
      createdTime: DateTime.parse(json['created_time'] as String),
      modifyTime: json['modifyTime'] == null
          ? null
          : DateTime.parse(json['modifyTime'] as String),
      title: json['title'] as String,
      timeline: json['timeline'] as int?,
      taskType: $enumDecode(_$TaskTypeEnumMap, json['taskType']),
      todoTaskStatus: $enumDecodeNullable(
              _$TodoTaskStatusEnumMap, json['todoTaskStatus']) ??
          TodoTaskStatus.not_yet,
    );

Map<String, dynamic> _$$TodoTaskImplToJson(_$TodoTaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workDate': instance.workDate.toIso8601String(),
      'created_time': instance.createdTime.toIso8601String(),
      'modifyTime': instance.modifyTime?.toIso8601String(),
      'title': instance.title,
      'timeline': instance.timeline,
      'taskType': _$TaskTypeEnumMap[instance.taskType]!,
      'todoTaskStatus': _$TodoTaskStatusEnumMap[instance.todoTaskStatus]!,
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

const _$TodoTaskStatusEnumMap = {
  TodoTaskStatus.not_yet: 'not_yet',
  TodoTaskStatus.matched: 'matched',
  TodoTaskStatus.unmatched: 'unmatched',
};
