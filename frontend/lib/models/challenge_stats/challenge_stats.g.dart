// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChallengeStats _$$_ChallengeStatsFromJson(Map<String, dynamic> json) =>
    _$_ChallengeStats(
      userID: json['userID'] as String,
      progress: json['progress'] as int,
      dateJoined: dateTimeFromTimestamp(json['dateJoined']),
    );

Map<String, dynamic> _$$_ChallengeStatsToJson(_$_ChallengeStats instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'progress': instance.progress,
      'dateJoined': dateTimeToTimestamp(instance.dateJoined),
    };
