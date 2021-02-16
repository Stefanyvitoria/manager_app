import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/expense.dart';
import 'package:manager_app/models/finance.dart';
import 'package:manager_app/services/database_service.dart';

class ActionFinance extends StatefulWidget {
  @override
  _ActionFinanceState createState() => _ActionFinanceState();
}

class _ActionFinanceState extends State<ActionFinance> {
  Finances finance;
  String _type = 'withdrawal';
  Expense expense = Expense();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List result = ModalRoute.of(context).settings.arguments;
    finance = result[0];
    String _uid = result[1];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Expense",
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width, //size of screen
          height: MediaQuery.of(context).size.height, //size of screen
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('withdrawal'),
                        value: _type,
                        onChanged: (value) {
                          setState(() {
                            _type = value;
                          });
                        },
                        items: <String>['addition', 'withdrawal']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onChanged: (text) {
                      expense.date = text;
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: 'Date:',
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
                    onChanged: (text) {
                      expense.value =
                          num.parse('${_type == "withdrawal" ? "-" : ""}$text');
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Value:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 5,
                    onChanged: (text) {
                      expense.considerations = text;
                    },
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      labelText: 'A little description:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!_validate()) return;

                        //create action
                        DocumentReference idExpense =
                            await DatabaseServiceFirestore().addDoc(
                          collectionName: 'expense',
                          instance: expense,
                        );
                        //update finance
                        finance.actions.add(idExpense);
                        finance.liquidMoney += expense.value;
                        await DatabaseServiceFirestore().setDoc(
                          collectionName: 'finance',
                          instance: finance,
                          uid: _uid,
                        );

                        Navigator.pop(context);
                      },
                      child: Text(
                        'Confirm',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
