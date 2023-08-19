import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  AuthService(this._auth);

  final FirebaseAuth _auth;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get onAuthStateChanged {
    return _auth.authStateChanges();
  }

  Future<User?> signInAnonymously() async {
    try {
      final authResult = await _auth.signInAnonymously();
      return authResult.user;
    } catch (exception) {
      rethrow;
    }
  }

  Future updateDisplayName(String name) async {
    try {
      await currentUser?.updateDisplayName(name);
    } catch (exception) {
      rethrow;
    }
  }

  Future reauthenticateEmailUser(String password) async {
    try {
      await currentUser?.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: currentUser!.email!,
          password: password,
        ),
      );
    } catch (exception) {
      rethrow;
    }
  }

  Future updatePassword(String password) async {
    try {
      await currentUser?.updatePassword(password);
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    ).signIn();

    if (googleUser == null) {
      return null;
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final user = await FirebaseAuth.instance.currentUser!.linkWithCredential(credential);
      return user;
    } on FirebaseAuthException catch (e) {
      // If an account was already linked, just sign back in.
      // e.credential is always null, therefore we must use GoogleAuth credential
      if (e.code == 'credential-already-in-use' || e.code == 'provider-already-linked') {
        return FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        rethrow;
      }
    }
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }

  Future<UserCredential?> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = _sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      nonce: nonce,
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    try {
      // Check if user with this email exists
      final query = FirebaseFirestore.instance.collection('users').where('email', isEqualTo: appleCredential.email);
      final snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        // If user doesn't exist, link it to the current anonymous user
        return FirebaseAuth.instance.currentUser!.linkWithCredential(oauthCredential);
      } else {
        // If user exists, reauthenticate
        return FirebaseAuth.instance.signInWithCredential(oauthCredential);
      }
    } on FirebaseAuthException catch (e) {
      // If an account was already linked, just sign back in.
      // e.credential is always null, therefore we must use Apple oAuth credential
      // ** NOTE ** This does not work with Apple because of invalid nonce error.

      if (e.code == 'credential-already-in-use' || e.code == 'provider-already-linked') {
        return FirebaseAuth.instance.signInWithCredential(oauthCredential);
      } else {
        rethrow;
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
