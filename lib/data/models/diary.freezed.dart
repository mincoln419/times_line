// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Diary _$DiaryFromJson(Map<String, dynamic> json) {
  return _Diary.fromJson(json);
}

/// @nodoc
mixin _$Diary {
  int? get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError; // 날짜
  String get feeling => throw _privateConstructorUsedError; // 느낀점
  String get regret => throw _privateConstructorUsedError; // 후회하는 점
  String get resolution => throw _privateConstructorUsedError; // 각오
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryCopyWith<Diary> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryCopyWith<$Res> {
  factory $DiaryCopyWith(Diary value, $Res Function(Diary) then) =
      _$DiaryCopyWithImpl<$Res, Diary>;
  @useResult
  $Res call(
      {int? id,
      DateTime date,
      String feeling,
      String regret,
      String resolution,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$DiaryCopyWithImpl<$Res, $Val extends Diary>
    implements $DiaryCopyWith<$Res> {
  _$DiaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = null,
    Object? feeling = null,
    Object? regret = null,
    Object? resolution = null,
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
      feeling: null == feeling
          ? _value.feeling
          : feeling // ignore: cast_nullable_to_non_nullable
              as String,
      regret: null == regret
          ? _value.regret
          : regret // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$DiaryImplCopyWith<$Res> implements $DiaryCopyWith<$Res> {
  factory _$$DiaryImplCopyWith(
          _$DiaryImpl value, $Res Function(_$DiaryImpl) then) =
      __$$DiaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      DateTime date,
      String feeling,
      String regret,
      String resolution,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$DiaryImplCopyWithImpl<$Res>
    extends _$DiaryCopyWithImpl<$Res, _$DiaryImpl>
    implements _$$DiaryImplCopyWith<$Res> {
  __$$DiaryImplCopyWithImpl(
      _$DiaryImpl _value, $Res Function(_$DiaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = null,
    Object? feeling = null,
    Object? regret = null,
    Object? resolution = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DiaryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      feeling: null == feeling
          ? _value.feeling
          : feeling // ignore: cast_nullable_to_non_nullable
              as String,
      regret: null == regret
          ? _value.regret
          : regret // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$DiaryImpl implements _Diary {
  const _$DiaryImpl(
      {this.id,
      required this.date,
      required this.feeling,
      required this.regret,
      required this.resolution,
      this.createdAt,
      this.updatedAt});

  factory _$DiaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryImplFromJson(json);

  @override
  final int? id;
  @override
  final DateTime date;
// 날짜
  @override
  final String feeling;
// 느낀점
  @override
  final String regret;
// 후회하는 점
  @override
  final String resolution;
// 각오
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Diary(id: $id, date: $date, feeling: $feeling, regret: $regret, resolution: $resolution, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.feeling, feeling) || other.feeling == feeling) &&
            (identical(other.regret, regret) || other.regret == regret) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, date, feeling, regret, resolution, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryImplCopyWith<_$DiaryImpl> get copyWith =>
      __$$DiaryImplCopyWithImpl<_$DiaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiaryImplToJson(
      this,
    );
  }
}

abstract class _Diary implements Diary {
  const factory _Diary(
      {final int? id,
      required final DateTime date,
      required final String feeling,
      required final String regret,
      required final String resolution,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$DiaryImpl;

  factory _Diary.fromJson(Map<String, dynamic> json) = _$DiaryImpl.fromJson;

  @override
  int? get id;
  @override
  DateTime get date;
  @override // 날짜
  String get feeling;
  @override // 느낀점
  String get regret;
  @override // 후회하는 점
  String get resolution;
  @override // 각오
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DiaryImplCopyWith<_$DiaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
