import 'package:manager_app/models/company.dart';

class Product {
  String name;
  Company company;
  int value;

  Product({
    this.value,
    this.name,
    this.company,
  });
}
