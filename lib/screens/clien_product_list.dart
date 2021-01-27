import 'package:flutter/material.dart';
import 'package:manager_app/models/product.dart';

class ClientListTile extends StatefulWidget {
  @override
  _ClientListTileState createState() => _ClientListTileState();
}

class _ClientListTileState extends State<ClientListTile> {
  List productsList;

  @override
  Widget build(BuildContext context) {
    productsList = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SR Manager',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (context, ind) {
          Product productC = productsList[ind];
          return ListTile(
            title: Text(productC.name),
            subtitle: Text(productsList[ind].company.name),
            onTap: () {},
          );
        },
      ),
    );
  }
}
