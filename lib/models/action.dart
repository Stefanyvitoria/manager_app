import 'package:flutter/cupertino.dart';

class FinanceAction {
  num value;
  String date;

  FinanceAction({this.value, this.date});

  FinanceAction.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> date = new Map<String, dynamic>();
    date['value'] = this.value;
    date['date'] = this.date;
    return date;
  }

  FinanceAction.fromSnapshot(AsyncSnapshot<dynamic> snapshot) {
    value = snapshot.data['value'];
    date = snapshot.data['date'];
  }
}
