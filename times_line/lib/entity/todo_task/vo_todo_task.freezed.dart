// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vo_todo_task.dart';

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
  String? get docId => throw _privateConstructorUsedError;
  set docId(String? value) => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  set uid(String value) => throw _privateConstructorUsedError;
  String get workDate => throw _privateConstructorUsedError;
  set workDate(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_time')
  DateTime? get createdTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_time')
  set createdTime(DateTime? value) => throw _privateConstructorUsedError;
  DateTime? get modifyTime => throw _privateConstructorUsedError;
  set modifyTime(DateTime? value) => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  set title(String value) => throw _privateConstructorUsedError;
  int? get timeline => throw _privateConstructorUsedError;
  set timeline(int? value) => throw _privateConstructorUsedError;
  TaskType get taskType => throw _privateConstructorUsedError;
  set taskType(TaskType value) => throw _privateConstructorUsedError;
  TodoTaskStatus get todoTaskStatus => throw _privateConstructorUsedError;
  set todoTaskStatus(TodoTaskStatus value) =>
      throw _privateConstructorUsedError;

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
      {String? docId,
      String uid,
      String workDate,
      @JsonKey(name: 'created_time') DateTime? createdTime,
      DateTime? modifyTime,
      String title,
      int? timeline,
      TaskType taskType,
      TodoTaskStatus todoTaskStatus});
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
    Object? docId = freezed,
    Object? uid = null,
    Object? workDate = null,
    Object? createdTime = freezed,
    Object? modifyTime = freezed,
    Object? title = null,
    Object? timeline = freezed,
    Object? taskType = null,
    Object? todoTaskStatus = null,
  }) {
    return _then(_value.copyWith(
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
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
      todoTaskStatus: null == todoTaskStatus
          ? _value.todoTaskStatus
          : todoTaskStatus // ignore: cast_nullable_to_non_nullable
              as TodoTaskStatus,
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
      {String? docId,
      String uid,
      String workDate,
      @JsonKey(name: 'created_time') DateTime? createdTime,
      DateTime? modifyTime,
      String title,
      int? timeline,
      TaskType taskType,
      TodoTaskStatus todoTaskStatus});
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
    Object? docId = freezed,
    Object? uid = null,
    Object? workDate = null,
    Object? createdTime = freezed,
    Object? modifyTime = freezed,
    Object? title = null,
    Object? timeline = freezed,
    Object? taskType = null,
    Object? todoTaskStatus = null,
  }) {
    return _then(_$TodoTaskImpl(
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
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
      todoTaskStatus: null == todoTaskStatus
          ? _value.todoTaskStatus
          : todoTaskStatus // ignore: cast_nullable_to_non_nullable
              as TodoTaskStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoTaskImpl extends _TodoTask {
  _$TodoTaskImpl(
      {this.docId,
      required this.uid,
      required this.workDate,
      @JsonKey(name: 'created_time') this.createdTime,
      this.modifyTime,
      required this.title,
      this.timeline,
      required this.taskType,
      this.todoTaskStatus = TodoTaskStatus.not_yet})
      : super._();

  factory _$TodoTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoTaskImplFromJson(json);

  @override
  String? docId;
  @override
  String uid;
  @override
  String workDate;
  @override
  @JsonKey(name: 'created_time')
  DateTime? createdTime;
  @override
  DateTime? modifyTime;
  @override
  String title;
  @override
  int? timeline;
  @override
  TaskType taskType;
  @override
  @JsonKey()
  TodoTaskStatus todoTaskStatus;

  @override
  String toString() {
    return 'TodoTask(docId: $docId, uid: $uid, workDate: $workDate, createdTime: $createdTime, modifyTime: $modifyTime, title: $title, timeline: $timeline, taskType: $taskType, todoTaskStatus: $todoTaskStatus)';
  }

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

abstract class _TodoTask extends TodoTask {
  factory _TodoTask(
      {String? docId,
      required String uid,
      required String workDate,
      @JsonKey(name: 'created_time') DateTime? createdTime,
      DateTime? modifyTime,
      required String title,
      int? timeline,
      required TaskType taskType,
      TodoTaskStatus todoTaskStatus}) = _$TodoTaskImpl;
  _TodoTask._() : super._();

  factory _TodoTask.fromJson(Map<String, dynamic> json) =
      _$TodoTaskImpl.fromJson;

  @override
  String? get docId;
  set docId(String? value);
  @override
  String get uid;
  set uid(String value);
  @override
  String get workDate;
  set workDate(String value);
  @override
  @JsonKey(name: 'created_time')
  DateTime? get createdTime;
  @JsonKey(name: 'created_time')
  set createdTime(DateTime? value);
  @override
  DateTime? get modifyTime;
  set modifyTime(DateTime? value);
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
  TodoTaskStatus get todoTaskStatus;
  set todoTaskStatus(TodoTaskStatus value);
  @override
  @JsonKey(ignore: true)
  _$$TodoTaskImplCopyWith<_$TodoTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
