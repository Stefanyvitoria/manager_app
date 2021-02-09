import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manager_app/models/company.dart';

class Product {
  String name;
  Company company;
  String value;
  String refUID;
  String id;
  String amount;

  Product({
    this.value,
    this.name,
    this.company,
    this.refUID,
    this.id,
    this.amount,
  });
  Product.fromJson(Map<String, dynamic> json, uid) {
    name = json['name'];
    value = json['value'];
    refUID = json['refUID'];
    id = uid;
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['refUID'] = this.refUID;
    data['amount'] = this.amount;
    return data;
  }
}
