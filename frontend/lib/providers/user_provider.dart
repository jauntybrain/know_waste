import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/models/app_user/app_user.dart';
import 'package:know_waste/providers/repositories_providers.dart';
import 'package:know_waste/repositories/user/user_repository.dart';

final userProvider = StateNotifierProvider<UserNotifier, AppUser?>(
  (ref) => UserNotifier(ref, ref.watch(userRepositoryProvider)),
);

class UserNotifier extends StateNotifier<AppUser?> {
  UserNotifier(this.ref, this.userRepository) : super(null) {
    userRepository.signInAnonymously();
    _userSubscription = userRepository.authState().listen(_userListener);
  }

  final Ref ref;
  final UserRepository userRepository;

  StreamSubscription? _userSubscription;
  StreamSubscription? _profileSubscription;

  @override
  void dispose() {
    _profileSubscription?.cancel();
    _userSubscription?.cancel();
    super.dispose();
  }

  User? _user;
  bool get loggedIn => _user != null;
  void _setUser(User? user) {
    _user = user;
  }

  void _userListener(User? user) {
    _setUser(user);

    if (user != null) {
      _profileSubscription = userRepository
          .userProfile()
          .where((event) => event != null)
          .listen((event) => profileListener(user.uid, event));
    } else {
      state = null;
      _profileSubscription?.cancel();
    }
  }

  profileListener(String uid, AppUser? profile) {
    state = profile;
  }

  Future<void> addBookmark(String articleID, Function(bool) callback) async {
    try {
      List<String> newBookmarks = List.from(state!.bookmarks);
      state = state!.copyWith(bookmarks: newBookmarks..add(articleID));
      await userRepository.updateProfile(state!.uid, state!.toJson());
      callback.call(true);
    } catch (err) {
      callback.call(false);
    }
  }

  Future<void> removeBookmark(String articleID, Function(bool) callback) async {
    try {
      List<String> newBookmarks = List.from(state!.bookmarks);
      state = state!.copyWith(bookmarks: newBookmarks..remove(articleID));
      print(state!.uid);
      await userRepository.updateProfile(state!.uid, state!.toJson());
      callback.call(true);
    } catch (err) {
      callback.call(false);
    }
  }

  @override
  String toString() {
    return state.toString();
  }
}
