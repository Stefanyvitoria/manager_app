import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/coordinates.dart';
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
  List<charts.Series<Points, String>> _seriesSale = [];

  Ceo ceo;
  final _formkey = GlobalKey<FormState>();
  var server;
  bool regression = false;
  num choose;

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
                        TextFormField(
                          validator: (value) {
                            return value.isEmpty ? 'Required field.' : null;
                          },
                          onChanged: (text) {
                            choose = num.parse(text);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Previous months:',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Align(
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formkey.currentState.validate()) return;
                              if (sales.length > 0) {
                                setState(() {
                                  regression = true;
                                });
                              } else {
                                ConstantesWidgets.dialog(
                                    context: context,
                                    title: Text('Fail'),
                                    content:
                                        Text('You have no registered sales.'),
                                    actions: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok')));
                              }
                            },
                            child: Text('Confirm'),
                          ),
                        )
                      ],
                    ),
                  );
                }

                List month = [];
                var date = DateTime.now();
                for (int i = 1; i <= choose; i += 1) {
                  var prevMonth =
                      new DateTime(date.year, date.month - i, date.day);

                  for (Sale saleM in sales) {
                    var monthS = saleM.date.substring(
                        saleM.date.indexOf('/') + 1,
                        saleM.date.lastIndexOf('/'));

                    var yearS = saleM.date
                                .substring(0, saleM.date.indexOf('/'))
                                .length ==
                            4
                        ? saleM.date.substring(0, saleM.date.indexOf('/'))
                        : saleM.date.substring(
                            saleM.date.lastIndexOf('/') + 1,
                            saleM.date.length,
                          );

                    if (num.parse(yearS) == prevMonth.year &&
                        num.parse(monthS) == prevMonth.month) {
                      month.add(saleM);
                    }
                  }
                }
                sales = month;

                List products = [];
                for (Sale sale in sales) {
                  if (products.indexOf(sale.nameProduct) == -1) {
                    products.add(sale.nameProduct);
                  }
                }

                List xs = [];
                List ys = [];

                for (Sale sale in sales) {
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

                List myX = [];

                for (var i = 0; i < products.length; i += 1) {
                  num s = 0;
                  for (var j = 0; j < xs.length; j += 1) {
                    s += xs[j][i];
                  }
                  myX.add(s ~/ choose);
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

                return FutureBuilder(
                  future: result,
                  builder: (ctxt, snap) {
                    while (snap.hasError ||
                        snap.connectionState == ConnectionState.waiting ||
                        !snap.hasData) {
                      return ConstantesWidgets.loading();
                    }
                    var a = Coordinates.fromJson(snap.data);

                    List<Points> points = [];
                    for (var i = 0; i < products.length; i += 1) {
                      points.add(
                          Points(name: products[i], x: (myX[i]).toString()));
                    }

                    if (_seriesSale.isEmpty) {
                      _seriesSale.add(charts.Series(
                          id: "Products Graphic",
                          data: points,
                          domainFn: (Points point, _) => point.name,
                          measureFn: (Points point, _) => num.parse(point.x),
                          labelAccessorFn: (Points row, _) => row.x));
                    }
                    NumberFormat formatter = NumberFormat("00.00");

                    return ListView(
                      children: [
                        ListTile(
                          title: Center(
                            child: Text(
                                'Expected quantity of products sold next month:'),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 400,
                          child: charts.PieChart(
                            _seriesSale,
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
                                    labelPosition:
                                        charts.ArcLabelPosition.inside)
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                            title: Center(
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'Approximate amount of expected\nprofit for the next month, based\non the last $choose months: ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        '\$ ${formatter.format(a.ys[a.ys.length - 1])}.',
                                    style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ))
                      ],
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
