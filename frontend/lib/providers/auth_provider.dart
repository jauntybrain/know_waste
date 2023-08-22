import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/user/user_repository.dart';
import 'repositories_providers.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
  (ref) => AuthNotifier(ref, ref.watch(userRepositoryProvider)),
);

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  AuthNotifier(this.ref, this.userRepository) : super(AsyncData(FirebaseAuth.instance.currentUser));

  final Ref ref;
  final UserRepository userRepository;

  Future<void> signInWithGoogle({required Function() onSuccess}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return userRepository.processLinkedUser(
        credential: await userRepository.signInWithGoogle(),
      );
    });

    if (state is AsyncData && state.value != null) {
      onSuccess.call();
    }
  }

  Future<void> signInWithApple({required Function() onSuccess}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return userRepository.processLinkedUser(
        credential: await userRepository.signInWithApple(),
      );
    });

    if (state is AsyncData && state.value != null) {
      onSuccess.call();
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await userRepository.signOut();
      await userRepository.signInAnonymously();
      return null;
    });
  }

  @override
  String toString() {
    return state.toString();
  }
}
