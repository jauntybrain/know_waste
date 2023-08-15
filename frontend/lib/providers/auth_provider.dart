import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/providers/repositories_providers.dart';
import 'package:know_waste/repositories/user/user_repository.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<void>>(
  (ref) => AuthNotifier(ref, ref.watch(userRepositoryProvider)),
);

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  AuthNotifier(this.ref, this.userRepository) : super(const AsyncData(null));

  final Ref ref;
  final UserRepository userRepository;

  Future<void> signInWithGoogle() async {
    try {
      await userRepository.signInWithGoogle();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithApple() async {
    try {
      await userRepository.signInWithApple();
    } catch (e) {
      rethrow;
    }
  }

  @override
  String toString() {
    return state.toString();
  }
}
