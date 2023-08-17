// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_stats.freezed.dart';
part 'challenge_stats.g.dart';

@freezed
class ChallengeStats with _$ChallengeStats {
  const ChallengeStats._();

  const factory ChallengeStats({
    required String userID,
    required int progress,
    @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp) DateTime? dateJoined,
  }) = _ChallengeStats;

  factory ChallengeStats.fromJson(Map<String, Object?> json) => _$ChallengeStatsFromJson(json);
}

DateTime? dateTimeFromTimestamp(dynamic timestamp) => timestamp == null
    ? null
    : timestamp is Timestamp
        ? timestamp.toDate()
        : DateTime.fromMillisecondsSinceEpoch(timestamp);

Timestamp? dateTimeToTimestamp(DateTime? date) => date == null ? null : Timestamp.fromDate(date);
