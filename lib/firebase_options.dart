import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyDH3YfDI7coCpOFqXDRnSf2HX3ANoGcBa8",
      authDomain: "rakshakauth.firebaseapp.com",
      projectId: "rakshakauth",
      storageBucket: "rakshakauth.firebasestorage.app",
      messagingSenderId: "621273360080",
      appId: "1:621273360080:web:4746f78dedddc5e93620d5",
    );
  }
}
