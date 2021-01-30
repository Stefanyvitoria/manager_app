import 'package:flutter/material.dart';
import 'package:manager_app/screens/clien_product_list.dart';
import 'package:manager_app/screens/employees.dart';
import 'package:manager_app/screens/expenses.dart';
import 'package:manager_app/screens/finances.dart';
import 'package:manager_app/screens/init.dart';
import 'package:manager_app/screens/login.dart';
import 'package:manager_app/screens/home.dart';
import 'package:manager_app/screens/forgot_password.dart';
import 'package:manager_app/screens/profile.dart';
import 'package:manager_app/screens/notes.dart';
import 'package:manager_app/screens/products.dart';
import 'package:manager_app/screens/ranking.dart';
import 'package:manager_app/screens/register_user.dart';
import 'package:manager_app/screens/sales.dart';
import 'package:manager_app/screens/settings.dart';
import 'package:manager_app/screens/statistics.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manager App',
      initialRoute: '/',
      routes: _buildRoutes(context),
      theme: _builThemeLigth(),
      darkTheme: _builThemeDark(),
      themeMode: ThemeMode.light,
    );
  }

  _buildRoutes(context) {
    return {
      '/': (context) => Init(),
      'login': (context) => Login(),
      'home': (context) => Home(),
      'productList': (context) => ClientListTile(),
      'forgotPassword': (context) => ForgotPassword(),
      'register': (context) => Register(),
      'finances': (context) => Finances(),
      'expenses': (context) => Expenses(),
      'sales': (context) => Sales(),
      'editSale': (context) => EditSale(),
      'addSale': (context) => AddSale(),
      'employees': (context) => Employees(),
      'addEmployee': (context) => AddEmployee(),
      'editEmployee': (context) => EditEmployee(),
      'products': (context) => Products(),
      'addProduct': (context) => AddProduct(),
      'editProduct': (context) => EditProduct(),
      'ranking': (context) => Ranking(),
      'notes': (context) => Notes(),
      'settings': (context) => Settings(),
      'statistics': (context) => Statistics(),
      'profile': (context) => Profile(),
    };
  }

  _builThemeLigth() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      accentColor: Colors.white,
      primaryColor: Colors.teal,
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(
            5.0,
          ),
        ),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusColor: Colors.white,
        labelStyle: TextStyle(color: Colors.white),
        suffixStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.all(12.0),
      ),
    );
  }

  _builThemeDark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey[700],
      primaryColor: Colors.grey[850],
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(
            5.0,
          ),
        ),
        contentPadding: EdgeInsets.all(16.0),
      ),
    );
  }
}
