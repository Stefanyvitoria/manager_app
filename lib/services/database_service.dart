import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  static Future register(email, passw) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.trim(), password: passw);
  }
}
