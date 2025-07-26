// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_task_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoTaskTemplate _$TodoTaskTemplateFromJson(Map<String, dynamic> json) {
  return _TodoTaskTemplate.fromJson(json);
}

/// @nodoc
mixin _$TodoTaskTemplate {
  String? get docId => throw _privateConstructorUsedError;
  set docId(String? value) => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  set uid(String? value) => throw _privateConstructorUsedError;
  String get workDate => throw _privateConstructorUsedError;
  set workDate(String value) => throw _privateConstructorUsedError;
  DateTime? get createdTime => throw _privateConstructorUsedError;
  set createdTime(DateTime? value) => throw _privateConstructorUsedError;
  DateTime? get modifyTime => throw _privateConstructorUsedError;
  set modifyTime(DateTime? value) => throw _privateConstructorUsedError;
  List<dynamic> get taskContents => throw _privateConstructorUsedError;
  set taskContents(List<dynamic> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoTaskTemplateCopyWith<TodoTaskTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoTaskTemplateCopyWith<$Res> {
  factory $TodoTaskTemplateCopyWith(
          TodoTaskTemplate value, $Res Function(TodoTaskTemplate) then) =
      _$TodoTaskTemplateCopyWithImpl<$Res, TodoTaskTemplate>;
  @useResult
  $Res call(
      {String? docId,
      String? uid,
      String workDate,
      DateTime? createdTime,
      DateTime? modifyTime,
      List<dynamic> taskContents});
}

/// @nodoc
class _$TodoTaskTemplateCopyWithImpl<$Res, $Val extends TodoTaskTemplate>
    implements $TodoTaskTemplateCopyWith<$Res> {
  _$TodoTaskTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = freezed,
    Object? uid = freezed,
    Object? workDate = null,
    Object? createdTime = freezed,
    Object? modifyTime = freezed,
    Object? taskContents = null,
  }) {
    return _then(_value.copyWith(
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      workDate: null == workDate
          ? _value.workDate
          : workDate // ignore: cast_nullable_to_non_nullable
              as String,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifyTime: freezed == modifyTime
          ? _value.modifyTime
          : modifyTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      taskContents: null == taskContents
          ? _value.taskContents
          : taskContents // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoTaskTemplateImplCopyWith<$Res>
    implements $TodoTaskTemplateCopyWith<$Res> {
  factory _$$TodoTaskTemplateImplCopyWith(_$TodoTaskTemplateImpl value,
          $Res Function(_$TodoTaskTemplateImpl) then) =
      __$$TodoTaskTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? docId,
      String? uid,
      String workDate,
      DateTime? createdTime,
      DateTime? modifyTime,
      List<dynamic> taskContents});
}

/// @nodoc
class __$$TodoTaskTemplateImplCopyWithImpl<$Res>
    extends _$TodoTaskTemplateCopyWithImpl<$Res, _$TodoTaskTemplateImpl>
    implements _$$TodoTaskTemplateImplCopyWith<$Res> {
  __$$TodoTaskTemplateImplCopyWithImpl(_$TodoTaskTemplateImpl _value,
      $Res Function(_$TodoTaskTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = freezed,
    Object? uid = freezed,
    Object? workDate = null,
    Object? createdTime = freezed,
    Object? modifyTime = freezed,
    Object? taskContents = null,
  }) {
    return _then(_$TodoTaskTemplateImpl(
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      workDate: null == workDate
          ? _value.workDate
          : workDate // ignore: cast_nullable_to_non_nullable
              as String,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifyTime: freezed == modifyTime
          ? _value.modifyTime
          : modifyTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      taskContents: null == taskContents
          ? _value.taskContents
          : taskContents // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoTaskTemplateImpl extends _TodoTaskTemplate {
  _$TodoTaskTemplateImpl(
      {this.docId,
      this.uid,
      required this.workDate,
      this.createdTime,
      this.modifyTime,
      required this.taskContents})
      : super._();

  factory _$TodoTaskTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoTaskTemplateImplFromJson(json);

  @override
  String? docId;
  @override
  String? uid;
  @override
  String workDate;
  @override
  DateTime? createdTime;
  @override
  DateTime? modifyTime;
  @override
  List<dynamic> taskContents;

  @override
  String toString() {
    return 'TodoTaskTemplate(docId: $docId, uid: $uid, workDate: $workDate, createdTime: $createdTime, modifyTime: $modifyTime, taskContents: $taskContents)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoTaskTemplateImplCopyWith<_$TodoTaskTemplateImpl> get copyWith =>
      __$$TodoTaskTemplateImplCopyWithImpl<_$TodoTaskTemplateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoTaskTemplateImplToJson(
      this,
    );
  }
}

abstract class _TodoTaskTemplate extends TodoTaskTemplate {
  factory _TodoTaskTemplate(
      {String? docId,
      String? uid,
      required String workDate,
      DateTime? createdTime,
      DateTime? modifyTime,
      required List<dynamic> taskContents}) = _$TodoTaskTemplateImpl;
  _TodoTaskTemplate._() : super._();

  factory _TodoTaskTemplate.fromJson(Map<String, dynamic> json) =
      _$TodoTaskTemplateImpl.fromJson;

  @override
  String? get docId;
  set docId(String? value);
  @override
  String? get uid;
  set uid(String? value);
  @override
  String get workDate;
  set workDate(String value);
  @override
  DateTime? get createdTime;
  set createdTime(DateTime? value);
  @override
  DateTime? get modifyTime;
  set modifyTime(DateTime? value);
  @override
  List<dynamic> get taskContents;
  set taskContents(List<dynamic> value);
  @override
  @JsonKey(ignore: true)
  _$$TodoTaskTemplateImplCopyWith<_$TodoTaskTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
