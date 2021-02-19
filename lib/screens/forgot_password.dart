import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/employee.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/database_service.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  String email1, email2;
  dynamic user;
  @override
  Widget build(BuildContext context) {
    String _type = ModalRoute.of(context).settings.arguments;

    return StreamBuilder(
      stream: DatabaseServiceFirestore().getAllDocs(collectionNamed: _type),
      builder: (context, snapshot) {
        while (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return ConstantesWidgets.loading();
        }

        List listUsers = snapshot.data.docs.map(
          //map elements
          (DocumentSnapshot e) {
            return _type == 'employee'
                ? Employee.fromJson(e.data())
                : Ceo.fromJson(e.data());
          },
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('Recover Password'),
          ),
          body: Form(
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              children: [
                TextFormField(
                  validator: (String value) {
                    return value.isEmpty
                        ? 'Required field.'
                        : value != email2
                            ? 'incompatible email'
                            : null;
                  },
                  onChanged: (txt) {
                    email1 = txt;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email:',
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(),
                  ),
                ),
                ConstantesSpaces.spacer,
                TextFormField(
                  validator: (String value) {
                    return value.isEmpty
                        ? 'Required field.'
                        : value != email1
                            ? 'incompatible email'
                            : null;
                  },
                  onChanged: (txt) {
                    email2 = txt;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Confirm email:',
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(),
                  ),
                ),
                Align(
                  child: Container(
                    padding: EdgeInsets.only(top: 7),
                    width: 150,
                    child: ElevatedButton(
                      child: Text('Confirmar email'),
                      onPressed: () async {
                        //Validate
                        if (!_validate()) return;

                        for (var item in listUsers) {
                          if (item.email == email1) user = item;
                        }

                        await DatabaseServiceAuth.login(
                            user.email, user.password);

                        await DatabaseServiceAuth.forgotPassword(
                            FirebaseAuth.instance.currentUser, email1);

                        user.password = null;
                        DatabaseServiceFirestore().setDoc(
                            collectionName: _type,
                            instance: user,
                            uid: user.uid);

                        ConstantesWidgets.dialog(
                            context: context,
                            title: Text('New password sent by email.'),
                            content: Text('Log in with your updated password.'),
                            actions: TextButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _validate() {
    if (_formkey.currentState.validate()) {
      return true;
    }
    return false;
  }
}
