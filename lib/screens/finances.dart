import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/action.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/finance.dart';
import 'package:manager_app/models/sale.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/database_service.dart';

class FinancesScreen extends StatefulWidget {
  @override
  _FinancesScreenState createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  Ceo ceo;
  Finances finance;

  @override
  Widget build(BuildContext context) {
    ceo = ModalRoute.of(context).settings.arguments;
    return StreamBuilder(
      stream: DatabaseServiceFirestore().getDoc(
        collectionName: 'finance',
        uid: ceo.uid,
      ),
      builder: (context, AsyncSnapshot snapshot) {
        while (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return ConstantesWidgets.loading();
        }

        finance = Finances.fromSnapshot(snapshot);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Finances",
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                tooltip: 'add actions',
                onPressed: () {
                  Navigator.pushNamed(context, 'action',
                      arguments: [finance, ceo.uid]);
                },
              ),
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        "Liquidity:",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "    \$ ${finance.liquidMoney}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80),
              Container(
                width: MediaQuery.of(context).size.width,
                color: (Theme.of(context).brightness == Brightness.light)
                    ? Colors.blueGrey[200]
                    : Colors.blueGrey[800],
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            "Action History",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color:
                            (Theme.of(context).brightness == Brightness.light)
                                ? Colors.blueGrey[400]
                                : Colors.blueGrey[900],
                      )
                    ],
                  ),
                ),
              ),
              new Expanded(
                child: Container(
                  color: (Theme.of(context).brightness == Brightness.light)
                      ? Colors.blueGrey[200]
                      : Colors.blueGrey[800],
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: ListView.builder(
                    itemCount: finance.actions.length,
                    itemBuilder: (context, int index) {
                      index = (finance.actions.length - 1) - index;
                      DocumentReference action = finance.actions[index];
                      if (action.parent.id == 'sale') {
                        return StreamBuilder(
                          stream: DatabaseServiceFirestore().getDoc(
                            collectionName: 'sale',
                            uid: action.id,
                          ),
                          builder: (context, snapshot) {
                            while (snapshot.hasError ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return LinearProgressIndicator(
                                backgroundColor: Colors.teal,
                              );
                            }
                            Sale action = Sale(
                                date: snapshot.data['date'],
                                value: snapshot.data['value']);

                            return ListTile(
                              title: Text(
                                "Sale",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text("\$ ${action.value}"),
                              leading: Icon(Icons.info_outline),
                              trailing: TextButton(
                                child: Icon(Icons.expand_more,
                                    color: Colors.black),
                                onPressed: () {
                                  ConstantesWidgets.dialog(
                                    context: context,
                                    title: Text('Sale'),
                                    content: Wrap(
                                      direction: Axis.vertical,
                                      children: [
                                        Text('Date: ${action.date}'),
                                        Text(
                                          'Value: \$ ${action.value}',
                                        )
                                      ],
                                    ),
                                    actions: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('ok'),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return StreamBuilder(
                          stream: DatabaseServiceFirestore().getDoc(
                            collectionName: 'expense',
                            uid: action.id,
                          ),
                          builder: (context, snapshot) {
                            while (snapshot.hasError ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return LinearProgressIndicator(
                                backgroundColor: Colors.teal,
                              );
                            }
                            FinanceAction actionv =
                                FinanceAction.fromSnapshot(snapshot);
                            return ListTile(
                              title: Text(
                                '${actionv.value > 0 ? "Addition" : "Withdrawal"}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: actionv.value > 0
                                      ? Colors.black
                                      : Colors.red,
                                ),
                              ),
                              subtitle: Text("\$ ${actionv.value}"),
                              leading: Icon(Icons.info_outline),
                              trailing: TextButton(
                                child: Icon(Icons.expand_more,
                                    color: Colors.black),
                                onPressed: () {
                                  ConstantesWidgets.dialog(
                                    context: context,
                                    title: Text(
                                        '${actionv.value > 0 ? "Addition" : "Withdrawal"}'),
                                    content: Wrap(
                                      direction: Axis.vertical,
                                      children: [
                                        Text('Date: ${actionv.date}'),
                                        Text('Value: \$ ${actionv.value}'),
                                        Text(
                                            'Descrition: ${actionv.descricion}'),
                                      ],
                                    ),
                                    actions: Row(
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            //delete from expense
                                            await DatabaseServiceFirestore()
                                                .deleteDoc(
                                                    collectionName: 'expense',
                                                    uid: action.id);

                                            //delete
                                            finance.actions.remove(action);
                                            finance.liquidMoney -=
                                                actionv.value;
                                            //update finance
                                            DatabaseServiceFirestore().setDoc(
                                              collectionName: 'finance',
                                              instance: finance,
                                              uid: ceo.uid,
                                            );

                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Delete'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
