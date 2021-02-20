import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/employee.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/database_service.dart';

import 'Loading.dart';

List employees;
List loadEmployeesRank() {
  return employees;
}

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    Employee employee = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Employees ranking",
        ),
        actions: [
          TextButton(
            onPressed: () {
              showSearch(context: context, delegate: DataSearchRanking());
            },
            child: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseServiceFirestore().getDocs(
            collectionNamed: "employee",
            field: "company",
            resultfield: employee.company),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading(); //widget loading
          }

          employees = snapshot.data.docs.map(
            //map elements into object employee
            (DocumentSnapshot e) {
              if (e.data()['company'].id == employee.company.id) {
                return Employee.fromJson(e.data());
              }
            },
          ).toList();

          mergeSortEmployees(employees);

          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (BuildContext ctxt, int index) {
              Employee employeec = employees[index];
              return Card(
                child: ListTile(
                  title: Text(employeec.name),
                  leading: Text(
                    "#${index + 1}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text("Sales quantity: ${employeec.sold}"),
                  onTap: () {
                    ConstantesWidgets.dialog(
                      context: context,
                      title: Wrap(children: [
                        Text('#${index + 1} - ' + employeec.name)
                      ]),
                      content: Wrap(
                        children: [
                          Text('Occupation: ${employeec.occupation}' +
                              '\nAdmission date: ${employeec.admissionDate}' +
                              '\nQuantity of sales: ${employeec.sold}'),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void mergeSortEmployees(List<Employee> listEmployees) {
    //sort in descending order
    if (listEmployees.length > 1) {
      var quite = listEmployees.length ~/ 2;
      var listLeft = listEmployees.sublist(0, quite);
      var listRight = listEmployees.sublist(quite, listEmployees.length);

      mergeSortEmployees(listLeft);
      mergeSortEmployees(listRight);

      int i, j, k;
      i = j = k = 0;

      while ((i < listLeft.length) && (j < listRight.length)) {
        if (listLeft[i].sold > listRight[j].sold) {
          listEmployees[k] = listLeft[i];
          i += 1;
        } else {
          listEmployees[k] = listRight[j];
          j += 1;
        }
        k += 1;
      }
      while (i < listLeft.length) {
        listEmployees[k] = listLeft[i];
        i += 1;
        k += 1;
      }
      while (j < listRight.length) {
        listEmployees[k] = listRight[j];
        j += 1;
        k += 1;
      }
    }
  }
}

class DataSearchRanking extends SearchDelegate<String> {
  //function to search bar on ranking page

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
        ? loadEmployeesRank()
        : loadEmployeesRank().where((p) => p.name.startsWith(query)).toList();
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
                  title: Text(employee.name),
                  leading: Text(
                    "#${index + 1}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text("Sales quantity: ${employee.sold}"),
                  onTap: () {
                    ConstantesWidgets.dialog(
                      context: context,
                      title: Wrap(
                          children: [Text('#${index + 1} - ' + employee.name)]),
                      content: Wrap(
                        children: [
                          Text('Occupation: ${employee.occupation}' +
                              '\nAdmission date: ${employee.admissionDate}' +
                              '\nQuantity of sales: ${employee.sold}'),
                        ],
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
    //show a list of suggestions
    final listEmployees = query.isEmpty
        ? loadEmployeesRank()
        : loadEmployeesRank().where((p) => p.name.startsWith(query)).toList();
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
                  leading: Text("#${index + 1}"),
                  title: RichText(
                    text: TextSpan(
                      text: employee.name.substring(0, query.length),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
