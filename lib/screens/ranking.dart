import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/employee.dart';
import 'package:manager_app/screens/employees.dart';
import 'package:manager_app/services/database_service.dart';

import 'Loading.dart';

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    Employee employee = ModalRoute.of(context).settings.arguments;
    print(employee.company.collection('employee').doc().id);
    print("oi");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Best Sellers",
        ),
        actions: [
          TextButton(
            onPressed: () {
              showSearch(context: context, delegate: DataSearchRanking());
            },
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseServiceFirestore().getDocs(
            collectionNamed: "employee",
            field: "company",
            resultfield: employee.company.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading(); //widget loading
          }

          List employees = snapshot.data.docs.map(
            //map elements into object employee
            (DocumentSnapshot e) {
              if (e.data()['company'].id == employee.company.id) {
                return Employee.fromJson(e.data());
              }
            },
          ).toList();
          return ListView.builder(
              itemCount: employees.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return ListTile(
                  title: Text("My Name"),
                  leading: Text("#1"),
                  subtitle: Text("Sales quantity: 100"),
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
                                "MyName\noccupation: seller\nadmissionDate: 99/99/99\nQuantity of Sales: 100",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              });
        },
      ),
    );
  }
}

class DataSearchRanking extends SearchDelegate<String> {
  //function to search bar on sales page
  final sales = [
    "MyName",
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
        leading: Text("#1"),
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
