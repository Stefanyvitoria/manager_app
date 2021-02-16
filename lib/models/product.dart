import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  DocumentReference company;
  num value;
  String id;
  String amount;

  Product({
    this.value,
    this.name,
    this.company,
    this.id,
    this.amount,
  });
  Product.fromJson(Map<String, dynamic> json, uid) {
    name = json['name'];
    value = json['value'];
    id = uid;
    amount = json['amount'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['amount'] = this.amount;
    data['company'] = this.company;
    return data;
  }
}
