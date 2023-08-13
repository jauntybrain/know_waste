// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'guide.freezed.dart';
part 'guide.g.dart';

@freezed
class Guide with _$Guide {
  const Guide._();

  const factory Guide({
    required String uid,
    required String material,
    required String imageUrl,
    required String iconUrl,
    required String color,
    required String content,
  }) = _Guide;

  factory Guide.fromJson(Map<String, Object?> json) => _$GuideFromJson(json);
}
