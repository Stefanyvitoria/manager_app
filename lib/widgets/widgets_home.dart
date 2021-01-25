import 'package:manager_app/constantes.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/user.dart';

buildHomebodyCEO() {
  return ListView(
    scrollDirection: Axis.vertical,
    padding: EdgeInsets.only(top: 50, left: 20, right: 20),
    children: <Widget>[
      Container(
        width: double.maxFinite,
        height: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: ConstantesImages.logo,
          scale: 0.1,
        )),
      ),
      ConstantesSpaces.spaceDivider,
      ListTile(
        onTap: () {},
        leading: Icon(Icons.account_balance_wallet),
        title: Text(
          'Finanças',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.people),
        title: Text(
          'Funcionários',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.inbox_rounded),
        title: Text(
          'Produtos',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.attach_money),
        title: Text(
          'Vendas',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.settings),
        title: Text(
          'Configurações',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Container(
        width: 200,
        height: 300,
        color: Colors.grey[400],
        child: Center(child: Text("Algum gráfico?")),
      ),
    ],
  );
}

buildAppBarHomeCEO(User user) {
  return AppBar(
    title: Text('${user.name[0].toUpperCase()}${user.name.substring(1)}'),
    actions: [
      FlatButton(
        onPressed: () {},
        child: Icon(
          Icons.account_box,
          color: Colors.black54,
        ),
      ),
    ],
  );
}
