import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manager_app/services/database_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameContoler = TextEditingController();
  TextEditingController _emailControler = TextEditingController();
  TextEditingController _passWord1Controler = TextEditingController();
  TextEditingController _passWord2Controler = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  Ceo ceo;

  @override
  Widget build(BuildContext context) {
    ceo = Ceo();

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
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
                validator: (String value) {
                  return value.isEmpty ? 'Required field.' : null;
                },
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
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  return value.isEmpty ? 'Required field.' : null;
                },
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
                obscureText: true,
                validator: (String value) {
                  return value.isEmpty
                      ? 'Required field.'
                      : value != _passWord2Controler.text
                          ? 'incompatible passwords.'
                          : null;
                },
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
                obscureText: true,
                validator: (String value) {
                  return value.isEmpty
                      ? 'Required field.'
                      : value != _passWord1Controler.text
                          ? 'incompatible passwords.'
                          : null;
                },
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
                  onPressed: () async {
                    if (!_validate()) return;
                    await DatabaseServiceAuth.register(ceo.email, ceo.password);
                    ceo.uid = auth.currentUser.uid; //*****
                    DatabaseServiceFirestore().setDoc(
                        uid: ceo.uid, collectionName: 'ceo', instance: ceo);
                    _buildPopup(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validate() {
    if (_formkey.currentState.validate()) {
      ceo.password = _passWord1Controler.text;
      ceo.name = _nameContoler.text;
      ceo.email = _emailControler.text;
      return true;
    }
    return false;
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
