// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChallengeStats _$ChallengeStatsFromJson(Map<String, dynamic> json) {
  return _ChallengeStats.fromJson(json);
}

/// @nodoc
mixin _$ChallengeStats {
  String get challengeID => throw _privateConstructorUsedError;
  String get userID => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
  DateTime? get dateJoined => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChallengeStatsCopyWith<ChallengeStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeStatsCopyWith<$Res> {
  factory $ChallengeStatsCopyWith(
          ChallengeStats value, $Res Function(ChallengeStats) then) =
      _$ChallengeStatsCopyWithImpl<$Res, ChallengeStats>;
  @useResult
  $Res call(
      {String challengeID,
      String userID,
      int progress,
      @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
      DateTime? dateJoined});
}

/// @nodoc
class _$ChallengeStatsCopyWithImpl<$Res, $Val extends ChallengeStats>
    implements $ChallengeStatsCopyWith<$Res> {
  _$ChallengeStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeID = null,
    Object? userID = null,
    Object? progress = null,
    Object? dateJoined = freezed,
  }) {
    return _then(_value.copyWith(
      challengeID: null == challengeID
          ? _value.challengeID
          : challengeID // ignore: cast_nullable_to_non_nullable
              as String,
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      dateJoined: freezed == dateJoined
          ? _value.dateJoined
          : dateJoined // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChallengeStatsCopyWith<$Res>
    implements $ChallengeStatsCopyWith<$Res> {
  factory _$$_ChallengeStatsCopyWith(
          _$_ChallengeStats value, $Res Function(_$_ChallengeStats) then) =
      __$$_ChallengeStatsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String challengeID,
      String userID,
      int progress,
      @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
      DateTime? dateJoined});
}

/// @nodoc
class __$$_ChallengeStatsCopyWithImpl<$Res>
    extends _$ChallengeStatsCopyWithImpl<$Res, _$_ChallengeStats>
    implements _$$_ChallengeStatsCopyWith<$Res> {
  __$$_ChallengeStatsCopyWithImpl(
      _$_ChallengeStats _value, $Res Function(_$_ChallengeStats) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeID = null,
    Object? userID = null,
    Object? progress = null,
    Object? dateJoined = freezed,
  }) {
    return _then(_$_ChallengeStats(
      challengeID: null == challengeID
          ? _value.challengeID
          : challengeID // ignore: cast_nullable_to_non_nullable
              as String,
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      dateJoined: freezed == dateJoined
          ? _value.dateJoined
          : dateJoined // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChallengeStats extends _ChallengeStats {
  const _$_ChallengeStats(
      {required this.challengeID,
      required this.userID,
      required this.progress,
      @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
      this.dateJoined})
      : super._();

  factory _$_ChallengeStats.fromJson(Map<String, dynamic> json) =>
      _$$_ChallengeStatsFromJson(json);

  @override
  final String challengeID;
  @override
  final String userID;
  @override
  final int progress;
  @override
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
  final DateTime? dateJoined;

  @override
  String toString() {
    return 'ChallengeStats(challengeID: $challengeID, userID: $userID, progress: $progress, dateJoined: $dateJoined)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChallengeStats &&
            (identical(other.challengeID, challengeID) ||
                other.challengeID == challengeID) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.dateJoined, dateJoined) ||
                other.dateJoined == dateJoined));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, challengeID, userID, progress, dateJoined);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChallengeStatsCopyWith<_$_ChallengeStats> get copyWith =>
      __$$_ChallengeStatsCopyWithImpl<_$_ChallengeStats>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChallengeStatsToJson(
      this,
    );
  }
}

abstract class _ChallengeStats extends ChallengeStats {
  const factory _ChallengeStats(
      {required final String challengeID,
      required final String userID,
      required final int progress,
      @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
      final DateTime? dateJoined}) = _$_ChallengeStats;
  const _ChallengeStats._() : super._();

  factory _ChallengeStats.fromJson(Map<String, dynamic> json) =
      _$_ChallengeStats.fromJson;

  @override
  String get challengeID;
  @override
  String get userID;
  @override
  int get progress;
  @override
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
  DateTime? get dateJoined;
  @override
  @JsonKey(ignore: true)
  _$$_ChallengeStatsCopyWith<_$_ChallengeStats> get copyWith =>
      throw _privateConstructorUsedError;
}
