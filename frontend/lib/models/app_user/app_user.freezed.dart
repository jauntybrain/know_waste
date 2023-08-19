// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  UserStats? get stats => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get profilePicture => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;
  List<String> get bookmarks => throw _privateConstructorUsedError;
  @JsonKey(name: 'fcm_token')
  String? get fcmToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {String uid,
      @JsonKey(includeToJson: false) UserStats? stats,
      String? email,
      String? username,
      String? name,
      String? phoneNumber,
      String? profilePicture,
      bool isAnonymous,
      List<String> bookmarks,
      @JsonKey(name: 'fcm_token') String? fcmToken});

  $UserStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? stats = freezed,
    Object? email = freezed,
    Object? username = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
    Object? profilePicture = freezed,
    Object? isAnonymous = null,
    Object? bookmarks = null,
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStats?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      bookmarks: null == bookmarks
          ? _value.bookmarks
          : bookmarks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserStatsCopyWith<$Res>? get stats {
    if (_value.stats == null) {
      return null;
    }

    return $UserStatsCopyWith<$Res>(_value.stats!, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$_AppUserCopyWith(
          _$_AppUser value, $Res Function(_$_AppUser) then) =
      __$$_AppUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      @JsonKey(includeToJson: false) UserStats? stats,
      String? email,
      String? username,
      String? name,
      String? phoneNumber,
      String? profilePicture,
      bool isAnonymous,
      List<String> bookmarks,
      @JsonKey(name: 'fcm_token') String? fcmToken});

  @override
  $UserStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class __$$_AppUserCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$_AppUser>
    implements _$$_AppUserCopyWith<$Res> {
  __$$_AppUserCopyWithImpl(_$_AppUser _value, $Res Function(_$_AppUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? stats = freezed,
    Object? email = freezed,
    Object? username = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
    Object? profilePicture = freezed,
    Object? isAnonymous = null,
    Object? bookmarks = null,
    Object? fcmToken = freezed,
  }) {
    return _then(_$_AppUser(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStats?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      bookmarks: null == bookmarks
          ? _value._bookmarks
          : bookmarks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppUser extends _AppUser {
  const _$_AppUser(
      {required this.uid,
      @JsonKey(includeToJson: false) this.stats,
      this.email,
      this.username,
      this.name,
      this.phoneNumber,
      this.profilePicture,
      this.isAnonymous = true,
      final List<String> bookmarks = const [],
      @JsonKey(name: 'fcm_token') this.fcmToken})
      : _bookmarks = bookmarks,
        super._();

  factory _$_AppUser.fromJson(Map<String, dynamic> json) =>
      _$$_AppUserFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey(includeToJson: false)
  final UserStats? stats;
  @override
  final String? email;
  @override
  final String? username;
  @override
  final String? name;
  @override
  final String? phoneNumber;
  @override
  final String? profilePicture;
  @override
  @JsonKey()
  final bool isAnonymous;
  final List<String> _bookmarks;
  @override
  @JsonKey()
  List<String> get bookmarks {
    if (_bookmarks is EqualUnmodifiableListView) return _bookmarks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookmarks);
  }

  @override
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;

  @override
  String toString() {
    return 'AppUser(uid: $uid, stats: $stats, email: $email, username: $username, name: $name, phoneNumber: $phoneNumber, profilePicture: $profilePicture, isAnonymous: $isAnonymous, bookmarks: $bookmarks, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUser &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            const DeepCollectionEquality()
                .equals(other._bookmarks, _bookmarks) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      stats,
      email,
      username,
      name,
      phoneNumber,
      profilePicture,
      isAnonymous,
      const DeepCollectionEquality().hash(_bookmarks),
      fcmToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      __$$_AppUserCopyWithImpl<_$_AppUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppUserToJson(
      this,
    );
  }
}

abstract class _AppUser extends AppUser {
  const factory _AppUser(
      {required final String uid,
      @JsonKey(includeToJson: false) final UserStats? stats,
      final String? email,
      final String? username,
      final String? name,
      final String? phoneNumber,
      final String? profilePicture,
      final bool isAnonymous,
      final List<String> bookmarks,
      @JsonKey(name: 'fcm_token') final String? fcmToken}) = _$_AppUser;
  const _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$_AppUser.fromJson;

  @override
  String get uid;
  @override
  @JsonKey(includeToJson: false)
  UserStats? get stats;
  @override
  String? get email;
  @override
  String? get username;
  @override
  String? get name;
  @override
  String? get phoneNumber;
  @override
  String? get profilePicture;
  @override
  bool get isAnonymous;
  @override
  List<String> get bookmarks;
  @override
  @JsonKey(name: 'fcm_token')
  String? get fcmToken;
  @override
  @JsonKey(ignore: true)
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      throw _privateConstructorUsedError;
}
