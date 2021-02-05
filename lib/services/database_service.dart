import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manager_app/models/ceo.dart';

class DatabaseService {
  static Future register(String email, String passw) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.trim(), password: passw);
  }

  static Future login(String email, String passw) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: passw);
  }

  Future<Ceo> getUser({String uid, String type: 'ceo'}) async {
    DocumentSnapshot doc;
    if (type == 'ceo') {
      doc = await FirebaseFirestore.instance.collection('ceo').doc(uid).get();
    }
    return fromJson(doc);
  }

  Ceo fromJson(DocumentSnapshot snapshot) {
    Ceo user = Ceo.fromJson(snapshot.data());
    return user;
  }
}
