// ignore_for_file: non_constant_identifier_names

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Challenge _$$_ChallengeFromJson(Map<String, dynamic> json) => _$_Challenge(
      uid: json['uid'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      color: json['color'] as String,
      criteria: json['criteria'] as String,
      goal: (json['goal'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      iconUrl: json['iconUrl'] as String,
      tool: json['tool'] as String,
      content: json['content'] as String,
      expires: dateTimeFromTimestamp(json['expires']),
    );

Map<String, dynamic> _$$_ChallengeToJson(_$_Challenge instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'color': instance.color,
      'criteria': instance.criteria,
      'goal': instance.goal,
      'imageUrl': instance.imageUrl,
      'iconUrl': instance.iconUrl,
      'tool': instance.tool,
      'content': instance.content,
      'expires': dateTimeToTimestamp(instance.expires),
    };
