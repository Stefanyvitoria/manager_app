import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/company.dart';
import 'package:manager_app/models/employee.dart';
import 'package:manager_app/screens/Loading.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/models/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manager_app/services/database_service.dart';

List productsList;
Company company;
List loadProducts() {
  return productsList;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _currentUser = FirebaseAuth.instance.currentUser;
  String _type;

  @override
  Widget build(BuildContext context) {
    _type = ModalRoute.of(context).settings.arguments;

    return _type == "client"
        ? StreamBuilder(
            stream: DatabaseServiceFirestore()
                .getAllDocs(collectionNamed: 'product'),
            builder: (context, snapshot) {
              while (snapshot.hasError ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return ConstantesWidgets.loading();
              }

              return Scaffold(
                appBar: _builAppBarHome(snapshot),
                body: _builBodyHome(snapshot),
              );
            },
          )
        : StreamBuilder(
            stream: DatabaseServiceFirestore()
                .getDoc(uid: _currentUser.uid, collectionName: _type),
            builder: (context, snapshot) {
              while (snapshot.hasError ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return ConstantesWidgets.loading();
              }
              return Scaffold(
                appBar: _builAppBarHome(snapshot),
                body: _builBodyHome(snapshot),
              );
            },
          );
  }

  AppBar _builAppBarHome(AsyncSnapshot snapshot) {
    //Returns the CEO bar app if user.type equals 'ceo'.
    // Returns the employee bar app if user.type equals 'employee'.
    // Returns the client bar app if user.type equals 'client'.
    if (_type == "ceo") {
      Ceo ceo = Ceo.fromSnapshot(snapshot); //current user
      return AppBar(
        title: Text("${ceo.name}".substring(0, 1).toUpperCase() +
            "${ceo.name}".substring(1)),
        actions: [
          TextButton(
            onPressed: () {
              DatabaseServiceAuth.logOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      );
    } else if (_type == "employee") {
      return AppBar(
        title: Text(
          'SR Manager - Employee',
          style: TextStyle(fontSize: 19),
        ),
        actions: [
          TextButton(
            onPressed: () {
              DatabaseServiceAuth.logOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      );
    } else {
      return AppBar(
        title: Text(
          'SR Manager ',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {
              showSearch(context: context, delegate: DataSearchProduct());
            },
            child: Icon(Icons.search, color: Colors.white),
          ),
        ],
      );
    }
  }

  Widget _builBodyHome(AsyncSnapshot snapshot) {
    //Returns the CEO body if user.type equals 'ceo'.
    //Returns the staff if user.type is equal to 'employee'.
    //Returns the customer body if user.type is equal to 'customer'.
    if (_type == "ceo") {
      Ceo ceo = Ceo.fromSnapshot(snapshot); //current user
      Future<dynamic> dialogHome() {
        return ConstantesWidgets.dialog(
          context: context,
          title: Text('fail'),
          content:
              Text('company not registered.\nFirst register your company.'),
          actions: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok'),
          ),
        );
      }

      return ListView(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        children: <Widget>[
          Container(
            width: double.maxFinite,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: (Theme.of(context).brightness == Brightness.light)
                  ? ConstantesImages.logo1
                  : ConstantesImages.logo4,
              scale: 0.1,
            )),
          ),
          ConstantesSpaces.spaceDivider,
          if (ceo.company == null) ...[
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('company', arguments: ceo);
              },
              leading: Icon(Icons.account_balance),
              title: Text(
                'Register Company',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(),
          ],
          if (ceo.password == null) ...[
            ListTile(
              leading: Icon(Icons.verified),
              title: Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                ConstantesWidgets.dialog(
                  context: context,
                  title: Text('Confirm Password'),
                  content: Wrap(
                    children: [
                      Text(
                          'You recently tried to change or changed your password, please confirm your password.'),
                      TextFormField(
                        onChanged: (txt) {
                          ceo.password = txt;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'updated password:',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  actions: TextButton(
                    onPressed: () {
                      DatabaseServiceFirestore().setDoc(
                        collectionName: 'ceo',
                        instance: ceo,
                        uid: ceo.uid,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirm'),
                  ),
                );
              },
            ),
            Divider(),
          ],
          ListTile(
            onTap: () {
              if (ceo.company == null) {
                dialogHome();
              } else {
                Navigator.pushNamed(context, 'finances', arguments: ceo);
              }
            },
            leading: Icon(Icons.account_balance_wallet),
            title: Text(
              'Finances',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              if (ceo.company == null) {
                dialogHome();
              } else {
                Navigator.pushNamed(context, "employees", arguments: ceo);
              }
            },
            leading: Icon(Icons.people),
            title: Text(
              'Employees',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              if (ceo.company == null) {
                dialogHome();
              } else {
                Navigator.pushNamed(context, "products", arguments: ceo);
              }
            },
            leading: Icon(Icons.inbox_rounded),
            title: Text(
              'Products',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              if (ceo.company == null) {
                dialogHome();
              } else {
                List arg = ["ceo", ceo];
                Navigator.pushNamed(context, 'sales', arguments: arg);
              }
            },
            leading: Icon(Icons.attach_money),
            title: Text(
              'Sales',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              if (ceo.company == null) {
                dialogHome();
              } else {
                Navigator.pushNamed(context, 'statistics');
              }
            },
            leading: Icon(FontAwesomeIcons.chartArea),
            title: Text(
              'Statistics',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('profile', arguments: ceo);
            },
            leading: Icon(
              Icons.account_box,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('settings', arguments: ceo);
            },
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ConstantesSpaces.spacer,
        ],
      );
    } else if (_type == "employee") {
      Employee employee = Employee.fromSnapshot(snapshot);
      return ListView(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        children: <Widget>[
          ListTile(
            leading: Image(image: ConstantesImages.pLogo),
            title: Wrap(children: [
              Text(
                '${employee.name}'.substring(0, 1).toUpperCase() +
                    "${employee.name}".substring(1) +
                    ',\n${employee.occupation}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ]),
          ),
          ConstantesSpaces.spaceDivider,
          if (employee.password == null) ...[
            ListTile(
              leading: Icon(Icons.verified),
              title: Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                ConstantesWidgets.dialog(
                  context: context,
                  title: Text('Confirm Password'),
                  content: Wrap(
                    children: [
                      Text(
                          'You recently changed your password, please confirm your password.'),
                      TextFormField(
                        onChanged: (txt) {
                          employee.password = txt;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'updated password:',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  actions: TextButton(
                    onPressed: () {
                      DatabaseServiceFirestore().setDoc(
                        collectionName: 'employee',
                        instance: employee,
                        uid: employee.uid,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirm'),
                  ),
                );
              },
            ),
            Divider(),
          ],
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "ranking", arguments: employee);
            },
            leading: Icon(
              Icons.star,
            ),
            title: Text(
              'Ranking',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              List arg = ["employee", employee];
              Navigator.pushNamed(context, "sales", arguments: arg);
            },
            leading: Icon(
              Icons.attach_money,
            ),
            title: Text(
              'Sales',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'notes', arguments: employee);
            },
            leading: Icon(Icons.book),
            title: Text(
              'Notes',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('profile', arguments: employee);
            },
            leading: Icon(
              Icons.account_box,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('settings', arguments: employee);
            },
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    } else {
      productsList = snapshot.data.docs.map(
        //map elements into object product
        (DocumentSnapshot e) {
          return Product.fromJson(e.data(), e.id);
        },
      ).toList();

      return ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          while (!snapshot.hasData) {
            return Loading();
          }
          Product product = productsList[index];
          return FutureBuilder(
            future: _getCompany(product),
            builder: (context, AsyncSnapshot snapshot) {
              company = snapshot.data;

              return Card(
                child: ListTile(
                  leading: Icon(Icons.all_inbox),
                  title: Text(product.name),
                  subtitle: Text("Value: ${product.value}"),
                  onTap: () {
                    ConstantesWidgets.dialog(
                      context: context,
                      title: Text('${product.name}'),
                      content: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text('Value: ${product.value}'),
                          Text('Amount: ${product.amount}'),
                          Text('Company: ${company.name}'),
                          Text('Phone: ${company.phone}')
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
              );
            },
          );
        },
      );
    }
  }
}

Future<Company> _getCompany(Product product) async {
  //use to get company object
  Company company = await product.company.get().then((value) {
    return Company.fromJson(value.data());
  });
  print(company.name);
  return company;
}

class DataSearchProduct extends SearchDelegate<String> {
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

              return Card(
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
                  subtitle: Text("Value: ${product.value}"),
                  onTap: () {
                    ConstantesWidgets.dialog(
                      context: context,
                      title: Text('${product.name}'),
                      content: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text('Value: ${product.value}'),
                          Text('Amount: ${product.amount}'),
                          Text('Company: ${company.name}'),
                          Text('Phone: ${company.phone}')
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
              final Product product = productsList[index];

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
