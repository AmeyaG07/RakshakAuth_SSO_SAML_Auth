
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'landingpage.dart';

class User {
  String? username;
  String? password;
  String? token;
  String? role;

  User({this.username,this.password, this.token, this.role});
}

class LoginProvider extends ChangeNotifier {
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      user = User(
        username: userCredential.user?.displayName,
        token: userCredential.user?.uid,
        role: "user",
      );

      notifyListeners();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LandingPage()),
      );
      return true;
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      return false;
    }
  }

  // 🔒 Sign Out Method
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}
