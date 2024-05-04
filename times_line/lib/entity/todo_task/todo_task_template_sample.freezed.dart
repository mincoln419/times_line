// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_task_template_sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoTaskTemplateSample _$TodoTaskTemplateSampleFromJson(
    Map<String, dynamic> json) {
  return _TodoTaskTemplateSample.fromJson(json);
}

/// @nodoc
mixin _$TodoTaskTemplateSample {
  String? get docId => throw _privateConstructorUsedError;
  set docId(String? value) => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  set uid(String? value) => throw _privateConstructorUsedError;
  String? get templateName => throw _privateConstructorUsedError;
  set templateName(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdTime')
  DateTime get createdTime => throw _privateConstructorUsedError;
  DateTime? get modifyTime => throw _privateConstructorUsedError;
  set modifyTime(DateTime? value) => throw _privateConstructorUsedError;
  List<dynamic> get taskContents => throw _privateConstructorUsedError;
  set taskContents(List<dynamic> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoTaskTemplateSampleCopyWith<TodoTaskTemplateSample> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoTaskTemplateSampleCopyWith<$Res> {
  factory $TodoTaskTemplateSampleCopyWith(TodoTaskTemplateSample value,
          $Res Function(TodoTaskTemplateSample) then) =
      _$TodoTaskTemplateSampleCopyWithImpl<$Res, TodoTaskTemplateSample>;
  @useResult
  $Res call(
      {String? docId,
      String? uid,
      String? templateName,
      @JsonKey(name: 'createdTime') DateTime createdTime,
      DateTime? modifyTime,
      List<dynamic> taskContents});
}

/// @nodoc
class _$TodoTaskTemplateSampleCopyWithImpl<$Res,
        $Val extends TodoTaskTemplateSample>
    implements $TodoTaskTemplateSampleCopyWith<$Res> {
  _$TodoTaskTemplateSampleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = freezed,
    Object? uid = freezed,
    Object? templateName = freezed,
    Object? createdTime = null,
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
      templateName: freezed == templateName
          ? _value.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
abstract class _$$TodoTaskTemplateSampleImplCopyWith<$Res>
    implements $TodoTaskTemplateSampleCopyWith<$Res> {
  factory _$$TodoTaskTemplateSampleImplCopyWith(
          _$TodoTaskTemplateSampleImpl value,
          $Res Function(_$TodoTaskTemplateSampleImpl) then) =
      __$$TodoTaskTemplateSampleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? docId,
      String? uid,
      String? templateName,
      @JsonKey(name: 'createdTime') DateTime createdTime,
      DateTime? modifyTime,
      List<dynamic> taskContents});
}

/// @nodoc
class __$$TodoTaskTemplateSampleImplCopyWithImpl<$Res>
    extends _$TodoTaskTemplateSampleCopyWithImpl<$Res,
        _$TodoTaskTemplateSampleImpl>
    implements _$$TodoTaskTemplateSampleImplCopyWith<$Res> {
  __$$TodoTaskTemplateSampleImplCopyWithImpl(
      _$TodoTaskTemplateSampleImpl _value,
      $Res Function(_$TodoTaskTemplateSampleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = freezed,
    Object? uid = freezed,
    Object? templateName = freezed,
    Object? createdTime = null,
    Object? modifyTime = freezed,
    Object? taskContents = null,
  }) {
    return _then(_$TodoTaskTemplateSampleImpl(
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      templateName: freezed == templateName
          ? _value.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
class _$TodoTaskTemplateSampleImpl extends _TodoTaskTemplateSample {
  _$TodoTaskTemplateSampleImpl(
      {this.docId,
      this.uid,
      this.templateName,
      @JsonKey(name: 'createdTime') required this.createdTime,
      this.modifyTime,
      required this.taskContents})
      : super._();

  factory _$TodoTaskTemplateSampleImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoTaskTemplateSampleImplFromJson(json);

  @override
  String? docId;
  @override
  String? uid;
  @override
  String? templateName;
  @override
  @JsonKey(name: 'createdTime')
  final DateTime createdTime;
  @override
  DateTime? modifyTime;
  @override
  List<dynamic> taskContents;

  @override
  String toString() {
    return 'TodoTaskTemplateSample(docId: $docId, uid: $uid, templateName: $templateName, createdTime: $createdTime, modifyTime: $modifyTime, taskContents: $taskContents)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoTaskTemplateSampleImplCopyWith<_$TodoTaskTemplateSampleImpl>
      get copyWith => __$$TodoTaskTemplateSampleImplCopyWithImpl<
          _$TodoTaskTemplateSampleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoTaskTemplateSampleImplToJson(
      this,
    );
  }
}

abstract class _TodoTaskTemplateSample extends TodoTaskTemplateSample {
  factory _TodoTaskTemplateSample(
      {String? docId,
      String? uid,
      String? templateName,
      @JsonKey(name: 'createdTime') required final DateTime createdTime,
      DateTime? modifyTime,
      required List<dynamic> taskContents}) = _$TodoTaskTemplateSampleImpl;
  _TodoTaskTemplateSample._() : super._();

  factory _TodoTaskTemplateSample.fromJson(Map<String, dynamic> json) =
      _$TodoTaskTemplateSampleImpl.fromJson;

  @override
  String? get docId;
  set docId(String? value);
  @override
  String? get uid;
  set uid(String? value);
  @override
  String? get templateName;
  set templateName(String? value);
  @override
  @JsonKey(name: 'createdTime')
  DateTime get createdTime;
  @override
  DateTime? get modifyTime;
  set modifyTime(DateTime? value);
  @override
  List<dynamic> get taskContents;
  set taskContents(List<dynamic> value);
  @override
  @JsonKey(ignore: true)
  _$$TodoTaskTemplateSampleImplCopyWith<_$TodoTaskTemplateSampleImpl>
      get copyWith => throw _privateConstructorUsedError;
}
