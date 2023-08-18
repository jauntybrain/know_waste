// ignore_for_file: non_constant_identifier_names

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserStats _$$_UserStatsFromJson(Map<String, dynamic> json) => _$_UserStats(
      total: json['total'] as int? ?? 0,
      plastic: json['plastic'] as int? ?? 0,
      glass: json['glass'] as int? ?? 0,
      electronics: json['electronics'] as int? ?? 0,
      paper: json['paper'] as int? ?? 0,
      other: json['other'] as int? ?? 0,
      rank: (json['rank'] as num?)?.toDouble() ?? 100,
    );

Map<String, dynamic> _$$_UserStatsToJson(_$_UserStats instance) =>
    <String, dynamic>{
      'total': instance.total,
      'plastic': instance.plastic,
      'glass': instance.glass,
      'electronics': instance.electronics,
      'paper': instance.paper,
      'other': instance.other,
      'rank': instance.rank,
    };
