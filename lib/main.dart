import 'package:flutter/material.dart';
import 'package:manager_app/screens/clien_product_list.dart';
import 'package:manager_app/screens/expenses.dart';
import 'package:manager_app/screens/finances.dart';
import 'package:manager_app/screens/init.dart';
import 'package:manager_app/screens/login.dart';
import 'package:manager_app/screens/home.dart';
import 'package:manager_app/screens/forgot_password.dart';
import 'package:manager_app/screens/profile.dart';
import 'package:manager_app/screens/register_user.dart';
import 'package:manager_app/screens/settings.dart';

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
      'settings': (context) => Settings(),
      'profile': (context) => Profile(),
    };
  }

  _builThemeLigth() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.teal[100],
      primaryColor: Colors.teal[300],
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            5.0,
          ),
        ),
        contentPadding: EdgeInsets.all(16.0),
      ),
    );
  }

  _builThemeDark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey[700],
      primaryColor: Colors.grey[850],
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            5.0,
          ),
        ),
        contentPadding: EdgeInsets.all(16.0),
      ),
    );
  }
}
