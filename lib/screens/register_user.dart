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
  String name, email, passw1, passw2;

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
            TextFormField(
              validator: (String value) {
                return value.isEmpty ? 'Required field.' : null;
              },
              onChanged: (text) {
                name = text;
              },
              decoration: const InputDecoration(
                labelText: 'Name:',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
            ),
            ConstantesSpaces.spacermin,
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (String value) {
                return value.isEmpty ? 'Required field.' : null;
              },
              onChanged: (text) {
                email = text;
              },
              decoration: const InputDecoration(
                labelText: 'Email:',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
            ),
            ConstantesSpaces.spacermin,
            TextFormField(
              obscureText: true,
              validator: (String value) {
                return value.isEmpty
                    ? 'Required field.'
                    : value != passw2
                        ? 'incompatible passwords.'
                        : null;
              },
              onChanged: (text) {
                passw1 = text;
              },
              decoration: const InputDecoration(
                labelText: 'Password:',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
            ),
            ConstantesSpaces.spacermin,
            TextFormField(
              obscureText: true,
              validator: (String value) {
                return value.isEmpty
                    ? 'Required field.'
                    : value != passw1
                        ? 'incompatible passwords.'
                        : null;
              },
              onChanged: (text) {
                passw2 = text;
              },
              decoration: const InputDecoration(
                labelText: 'Password:',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
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
                    ceo.uid = auth.currentUser.uid;
                    DatabaseServiceFirestore().setDoc(
                        uid: ceo.uid, collectionName: 'ceo', instance: ceo);
                    ConstantesWidgets.dialog(
                      context: context,
                      title: Text('Sucess'),
                      actions: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'),
                      ),
                    );
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
      ceo.password = passw1;
      ceo.name = name;
      ceo.email = email;
      return true;
    }
    return false;
  }
}
