import 'package:flutter/material.dart';
import 'package:manager_app/screens/Loading.dart';
import 'package:manager_app/screens/clien_product_list.dart';
import 'package:manager_app/screens/company.dart';
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
import 'package:manager_app/services/theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        while (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return Themebuilder(
          builder: (context, _themeData) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Manager App',
              initialRoute: '/',
              routes: _buildRoutes(context),
              theme: _themeData,
            );
          },
        );
      },
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
      'addOrEditSale': (context) => AddOrEditSale(),
      'employees': (context) => Employees(),
      'addEmployee': (context) => AddEmployee(),
      'editEmployee': (context) => EditEmployee(),
      'products': (context) => Products(),
      'addOrEditProduct': (context) => AddOrEditProduct(),
      'ranking': (context) => Ranking(),
      'notes': (context) => Notes(),
      'addOrEditNote': (context) => AddOrEditNote(),
      'settings': (context) => SettingsApp(),
      'statistics': (context) => Statistics(),
      'profile': (context) => Profile(),
      'company': (context) => CompanyScreen(),
    };
  }
}
