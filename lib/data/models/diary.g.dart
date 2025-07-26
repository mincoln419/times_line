// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiaryImpl _$$DiaryImplFromJson(Map<String, dynamic> json) => _$DiaryImpl(
      id: (json['id'] as num?)?.toInt(),
      date: DateTime.parse(json['date'] as String),
      feeling: json['feeling'] as String,
      regret: json['regret'] as String,
      resolution: json['resolution'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DiaryImplToJson(_$DiaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'feeling': instance.feeling,
      'regret': instance.regret,
      'resolution': instance.resolution,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
