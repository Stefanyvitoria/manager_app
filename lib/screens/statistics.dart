import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/employee.dart';
import 'package:manager_app/models/ngrock_parametros.dart';
import 'package:manager_app/models/product.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/database_service.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<Widget> containers = [
    Container(
      child: Center(
        child: Text("*graphics for employees here*"),
      ),
    ),
    Container(
      child: Center(
        child: Text("*graphics for sales here*"),
      ),
    ),
    Container(
      child: Center(
        child: Text("*graphics for products here*"),
      ),
    ),
  ];
  Ceo ceo;

  @override
  Widget build(BuildContext context) {
    ceo = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Statistics"),
            // bottom: TabBar(
            //   tabs: [
            //     Tab(
            //       icon: Icon(Icons.person),
            //     ),
            //     Tab(
            //       icon: Icon(Icons.monetization_on),
            //     ),
            //     Tab(
            //       icon: Icon(Icons.point_of_sale),
            //     ),
            //   ],
            // ),
          ),
          body: PageView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              if (index == 0) {
                return StreamBuilder<QuerySnapshot>(
                  stream: DatabaseServiceFirestore().getDocs(
                    collectionNamed: 'employee',
                    field: 'company',
                    resultfield: ceo.company,
                  ),
                  builder: (context, snapshot) {
                    while (snapshot.hasError ||
                        snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return ConstantesWidgets.loading();
                    }

                    List employees = snapshot.data.docs.map(
                      //map elements into object employee
                      (DocumentSnapshot e) {
                        return Employee.fromJson(e.data());
                      },
                    ).toList();

                    Service.mergeSortEmployees(employees);

                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height -
                              (80 *
                                  (employees.length >= 3
                                      ? 4
                                      : employees.length + 1)),
                        ),
                        Container(
                          child: Expanded(
                            child: (ListView.builder(
                              itemCount: employees.length,
                              itemBuilder: (context, index) {
                                Employee employeec = employees[index];
                                return Container(
                                  height: 80,
                                  child: Card(
                                    child: ListTile(
                                      title: Text(employeec.name),
                                      leading: Text(
                                        "#${index + 1}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(
                                          "Sales quantity: ${employeec.sold}"),
                                      onTap: () {
                                        ConstantesWidgets.dialog(
                                          context: context,
                                          title: Wrap(children: [
                                            Text('#${index + 1} - ' +
                                                employeec.name)
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
                                  ),
                                );
                              },
                            )),
                          ),
                        )
                      ],
                    );
                  },
                );
              } else if (index == 1) {
                return Form(
                  child: Container(
                    color: Colors.yellow,
                    child: TextFormField(
                      onChanged: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(labelText: 'seeee'),
                    ),
                  ),
                );
              } else {
                return Form(
                  child: Container(
                    color: Colors.pink,
                    child: TextFormField(
                      onChanged: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(labelText: 'seeee'),
                    ),
                  ),
                );
              }
            },
          ),
        )

        // var result = appRest.call(
        //   path: "/regression",
        //   params: {
        //     'params': jsonEncode(
        //       Params(
        //         xCoordinates: [
        //           [1, 1],
        //           [2, 2],
        //           [2, 3]
        //         ],
        //         yCoordinates: [30, 60, 80],
        //         xPredict: [3, 2],
        //       ).toJson(),
        //     )
        //   },
        // );
        // return FutureBuilder(
        //   future: result,
        //   builder: (context, snapshot) {
        //     while (snapshot.hasError ||
        //         snapshot.connectionState == ConnectionState.waiting ||
        //         !snapshot.hasData) {
        //       return ConstantesWidgets.loading();
        //     }
        //     List xCoordinates = snapshot.data['x_coordinates'];
        //     List yCoordinates = snapshot.data['y_coordinates'];
        //     print(snapshot);

        );
  }
}
