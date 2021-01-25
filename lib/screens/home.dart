import 'package:flutter/material.dart';
import 'package:manager_app/models/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    if (user == null) user = User();
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {},
          child: Text(user.type),
        ),
      ),
    );
  }
}
