// ignore_for_file: non_constant_identifier_names

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recycling_tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RecyclingTool _$$_RecyclingToolFromJson(Map<String, dynamic> json) =>
    _$_RecyclingTool(
      uid: json['uid'] as String,
      title: json['title'] as String,
      tag: json['tag'] as String,
      image: json['image'] as String,
      icon: json['icon'] as String,
      about: json['about'] as String,
      route: json['route'] as String?,
      buttonText: json['buttonText'] as String?,
    );

Map<String, dynamic> _$$_RecyclingToolToJson(_$_RecyclingTool instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'tag': instance.tag,
      'image': instance.image,
      'icon': instance.icon,
      'about': instance.about,
      'route': instance.route,
      'buttonText': instance.buttonText,
    };
