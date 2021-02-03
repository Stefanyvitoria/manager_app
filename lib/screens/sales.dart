import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/models/user.dart';

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    if (user == null) user = User();
    return Scaffold(
        appBar: buildAppbarSales(user, context),
        floatingActionButton: buildFloatingButtonSales(user, context),
        body: buildBodySales(user, context));
  }
}

class EditSale extends StatefulWidget {
  @override
  _EditSaleState createState() => _EditSaleState();
}

class _EditSaleState extends State<EditSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: ConstantesGradiente.gradientAppBar(context),
        title: Text(
          "Edit Sale",
        ),
      ),
      body: Container(
        decoration: ConstantesGradiente.gradientContainer(context),
        child: SingleChildScrollView(
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
                      labelText: 'Product:',
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
                      labelText: 'Employee:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (text) {},
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
                    onChanged: (text) {},
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantity:',
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
      ),
    );
  }
}

class AddSale extends StatefulWidget {
  @override
  _AddSale createState() => _AddSale();
}

class _AddSale extends State<AddSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: ConstantesGradiente.gradientAppBar(context),
        title: Text(
          "New Sale",
        ),
      ),
      body: Container(
        decoration: ConstantesGradiente.gradientContainer(context),
        child: SingleChildScrollView(
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
                      labelText: 'Product:',
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
                      labelText: 'Employee:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (text) {},
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
                    onChanged: (text) {},
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantity:',
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
      ),
    );
  }
}

buildAppbarSales(User user, BuildContext context) {
  if (user.type == "ceo") {
    return AppBar(
        flexibleSpace: ConstantesGradiente.gradientAppBar(context),
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
  } else if (user.type == "employee") {
    return AppBar(
        flexibleSpace: ConstantesGradiente.gradientAppBar(context),
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

buildFloatingButtonSales(User user, BuildContext context) {
  if (user.type == "ceo") {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, 'addSale');
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
      backgroundColor: Colors.teal[300],
    );
  } else {}
}

buildBodySales(User user, BuildContext context) {
  if (user.type == "ceo") {
    return Container(
      decoration: ConstantesGradiente.gradientContainer(context),
      child: ListView(
        //will be a listview.builder stream
        children: [
          Dismissible(
            onDismissed: (direction) {},
            child: ListTile(
                leading: Icon(Icons.point_of_sale),
                title: Text("Sale1"),
                subtitle: Text("Value: R\$ 9999"),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'editSale');
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
                                "Sale1\nvalue: R\$9999\ndate: 99/99/99\nseller: robert\nproduct: chocolate\nquantity: 99\n",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),
                          ],
                        );
                      });
                }),
            key: Key("1"),
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
          ),
          Dismissible(
            onDismissed: (direction) {},
            child: ListTile(
                leading: Icon(Icons.point_of_sale),
                title: Text("Sale1"),
                subtitle: Text("Value: R\$ 9999"),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'editSale');
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
                                "Sale1\nvalue: R\$9999\ndate: 99/99/99\nseller: robert\nproduct: chocolate\nquantity: 99\n",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),
                          ],
                        );
                      });
                }),
            key: Key("1"),
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
          ),
          Dismissible(
            onDismissed: (direction) {},
            child: ListTile(
                leading: Icon(Icons.point_of_sale),
                title: Text("Sale1"),
                subtitle: Text("Value: R\$ 9999"),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'editSale');
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
                                "Sale1\nvalue: R\$9999\ndate: 99/99/99\nseller: robert\nproduct: chocolate\nquantity: 99\n",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),
                          ],
                        );
                      });
                }),
            key: Key("1"),
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
          ),
          Dismissible(
            onDismissed: (direction) {},
            child: ListTile(
                leading: Icon(Icons.point_of_sale),
                title: Text("Sale1"),
                subtitle: Text("Value: R\$ 9999"),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'editSale');
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
                                "Sale1\nvalue: R\$9999\ndate: 99/99/99\nseller: robert\nproduct: chocolate\nquantity: 99\n",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),
                          ],
                        );
                      });
                }),
            key: Key("1"),
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
          ),
        ],
      ),
    );
  } else if (user.type == "employee") {
    return Container(
      decoration: ConstantesGradiente.gradientContainer(context),
      child: ListView(
        //will be a listview.builder stream
        children: [
          ListTile(
              leading: Icon(Icons.point_of_sale),
              title: Text("Sale1"),
              subtitle: Text("Value: R\$ 9999"),
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
                              "Sale1\nvalue: R\$9999\ndate: 99/99/99\nseller: robert\nproduct: chocolate\nquantity: 99\n",
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          ),
                        ],
                      );
                    });
              }),
          ListTile(
              leading: Icon(Icons.point_of_sale),
              title: Text("Sale1"),
              subtitle: Text("Value: R\$ 9999"),
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
                              "Sale1\nvalue: R\$9999\ndate: 99/99/99\nseller: robert\nproduct: chocolate\nquantity: 99\n",
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          ),
                        ],
                      );
                    });
              }),
          ListTile(
              leading: Icon(Icons.point_of_sale),
              title: Text("Sale1"),
              subtitle: Text("Value: R\$ 9999"),
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
                              "Sale1\nvalue: R\$9999\ndate: 99/99/99\nseller: robert\nproduct: chocolate\nquantity: 99\n",
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          ),
                        ],
                      );
                    });
              }),
          ListTile(
              leading: Icon(Icons.point_of_sale),
              title: Text("Sale1"),
              subtitle: Text("Value: R\$ 9999"),
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
                              "Sale1\nvalue: R\$9999\ndate: 99/99/99\nseller: robert\nproduct: chocolate\nquantity: 99\n",
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          ),
                        ],
                      );
                    });
              }),
          ListTile(
              leading: Icon(Icons.point_of_sale),
              title: Text("Sale1"),
              subtitle: Text("Value: R\$ 9999"),
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
                              "Sale1\nvalue: R\$9999\ndate: 99/99/99\nseller: robert\nproduct: chocolate\nquantity: 99\n",
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          ),
                        ],
                      );
                    });
              }),
        ],
      ),
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
    return Container(
      decoration: ConstantesGradiente.gradientContainer(context),
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {},
          leading: Icon(Icons.money),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
        ),
        itemCount: suggestionList.length,
      ),
    );
  }
}
