// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recycling_tool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RecyclingTool _$RecyclingToolFromJson(Map<String, dynamic> json) {
  return _RecyclingTool.fromJson(json);
}

/// @nodoc
mixin _$RecyclingTool {
  String get uid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get tag => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get about => throw _privateConstructorUsedError;
  String? get route => throw _privateConstructorUsedError;
  String? get buttonText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecyclingToolCopyWith<RecyclingTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecyclingToolCopyWith<$Res> {
  factory $RecyclingToolCopyWith(
          RecyclingTool value, $Res Function(RecyclingTool) then) =
      _$RecyclingToolCopyWithImpl<$Res, RecyclingTool>;
  @useResult
  $Res call(
      {String uid,
      String title,
      String tag,
      String image,
      String icon,
      String about,
      String? route,
      String? buttonText});
}

/// @nodoc
class _$RecyclingToolCopyWithImpl<$Res, $Val extends RecyclingTool>
    implements $RecyclingToolCopyWith<$Res> {
  _$RecyclingToolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? title = null,
    Object? tag = null,
    Object? image = null,
    Object? icon = null,
    Object? about = null,
    Object? route = freezed,
    Object? buttonText = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      about: null == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String,
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      buttonText: freezed == buttonText
          ? _value.buttonText
          : buttonText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecyclingToolCopyWith<$Res>
    implements $RecyclingToolCopyWith<$Res> {
  factory _$$_RecyclingToolCopyWith(
          _$_RecyclingTool value, $Res Function(_$_RecyclingTool) then) =
      __$$_RecyclingToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String title,
      String tag,
      String image,
      String icon,
      String about,
      String? route,
      String? buttonText});
}

/// @nodoc
class __$$_RecyclingToolCopyWithImpl<$Res>
    extends _$RecyclingToolCopyWithImpl<$Res, _$_RecyclingTool>
    implements _$$_RecyclingToolCopyWith<$Res> {
  __$$_RecyclingToolCopyWithImpl(
      _$_RecyclingTool _value, $Res Function(_$_RecyclingTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? title = null,
    Object? tag = null,
    Object? image = null,
    Object? icon = null,
    Object? about = null,
    Object? route = freezed,
    Object? buttonText = freezed,
  }) {
    return _then(_$_RecyclingTool(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      about: null == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String,
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      buttonText: freezed == buttonText
          ? _value.buttonText
          : buttonText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RecyclingTool extends _RecyclingTool {
  const _$_RecyclingTool(
      {required this.uid,
      required this.title,
      required this.tag,
      required this.image,
      required this.icon,
      required this.about,
      this.route,
      this.buttonText})
      : super._();

  factory _$_RecyclingTool.fromJson(Map<String, dynamic> json) =>
      _$$_RecyclingToolFromJson(json);

  @override
  final String uid;
  @override
  final String title;
  @override
  final String tag;
  @override
  final String image;
  @override
  final String icon;
  @override
  final String about;
  @override
  final String? route;
  @override
  final String? buttonText;

  @override
  String toString() {
    return 'RecyclingTool(uid: $uid, title: $title, tag: $tag, image: $image, icon: $icon, about: $about, route: $route, buttonText: $buttonText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecyclingTool &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.buttonText, buttonText) ||
                other.buttonText == buttonText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, uid, title, tag, image, icon, about, route, buttonText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecyclingToolCopyWith<_$_RecyclingTool> get copyWith =>
      __$$_RecyclingToolCopyWithImpl<_$_RecyclingTool>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecyclingToolToJson(
      this,
    );
  }
}

abstract class _RecyclingTool extends RecyclingTool {
  const factory _RecyclingTool(
      {required final String uid,
      required final String title,
      required final String tag,
      required final String image,
      required final String icon,
      required final String about,
      final String? route,
      final String? buttonText}) = _$_RecyclingTool;
  const _RecyclingTool._() : super._();

  factory _RecyclingTool.fromJson(Map<String, dynamic> json) =
      _$_RecyclingTool.fromJson;

  @override
  String get uid;
  @override
  String get title;
  @override
  String get tag;
  @override
  String get image;
  @override
  String get icon;
  @override
  String get about;
  @override
  String? get route;
  @override
  String? get buttonText;
  @override
  @JsonKey(ignore: true)
  _$$_RecyclingToolCopyWith<_$_RecyclingTool> get copyWith =>
      throw _privateConstructorUsedError;
}
