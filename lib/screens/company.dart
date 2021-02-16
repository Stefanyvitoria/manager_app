import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/company.dart';
import 'package:manager_app/models/finance.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/database_service.dart';

class CompanyScreen extends StatefulWidget {
  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  Ceo ceo;
  Company company = Company(nEmployees: 0);
  Finances finance = Finances(liquidMoney: 0, actions: []);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ceo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Company'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              validator: (String value) {
                return value.isEmpty ? 'Required field.' : null;
              },
              onChanged: (txt) {
                company.name = txt;
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Name:',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (String value) {
                return value.isEmpty ? 'Required field.' : null;
              },
              onChanged: (txt) {
                company.email = txt;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email:',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (String value) {
                return value.isEmpty ? 'Required field.' : null;
              },
              onChanged: (txt) {
                company.phone = txt;
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Phone:',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (String value) {
                return value.isEmpty ? 'Required field.' : null;
              },
              onChanged: (txt) {
                company.adress = txt;
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Adress:',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (String value) {
                return value.isEmpty ? 'Required field.' : null;
              },
              onChanged: (txt) {
                company.cnpj = txt;
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'CNPJ:',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              child: SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_validate()) {
                      return null;
                    } else {
                      //create finance
                      await DatabaseServiceFirestore().setDoc(
                        collectionName: 'finance',
                        instance: finance,
                        uid: ceo.uid,
                      );
                      // create company
                      await DatabaseServiceFirestore().setDoc(
                        collectionName: 'company',
                        instance: company,
                        uid: ceo.uid,
                      );
                      //Company Ref
                      ceo.company = DatabaseServiceFirestore().getRef(
                        collectionNamed: 'company',
                        uid: ceo.uid,
                      );
                      //update ceo
                      await DatabaseServiceFirestore().setDoc(
                        collectionName: 'ceo',
                        instance: ceo,
                        uid: ceo.uid,
                      );

                      ConstantesWidgets.dialog(
                        context: context,
                        title: Text('Sucess'),
                        content: Text('Company successfully registered.'),
                        actions: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validate() {
    if (_formKey.currentState.validate()) {
      return true;
    }
    return false;
  }
}
