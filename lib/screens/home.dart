import 'package:flutter/material.dart';
import 'package:manager_app/models/company.dart';
import 'package:manager_app/models/user.dart';
import 'package:manager_app/constantes.dart';
import 'package:manager_app/models/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      return AppBar(
        title: Text(
          'SR Manager - Consulta',
          style: TextStyle(fontSize: 20),
        ),
      );
    }
  }

  _builBodyHome(User user) {
    if (user.type == "ceo") {
      return ListView(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
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
            onTap: () {
              Navigator.pushNamed(context, 'finances');
            },
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
            onTap: () {
              Navigator.pushNamed(context, "employees");
            },
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
            onTap: () {
              Navigator.pushNamed(context, "products");
            },
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
            onTap: () {
              Navigator.pushNamed(context, 'sales', arguments: user);
            },
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
            onTap: () {
              Navigator.pushNamed(context, 'statistics', arguments: user);
            },
            leading: Icon(FontAwesomeIcons.chartArea),
            title: Text(
              'Statistics',
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
            onTap: () {
              Navigator.of(context).pushNamed('settings');
            },
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
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          ConstantesSpaces.spaceDivider,
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "ranking");
            },
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
            onTap: () {
              Navigator.pushNamed(context, "sales", arguments: user);
            },
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
            onTap: () {
              Navigator.pushNamed(context, 'notes');
            },
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
            onTap: () {
              Navigator.of(context).pushNamed('settings');
            },
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
      //String product;
      List<Product> productsList = [
        Product(
          name: 'Product 01',
          company: Company(name: 'Company 01'),
        ),
        Product(
          name: 'Product 02',
          company: Company(name: 'Company 02'),
        ),
        Product(
          name: 'Product 03',
          company: Company(name: 'Company 03'),
        ),
      ];
      return ListView(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        children: [
          Center(
            child: Text(
              'Insira o nome do produto:',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextFormField(
            onChanged: (text) {
              //product = text;
              //print(product);
            },
          ),
          Align(
            child: Container(
              width: 150,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    'productList',
                    arguments: productsList,
                  );
                },
                child: Text('Consultar'),
              ),
            ),
          ),
        ],
      );
    }
  }
}
