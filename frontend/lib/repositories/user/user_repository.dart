import 'package:firebase_auth/firebase_auth.dart';

import '../../models/app_user/app_user.dart';

abstract class UserRepository {
  Stream<User?> authState();

  Stream<AppUser?> userProfile();

  Future<AppUser?> futureSingle();

  Future<void> updateProfile(String uid, Map<String, dynamic> newProfile);

  Future<void> signOut([String? userId]);

  Future<User?> signInAnonymously();

  Future<User?> signInWithGoogle();

  Future<User?> signInWithApple();
}
