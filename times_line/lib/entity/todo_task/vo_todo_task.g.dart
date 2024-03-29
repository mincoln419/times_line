// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vo_todo_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoTask _$$_TodoTaskFromJson(Map<String, dynamic> json) => _$_TodoTask(
      id: json['id'] as int,
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

Map<String, dynamic> _$$_TodoTaskToJson(_$_TodoTask instance) =>
    <String, dynamic>{
      'id': instance.id,
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
};

const _$TodoTaskStatusEnumMap = {
  TodoTaskStatus.not_yet: 'not_yet',
  TodoTaskStatus.matched: 'matched',
  TodoTaskStatus.unmatched: 'unmatched',
};
