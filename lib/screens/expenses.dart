import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/widgets/widgets_expenses.dart';

class Expenses extends StatefulWidget {
  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarExpensesCEO(),
      body: buildExpensesBodyCEO(context),
    );
  }
}
