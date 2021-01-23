import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('User name or e-mail'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(),
          ),
          Text('Password'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(),
          ),
        ],
      ),
    ));
  }
}
