// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'analyzed_waste.freezed.dart';
part 'analyzed_waste.g.dart';

@freezed
class AnalyzedWaste with _$AnalyzedWaste {
  const AnalyzedWaste._();

  const factory AnalyzedWaste({
    required String uid,
    required List<String> labels,
    required List<String> objects,
    String? imageUrl,
    String? advice,
    String? tips,
    String? name,
    String? material,
    @Default(false) bool? recyclable,
    @JsonKey(fromJson: dateTimeFromTimestamp) DateTime? date,
  }) = _AnalyzedWaste;

  factory AnalyzedWaste.fromJson(Map<String, Object?> json) => _$AnalyzedWasteFromJson(json);
}

DateTime? dateTimeFromTimestamp(Timestamp? timestamp) => timestamp?.toDate();
