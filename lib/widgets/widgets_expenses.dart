import 'package:flutter/material.dart';

buildAppBarExpensesCEO() {
  return AppBar(
    title: Text(
      "New Expense",
    ),
  );
}

buildExpensesBodyCEO(BuildContext context) {
  return SingleChildScrollView(
    child: SizedBox(
      width: MediaQuery.of(context).size.width, //size of screen
      height: MediaQuery.of(context).size.height, //size of screen
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (text) {},
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Action:',
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
                labelText: 'Date:',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (text) {},
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Value:',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 5,
              onChanged: (text) {},
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: 'A little description:',
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
  );
}