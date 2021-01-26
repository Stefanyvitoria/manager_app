import 'package:flutter/material.dart';
import 'package:manager_app/constantes.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        children: [
          Center(
            child: Text(
              'Name:',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            child: TextFormField(),
          ),
          ConstantesSpaces.spacermin,
          Center(
            child: Text(
              'Email:',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            child: TextFormField(),
          ),
          ConstantesSpaces.spacermin,
          Center(
            child: Text(
              'Password:',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            child: TextFormField(),
          ),
          ConstantesSpaces.spacermin,
          Center(
            child: Text(
              'confirm password:',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            child: TextFormField(),
          ),
          Align(
            child: Container(
              padding: EdgeInsets.only(top: 7),
              width: 150,
              child: RaisedButton(
                child: Text('Register'),
                onPressed: () {
                  //Validate
                  _buildPopup(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildPopup(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success.'),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
