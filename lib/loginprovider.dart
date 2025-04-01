import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'landingpage.dart';
class Screens {
  String? name;
  bool create;
  bool read;
  bool update;
  bool delete;

  Screens({
    this.name,
    this.create = false,
    this.read = false,
    this.update = false,
    this.delete = false,
  }
  );

  Map<String, dynamic> toJson() {
    return {
      "ScreenName": name,
      "create": create,
      "read": read,
      "update": update,
      "delete": delete,
    };
  }
  factory Screens.fromJson(Map<String, dynamic> json) {
    return Screens(
      name: json["name"],
      create: json["create"] ?? false,
      read: json["read"] ?? false,
      update: json["update"] ?? false,
      delete: json["delete"] ?? false,
    );
  }
}

class User {
  String? username;
  String? password;
  String? email;
  String? uid;
  Map<String, Screens>? screens;
  User({this.username, this.password, this.email, this.uid});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "email": email,
      "uid": uid,
      "screens": screens?.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class LoginProvider extends ChangeNotifier {
  User? currentuser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();



  Future<bool> signInWithGoogle(BuildContext context) async {

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      currentuser = User(
        username: userCredential.user?.displayName,
        email: userCredential.user?.email,
        uid: userCredential.user?.uid,
      );

      await _dbRef.child("users/${currentuser!.uid}").set(currentuser!.toJson());

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

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    currentuser = null;
    notifyListeners();
  }

  Future<void> addUser(User user) async {
    await _dbRef.child("users/${user.username}").set(user.toJson());
    notifyListeners();
  }


  Future<void> deleteUser(String uid) async {
    await _dbRef.child("users/$uid").remove();
    notifyListeners();
  }

  Future<void> editUser(User updatedUser) async {
    await _dbRef.child("users/${updatedUser.uid}").update(updatedUser.toJson());
    notifyListeners();
  }

  Future<List<User>> listUsers() async {
    DataSnapshot snapshot = await _dbRef.child("users").get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> usersData = snapshot.value as Map<dynamic, dynamic>;
      return usersData.entries.map((entry) => User(
        username: entry.value["username"],
        password: entry.value["password"],
        email: entry.value["email"],
        uid: entry.key,
      )).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>> screens(String username) async {
    DataSnapshot snapshot = await _dbRef.child("users/$username/screens").get();

    if (snapshot.exists) {
      return snapshot.value as Map<String, dynamic>;
    }
    return {};
  }
}
