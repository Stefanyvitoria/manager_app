import 'package:flutter/material.dart';
import 'package:manager_app/models/product.dart';
import 'package:manager_app/constantes.dart';

class ClientListTile extends StatefulWidget {
  //Screen that displays the list with the consulted product.
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
        flexibleSpace: ConstantesGradiente.gradientAppBar(context),
        title: Text(
          'SR Manager',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
        decoration: ConstantesGradiente.gradientContainer(context),
        child: ListView.builder(
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
      ),
    );
  }
}
