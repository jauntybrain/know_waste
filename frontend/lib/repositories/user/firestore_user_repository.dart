import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/app_user/app_user.dart';
import '../../models/user_stats/user_stats.dart';
import '../../services/auth/auth_service.dart';
import '../../services/database/firestore_collection.dart';
import '../../services/database/firestore_service.dart';
import 'user_repository.dart';

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
    await firebaseAuth.signOut();
  }

  @override
  Future<User?> signInAnonymously() async {
    return await firebaseAuth.signInAnonymously();
  }

  @override
  Future<UserCredential?> signInWithApple() async {
    return (await firebaseAuth.signInWithApple());
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    return (await firebaseAuth.signInWithGoogle());
  }

  /* 
    *Why not use a trigger?*
    As of 2023, Firebase does not support triggers on account linkings,
    and account parameters like "displayName", "profilePicture" are not
    applied to the anonymous user, therefore, we must attach them manually. 
  */
  @override
  Future<User?> processLinkedUser({required UserCredential? credential}) async {
    try {
      // Don't update if the user profile is null
      if (credential?.additionalUserInfo?.profile == null) {
        return null;
      }

      // Don't update if the user exists
      if (!credential!.additionalUserInfo!.isNewUser) {
        return credential.user;
      }

      // Pull data from profile and populate Firestore entry
      final userID = credential.user!.uid;
      final providerID = credential.additionalUserInfo!.providerId!;
      final profile = credential.additionalUserInfo!.profile!;

      final userData = {
        'uid': userID,
        'isAnonymous': false,
        'email': profile['email'],
        'name': providerID == 'google.com' ? profile['name'] : 'Apple User',
        if (providerID == 'google.com') 'profilePicture': profile['picture'],
      };

      await firestore.set('users/$userID', userData);

      return credential.user;
    } catch (e) {
      rethrow;
    }
  }
}
