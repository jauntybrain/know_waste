// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'recycling_tool.freezed.dart';
part 'recycling_tool.g.dart';

@freezed
class RecyclingTool with _$RecyclingTool {
  const RecyclingTool._();

  const factory RecyclingTool({
    required String uid,
    required String title,
    required String tag,
    required String image,
    required String icon,
    required String about,
    String? route,
    String? buttonText,
  }) = _RecyclingTool;

  factory RecyclingTool.fromJson(Map<String, Object?> json) => _$RecyclingToolFromJson(json);
}
