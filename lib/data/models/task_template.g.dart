// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskTemplateImpl _$$TaskTemplateImplFromJson(Map<String, dynamic> json) =>
    _$TaskTemplateImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => TodoTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TaskTemplateImplToJson(_$TaskTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tasks': instance.tasks,
      'isDefault': instance.isDefault,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
