import 'package:cloud_firestore/cloud_firestore.dart';

class Sale {
  String id;
  DocumentReference employee;
  DocumentReference company;
  String date;
  DocumentReference product;
  num value;
  num productAmount;
  String nameProduct;
  String nameEmployee;
  Sale({
    this.employee,
    this.company,
    this.product,
    this.date,
    this.value,
    this.productAmount,
    this.id,
    this.nameProduct,
    this.nameEmployee,
  });

  Sale.fromJson(Map<String, dynamic> json, uid) {
    employee = json['employee'];
    value = json['value'];
    nameProduct = json['nameProduct'];
    //ceoid = json['refUID'];
    id = uid;
    productAmount = json['productAmount'];
    date = json['date'];
    product = json['product'];
    company = json['company'];
    nameEmployee = json['nameEmployee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['value'] = this.value;
    //data['ceoid'] = this.ceoid;
    data['nameEmployee'] = this.nameEmployee;
    data['productAmount'] = this.productAmount;
    data['date'] = this.date;
    data['employee'] = this.employee;
    data['company'] = this.company;
    data['nameProduct'] = this.nameProduct;
    return data;
  }
}
