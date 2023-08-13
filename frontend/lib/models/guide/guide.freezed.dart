// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guide.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Guide _$GuideFromJson(Map<String, dynamic> json) {
  return _Guide.fromJson(json);
}

/// @nodoc
mixin _$Guide {
  String get uid => throw _privateConstructorUsedError;
  String get material => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get iconUrl => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GuideCopyWith<Guide> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuideCopyWith<$Res> {
  factory $GuideCopyWith(Guide value, $Res Function(Guide) then) =
      _$GuideCopyWithImpl<$Res, Guide>;
  @useResult
  $Res call(
      {String uid,
      String material,
      String imageUrl,
      String iconUrl,
      String color,
      String content});
}

/// @nodoc
class _$GuideCopyWithImpl<$Res, $Val extends Guide>
    implements $GuideCopyWith<$Res> {
  _$GuideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? material = null,
    Object? imageUrl = null,
    Object? iconUrl = null,
    Object? color = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      material: null == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GuideCopyWith<$Res> implements $GuideCopyWith<$Res> {
  factory _$$_GuideCopyWith(_$_Guide value, $Res Function(_$_Guide) then) =
      __$$_GuideCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String material,
      String imageUrl,
      String iconUrl,
      String color,
      String content});
}

/// @nodoc
class __$$_GuideCopyWithImpl<$Res> extends _$GuideCopyWithImpl<$Res, _$_Guide>
    implements _$$_GuideCopyWith<$Res> {
  __$$_GuideCopyWithImpl(_$_Guide _value, $Res Function(_$_Guide) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? material = null,
    Object? imageUrl = null,
    Object? iconUrl = null,
    Object? color = null,
    Object? content = null,
  }) {
    return _then(_$_Guide(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      material: null == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Guide extends _Guide {
  const _$_Guide(
      {required this.uid,
      required this.material,
      required this.imageUrl,
      required this.iconUrl,
      required this.color,
      required this.content})
      : super._();

  factory _$_Guide.fromJson(Map<String, dynamic> json) =>
      _$$_GuideFromJson(json);

  @override
  final String uid;
  @override
  final String material;
  @override
  final String imageUrl;
  @override
  final String iconUrl;
  @override
  final String color;
  @override
  final String content;

  @override
  String toString() {
    return 'Guide(uid: $uid, material: $material, imageUrl: $imageUrl, iconUrl: $iconUrl, color: $color, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Guide &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.material, material) ||
                other.material == material) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, uid, material, imageUrl, iconUrl, color, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GuideCopyWith<_$_Guide> get copyWith =>
      __$$_GuideCopyWithImpl<_$_Guide>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GuideToJson(
      this,
    );
  }
}

abstract class _Guide extends Guide {
  const factory _Guide(
      {required final String uid,
      required final String material,
      required final String imageUrl,
      required final String iconUrl,
      required final String color,
      required final String content}) = _$_Guide;
  const _Guide._() : super._();

  factory _Guide.fromJson(Map<String, dynamic> json) = _$_Guide.fromJson;

  @override
  String get uid;
  @override
  String get material;
  @override
  String get imageUrl;
  @override
  String get iconUrl;
  @override
  String get color;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$_GuideCopyWith<_$_Guide> get copyWith =>
      throw _privateConstructorUsedError;
}
