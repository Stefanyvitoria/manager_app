import 'package:flutter/material.dart';
import 'package:manager_app/services/constantes.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameContoler = TextEditingController();
  TextEditingController _emailControler = TextEditingController();
  TextEditingController _passWord1Controler = TextEditingController();
  TextEditingController _passWord2Controler = TextEditingController();

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
            child: TextFormField(
              onSaved: (text) {
                _nameContoler.text = text;
              },
              controller: _nameContoler,
            ),
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
            child: TextFormField(
              onSaved: (text) {
                _emailControler.text = text;
              },
              controller: _emailControler,
            ),
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
            child: TextFormField(
              onSaved: (text) {
                _passWord1Controler.text = text;
              },
              controller: _passWord1Controler,
            ),
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
            child: TextFormField(
              onSaved: (text) {
                _passWord2Controler.text = text;
              },
              controller: _passWord2Controler,
            ),
          ),
          Align(
            child: Container(
              padding: EdgeInsets.only(top: 7),
              width: 150,
              child: ElevatedButton(
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
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black),
              ),
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
