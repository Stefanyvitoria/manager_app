import 'package:flutter/material.dart';

buildFinancesBody(BuildContext context, String liquidMoney) {
  //issues of finances to CEO page
  return Container(
    child: Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  "Liquidity:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "    R\$ ${liquidMoney}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 80),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blueGrey[200],
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Action History",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Filter"),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[400],
                )
              ],
            ),
          ),
        ),
        new Expanded(
          child: Container(
            color: Colors.blueGrey[200],
            padding: EdgeInsets.only(left: 5, right: 5),
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    "action1",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text("Buy"),
                  leading: Icon(Icons.info_outline),
                  trailing: FlatButton(
                    child: Icon(Icons.expand_more),
                    onPressed: () {
                      buildDialogAlertFinances(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

buildAppBarFinances(BuildContext context) {
  return AppBar(
    title: Text(
      "Finances",
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'expenses');
        },
      ),
    ],
  );
}

buildDialogAlertFinances(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          direction: Axis.vertical,
          children: [
            AlertDialog(
              titlePadding:
                  EdgeInsets.only(top: 40, bottom: 20, left: 30, right: 10),
              actions: [
                FlatButton(
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
                "nothing yet",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      });
}
