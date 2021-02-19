import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String title;
  String description;
  DocumentReference employee;
  String id;

  Note({
    this.title,
    this.description,
    this.employee,
    this.id,
  });
  Note.fromJson(Map<String, dynamic> json, uid) {
    title = json['title'];
    description = json['description'];
    employee = json['employee'];
    id = uid;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['employee'] = this.employee;
    return data;
  }
}
