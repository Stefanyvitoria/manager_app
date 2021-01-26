import 'package:manager_app/models/company.dart';

class User {
  String name, email, password, type;
  Company company;
  User({
    this.name = "client",
    this.email = "cliente@dominio.com",
    this.password,
    this.type = "client",
    this.company,
  });
}
