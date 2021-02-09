import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/product.dart';
import 'package:manager_app/services/database_service.dart';

import 'Loading.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  //var _currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    //print("ceo UID ${_currentUser.uid}");
    Ceo ceo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Products",
          ),
          actions: [
            TextButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearchProduct());
              },
              child: Icon(Icons.search, color: Colors.white),
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List args = ["New Product", ceo, null];
          Navigator.pushNamed(context, 'addOrEditProduct', arguments: args);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.teal[300],
      ),
      body: StreamBuilder<QuerySnapshot>(
        //will be a listview.builder stream
        stream: DatabaseServiceFirestore().getDocs(
            field: "refUID", resultfield: ceo.uid, collectionNamed: 'product'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading(); //widget loading
          }
          List products = snapshot.data.docs.map(
            //map elements into object product
            (DocumentSnapshot e) {
              return Product.fromJson(e.data(), e.id);
            },
          ).toList();

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Dismissible(
                onDismissed: (direction) {
                  DatabaseServiceFirestore().deleteDoc(
                      uid: products[index].id, collectionName: "product");
                },
                child: ListTile(
                    leading: Icon(Icons.point_of_sale),
                    title: Text(products[index].name),
                    subtitle: Text("Amount: ${products[index].amount}"),
                    trailing: TextButton(
                      onPressed: () {
                        List args = ["Edit Product", ceo, products[index].id];
                        Navigator.pushNamed(context, 'addOrEditProduct',
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
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ),
                                    ),
                                  ],
                                  title: Text(
                                    "${products[index].name}\nAmount: ${products[index].amount}\nCompany: ${products[index].company}\nEach Value: R\$ ${products[index].value}",
                                    style: TextStyle(color: Colors.grey[800]),
                                  ),
                                ),
                              ],
                            );
                          });
                    }),
                key: Key(products[index].id),
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
      ),
    );
  }
}

class AddOrEditProduct extends StatefulWidget {
  @override
  _AddOrEditProductState createState() => _AddOrEditProductState();
}

class _AddOrEditProductState extends State<AddOrEditProduct> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _valueController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  Product product = Product();
  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context).settings.arguments;
    Ceo ceo = args[1];
    String title = args[0];
    product.id = args[2];
    return Scaffold(
      appBar: AppBar(title: Text(title)),
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
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    controller: _nameController,
                    onSaved: (text) {
                      _nameController.text = text;
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
                    controller: _amountController,
                    onSaved: (text) {
                      _amountController.text = text;
                    },
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
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    controller: _valueController,
                    onSaved: (text) {
                      _valueController.text = text;
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
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_validate()) return;
                        product.refUID =
                            ceo.uid; // add reference id of ceo to product
                        DatabaseServiceFirestore().setDoc(
                            collectionName: 'product',
                            instance: product,
                            uid: product.id);
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
      product.name = _nameController.text;
      product.value = _valueController.text;
      product.amount = _amountController.text;
      return true;
    }
    return false;
  }
}

class DataSearchProduct extends SearchDelegate<String> {
  //function to search bar on sales page
  final sales = [
    "Product1",
    "Product2",
    "Product3",
    "Product4",
    "Product5",
  ];
  final recentSales = [
    "Product1",
    "Product2",
    "Product3",
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
        leading: Icon(Icons.indeterminate_check_box),
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
