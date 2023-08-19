// ignore_for_file: non_constant_identifier_names

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Article _$$_ArticleFromJson(Map<String, dynamic> json) => _$_Article(
      uid: json['uid'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      imageUrl: json['imageUrl'] as String,
      tag: json['tag'] as String,
      content: json['content'] as String,
      date: dateTimeFromTimestamp(json['date']),
      featured: json['featured'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ArticleToJson(_$_Article instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'summary': instance.summary,
      'imageUrl': instance.imageUrl,
      'tag': instance.tag,
      'content': instance.content,
      'date': dateTimeToTimestamp(instance.date),
      'featured': instance.featured,
    };
