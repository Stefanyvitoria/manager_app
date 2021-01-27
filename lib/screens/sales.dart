import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sales",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addSale');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.teal[300],
      ),
      body: ListView(
        //will be a listview.builder stream
        children: [
          Dismissible(
            onDismissed: (direction) {},
            child: ListTile(
                leading: Icon(Icons.point_of_sale),
                title: Text("Sale1"),
                subtitle: Text("Value: R\$ 9999"),
                trailing: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'editSale');
                  },
                  child: Icon(Icons.edit),
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
                                FlatButton(
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
                trailing: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'editSale');
                  },
                  child: Icon(Icons.edit),
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
                                FlatButton(
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
                trailing: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'editSale');
                  },
                  child: Icon(Icons.edit),
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
                                FlatButton(
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
                trailing: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'editSale');
                  },
                  child: Icon(Icons.edit),
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
                                FlatButton(
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
        title: Text(
          "Edit Sale",
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
                  child: RaisedButton(
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

class AddSale extends StatefulWidget {
  @override
  _AddSale createState() => _AddSale();
}

class _AddSale extends State<AddSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Sale",
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
                  child: RaisedButton(
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
