import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/screens/Loading.dart';
import 'package:manager_app/services/database_service.dart';
import 'package:manager_app/models/employee.dart';

class Employees extends StatefulWidget {
  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  Ceo ceo;
  @override
  Widget build(BuildContext context) {
    ceo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Employees",
          ),
          actions: [
            TextButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearchEmployee());
              },
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addEmployee', arguments: ceo);
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder(
        stream: DatabaseServiceFirestore().getDocs(
            collectioNnamed: 'employee',
            field: "company",
            resultfield: "companySte"),
        builder: (context, AsyncSnapshot snapshot) {
          while (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          if (!snapshot.hasData) {
            return Loading(); //widget loading
          }
          List listEmployees = snapshot.data.docs.map(
            //map elements into object product
            (DocumentSnapshot e) {
              return Employee.fromJson(e.data());
            },
          ).toList();

          return ListView.builder(
            itemCount: listEmployees.length,
            itemBuilder: (context, int index) {
              Employee employee = listEmployees[index];
              return Dismissible(
                onDismissed: (direction) {
                  DatabaseServiceFirestore()
                      .deleteDoc(collectionName: 'employee', uid: employee.uid);
                },
                child: ListTile(
                    leading: Icon(Icons.point_of_sale),
                    title: Text("${employee.name}"),
                    subtitle: Text("Occupation: ${employee.occupation}"),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'editEmployee',
                            arguments: listEmployees[index]);
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
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
                                "Name: ${employee.name}\nOccupation: ${employee.occupation}\nAdmissionDate: 99/99/99\nQuantity of Sales: 99", //****** a terminar
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            );
                          });
                    }),
                key: Key("2"),
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

class EditEmployee extends StatefulWidget {
  @override
  _EditEmployeeState createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final _formKey = GlobalKey<FormState>();

  Employee employee;

  @override
  Widget build(BuildContext context) {
    employee = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Employee",
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
                    initialValue: employee.name,
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onChanged: (txt) {
                      employee.name = txt;
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
                    initialValue: employee.email,
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onChanged: (txt) {
                      employee.email = txt.trim();
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: employee.occupation,
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onChanged: (txt) {
                      employee.occupation = txt;
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Occupation:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: employee.admissionDate,
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onChanged: (txt) {
                      employee.admissionDate = txt;
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: 'Admission date:',
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
                        DatabaseServiceFirestore().setDoc(
                          collectionName: 'employee',
                          uid: employee.uid,
                          instance: employee,
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

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ocupacionController = TextEditingController();
  TextEditingController _admissionDateController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Employee employee = Employee();
  Ceo ceo;

  @override
  Widget build(BuildContext context) {
    ceo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Employee",
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
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onSaved: (txt) {
                      _nameController.text = txt;
                    },
                    controller: _nameController,
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
                    onSaved: (txt) {
                      _emailController.text = txt;
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onSaved: (txt) {
                      _passwordController.text = txt;
                    },
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Password:',
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
                    onSaved: (txt) {
                      _ocupacionController.text = txt;
                    },
                    controller: _ocupacionController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Occupation:',
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
                    onSaved: (txt) {
                      _admissionDateController.text = txt;
                    },
                    controller: _admissionDateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: 'Admission date:',
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
                        await DatabaseServiceAuth.register(
                            employee.email, employee.password);
                        employee.uid = FirebaseAuth.instance.currentUser.uid;
                        DatabaseServiceFirestore().setDoc(
                            collectionName: 'employee',
                            instance: employee,
                            uid: employee.uid);

                        DatabaseServiceAuth.logOut();

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
      //employee.company = ceo.company; *****
      employee.admissionDate = _admissionDateController.text;
      employee.name = _nameController.text;
      employee.occupation = _ocupacionController.text;
      employee.email = _emailController.text.trim();
      employee.password = _passwordController.text;
      return true;
    }
    return false;
  }
}

class DataSearchEmployee extends SearchDelegate<String> {
  //function to search bar on sales page
  final sales = [
    "Employee1",
    "Employee2",
    "Employee3",
    "Employee4",
    "Employee5",
  ];
  final recentSales = [
    "Employee1",
    "Employee2",
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
        leading: Icon(Icons.person),
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
