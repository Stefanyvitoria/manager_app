import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ceo {
  String name;
  String email;
  String password;
  String phone;
  DocumentReference company;
  String uid;
  List<DocumentReference> employees;

  Ceo(
      {this.name,
      this.email,
      this.password,
      this.phone,
      this.company,
      this.employees,
      this.uid});

  Ceo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    company = json['company'];
    employees = json['employees'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['company'] = this.company;
    data['employees'] = this.employees;
    data['uid'] = this.uid;
    return data;
  }

  Ceo.fromSnapshot(AsyncSnapshot<dynamic> snapshot) {
    name = snapshot.data['name'];
    email = snapshot.data['email'];
    password = snapshot.data['password'];
    phone = snapshot.data['phone'];
    company = snapshot.data['company'];
    employees = snapshot.data['employees'];
    uid = snapshot.data['uid'];
  }
}
