import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Employee {
  String name;
  String email;
  String phone;
  String adress;
  String password;
  String occupation;
  String admissionDate;
  String company; //DocumentReference company;
  String uid;

  Employee({
    this.name,
    this.email,
    this.phone,
    this.adress,
    this.password,
    this.occupation,
    this.admissionDate,
    this.company,
    this.uid,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    adress = json['adress'];
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
    data['phone'] = this.phone;
    data['adress'] = this.adress;
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
    phone = snapshot.data['phone'];
    adress = snapshot.data['adress'];
    password = snapshot.data['password'];
    occupation = snapshot.data['occupation'];
    admissionDate = snapshot.data['admissionDate'];
    company = snapshot.data['company'];
    uid = snapshot.data['uid'];
  }

  Employee.fromQuerySnapshot(AsyncSnapshot<dynamic> snapshot, int index) {
    name = snapshot.data.docs[index]['name'];
    email = snapshot.data.docs[index]['email'];
    phone = snapshot.data.docs[index]['phone'];
    adress = snapshot.data.docs[index]['adress'];
    password = snapshot.data.docs[index]['password'];
    occupation = snapshot.data.docs[index]['occupation'];
    admissionDate = snapshot.data.docs[index]['admissionDate'];
    company = snapshot.data.docs[index]['company'];
    uid = snapshot.data.docs[index]['uid'];
  }
}
