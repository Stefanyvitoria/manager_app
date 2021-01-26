import 'package:flutter/material.dart';
import 'package:manager_app/constantes.dart';
import 'package:manager_app/models/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    User user = User(); //start current user.
    user.type =
        ModalRoute.of(context).settings.arguments; // recovery user type.
    return Scaffold(
        body: Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 100, left: 10, right: 10, bottom: 20),
        child: Column(
          children: [
            ConstantesImages.sizedLogo,
            Text(
              'Username or email:',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (text) {
                  user.email = text;
                },
              ),
            ),
            Text(
              'Password:',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
              child: TextFormField(
                obscureText: true,
                onChanged: (text) {
                  user.password = text;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  padding: EdgeInsets.only(right: 25),
                  child: Text('Forgot password'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('forgotPassword');
                  },
                ),
              ],
            ),
            Container(
              width: 150,
              child: RaisedButton(
                child: Text('Login'),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'home', ModalRoute.withName('/'),
                      arguments: user);
                },
              ),
            ),
            FlatButton(
              child: Text('Register.'),
              onPressed: () {
                Navigator.of(context).pushNamed('register', arguments: user);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
