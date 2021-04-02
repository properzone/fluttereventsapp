import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static Future<UserCredential> anonymousLogin() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    return userCredential;
  }

  static User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
