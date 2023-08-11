// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();

  const factory AppUser({
    required String uid,
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    String? profilePicture,
    @JsonKey(name: 'fcm_token') String? fcmToken,
    String? token,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, Object?> json) => _$AppUserFromJson(json);
}
