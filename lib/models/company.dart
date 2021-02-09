import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Company {
  String name;
  String phone;
  DocumentReference finance;
  int nEmployees;
  String email;
  String adress;
  String cnpj;

  Company({
    this.name,
    this.phone,
    this.finance,
    this.nEmployees,
    this.email,
    this.adress,
    this.cnpj,
  });

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    finance = json['finance'];
    nEmployees = json['nEmployees'];
    email = json['email'];
    adress = json['adress'];
    cnpj = json['cnpj'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['finance'] = this.finance;
    data['nEmployees'] = this.nEmployees;
    data['email'] = this.email;
    data['adress'] = this.adress;
    data['cnpj'] = this.cnpj;
    return data;
  }

  Company.fromSnapshot(AsyncSnapshot<dynamic> snapshot) {
    name = snapshot.data['name'];
    phone = snapshot.data['phone'];
    finance = snapshot.data['finance'];
    nEmployees = snapshot.data['nEmployees'];
    email = snapshot.data['email'];
    adress = snapshot.data['adress'];
    cnpj = snapshot.data['cnpj'];
  }
}
