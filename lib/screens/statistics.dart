import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
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
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(
                icon: Icon(Icons.monetization_on),
              ),
              Tab(
                icon: Icon(Icons.point_of_sale),
              ),
            ],
          ),
        ),
        body: StreamBuilder(
          stream: DatabaseServiceFirestore().getDocs(
            collectionNamed: 'product',
            field: 'company',
            resultfield: ceo.company,
          ),
          builder: (context, snapshot) {
            while (snapshot.hasError ||
                snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return ConstantesWidgets.loading();
            }

            List listProduct = snapshot.data.docs.map(
              //map elements into object
              (DocumentSnapshot e) {
                return Product.fromJson(e.data(), e.id);
              },
            ).toList();

            bool click;

            // while (click) {
            //   return Null;
            // }

            var result = appRest.call(
              path: "/regression",
              params: {
                'params': jsonEncode(
                  Params(
                    xCoordinates: [
                      [1, 1],
                      [2, 2],
                      [2, 3]
                    ],
                    yCoordinates: [30, 60, 80],
                    xPredict: [3, 2],
                  ).toJson(),
                )
              },
            );
            return FutureBuilder(
              future: result,
              builder: (context, snapshot) {
                while (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return ConstantesWidgets.loading();
                }
                List xCoordinates = snapshot.data['x_coordinates'];
                List yCoordinates = snapshot.data['y_coordinates'];
                print(snapshot);

                return TabBarView(children: containers);
              },
            );
          },
        ),
      ),
    );
  }
}
