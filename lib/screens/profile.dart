import 'package:flutter/material.dart';
import 'package:manager_app/constantes.dart';
import 'package:manager_app/models/user.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: user.type == 'ceo'
          ? _buildBodyProfileCEO(user)
          : _buildBodyProfileEmployee(user),
    );
  }

  _buildBodyProfileCEO(User user) {
    return ListView(
      padding: EdgeInsets.only(top: 25),
      children: [
        Center(
          child: Text(
            'User Profile',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {
            _buildPopup(context, user.name, '1');
          },
          leading: Icon(
            Icons.account_box,
          ),
          title: Text(
            'user.name',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            _buildPopup(context, user.name, '2');
          },
          leading: Icon(
            Icons.email,
          ),
          title: Text(
            'user.email',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            _buildPopup(context, user.name, '3');
          },
          leading: Icon(
            Icons.phone,
          ),
          title: Text(
            'telephone',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ConstantesSpaces.spacer,
        Center(
          child: Text(
            'Company Profile',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {
            _buildPopup(context, user.name, '4');
          },
          leading: Icon(
            Icons.account_balance,
          ),
          title: Text(
            'user.company.name',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            //employees page
          },
          leading: Icon(
            Icons.people,
          ),
          title: Text(
            'emplyees',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            _buildPopup(context, user.name, '6');
          },
          leading: Icon(
            Icons.email,
          ),
          title: Text(
            'company.email',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            _buildPopup(context, user.name, '7');
          },
          leading: Icon(
            Icons.phone,
          ),
          title: Text(
            'company.telephone',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            _buildPopup(context, user.name, '8');
          },
          leading: Icon(
            Icons.add_location_sharp,
          ),
          title: Text(
            'company.adress',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  _buildBodyProfileEmployee(User user) {
    return ListView(
      padding: EdgeInsets.only(top: 25),
      children: [
        Center(
          child: Text(
            'User Profile',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Divider(),
        ListTile(
          onTap: () {
            _buildPopup(context, user.name, '1');
          },
          leading: Icon(
            Icons.account_box,
          ),
          title: Text(
            'user.name',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            _buildPopup(context, user.name, '2');
          },
          leading: Icon(
            Icons.email,
          ),
          title: Text(
            'user.email',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            _buildPopup(context, user.name, '3');
          },
          leading: Icon(
            Icons.phone,
          ),
          title: Text(
            'telephone',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            _buildPopup(context, user.name, '8');
          },
          leading: Icon(
            Icons.add_location_sharp,
          ),
          title: Text(
            'adress',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.account_balance,
          ),
          title: Text(
            'user.company.name',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  final listTile = {
    '1': 'name',
    '2': 'email',
    '3': 'phone',
    '4': ' company name',
    '6': 'company email',
    '7': 'company phone',
    '8': ' company adress',
  };

  _buildPopup(context, attrName, String i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          title: Text('Change ${listTile[i]}'),
          content: Container(
            child: TextFormField(
              initialValue: '(missing add functionality)',
              onChanged: (txt) {},
            ),
          ),
          actions: [
            FlatButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
