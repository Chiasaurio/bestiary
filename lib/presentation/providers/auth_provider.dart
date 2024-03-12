import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isSignedIn => _auth.currentUser != null;

  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    final res = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return res;
    // notifyListeners();
  }

  Future<UserCredential> createAcccount(
      {required String email, required String password}) async {
    final res = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return res;
    // notifyListeners();
  }

  User? getUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
