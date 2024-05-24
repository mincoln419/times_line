// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DiaryContent _$DiaryContentFromJson(Map<String, dynamic> json) {
  return _DiaryContent.fromJson(json);
}

/// @nodoc
mixin _$DiaryContent {
  String get uid => throw _privateConstructorUsedError;
  set uid(String value) => throw _privateConstructorUsedError;
  String get contents => throw _privateConstructorUsedError;
  set contents(String value) => throw _privateConstructorUsedError;
  DiaryType get diaryType => throw _privateConstructorUsedError;
  set diaryType(DiaryType value) => throw _privateConstructorUsedError;
  String get workDate => throw _privateConstructorUsedError;
  set workDate(String value) => throw _privateConstructorUsedError;
  DateTime? get createTime => throw _privateConstructorUsedError;
  set createTime(DateTime? value) => throw _privateConstructorUsedError;
  DateTime? get modifyTime => throw _privateConstructorUsedError;
  set modifyTime(DateTime? value) => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  set sortOrder(int value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryContentCopyWith<DiaryContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryContentCopyWith<$Res> {
  factory $DiaryContentCopyWith(
          DiaryContent value, $Res Function(DiaryContent) then) =
      _$DiaryContentCopyWithImpl<$Res, DiaryContent>;
  @useResult
  $Res call(
      {String uid,
      String contents,
      DiaryType diaryType,
      String workDate,
      DateTime? createTime,
      DateTime? modifyTime,
      int sortOrder});
}

/// @nodoc
class _$DiaryContentCopyWithImpl<$Res, $Val extends DiaryContent>
    implements $DiaryContentCopyWith<$Res> {
  _$DiaryContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? contents = null,
    Object? diaryType = null,
    Object? workDate = null,
    Object? createTime = freezed,
    Object? modifyTime = freezed,
    Object? sortOrder = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
      diaryType: null == diaryType
          ? _value.diaryType
          : diaryType // ignore: cast_nullable_to_non_nullable
              as DiaryType,
      workDate: null == workDate
          ? _value.workDate
          : workDate // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifyTime: freezed == modifyTime
          ? _value.modifyTime
          : modifyTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiaryContentImplCopyWith<$Res>
    implements $DiaryContentCopyWith<$Res> {
  factory _$$DiaryContentImplCopyWith(
          _$DiaryContentImpl value, $Res Function(_$DiaryContentImpl) then) =
      __$$DiaryContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String contents,
      DiaryType diaryType,
      String workDate,
      DateTime? createTime,
      DateTime? modifyTime,
      int sortOrder});
}

/// @nodoc
class __$$DiaryContentImplCopyWithImpl<$Res>
    extends _$DiaryContentCopyWithImpl<$Res, _$DiaryContentImpl>
    implements _$$DiaryContentImplCopyWith<$Res> {
  __$$DiaryContentImplCopyWithImpl(
      _$DiaryContentImpl _value, $Res Function(_$DiaryContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? contents = null,
    Object? diaryType = null,
    Object? workDate = null,
    Object? createTime = freezed,
    Object? modifyTime = freezed,
    Object? sortOrder = null,
  }) {
    return _then(_$DiaryContentImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
      diaryType: null == diaryType
          ? _value.diaryType
          : diaryType // ignore: cast_nullable_to_non_nullable
              as DiaryType,
      workDate: null == workDate
          ? _value.workDate
          : workDate // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifyTime: freezed == modifyTime
          ? _value.modifyTime
          : modifyTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiaryContentImpl extends _DiaryContent {
  _$DiaryContentImpl(
      {required this.uid,
      required this.contents,
      required this.diaryType,
      required this.workDate,
      this.createTime,
      this.modifyTime,
      required this.sortOrder})
      : super._();

  factory _$DiaryContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryContentImplFromJson(json);

  @override
  String uid;
  @override
  String contents;
  @override
  DiaryType diaryType;
  @override
  String workDate;
  @override
  DateTime? createTime;
  @override
  DateTime? modifyTime;
  @override
  int sortOrder;

  @override
  String toString() {
    return 'DiaryContent(uid: $uid, contents: $contents, diaryType: $diaryType, workDate: $workDate, createTime: $createTime, modifyTime: $modifyTime, sortOrder: $sortOrder)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryContentImplCopyWith<_$DiaryContentImpl> get copyWith =>
      __$$DiaryContentImplCopyWithImpl<_$DiaryContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiaryContentImplToJson(
      this,
    );
  }
}

abstract class _DiaryContent extends DiaryContent {
  factory _DiaryContent(
      {required String uid,
      required String contents,
      required DiaryType diaryType,
      required String workDate,
      DateTime? createTime,
      DateTime? modifyTime,
      required int sortOrder}) = _$DiaryContentImpl;
  _DiaryContent._() : super._();

  factory _DiaryContent.fromJson(Map<String, dynamic> json) =
      _$DiaryContentImpl.fromJson;

  @override
  String get uid;
  set uid(String value);
  @override
  String get contents;
  set contents(String value);
  @override
  DiaryType get diaryType;
  set diaryType(DiaryType value);
  @override
  String get workDate;
  set workDate(String value);
  @override
  DateTime? get createTime;
  set createTime(DateTime? value);
  @override
  DateTime? get modifyTime;
  set modifyTime(DateTime? value);
  @override
  int get sortOrder;
  set sortOrder(int value);
  @override
  @JsonKey(ignore: true)
  _$$DiaryContentImplCopyWith<_$DiaryContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
