import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:know_waste/models/user_stats/user_stats.dart';
import 'package:know_waste/repositories/user/user_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/app_user/app_user.dart';
import '../../services/auth/auth_service.dart';
import '../../services/database/firestore_collection.dart';
import '../../services/database/firestore_service.dart';

class FirestoreUserRepository implements UserRepository {
  FirestoreUserRepository(
    this.firebaseAuth,
    this.firestore,
    this.userCollection,
    this.userStatsCollection,
  );

  final AuthService firebaseAuth;
  final FirestoreService firestore;
  final FirestoreCollection<AppUser> userCollection;
  final FirestoreCollection<UserStats> userStatsCollection;

  @override
  Stream<User?> authState() async* {
    yield* firebaseAuth.onAuthStateChanged;
  }

  @override
  Stream<AppUser?> userProfile() async* {
    yield* Rx.combineLatest2(
      userCollection.streamSingle(firebaseAuth.currentUser?.uid).cast<AppUser?>(),
      userStatsCollection.streamSingle(firebaseAuth.currentUser?.uid).cast<UserStats?>(),
      (AppUser? user, UserStats? userStats) => user?.copyWith(stats: userStats),
    );
  }

  @override
  Future<AppUser?> futureSingle() async {
    return userCollection.futureSingleByID(firebaseAuth.currentUser!.uid);
  }

  @override
  Future<void> updateProfile(String uid, Map<String, dynamic> newProfile) {
    return firestore.update('${userCollection.path}/$uid', newProfile);
  }

  @override
  Future<void> signOut([String? userId]) async {
    return firebaseAuth.signOut();
  }

  @override
  Future<User?> signInAnonymously() async {
    return await firebaseAuth.signInAnonymously();
  }

  @override
  Future<User?> signInWithApple() async {
    return (await firebaseAuth.signInWithApple())?.user;
  }

  @override
  Future<User?> signInWithGoogle() async {
    return (await firebaseAuth.signInWithGoogle())?.user;
  }
}
