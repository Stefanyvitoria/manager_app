import 'package:flutter/material.dart';
import 'package:manager_app/models/company.dart';
import 'package:manager_app/models/user.dart';
import 'package:manager_app/constantes.dart';
import 'package:manager_app/models/product.dart';

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
    //Returns the CEO bar app if user.type equals 'ceo'.
    // Returns the employee bar app if user.type equals 'employee'.
    // Returns the client bar app if user.type equals 'client'.
    if (user.type == "ceo") {
      return AppBar(
        title: Text('User.name'),
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
          'SR Manager ',
          style: TextStyle(fontSize: 20),
        ),
      );
    }
  }

  _builBodyHome(User user) {
    //Returns the CEO body if user.type equals 'ceo'.
    //Returns the staff if user.type is equal to 'employee'.
    //Returns the customer body if user.type is equal to 'customer'.
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
            onTap: () {
              Navigator.pushNamed(context, 'finances');
            },
            leading: Icon(Icons.account_balance_wallet),
            title: Text(
              'Finances',
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
              'Employees',
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
              'Products',
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
              'Sales',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('profile', arguments: user);
            },
            leading: Icon(
              Icons.account_box,
            ),
            title: Text(
              'Profile',
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
              'Settings',
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
              'User.name\nUser.email', //Text(user.company.name) *****,
              style: TextStyle(
                fontSize: 20.0,
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
              'Sales',
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
              'Notes',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('profile', arguments: user);
            },
            leading: Icon(
              Icons.account_box,
            ),
            title: Text(
              'Profile',
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
              'Settings',
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
              'Enter product name:',
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
                child: Text('Consult'),
              ),
            ),
          ),
        ],
      );
    }
  }
}
