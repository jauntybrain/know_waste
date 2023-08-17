// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyzed_waste.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnalyzedWaste _$$_AnalyzedWasteFromJson(Map<String, dynamic> json) =>
    _$_AnalyzedWaste(
      uid: json['uid'] as String,
      labels:
          (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
      objects:
          (json['objects'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String?,
      advice: json['advice'] as String?,
      tips: json['tips'] as String?,
      name: json['name'] as String?,
      material: json['material'] as String?,
      recyclable: json['recyclable'] as bool? ?? false,
      date: dateTimeFromTimestamp(json['date'] as Timestamp?),
    );

Map<String, dynamic> _$$_AnalyzedWasteToJson(_$_AnalyzedWaste instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'labels': instance.labels,
      'objects': instance.objects,
      'imageUrl': instance.imageUrl,
      'advice': instance.advice,
      'tips': instance.tips,
      'name': instance.name,
      'material': instance.material,
      'recyclable': instance.recyclable,
      'date': instance.date?.toIso8601String(),
    };
