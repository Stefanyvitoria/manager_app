import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/product.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/database_service.dart';

class Products extends StatefulWidget {
  @override
  ProductsState createState() => ProductsState();
}

List<Product> products;
List<Product> loadProducts() {
  return products;
}

Ceo ceo;

class ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    Ceo ceo = ModalRoute.of(context).settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseServiceFirestore().getDocs(
            field: "company",
            resultfield: ceo.company,
            collectionNamed: 'product'),
        builder: (context, snapshot) {
          while (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return ConstantesWidgets.loading();
          }

          products = snapshot.data.docs.map(
            //map elements into object product
            (DocumentSnapshot e) {
              return Product.fromJson(e.data(), e.id);
            },
          ).toList();

          return Scaffold(
            appBar: AppBar(
                title: Text(
                  "Products",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: DataSearchProduct());
                    },
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                List args = ["New Product", ceo, Product()];
                Navigator.pushNamed(context, 'addOrEditProduct',
                    arguments: args);
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
              backgroundColor: Colors.teal[300],
            ),
            body: ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext ctxt, int index) {
                Product product = products[index];
                return Dismissible(
                  onDismissed: (direction) async {
                    //delete product
                    await DatabaseServiceFirestore().deleteDoc(
                        uid: products[index].id, collectionName: "product");
                  },
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.all_inbox),
                      title: Text(product.name),
                      subtitle: Text("Amount: ${product.amount}"),
                      trailing: TextButton(
                        onPressed: () {
                          List args = ["Edit Product", ceo, product];
                          Navigator.pushNamed(context, 'addOrEditProduct',
                              arguments: args);
                        },
                        child: Icon(Icons.edit, color: Colors.grey),
                      ),
                      onTap: () {
                        ConstantesWidgets.dialog(
                          context: context,
                          title: Text('${product.name}'),
                          content: Wrap(
                            direction: Axis.vertical,
                            children: [
                              Text('Value: ${product.value}'),
                              Text('Amount: ${product.amount}')
                            ],
                          ),
                          actions: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Ok'),
                          ),
                        );
                      },
                    ),
                  ),
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
            ),
          );
        });
  }
}

class AddOrEditProduct extends StatefulWidget {
  @override
  _AddOrEditProductState createState() => _AddOrEditProductState();
}

class _AddOrEditProductState extends State<AddOrEditProduct> {
  final _formKey = GlobalKey<FormState>();
  Product product;
  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context).settings.arguments;
    ceo = args[1];
    String title = args[0];
    product = args[2];

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
                    initialValue: product.name,
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onChanged: (text) {
                      product.name = text;
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
                    initialValue:
                        product.amount == null ? '' : product.amount.toString(),
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onChanged: (text) {
                      product.amount = text != '' ? num.parse(text) : 0;
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
                    initialValue:
                        product.value == null ? '' : product.value.toString(),
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onChanged: (text) {
                      product.value = num.parse(text.replaceAll(',', ''));
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
                      onPressed: () async {
                        if (!_validate()) return;
                        //add product.
                        await DatabaseServiceFirestore().setDoc(
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
      product.company = ceo.company;
      return true;
    }
    return false;
  }
}

class DataSearchProduct extends SearchDelegate<Product> {
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
    final listProducts = query.isEmpty
        ? loadProducts()
        : loadProducts().where((p) => p.name.startsWith(query)).toList();
    return listProducts.isEmpty
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "No results found.",
              style: TextStyle(fontSize: 20),
            ),
          ])
        : ListView.builder(
            itemCount: listProducts.length,
            itemBuilder: (context, index) {
              final Product product = listProducts[index];

              return Dismissible(
                onDismissed: (direction) {
                  DatabaseServiceFirestore().deleteDoc(
                      uid: listProducts[index].id, collectionName: "product");
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.all_inbox),
                    title: RichText(
                      text: TextSpan(
                          text: product.name.substring(0, query.length),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                                text: product.name.substring(query.length),
                                style: TextStyle(color: Colors.grey))
                          ]),
                    ),
                    subtitle: Text("Amount: ${product.amount}"),
                    trailing: TextButton(
                      onPressed: () {
                        List args = ["Edit Product", ceo, product];
                        Navigator.pushNamed(context, 'addOrEditProduct',
                            arguments: args);
                      },
                      child: Icon(Icons.edit, color: Colors.grey),
                    ),
                    onTap: () {
                      ConstantesWidgets.dialog(
                        context: context,
                        title: Text('${product.name}'),
                        content: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text('Value: ${product.value}'),
                            Text('Amount: ${product.amount}')
                          ],
                        ),
                        actions: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Ok'),
                        ),
                      );
                    },
                  ),
                ),
                key: Key(product.id),
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
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listProducts = query.isEmpty
        ? loadProducts()
        : loadProducts().where((p) => p.name.startsWith(query)).toList();

    return listProducts.isEmpty
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "No results found.",
              style: TextStyle(fontSize: 20),
            ),
          ])
        : ListView.builder(
            itemCount: listProducts.length,
            itemBuilder: (context, index) {
              final Product product = products[index];

              return Card(
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      text: product.name.substring(0, query.length),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                            text: product.name.substring(query.length),
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
