import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/database_service.dart';
import 'package:manager_app/models/employee.dart';

class Employees extends StatefulWidget {
  @override
  _EmployeesState createState() => _EmployeesState();
}

List<Employee> listEmployees;
List<Employee> loadEmployees() {
  return listEmployees;
}

Ceo ceo;

class _EmployeesState extends State<Employees> {
  @override
  Widget build(BuildContext context) {
    ceo = ModalRoute.of(context).settings.arguments;

    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseServiceFirestore().getDocs(
          collectionNamed: 'employee',
          field: "company",
          resultfield: ceo.company),
      builder: (context, snapshot) {
        while (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return ConstantesWidgets.loading();
        }
        listEmployees = snapshot.data.docs.map(
          //map elements into object employee
          (DocumentSnapshot e) {
            return Employee.fromJson(e.data());
          },
        ).toList();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Employees",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  print('oi');
                  showSearch(context: context, delegate: DataSearchEmployee());
                },
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, 'addEmployee', arguments: ceo);
            },
            tooltip: 'Increment',
            child: Icon(
              Icons.person_add_alt_1_outlined,
            ),
            backgroundColor: Colors.teal,
          ),
          body: ListView.builder(
            itemCount: listEmployees.length,
            itemBuilder: (BuildContext ctxt, int index) {
              Employee employee = listEmployees[index];
              return Dismissible(
                onDismissed: (direction) async {
                  //requires authentication to delete
                  await DatabaseServiceAuth.login(
                      employee.email, employee.password);
                  //delete employee
                  listEmployees.remove(employee);
                  await DatabaseServiceAuth.deleteUser(
                      FirebaseAuth.instance.currentUser);
                  await DatabaseServiceFirestore()
                      .deleteDoc(collectionName: 'employee', uid: employee.uid);
                  await DatabaseServiceAuth.login(ceo.email, ceo.password);
                },
                child: Card(
                  child: ListTile(
                      leading: Icon(Icons.person_outline),
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
                        ConstantesWidgets.dialog(
                          context: context,
                          title: Text("${employee.name}"),
                          content: Wrap(
                            direction: Axis.vertical,
                            children: [
                              Text("Occupation: ${employee.occupation}"),
                              Text("Admission Date: ${employee.admissionDate}"),
                              Text("Quantity of Sales: ${employee.sold}"),
                            ],
                          ),
                          actions: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Ok',
                            ),
                          ),
                        );
                      }),
                ),
                key: Key(employee.uid),
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
      },
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
                        //update employee
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
  Employee employee = Employee(sold: 0);
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

                        //create login employee
                        await DatabaseServiceAuth.register(
                            employee.email, employee.password);

                        //create document employee
                        employee.uid = FirebaseAuth.instance.currentUser.uid;
                        await DatabaseServiceFirestore().setDoc(
                            collectionName: 'employee',
                            instance: employee,
                            uid: employee.uid);

                        //login in CEO
                        await DatabaseServiceAuth.logOut();
                        await DatabaseServiceAuth.login(
                            ceo.email, ceo.password);

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
      employee.company = ceo.company;
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
    final listEmployees = query.isEmpty
        ? loadEmployees()
        : loadEmployees().where((p) => p.name.startsWith(query)).toList();
    return listEmployees.isEmpty
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "No results found.",
              style: TextStyle(fontSize: 20),
            ),
          ])
        : ListView.builder(
            itemCount: listEmployees.length,
            itemBuilder: (context, index) {
              final Employee employee = listEmployees[index];

              return Dismissible(
                onDismissed: (direction) {
                  DatabaseServiceFirestore()
                      .deleteDoc(collectionName: 'employee', uid: employee.uid);
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.person_outline),
                    title: RichText(
                      text: TextSpan(
                          text: employee.name.substring(0, query.length),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                                text: employee.name.substring(query.length),
                                style: TextStyle(color: Colors.grey))
                          ]),
                    ),
                    subtitle: Text("Occupation: ${employee.occupation}"),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'editEmployee',
                            arguments: employee);
                      },
                      child: Icon(Icons.edit, color: Colors.grey),
                    ),
                    onTap: () {
                      ConstantesWidgets.dialog(
                        context: context,
                        title: Text("${employee.name}"),
                        content: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text("Occupation: ${employee.occupation}"),
                            Text("Admission Date: ${employee.admissionDate}"),
                            Text("Quantity of Sales: ${employee.sold}"),
                          ],
                        ),
                        actions: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Ok',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                key: Key(employee.uid),
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
    final listEmployees = query.isEmpty
        ? loadEmployees()
        : loadEmployees().where((p) => p.name.startsWith(query)).toList();

    return listEmployees.isEmpty
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "No results found.",
              style: TextStyle(fontSize: 20),
            ),
          ])
        : ListView.builder(
            itemCount: listEmployees.length,
            itemBuilder: (context, index) {
              final Employee employee = listEmployees[index];

              return Card(
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      text: employee.name.substring(0, query.length),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                            text: employee.name.substring(query.length),
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
