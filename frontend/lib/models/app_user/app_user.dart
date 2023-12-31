// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../user_stats/user_stats.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();

  const factory AppUser({
    required String uid,
    @JsonKey(includeToJson: false) UserStats? stats,
    String? email,
    String? username,
    String? name,
    String? phoneNumber,
    String? profilePicture,
    @Default(true) bool isAnonymous,
    @Default([]) List<String> bookmarks,
    @JsonKey(name: 'fcm_token') String? fcmToken,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, Object?> json) => _$AppUserFromJson(json);
}
