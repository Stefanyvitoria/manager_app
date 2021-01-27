import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Employees extends StatefulWidget {
  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Employees",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addEmployee');
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
                title: Text("Employee1"),
                subtitle: Text("Occupation: seller"),
                trailing: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'editEmployee');
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
                                "Employee1\noccupation: seller\nadmissionDate: 99/99/99\n",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),
                          ],
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
          ),
        ],
      ),
    );
  }
}

class EditEmployee extends StatefulWidget {
  @override
  _EditEmployeeState createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  @override
  Widget build(BuildContext context) {
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
                    labelText: 'Occupation:',
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

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  @override
  Widget build(BuildContext context) {
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
                    labelText: 'Occupation:',
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
