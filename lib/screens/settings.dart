import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/theme.dart';
import 'package:manager_app/services/database_service.dart';

class SettingsApp extends StatefulWidget {
  @override
  _SettingsAppState createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  bool valueSwitch = false;

  @override
  Widget build(BuildContext context) {
    dynamic user = ModalRoute.of(context).settings.arguments;
    String _type = user.toString() == "Instance of 'Ceo'" ? "ceo" : "employee";
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            trailing: Switch(
              activeColor: Theme.of(context).primaryColor,
              value: valueSwitch,
              onChanged: (value) {
                Themebuilder.of(context).changeTheme();
                setState(
                  () {
                    valueSwitch = !valueSwitch;
                  },
                );
              },
            ),
            title: Text(
              'Dark Theme',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              ConstantesWidgets.dialog(
                context: context,
                title: Text('Change password'),
                content: Container(
                  child: TextFormField(
                    obscureText: true,
                    initialValue: user.password,
                    onChanged: (txt) {
                      user.password = txt;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                actions: TextButton(
                  onPressed: () {
                    setState(() {
                      DatabaseServiceFirestore().setDoc(
                        collectionName: _type,
                        instance: user,
                        uid: user.uid,
                      );
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Confirm'),
                ),
              );
              //_buildPopup(context, 'Change Password');
            },
            title: Text(
              'Change Password',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              ConstantesWidgets.dialog(
                context: context,
                title: Text('Delete Account'),
                content: Text('Press confirm to delete the account.'),
                actions: TextButton(
                  onPressed: () {
                    setState(() {
                      DatabaseServiceAuth.deleteUser(
                          FirebaseAuth.instance.currentUser);
                      DatabaseServiceFirestore().deleteDoc(
                          uid: FirebaseAuth.instance.currentUser.uid,
                          collectionName: _type);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    });
                  },
                  child: Text('Confirm'),
                ),
              );
            },
            title: Text(
              'Delete Account',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              _buildPopup(context, 'Support');
            },
            title: Text(
              'Support',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              _buildPopup(context, 'About');
            },
            title: Text(
              'About',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildPopup(context, txt) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$txt'),
          content: Text('(missing add functionality)'),
          actions: [
            TextButton(
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
