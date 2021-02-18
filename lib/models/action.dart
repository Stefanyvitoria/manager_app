import 'package:flutter/cupertino.dart';

class FinanceAction {
  num value;
  String date;
  String descricion;

  FinanceAction({
    this.value,
    this.date,
    this.descricion,
  });

  FinanceAction.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    date = json['date'];
    descricion = json['considerations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> date = new Map<String, dynamic>();
    date['value'] = this.value;
    date['date'] = this.date;
    date['considerations'] = this.descricion;
    return date;
  }

  FinanceAction.fromSnapshot(AsyncSnapshot<dynamic> snapshot) {
    value = snapshot.data['value'];
    date = snapshot.data['date'];
    descricion = snapshot.data['considerations'];
  }
}
