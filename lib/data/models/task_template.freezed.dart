// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskTemplate _$TaskTemplateFromJson(Map<String, dynamic> json) {
  return _TaskTemplate.fromJson(json);
}

/// @nodoc
mixin _$TaskTemplate {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError; // 템플릿 이름
  List<TodoTask> get tasks => throw _privateConstructorUsedError; // 24시간 태스크 목록
  bool get isDefault => throw _privateConstructorUsedError; // 기본 템플릿 여부
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskTemplateCopyWith<TaskTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskTemplateCopyWith<$Res> {
  factory $TaskTemplateCopyWith(
          TaskTemplate value, $Res Function(TaskTemplate) then) =
      _$TaskTemplateCopyWithImpl<$Res, TaskTemplate>;
  @useResult
  $Res call(
      {int? id,
      String name,
      List<TodoTask> tasks,
      bool isDefault,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$TaskTemplateCopyWithImpl<$Res, $Val extends TaskTemplate>
    implements $TaskTemplateCopyWith<$Res> {
  _$TaskTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? tasks = null,
    Object? isDefault = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TodoTask>,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$TaskTemplateImplCopyWith<$Res>
    implements $TaskTemplateCopyWith<$Res> {
  factory _$$TaskTemplateImplCopyWith(
          _$TaskTemplateImpl value, $Res Function(_$TaskTemplateImpl) then) =
      __$$TaskTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      List<TodoTask> tasks,
      bool isDefault,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$TaskTemplateImplCopyWithImpl<$Res>
    extends _$TaskTemplateCopyWithImpl<$Res, _$TaskTemplateImpl>
    implements _$$TaskTemplateImplCopyWith<$Res> {
  __$$TaskTemplateImplCopyWithImpl(
      _$TaskTemplateImpl _value, $Res Function(_$TaskTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? tasks = null,
    Object? isDefault = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TaskTemplateImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TodoTask>,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$TaskTemplateImpl implements _TaskTemplate {
  const _$TaskTemplateImpl(
      {this.id,
      required this.name,
      required final List<TodoTask> tasks,
      this.isDefault = false,
      this.createdAt,
      this.updatedAt})
      : _tasks = tasks;

  factory _$TaskTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskTemplateImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
// 템플릿 이름
  final List<TodoTask> _tasks;
// 템플릿 이름
  @override
  List<TodoTask> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

// 24시간 태스크 목록
  @override
  @JsonKey()
  final bool isDefault;
// 기본 템플릿 여부
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'TaskTemplate(id: $id, name: $name, tasks: $tasks, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_tasks),
      isDefault,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskTemplateImplCopyWith<_$TaskTemplateImpl> get copyWith =>
      __$$TaskTemplateImplCopyWithImpl<_$TaskTemplateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskTemplateImplToJson(
      this,
    );
  }
}

abstract class _TaskTemplate implements TaskTemplate {
  const factory _TaskTemplate(
      {final int? id,
      required final String name,
      required final List<TodoTask> tasks,
      final bool isDefault,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$TaskTemplateImpl;

  factory _TaskTemplate.fromJson(Map<String, dynamic> json) =
      _$TaskTemplateImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override // 템플릿 이름
  List<TodoTask> get tasks;
  @override // 24시간 태스크 목록
  bool get isDefault;
  @override // 기본 템플릿 여부
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TaskTemplateImplCopyWith<_$TaskTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
