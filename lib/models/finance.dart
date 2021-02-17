//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Finances {
  num liquidMoney;
  //DocumentReference company;
  List<dynamic> actions;

  Finances({this.liquidMoney, this.actions});

  Finances.fromJson(Map<String, dynamic> json) {
    liquidMoney = json['liquidMoney'];
    actions = json['actions'];
    //company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['liquidMoney'] = this.liquidMoney;
    data['actions'] = this.actions;
    //data['company'] = this.company;
    return data;
  }

  Finances.fromSnapshot(AsyncSnapshot<dynamic> snapshot) {
    liquidMoney = snapshot.data['liquidMoney'];
    actions = snapshot.data['actions'];
    //company = snapshot.data['company'];
  }
}
