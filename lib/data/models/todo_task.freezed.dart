// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoTask _$TodoTaskFromJson(Map<String, dynamic> json) {
  return _TodoTask.fromJson(json);
}

/// @nodoc
mixin _$TodoTask {
  int? get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError; // 날짜
  int get hour => throw _privateConstructorUsedError; // 시간 (0-23)
  String get title => throw _privateConstructorUsedError; // 제목
  TaskType get taskType => throw _privateConstructorUsedError; // 태스크 타입
  bool get isCompleted => throw _privateConstructorUsedError; // 완료 여부
  String? get alternativeActivity =>
      throw _privateConstructorUsedError; // 대체 활동 (완료하지 않았을 때)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoTaskCopyWith<TodoTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoTaskCopyWith<$Res> {
  factory $TodoTaskCopyWith(TodoTask value, $Res Function(TodoTask) then) =
      _$TodoTaskCopyWithImpl<$Res, TodoTask>;
  @useResult
  $Res call(
      {int? id,
      DateTime date,
      int hour,
      String title,
      TaskType taskType,
      bool isCompleted,
      String? alternativeActivity,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$TodoTaskCopyWithImpl<$Res, $Val extends TodoTask>
    implements $TodoTaskCopyWith<$Res> {
  _$TodoTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = null,
    Object? hour = null,
    Object? title = null,
    Object? taskType = null,
    Object? isCompleted = null,
    Object? alternativeActivity = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      taskType: null == taskType
          ? _value.taskType
          : taskType // ignore: cast_nullable_to_non_nullable
              as TaskType,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      alternativeActivity: freezed == alternativeActivity
          ? _value.alternativeActivity
          : alternativeActivity // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoTaskImplCopyWith<$Res>
    implements $TodoTaskCopyWith<$Res> {
  factory _$$TodoTaskImplCopyWith(
          _$TodoTaskImpl value, $Res Function(_$TodoTaskImpl) then) =
      __$$TodoTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      DateTime date,
      int hour,
      String title,
      TaskType taskType,
      bool isCompleted,
      String? alternativeActivity,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$TodoTaskImplCopyWithImpl<$Res>
    extends _$TodoTaskCopyWithImpl<$Res, _$TodoTaskImpl>
    implements _$$TodoTaskImplCopyWith<$Res> {
  __$$TodoTaskImplCopyWithImpl(
      _$TodoTaskImpl _value, $Res Function(_$TodoTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = null,
    Object? hour = null,
    Object? title = null,
    Object? taskType = null,
    Object? isCompleted = null,
    Object? alternativeActivity = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TodoTaskImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      taskType: null == taskType
          ? _value.taskType
          : taskType // ignore: cast_nullable_to_non_nullable
              as TaskType,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      alternativeActivity: freezed == alternativeActivity
          ? _value.alternativeActivity
          : alternativeActivity // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoTaskImpl implements _TodoTask {
  const _$TodoTaskImpl(
      {this.id,
      required this.date,
      required this.hour,
      required this.title,
      required this.taskType,
      this.isCompleted = false,
      this.alternativeActivity,
      this.createdAt,
      this.updatedAt});

  factory _$TodoTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoTaskImplFromJson(json);

  @override
  final int? id;
  @override
  final DateTime date;
// 날짜
  @override
  final int hour;
// 시간 (0-23)
  @override
  final String title;
// 제목
  @override
  final TaskType taskType;
// 태스크 타입
  @override
  @JsonKey()
  final bool isCompleted;
// 완료 여부
  @override
  final String? alternativeActivity;
// 대체 활동 (완료하지 않았을 때)
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'TodoTask(id: $id, date: $date, hour: $hour, title: $title, taskType: $taskType, isCompleted: $isCompleted, alternativeActivity: $alternativeActivity, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoTaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.taskType, taskType) ||
                other.taskType == taskType) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.alternativeActivity, alternativeActivity) ||
                other.alternativeActivity == alternativeActivity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, hour, title, taskType,
      isCompleted, alternativeActivity, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoTaskImplCopyWith<_$TodoTaskImpl> get copyWith =>
      __$$TodoTaskImplCopyWithImpl<_$TodoTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoTaskImplToJson(
      this,
    );
  }
}

abstract class _TodoTask implements TodoTask {
  const factory _TodoTask(
      {final int? id,
      required final DateTime date,
      required final int hour,
      required final String title,
      required final TaskType taskType,
      final bool isCompleted,
      final String? alternativeActivity,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$TodoTaskImpl;

  factory _TodoTask.fromJson(Map<String, dynamic> json) =
      _$TodoTaskImpl.fromJson;

  @override
  int? get id;
  @override
  DateTime get date;
  @override // 날짜
  int get hour;
  @override // 시간 (0-23)
  String get title;
  @override // 제목
  TaskType get taskType;
  @override // 태스크 타입
  bool get isCompleted;
  @override // 완료 여부
  String? get alternativeActivity;
  @override // 대체 활동 (완료하지 않았을 때)
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TodoTaskImplCopyWith<_$TodoTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
