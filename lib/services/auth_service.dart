/// services/auth_service.dart
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/youtube.readonly',
    ],  );

  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  Future<void> signIn() async {
    try {
      final result = await _googleSignIn.signIn();
      _user = result;
      print("User signed in: $_user");
      notifyListeners();
    } catch (e) {
      print('Login error: $e');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _user = null;
    notifyListeners();
  }
}
