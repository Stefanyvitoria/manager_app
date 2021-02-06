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
}

class DatabaseServiceFirestore {
  FutureOr setCeo(Ceo ceo) async {
    await FirebaseFirestore.instance
        .collection('ceo')
        .doc(ceo.uid)
        .set(ceo.toJson());
  }

  List<Ceo> ceoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map(
        (e) {
          return Ceo.fromJson(e.data());
        },
      );
    }
  }

  Stream<List<Ceo>> listCeo(uid) {
    return FirebaseFirestore.instance
        .collection('ceo')
        .where(uid)
        .snapshots()
        .map(ceoFromFirestore);
  }
}
