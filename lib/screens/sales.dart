import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/employee.dart';
import 'package:manager_app/models/finance.dart';
import 'package:manager_app/models/product.dart';
import 'package:manager_app/models/sale.dart';
import 'package:manager_app/services/constantes.dart';
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
  List lEmployees, lProducts;
  Sale sale;
  String productValue, employeeValue, dataValue;
  String title, amountValue;
  Ceo ceo;
  Finances finance;

  num money, amount;

  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context).settings.arguments;
    ceo = args[1];
    title = args[0];
    sale = args[2] == null ? Sale() : args[2];
    money = args[2] != null ? args[2].value : 0;
    amount = args[2] != null ? args[2].productAmount : 0;

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
            title: Text(title),
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width, //size of screen
            height: MediaQuery.of(context).size.height, //size of screen
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Align(
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height,
                      ),
                      child: StreamBuilder(
                        stream: DatabaseServiceFirestore().getDocs(
                          collectionNamed: 'product',
                          field: 'company',
                          resultfield: ceo.company,
                        ),
                        builder: (context, AsyncSnapshot snapshot) {
                          while (snapshot.hasError ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              !snapshot.hasData) {
                            return ConstantesWidgets.loading();
                          }

                          lProducts = snapshot.data.docs.map(
                            //map elements into object product
                            (DocumentSnapshot e) {
                              return Product.fromJson(e.data(), e.id);
                            },
                          ).toList();

                          List<String> nameProduct = [];
                          for (var item in lProducts) {
                            nameProduct.add(item.name);
                          }

                          return Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                              height: title == 'New Sale' ? 55 : 0,
                              child: Column(
                                children: [
                                  if (title == 'New Sale') ...[
                                    DropdownButton(
                                        itemHeight: 55,
                                        isExpanded: true,
                                        hint: Text('Product'),
                                        value: sale.nameProduct == null
                                            ? productValue
                                            : sale.nameProduct,
                                        onChanged: (value) {
                                          setState(() {
                                            sale.nameProduct = productValue =
                                                value; //productValue = value;
                                          });
                                        },
                                        items: nameProduct.map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList()),
                                  ]
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height,
                      ),
                      child: StreamBuilder(
                        stream: DatabaseServiceFirestore().getDocs(
                          collectionNamed: 'employee',
                          field: 'company',
                          resultfield: ceo.company,
                        ),
                        builder: (context, AsyncSnapshot snapshot) {
                          while (snapshot.hasError ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              !snapshot.hasData) {
                            return ConstantesWidgets.loading();
                          }

                          lEmployees = snapshot.data.docs.map(
                            //map elements into object product
                            (DocumentSnapshot e) {
                              return Employee.fromJson(e.data());
                            },
                          ).toList();

                          List<String> nameEmployee = [];
                          for (var item in lEmployees) {
                            nameEmployee.add(item.name);
                          }

                          return Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: DropdownButton(
                                isExpanded: true,
                                hint: Text('Employee'),
                                value: sale.nameEmployee == null
                                    ? employeeValue
                                    : sale.nameEmployee,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      sale.nameEmployee = employeeValue = value;
                                    },
                                  );
                                },
                                items: nameEmployee.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList()),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: TextFormField(
                      //autofocus: true,
                      initialValue: sale.date == null ? dataValue : sale.date,
                      onChanged: (text) {
                        sale.date = dataValue = text;
                      },
                      validator: (String value) {
                        return value.isEmpty ? 'Required field.' : null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Date:',
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: TextFormField(
                      //autofocus: true,
                      initialValue: sale.productAmount == null
                          ? amountValue
                          : sale.productAmount.toString(),
                      onChanged: (text) {
                        amountValue = text;
                        sale.productAmount = text != '' ? num.parse(text) : 0;
                      },
                      validator: (String value) {
                        return value.isEmpty ? 'Required field.' : null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Amount:',
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(),
                      ),
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
                          if (!_validate()) return;

                          if (title == 'New Sale') {
                            // add sale
                            DocumentReference refsale =
                                await DatabaseServiceFirestore().addDoc(
                              collectionName: 'sale',
                              instance: sale,
                            );
                            //update liquidMoney
                            finance.liquidMoney += sale.value;
                            finance.actions.add(refsale);
                            await DatabaseServiceFirestore().setDoc(
                              collectionName: 'finance',
                              instance: finance,
                              uid: ceo.uid,
                            );
                          } else {
                            //update sale
                            await DatabaseServiceFirestore().setDoc(
                              collectionName: 'sale',
                              instance: sale,
                              uid: sale.id,
                            );
                            //update liquidMoney
                            finance.liquidMoney += num.parse("-$money");
                            finance.liquidMoney += sale.value;
                            //finance.actions.add(sale.id);
                            await DatabaseServiceFirestore().setDoc(
                              collectionName: 'finance',
                              instance: finance,
                              uid: ceo.uid,
                            );
                          }

                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Confirm',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _validate() {
    if ((productValue == null || employeeValue == null) &&
        title == 'New Sale') {
      ConstantesWidgets.dialog(
        context: context,
        title: Text('Fail'),
        content: Text('All fields are mandatory.'),
        actions: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Ok'),
        ),
      );
      return false;
    } else if (_formKey.currentState.validate()) {
      String idProduct, idEmployee;
      num valueProduct;

      employeeValue = employeeValue == null ? sale.nameEmployee : employeeValue;
      productValue = productValue == null ? sale.nameProduct : productValue;
      dataValue = dataValue == null ? sale.date : dataValue;
      amountValue =
          amountValue == null ? sale.productAmount.toString() : amountValue;

      //recovery employee id
      for (var item in lEmployees) {
        if (item.name == employeeValue) idEmployee = item.uid;
      }
      //recovery employee reference
      DocumentReference employee = DatabaseServiceFirestore()
          .getRef(collectionNamed: 'employee', uid: idEmployee);

      //recovery product id, value product and update products
      for (var item in lProducts) {
        if (item.name == productValue) {
          idProduct = item.id;
          valueProduct = item.value;
          item.amount -= (num.parse(amountValue) - amount);
          DatabaseServiceFirestore().setDoc(
            collectionName: 'product',
            instance: item,
            uid: item.id,
          );
        }
      }
      //recovery product reference
      DocumentReference product = DatabaseServiceFirestore()
          .getRef(collectionNamed: 'product', uid: idProduct);

      sale.employee = employee;
      sale.product = product;
      sale.company = ceo.company;
      sale.date = dataValue;
      sale.nameEmployee = employeeValue;
      sale.nameProduct = productValue;
      sale.productAmount = num.parse(amountValue);
      sale.value = num.parse(amountValue) * valueProduct;

      return true;
    } else {
      return false;
    }
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

List sales; //list of sales
Ceo ceo; // object ceo
Employee employee; // object employee
String user; //identify ceo/employee screen
List loadSales() {
  //to return list sales
  return sales;
}

buildBodySales(List obj, BuildContext context) {
  // list obj contains string to determinate ceo or employee and contains object properties
  user = obj[0];
  Finances finance;
  var product;
  if (user == "ceo") {
    ceo = obj[1];
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseServiceFirestore().getDocs(
          collectionNamed: "sale", field: "company", resultfield: ceo.company),
      builder: (context, snapshot) {
        while (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return ConstantesWidgets.loading();
        }
        sales = snapshot.data.docs.map(
          (DocumentSnapshot e) {
            return Sale.fromJson(e.data(), e.id);
          },
        ).toList();
        return ListView.builder(
          itemCount: sales.length,
          itemBuilder: (BuildContext ctxt, int index) {
            Sale sale = sales[index];
            return StreamBuilder(
              stream: DatabaseServiceFirestore().getDoc(
                collectionName: 'finance',
                uid: ceo.uid,
              ),
              builder: (context, snapshot) {
                while (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return LinearProgressIndicator(
                    backgroundColor: Colors.teal,
                  );
                }

                finance = Finances.fromSnapshot(snapshot);

                return StreamBuilder(
                  stream: DatabaseServiceFirestore().getDocs(
                    collectionNamed: 'product',
                    field: 'name',
                    resultfield: sale.nameProduct,
                  ),
                  builder: (context, snapshot1) {
                    while (snapshot1.hasError ||
                        snapshot1.connectionState == ConnectionState.waiting) {
                      return LinearProgressIndicator(
                        backgroundColor: Colors.teal,
                      );
                    }
                    product = snapshot1.data.docs.map(
                      (DocumentSnapshot e) {
                        return Product.fromJson(e.data(), e.id);
                      },
                    ).toList();
                    product = product[0];

                    return Dismissible(
                      onDismissed: (direction) async {
                        //update finance
                        finance.liquidMoney -= sale.value;
                        DocumentReference refSale =
                            DatabaseServiceFirestore().getRef(
                          collectionNamed: 'sale',
                          uid: sale.id,
                        );
                        finance.actions.remove(refSale);
                        await DatabaseServiceFirestore().setDoc(
                          collectionName: 'finance',
                          instance: finance,
                          uid: ceo.uid,
                        );

                        //update product
                        product.amount += sale.productAmount;
                        await DatabaseServiceFirestore().setDoc(
                          collectionName: 'product',
                          instance: product,
                          uid: product.id,
                        );

                        //delete sale
                        await DatabaseServiceFirestore()
                            .deleteDoc(uid: sale.id, collectionName: "sale");
                      },
                      child: ListTile(
                        leading: Icon(Icons.point_of_sale),
                        title: Text("${sale.nameProduct}"),
                        subtitle: Text("Value: ${sale.value}"),
                        trailing: TextButton(
                          onPressed: () {
                            List args = ["Edit Sale", ceo, sale];
                            Navigator.pushNamed(context, 'addOrEditSale',
                                arguments: args);
                          },
                          child: Icon(Icons.edit, color: Colors.grey),
                        ),
                        onTap: () {
                          ConstantesWidgets.dialog(
                            context: context,
                            title: Text('Sale'),
                            content: Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text('Sale value: \$ ${sale.value}'),
                                Text('Date: ${sale.date}'),
                                Text('Product: ${sale.nameProduct}'),
                                Text('Amount: ${sale.productAmount}'),
                                Text(
                                    'Product value: \$ ${sale.value / sale.productAmount}'),
                                Text('Employee: ${sale.nameEmployee}'),
                              ],
                            ),
                            actions: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Ok'),
                            ),
                          );
                        },
                      ),
                      key: UniqueKey(),
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
          },
        );
      },
    );
  } else if (user == "employee") {
    employee = obj[1];
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseServiceFirestore().getDocs(
          collectionNamed: "sale",
          field: "employeeid",
          resultfield: employee.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        sales = snapshot.data.docs.map(
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
//function to search bar on product page
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
    final listSales = query.isEmpty
        ? loadSales()
        : loadSales().where((p) => p.nameProduct.startsWith(query)).toList();
    return user == "ceo"
        ? (listSales.isEmpty
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "No results found.",
                  style: TextStyle(fontSize: 20),
                ),
              ])
            : ListView.builder(
                itemCount: listSales.length,
                itemBuilder: (context, index) {
                  final Sale sale = listSales[index];

                  return Dismissible(
                    onDismissed: (direction) {
                      DatabaseServiceFirestore()
                          .deleteDoc(uid: sale.id, collectionName: "sale");
                    },
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.point_of_sale),
                        title: RichText(
                          text: TextSpan(
                              text: sale.nameProduct.substring(0, query.length),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                    text: sale.nameProduct
                                        .substring(query.length),
                                    style: TextStyle(color: Colors.grey))
                              ]),
                        ),
                        subtitle: Text("Amount: ${sale.date}"),
                        trailing: TextButton(
                          onPressed: () {
                            List args = ["Edit Sale", ceo, sale];
                            Navigator.pushNamed(context, 'addOrEditSale',
                                arguments: args);
                          },
                          child: Icon(Icons.edit, color: Colors.grey),
                        ),
                        onTap: () {
                          ConstantesWidgets.dialog(
                            context: context,
                            title: Text('Sale'),
                            content: Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text('Sale value: \$ ${sale.value}'),
                                Text('Date: ${sale.date}'),
                                Text('Product: ${sale.nameProduct}'),
                                Text('Amount: ${sale.productAmount}'),
                                Text(
                                    'Product value: \$ ${sale.value / sale.productAmount}'),
                                Text('Employee: ${sale.nameEmployee}'),
                              ],
                            ),
                            actions: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Ok'),
                            ),
                          );
                        },
                      ),
                    ),
                    key: Key(sale.id),
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
              ))
        : listSales.isEmpty
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "No results found.",
                  style: TextStyle(fontSize: 20),
                ),
              ])
            : ListView.builder(
                itemCount: listSales.length,
                itemBuilder: (context, index) {
                  final Sale sale = listSales[index];

                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.point_of_sale),
                      title: RichText(
                        text: TextSpan(
                            text: sale.nameProduct.substring(0, query.length),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      sale.nameProduct.substring(query.length),
                                  style: TextStyle(color: Colors.grey))
                            ]),
                      ),
                      subtitle: Text("Amount: ${sale.date}"),
                      trailing: TextButton(
                        onPressed: () {
                          List args = ["Edit Sale", ceo, sale];
                          Navigator.pushNamed(context, 'addOrEditSale',
                              arguments: args);
                        },
                        child: Icon(Icons.edit, color: Colors.grey),
                      ),
                      onTap: () {
                        ConstantesWidgets.dialog(
                          context: context,
                          title: Text('Sale'),
                          content: Wrap(
                            direction: Axis.vertical,
                            children: [
                              Text('Sale value: \$ ${sale.value}'),
                              Text('Date: ${sale.date}'),
                              Text('Product: ${sale.nameProduct}'),
                              Text('Amount: ${sale.productAmount}'),
                              Text(
                                  'Product value: \$ ${sale.value / sale.productAmount}'),
                              Text('Employee: ${sale.nameEmployee}'),
                            ],
                          ),
                          actions: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Ok'),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listSales = query.isEmpty
        ? loadSales()
        : loadSales().where((p) => p.nameProduct.startsWith(query)).toList();

    return listSales.isEmpty
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "No results found.",
              style: TextStyle(fontSize: 20),
            ),
          ])
        : ListView.builder(
            itemCount: listSales.length,
            itemBuilder: (context, index) {
              final Sale sale = listSales[index];

              return Card(
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      text: sale.nameProduct.substring(0, query.length),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                            text: sale.nameProduct.substring(query.length),
                            style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
