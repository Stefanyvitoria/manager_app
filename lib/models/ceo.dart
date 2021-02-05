import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ceo {
  String name;
  String email;
  String password;
  String phone;
  String company;
  String uid;

  Ceo(
      {this.name,
      this.email,
      this.password,
      this.phone,
      this.company,
      this.uid});

  Ceo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    company = json['company'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['company'] = this.company;
    data['uid'] = this.uid;
    return data;
  }
}

CeoControler ceoControler = CeoControler();

class CeoControler {
  final CollectionReference ceoCollection =
      FirebaseFirestore.instance.collection('ceo');

  FutureOr createCeo(Ceo ceo) async {
    await ceoCollection.doc(ceo.uid).set(ceo.toJson());
  }
}
