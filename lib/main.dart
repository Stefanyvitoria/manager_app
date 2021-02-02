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
      theme: Themes._lightTheme,
      darkTheme: Themes._darkTheme,
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
}

class Themes {
  static final _darkTheme = ThemeData(
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

  static final _lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.grey[400],
      primaryVariant: Colors.teal,
      secondaryVariant: Colors.teal[600],
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        minimumSize: Size(60, 40),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent,
    accentColor: Colors.black,
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
