import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/employee.dart';

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

  Future<Ceo> getCeo({String uid, String type}) async {
    DocumentSnapshot doc;
    doc = await FirebaseFirestore.instance.collection('ceo').doc(uid).get();
    Ceo user = Ceo.fromJson(doc.data());
    return user;
  }

  Future<Employee> getEmployee({String uid, String type}) async {
    DocumentSnapshot doc;
    doc =
        await FirebaseFirestore.instance.collection('employee').doc(uid).get();
    Employee user = Employee.fromJson(doc.data());
    return user;
  }
}
