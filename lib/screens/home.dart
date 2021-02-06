import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/company.dart';
import 'package:manager_app/screens/Loading.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/models/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manager_app/services/database_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _currentUser = FirebaseAuth.instance.currentUser;
  String _type;

  @override
  Widget build(BuildContext context) {
    _type = ModalRoute.of(context).settings.arguments;

    return StreamBuilder(
      stream: DatabaseServiceFirestore().getCeo(uid: _currentUser.uid),
      builder: (context, snapshot) {
        while (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        return Scaffold(
          appBar: _builAppBarHome(snapshot),
          body: _builBodyHome(snapshot),
        );
      },
    );
  }

  AppBar _builAppBarHome(AsyncSnapshot snapshot) {
    //Returns the CEO bar app if user.type equals 'ceo'.
    // Returns the employee bar app if user.type equals 'employee'.
    // Returns the client bar app if user.type equals 'client'.
    if (_type == "ceo") {
      return AppBar(
        title: Text("${snapshot.data['name']}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      );
    } else if (_type == "employee") {
      return AppBar(
        title: Text(
          'SR Manager',
          style: TextStyle(fontSize: 23),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
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

  Widget _builBodyHome(AsyncSnapshot snapshot) {
    //Returns the CEO body if user.type equals 'ceo'.
    //Returns the staff if user.type is equal to 'employee'.
    //Returns the customer body if user.type is equal to 'customer'.
    if (_type == "ceo") {
      return ListView(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        children: <Widget>[
          Container(
            width: double.maxFinite,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: (Theme.of(context).brightness == Brightness.light)
                  ? ConstantesImages.logo1
                  : ConstantesImages.logo4,
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
            onTap: () {
              Navigator.pushNamed(context, "employees");
            },
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
            onTap: () {
              Navigator.pushNamed(context, "products");
            },
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
            onTap: () {
              Navigator.pushNamed(context, 'sales');
            },
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
              Navigator.pushNamed(context, 'statistics');
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
            onTap: () {
              Navigator.of(context).pushNamed('profile');
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
              Navigator.of(context).pushNamed('settings'); //, arguments: user);
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
    } else if (_type == "employee") {
      return ListView(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        children: <Widget>[
          ListTile(
            leading: Image(image: ConstantesImages.pLogo),
            title: Text(
              'User.name\nUser.email',
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
              Navigator.pushNamed(context, "sales");
            },
            leading: Icon(
              Icons.attach_money,
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
            onTap: () {
              Navigator.pushNamed(context, 'notes');
            },
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
              Navigator.of(context).pushNamed('profile');
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
            onChanged: (text) {},
          ),
          Align(
            child: Container(
              width: 150,
              child: ElevatedButton(
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
