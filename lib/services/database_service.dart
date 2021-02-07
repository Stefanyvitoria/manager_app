import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manager_app/models/ceo.dart';

class DatabaseServiceAuth {
  static Future register(String email, String passw) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.trim(), password: passw);
  }

  static Future login(String email, String passw) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: passw);
  }

  static Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future deleteuser(user) async {
    await user.delete();
  }
}

class DatabaseServiceFirestore {
  FutureOr setCeo(Ceo ceo) async {
    await FirebaseFirestore.instance
        .collection('ceo')
        .doc(ceo.uid)
        .set(ceo.toJson());
  }

  Stream<DocumentSnapshot> getCeo({String uid}) {
    return FirebaseFirestore.instance.collection('ceo').doc(uid).snapshots();
  }

  FutureOr deleteCeo(String uid) {
    FirebaseFirestore.instance.collection('ceo').doc(uid).delete();
  }
}
