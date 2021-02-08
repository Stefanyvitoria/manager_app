//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manager_app/models/company.dart';

class Product {
  String name;
  Company company;
  String value;
  String refUID;
  String id;

  Product({
    this.value,
    this.name,
    this.company,
    this.refUID,
    this.id,
  });
  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    refUID = json['refUID'];
    id = json['id'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   data['company'] = this.company;
  //   data['value'] = this.value;
  //   data['refUID'] = this.refUID;
  //   data['id'] = this.id;
  //   return data;
  // }
}
