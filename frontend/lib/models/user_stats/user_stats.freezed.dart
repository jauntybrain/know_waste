// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserStats _$UserStatsFromJson(Map<String, dynamic> json) {
  return _UserStats.fromJson(json);
}

/// @nodoc
mixin _$UserStats {
  int get total => throw _privateConstructorUsedError;
  int get plastic => throw _privateConstructorUsedError;
  int get glass => throw _privateConstructorUsedError;
  int get electronics => throw _privateConstructorUsedError;
  int get paper => throw _privateConstructorUsedError;
  int get other => throw _privateConstructorUsedError;
  double get rank => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserStatsCopyWith<UserStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsCopyWith<$Res> {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) then) =
      _$UserStatsCopyWithImpl<$Res, UserStats>;
  @useResult
  $Res call(
      {int total,
      int plastic,
      int glass,
      int electronics,
      int paper,
      int other,
      double rank});
}

/// @nodoc
class _$UserStatsCopyWithImpl<$Res, $Val extends UserStats>
    implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? plastic = null,
    Object? glass = null,
    Object? electronics = null,
    Object? paper = null,
    Object? other = null,
    Object? rank = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      plastic: null == plastic
          ? _value.plastic
          : plastic // ignore: cast_nullable_to_non_nullable
              as int,
      glass: null == glass
          ? _value.glass
          : glass // ignore: cast_nullable_to_non_nullable
              as int,
      electronics: null == electronics
          ? _value.electronics
          : electronics // ignore: cast_nullable_to_non_nullable
              as int,
      paper: null == paper
          ? _value.paper
          : paper // ignore: cast_nullable_to_non_nullable
              as int,
      other: null == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as int,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserStatsCopyWith<$Res> implements $UserStatsCopyWith<$Res> {
  factory _$$_UserStatsCopyWith(
          _$_UserStats value, $Res Function(_$_UserStats) then) =
      __$$_UserStatsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int total,
      int plastic,
      int glass,
      int electronics,
      int paper,
      int other,
      double rank});
}

/// @nodoc
class __$$_UserStatsCopyWithImpl<$Res>
    extends _$UserStatsCopyWithImpl<$Res, _$_UserStats>
    implements _$$_UserStatsCopyWith<$Res> {
  __$$_UserStatsCopyWithImpl(
      _$_UserStats _value, $Res Function(_$_UserStats) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? plastic = null,
    Object? glass = null,
    Object? electronics = null,
    Object? paper = null,
    Object? other = null,
    Object? rank = null,
  }) {
    return _then(_$_UserStats(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      plastic: null == plastic
          ? _value.plastic
          : plastic // ignore: cast_nullable_to_non_nullable
              as int,
      glass: null == glass
          ? _value.glass
          : glass // ignore: cast_nullable_to_non_nullable
              as int,
      electronics: null == electronics
          ? _value.electronics
          : electronics // ignore: cast_nullable_to_non_nullable
              as int,
      paper: null == paper
          ? _value.paper
          : paper // ignore: cast_nullable_to_non_nullable
              as int,
      other: null == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as int,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserStats extends _UserStats {
  const _$_UserStats(
      {this.total = 0,
      this.plastic = 0,
      this.glass = 0,
      this.electronics = 0,
      this.paper = 0,
      this.other = 0,
      this.rank = 100})
      : super._();

  factory _$_UserStats.fromJson(Map<String, dynamic> json) =>
      _$$_UserStatsFromJson(json);

  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final int plastic;
  @override
  @JsonKey()
  final int glass;
  @override
  @JsonKey()
  final int electronics;
  @override
  @JsonKey()
  final int paper;
  @override
  @JsonKey()
  final int other;
  @override
  @JsonKey()
  final double rank;

  @override
  String toString() {
    return 'UserStats(total: $total, plastic: $plastic, glass: $glass, electronics: $electronics, paper: $paper, other: $other, rank: $rank)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserStats &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.plastic, plastic) || other.plastic == plastic) &&
            (identical(other.glass, glass) || other.glass == glass) &&
            (identical(other.electronics, electronics) ||
                other.electronics == electronics) &&
            (identical(other.paper, paper) || other.paper == paper) &&
            (identical(other.other, this.other) || other.other == this.other) &&
            (identical(other.rank, rank) || other.rank == rank));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, total, plastic, glass, electronics, paper, other, rank);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserStatsCopyWith<_$_UserStats> get copyWith =>
      __$$_UserStatsCopyWithImpl<_$_UserStats>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserStatsToJson(
      this,
    );
  }
}

abstract class _UserStats extends UserStats {
  const factory _UserStats(
      {final int total,
      final int plastic,
      final int glass,
      final int electronics,
      final int paper,
      final int other,
      final double rank}) = _$_UserStats;
  const _UserStats._() : super._();

  factory _UserStats.fromJson(Map<String, dynamic> json) =
      _$_UserStats.fromJson;

  @override
  int get total;
  @override
  int get plastic;
  @override
  int get glass;
  @override
  int get electronics;
  @override
  int get paper;
  @override
  int get other;
  @override
  double get rank;
  @override
  @JsonKey(ignore: true)
  _$$_UserStatsCopyWith<_$_UserStats> get copyWith =>
      throw _privateConstructorUsedError;
}
