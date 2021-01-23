import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manager App',
      initialRoute: 'login',
      routes: _buildRoutes(context),
      theme: _builTheme(),
    );
  }

  _buildRoutes(context) {
    return {
      'login': (context) => Login(),
      'home': (context) => Home(),
    };
  }

  _builTheme() {
    return ThemeData(
      primaryColor: Colors.grey,
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
