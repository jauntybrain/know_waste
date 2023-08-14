import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
