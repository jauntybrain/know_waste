// ignore_for_file: non_constant_identifier_names

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      uid: json['uid'] as String,
      stats: json['stats'] == null ? null : UserStats.fromJson(json['stats'] as Map<String, dynamic>),
      email: json['email'] as String?,
      username: json['username'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profilePicture: json['profilePicture'] as String?,
      isAnonymous: json['isAnonymous'] as bool? ?? true,
      bookmarks: (json['bookmarks'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'username': instance.username,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'profilePicture': instance.profilePicture,
      'isAnonymous': instance.isAnonymous,
      'bookmarks': instance.bookmarks,
      'fcm_token': instance.fcmToken,
    };
