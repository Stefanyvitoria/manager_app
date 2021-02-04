import 'package:manager_app/models/company.dart';

class UserApp {
  String name, email, password, type, phone;
  Company company;
  UserApp({
    this.name = "client",
    this.email = "cliente@dominio.com",
    this.password,
    this.type = "client",
    this.phone,
    this.company,
  });
}
