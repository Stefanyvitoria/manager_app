import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

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
  @override
  Widget build(BuildContext context) {
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
          body: TabBarView(
            children: containers,
          )),
    );
  }
}
