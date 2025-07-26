// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoContent _$TodoContentFromJson(Map<String, dynamic> json) {
  return _TodoContent.fromJson(json);
}

/// @nodoc
mixin _$TodoContent {
  String get title => throw _privateConstructorUsedError;
  set title(String value) => throw _privateConstructorUsedError;
  int? get timeline => throw _privateConstructorUsedError;
  set timeline(int? value) => throw _privateConstructorUsedError;
  TaskType get taskType => throw _privateConstructorUsedError;
  set taskType(TaskType value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoContentCopyWith<TodoContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoContentCopyWith<$Res> {
  factory $TodoContentCopyWith(
          TodoContent value, $Res Function(TodoContent) then) =
      _$TodoContentCopyWithImpl<$Res, TodoContent>;
  @useResult
  $Res call({String title, int? timeline, TaskType taskType});
}

/// @nodoc
class _$TodoContentCopyWithImpl<$Res, $Val extends TodoContent>
    implements $TodoContentCopyWith<$Res> {
  _$TodoContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? timeline = freezed,
    Object? taskType = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      timeline: freezed == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as int?,
      taskType: null == taskType
          ? _value.taskType
          : taskType // ignore: cast_nullable_to_non_nullable
              as TaskType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoContentImplCopyWith<$Res>
    implements $TodoContentCopyWith<$Res> {
  factory _$$TodoContentImplCopyWith(
          _$TodoContentImpl value, $Res Function(_$TodoContentImpl) then) =
      __$$TodoContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, int? timeline, TaskType taskType});
}

/// @nodoc
class __$$TodoContentImplCopyWithImpl<$Res>
    extends _$TodoContentCopyWithImpl<$Res, _$TodoContentImpl>
    implements _$$TodoContentImplCopyWith<$Res> {
  __$$TodoContentImplCopyWithImpl(
      _$TodoContentImpl _value, $Res Function(_$TodoContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? timeline = freezed,
    Object? taskType = null,
  }) {
    return _then(_$TodoContentImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      timeline: freezed == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as int?,
      taskType: null == taskType
          ? _value.taskType
          : taskType // ignore: cast_nullable_to_non_nullable
              as TaskType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoContentImpl extends _TodoContent {
  _$TodoContentImpl(
      {required this.title, this.timeline, required this.taskType})
      : super._();

  factory _$TodoContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoContentImplFromJson(json);

  @override
  String title;
  @override
  int? timeline;
  @override
  TaskType taskType;

  @override
  String toString() {
    return 'TodoContent(title: $title, timeline: $timeline, taskType: $taskType)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoContentImplCopyWith<_$TodoContentImpl> get copyWith =>
      __$$TodoContentImplCopyWithImpl<_$TodoContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoContentImplToJson(
      this,
    );
  }
}

abstract class _TodoContent extends TodoContent {
  factory _TodoContent(
      {required String title,
      int? timeline,
      required TaskType taskType}) = _$TodoContentImpl;
  _TodoContent._() : super._();

  factory _TodoContent.fromJson(Map<String, dynamic> json) =
      _$TodoContentImpl.fromJson;

  @override
  String get title;
  set title(String value);
  @override
  int? get timeline;
  set timeline(int? value);
  @override
  TaskType get taskType;
  set taskType(TaskType value);
  @override
  @JsonKey(ignore: true)
  _$$TodoContentImplCopyWith<_$TodoContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
