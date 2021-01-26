import 'package:flutter/material.dart';
import 'package:manager_app/models/user.dart';
import 'package:manager_app/constantes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    if (user == null) user = User();

    return Scaffold(
      appBar: _builAppBarHome(user),
      body: _builBodyHome(user),
    );
  }

  _builAppBarHome(User user) {
    if (user.type == "ceo") {
      return AppBar(
        title: Text('${user.name[0].toUpperCase()}${user.name.substring(1)}'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Icon(
              Icons.logout,
              color: Colors.black54,
            ),
          ),
        ],
      );
    } else if (user.type == "employee") {
      return AppBar(
        title: Text(
          'SR Manager',
          style: TextStyle(fontSize: 23),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Icon(
              Icons.logout,
              color: Colors.black54,
            ),
          ),
        ],
      );
    } else {
      return null;
    }
  }

  _builBodyHome(User user) {
    if (user.type == "ceo") {
      return ListView(
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
            leading: Icon(
              Icons.account_box,
              color: Colors.black54,
            ),
            title: Text(
              'Perfil',
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
          ConstantesSpaces.spacer,
          Container(
            width: 200,
            height: 300,
            color: Colors.grey[400],
            child: Center(child: Text("Algum gráfico?")),
          ),
          ConstantesSpaces.spacer,
        ],
      );
    } else if (user.type == "employee") {
      return ListView(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        children: <Widget>[
          ListTile(
            leading: Image(image: ConstantesImages.pLogo),
            title: Text(
              '${user.email}\n${user.name}', //Text(user.company.name) *****,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          ConstantesSpaces.spaceDivider,
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.star,
              color: Colors.black54,
            ),
            title: Text(
              'Ranking',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.attach_money,
              color: Colors.black54,
            ),
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
            leading: Icon(Icons.book),
            title: Text(
              'Anotações',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.account_box,
              color: Colors.black54,
            ),
            title: Text(
              'Perfil',
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
        ],
      );
    } else {
      return null;
    }
  }
}
