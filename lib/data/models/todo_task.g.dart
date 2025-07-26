// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoTaskImpl _$$TodoTaskImplFromJson(Map<String, dynamic> json) =>
    _$TodoTaskImpl(
      id: (json['id'] as num?)?.toInt(),
      date: DateTime.parse(json['date'] as String),
      hour: (json['hour'] as num).toInt(),
      title: json['title'] as String,
      taskType: $enumDecode(_$TaskTypeEnumMap, json['taskType']),
      isCompleted: json['isCompleted'] as bool? ?? false,
      alternativeActivity: json['alternativeActivity'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TodoTaskImplToJson(_$TodoTaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'hour': instance.hour,
      'title': instance.title,
      'taskType': _$TaskTypeEnumMap[instance.taskType]!,
      'isCompleted': instance.isCompleted,
      'alternativeActivity': instance.alternativeActivity,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$TaskTypeEnumMap = {
  TaskType.spiritual: 'spiritual',
  TaskType.intellectual: 'intellectual',
  TaskType.social: 'social',
  TaskType.physical: 'physical',
  TaskType.waste: 'waste',
  TaskType.sleep: 'sleep',
};
