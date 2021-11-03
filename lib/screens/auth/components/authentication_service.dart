import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  AuthenticationService(this._firebaseAuth);
  Future<String> signIn({
    String? email,
    String? pass,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: pass!);
      return 'SignedIn';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (_) {}
  }
}
