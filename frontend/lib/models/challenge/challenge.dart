// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge.freezed.dart';
part 'challenge.g.dart';

@freezed
class Challenge with _$Challenge {
  const Challenge._();

  const factory Challenge({
    required String uid,
    required String title,
    required String subtitle,
    required String color,
    required String criteria,
    required double goal,
    required String imageUrl,
    required String iconUrl,
    required String tool,
    required String content,
    @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp) DateTime? expires,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, Object?> json) => _$ChallengeFromJson(json);
}

DateTime? dateTimeFromTimestamp(dynamic timestamp) => timestamp == null
    ? null
    : timestamp is Timestamp
        ? timestamp.toDate()
        : DateTime.fromMillisecondsSinceEpoch(timestamp);

Timestamp? dateTimeToTimestamp(DateTime? date) => date == null ? null : Timestamp.fromDate(date);
