import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/employee.dart';
import 'package:manager_app/models/ngrock_parametros.dart';
import 'package:manager_app/models/sale.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/database_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<charts.Series<Employee, String>> _seriesEmployee = [];

  Ceo ceo;
  final _formkey = GlobalKey<FormState>();
  var server;
  bool regression = false;

  @override
  Widget build(BuildContext context) {
    ceo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
      ),
      body: PageView.builder(
        itemCount: 2,
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

                if (employees.length > 0 && _seriesEmployee.isEmpty) {
                  _seriesEmployee.add(charts.Series(
                      id: "Employees Graphic",
                      data: employees,
                      domainFn: (Employee employee, _) => employee.name,
                      measureFn: (Employee employee, _) => employee.sold,
                      labelAccessorFn: (Employee row, _) =>
                          row.sold.toString()));
                }
                var solds = 0;
                for (var item in employees) {
                  solds += item.sold;
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (employees.length == 0) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('The company has no registered employees.'),
                        ],
                      )
                    ],
                    if (solds <= 0) ...[
                      Container(
                        height: 80,
                        color: Colors.grey[200],
                        child: ListTile(
                          title: Center(child: Text('No registered sales.')),
                        ),
                      ),
                      Divider(),
                    ],
                    if (employees.length > 0 && solds > 0) ...[
                      ListTile(
                        title: Center(child: Text('Sales By Employees:')),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height -
                            (80 *
                                (employees.length >= 3
                                    ? 5
                                    : employees.length + 2)),
                        child: charts.PieChart(
                          _seriesEmployee,
                          animate: true,
                          animationDuration: Duration(seconds: 1),
                          behaviors: [
                            new charts.DatumLegend(
                              outsideJustification:
                                  charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                              cellPadding:
                                  new EdgeInsets.only(right: 4, bottom: 4),
                              entryTextStyle: charts.TextStyleSpec(
                                  color: charts
                                      .MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Georgia',
                                  fontSize: 11),
                            ),
                          ],
                          defaultRenderer: new charts.ArcRendererConfig(
                            arcWidth: 100,
                            arcRendererDecorators: [
                              new charts.ArcLabelDecorator(
                                  labelPosition: charts.ArcLabelPosition.inside)
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (employees.length > 0) ...[
                      Container(
                        child: Expanded(
                          child: (ListView.builder(
                            itemCount: employees.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return ListTile(
                                  title:
                                      Center(child: Text('Employees Ranking')),
                                );
                              }
                              Employee employeec = employees[index - 1];
                              return Container(
                                height: 80,
                                child: Card(
                                  child: ListTile(
                                    title: Text(employeec.name),
                                    leading: Text(
                                      "#$index",
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
                                          Text('#$index - ' + employeec.name)
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
                    ]
                  ],
                );
              },
            );
          } else {
            return StreamBuilder(
              stream: DatabaseServiceFirestore().getDocs(
                collectionNamed: 'sale',
                field: 'company',
                resultfield: ceo.company,
              ),
              builder: (context, snapshot) {
                while (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return ConstantesWidgets.loading();
                }

                List sales = snapshot.data.docs.map(
                  //map elements into object employee
                  (DocumentSnapshot e) {
                    return Sale.fromJson(e.data(), e.id);
                  },
                ).toList();

                if (!regression) {
                  return Form(
                    key: _formkey,
                    child: ListView(
                      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                      children: [
                        TextFormField(
                          validator: (value) {
                            return value.isEmpty ? 'Required field.' : null;
                          },
                          onChanged: (text) {
                            server = text;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Server:',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Align(
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formkey.currentState.validate()) return;
                              setState(() {
                                regression = true;
                              });
                            },
                            child: Text('Confirm'),
                          ),
                        )
                      ],
                    ),
                  );
                }

                //print(sales);

                List products = [];
                for (Sale sale in sales) {
                  if (products.indexOf(sale.nameProduct) == -1) {
                    products.add(sale.nameProduct);
                  }
                }

                List xs = [];
                List ys = [];
                List pn = [];

                //print(pn.indexOf('sste'));

                for (Sale sale in sales) {
                  //print(sale.nameProduct + '${sale.productAmount}');
                  List x = [];

                  for (var i = 0; i < products.length; i += 1) {
                    if (products[i] == sale.nameProduct) {
                      x.insert(i, sale.productAmount);
                    } else {
                      x.insert(i, 0);
                    }
                  }

                  ys.add(sale.value);
                  xs.add(x);
                }

                print(xs);
                List myX = [];

                for (var i = 0; i < products.length; i += 1) {
                  num s = 0;
                  for (var j = 0; j < xs.length; j += 1) {
                    s += xs[j][i];
                  }
                  myX.add(s * 2);
                }

                var result = appRest.call(
                  path: "/regression",
                  server: server,
                  params: {
                    'params': jsonEncode(
                      Params(
                        xCoordinates: xs,
                        yCoordinates: ys,
                        xPredict: myX,
                      ).toJson(),
                    )
                  },
                );
                return Container();
              },
            );
          }
        },
      ),
    );
  }
}
