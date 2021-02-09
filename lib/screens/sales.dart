import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/employee.dart';
import 'package:manager_app/models/sale.dart';
import 'package:manager_app/services/database_service.dart';

import 'Loading.dart';

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  var obj;
  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: buildAppbarSales(args[0], context),
        floatingActionButton: buildFloatingButtonSales(args, context),
        body: buildBodySales(args, context));
  }
}

class AddOrEditSale extends StatefulWidget {
  @override
  _AddOrEditSale createState() => _AddOrEditSale();
}

class _AddOrEditSale extends State<AddOrEditSale> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _productController = TextEditingController();
  TextEditingController _valueController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _employeeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  Sale sale = Sale();
  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context).settings.arguments;
    Ceo ceo = args[1];
    String title = args[0];
    sale.id = args[2];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
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
                  TextFormField(
                    onSaved: (text) {
                      _productController.text = text;
                    },
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    controller: _productController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Product:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (text) {
                      _employeeController.text = text;
                    },
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    controller: _employeeController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Employee:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (text) {
                      _dateController.text = text;
                    },
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    controller: _dateController,
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
                    onSaved: (text) {
                      _amountController.text = text;
                    },
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Amount:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (text) {
                      _valueController.text = text;
                    },
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    controller: _valueController,
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
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_validate()) return;
                        sale.ceoid = ceo.uid; // add reference id of ceo to sale
                        DatabaseServiceFirestore().setDoc(
                            collectionName: 'sale',
                            instance: sale,
                            uid: sale.id);
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
      sale.product = _productController.text;
      sale.value = _valueController.text;
      sale.productAmount = _amountController.text;
      sale.employee = _employeeController.text;
      sale.date = _dateController.text;
      return true;
    }
    return false;
  }
}

buildAppbarSales(String user, BuildContext context) {
  if (user == "ceo") {
    return AppBar(
        title: Text(
          "Sales",
        ),
        actions: [
          TextButton(
            onPressed: () {
              showSearch(context: context, delegate: DataSearchSale());
            },
            child: Icon(Icons.search, color: Colors.white),
          ),
        ]);
  } else if (user == "employee") {
    return AppBar(
        title: Text(
          "My Sales",
        ),
        actions: [
          TextButton(
            onPressed: () {
              showSearch(context: context, delegate: DataSearchSale());
            },
            child: Icon(Icons.search, color: Colors.white),
          ),
        ]);
  }
}

buildFloatingButtonSales(arg, BuildContext context) {
  String user = arg[0];

  if (user == "ceo") {
    Ceo ceo = arg[1];
    return FloatingActionButton(
      onPressed: () {
        List args = ["New Sale", ceo, null];
        Navigator.pushNamed(context, 'addOrEditSale', arguments: args);
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
      backgroundColor: Colors.teal[300],
    );
  } else {}
}

buildBodySales(List obj, BuildContext context) {
  // list obj contains string to determinate ceo or employee and contains object properties
  String user = obj[0];
  if (user == "ceo") {
    Ceo ceo = obj[1];
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseServiceFirestore().getDocs(
          collectionNamed: "sale", field: "ceoid", resultfield: ceo.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        List sales = snapshot.data.docs.map(
          (DocumentSnapshot e) {
            return Sale.fromJson(e.data(), e.id);
          },
        ).toList();
        return ListView.builder(
          itemCount: sales.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Dismissible(
              onDismissed: (direction) {
                DatabaseServiceFirestore()
                    .deleteDoc(uid: sales[index].id, collectionName: "sale");
              },
              child: ListTile(
                  leading: Icon(Icons.point_of_sale),
                  title: Text("${sales[index].product}"),
                  subtitle: Text("Value: ${sales[index].value}"),
                  trailing: TextButton(
                    onPressed: () {
                      List args = ["Edit Sale", ceo, sales[index].id];
                      Navigator.pushNamed(context, 'addOrEditSale',
                          arguments: args);
                    },
                    child: Icon(Icons.edit, color: Colors.grey),
                  ),
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Wrap(
                            direction: Axis.vertical,
                            children: [
                              AlertDialog(
                                titlePadding: EdgeInsets.only(
                                    top: 40, bottom: 20, left: 30, right: 10),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ),
                                ],
                                title: Text(
                                  "${sales[index].product}\nvalue: ${sales[index].value}\ndate: ${sales[index].date}\nseller: ${sales[index].employee}\nAmount: ${sales[index].productAmount}\n",
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                              ),
                            ],
                          );
                        });
                  }),
              key: Key(sales[index].id),
              background: Container(
                color: Colors.red[300],
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.delete),
                      Icon(Icons.delete),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  } else if (user == "employee") {
    Employee employee = obj[1];
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseServiceFirestore().getDocs(
          collectionNamed: "sale",
          field: "employeeid",
          resultfield: employee.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        List sales = snapshot.data.docs.map(
          (DocumentSnapshot e) {
            return Sale.fromJson(e.data(), e.id);
          },
        ).toList();
        return ListView.builder(
          itemCount: sales.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return ListTile(
              leading: Icon(Icons.point_of_sale),
              title: Text("${sales[index].product}"),
              subtitle: Text("Value: ${sales[index].value}"),
              trailing: TextButton(
                onPressed: () {
                  List args = ["Edit Sale", employee, sales[index].id];
                  Navigator.pushNamed(context, 'addOrEditSale',
                      arguments: args);
                },
                child: Icon(Icons.edit, color: Colors.grey),
              ),
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Wrap(
                      direction: Axis.vertical,
                      children: [
                        AlertDialog(
                          titlePadding: EdgeInsets.only(
                              top: 40, bottom: 20, left: 30, right: 10),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                          ],
                          title: Text(
                            "${sales[index].product}\nvalue: ${sales[index].value}\ndate: ${sales[index].date}\nseller: ${sales[index].employee}\nAmount: ${sales[index].productAmount}\n",
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class DataSearchSale extends SearchDelegate<String> {
  //function to search bar on sales page
  final sales = [
    "Sale1",
    "Sale2",
    "Sale3",
    "Sale4",
    "Sale5",
  ];
  final recentSales = [
    "Sale1",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //button to erase the search bar words
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //a button to close search bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // go to the function when press a option
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show a list of suggestions
    final suggestionList = query.isEmpty
        ? recentSales
        : sales.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {},
        leading: Icon(Icons.money),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
