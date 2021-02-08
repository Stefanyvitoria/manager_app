import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/product.dart';
import 'package:manager_app/services/database_service.dart';

import 'Loading.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var _currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    print("ceo UID ${_currentUser.uid}");
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
          Navigator.pushNamed(context, 'addProduct');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.teal[300],
      ),
      body: StreamBuilder<QuerySnapshot>(
        //will be a listview.builder stream
        stream: DatabaseServiceFirestore().getDocs(
            field: "refUID",
            resultfield: _currentUser.uid,
            collectioNnamed: 'product'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading(); //widget loading
          }
          List products = snapshot.data.docs.map(
            //map elements into object product
            (DocumentSnapshot e) {
              return Product.fromJson(e.data());
            },
          ).toList();

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Dismissible(
                onDismissed: (direction) {},
                child: ListTile(
                    leading: Icon(Icons.point_of_sale),
                    title: Text(products[index].name),
                    subtitle: Text("value: ${products[index].value}"),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'editProduct');
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
                                    "${products[index].name}\ncompany: ${products[index].company}\nvalue: R\$ ${products[index].value}",
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

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Product",
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width, //size of screen
          height: MediaQuery.of(context).size.height, //size of screen
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  onChanged: (text) {},
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
                  onChanged: (text) {},
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Company:',
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {},
                  keyboardType: TextInputType.text,
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
    );
  }
}

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Product",
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width, //size of screen
          height: MediaQuery.of(context).size.height, //size of screen
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  onChanged: (text) {},
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
                  onChanged: (text) {},
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Company:',
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {},
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
    );
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
