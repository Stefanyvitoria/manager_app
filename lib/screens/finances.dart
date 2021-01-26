import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/widgets/widgets_finances.dart';

class Finances extends StatefulWidget {
  @override
  _FinancesState createState() => _FinancesState();
}

class _FinancesState extends State<Finances> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarFinances(context),
      body: buildFinancesBody(context, "100.00  *only demonstrative*"),
    );
  }
}
