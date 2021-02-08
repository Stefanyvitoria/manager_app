import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Employee {
  String name;
  String email;
  String password;
  String occupation;
  String admissionDate;
  DocumentReference company;
  String uid;

  Employee({
    this.name,
    this.email,
    this.password,
    this.occupation,
    this.admissionDate,
    this.company,
    this.uid,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    occupation = json['occupation'];
    admissionDate = json['admissionDate'];
    company = json['company'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['occupation'] = this.occupation;
    data['admissionDate'] = this.admissionDate;
    data['company'] = this.company;
    data['uid'] = this.uid;
    return data;
  }

  Employee.fromSnapshot(AsyncSnapshot<dynamic> snapshot) {
    name = snapshot.data['name'];
    email = snapshot.data['email'];
    password = snapshot.data['password'];
    occupation = snapshot.data['occupation'];
    admissionDate = snapshot.data['admissionDate'];
    company = snapshot.data['company'];
    uid = snapshot.data['uid'];
  }
}
