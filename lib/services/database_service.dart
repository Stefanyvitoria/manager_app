import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:manager_app/models/ceo.dart';

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
  validatelogin({String collectiom, uid}) async {
    var result = false;
    await FirebaseFirestore.instance.collection(collectiom).doc(uid).get().then(
      (DocumentSnapshot value) {
        if (value.exists) {
          result = true;
        }
      },
    );
    return result;
  }

  FutureOr setCeo({String uid, String collectionName, instance}) async {
    await FirebaseFirestore.instance
        .collection('ceo')
        .doc(uid)
        .set(instance.toJson());
  }

  Stream<DocumentSnapshot> getCeo({String uid, String collectionName}) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .snapshots();
  }

  FutureOr deleteCeo(String uid) {
    FirebaseFirestore.instance.collection('ceo').doc(uid).delete();
  }
}
