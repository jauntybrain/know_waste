// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats.freezed.dart';
part 'user_stats.g.dart';

@freezed
class UserStats with _$UserStats {
  const UserStats._();

  const factory UserStats({
    @Default(0) int total,
    @Default(0) int plastic,
    @Default(0) int glass,
    @Default(0) int electronics,
    @Default(0) int paper,
    @Default(0) int other,
    @Default(100) double rank,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, Object?> json) => _$UserStatsFromJson(json);
}
