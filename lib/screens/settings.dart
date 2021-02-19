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
  @override
  Widget build(BuildContext context) {
    bool valueSwitch =
        Theme.of(context).brightness == Brightness.light ? false : true;
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
                      //change password
                      DatabaseServiceAuth.changePassword(
                        FirebaseAuth.instance.currentUser,
                        user.password,
                      );
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
                      //delete login and (logical exclusion)
                      DatabaseServiceAuth.deleteUser(
                          FirebaseAuth.instance.currentUser);
                      print(user.toString());
                      if (user.toString() == "Instance of 'Employee'") {
                        DatabaseServiceFirestore().deleteDoc(
                          collectionName: 'employee',
                          uid: user.uid,
                        );
                      }

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
              ConstantesWidgets.dialog(
                context: context,
                title: Text('Sr Manager'),
                content: Wrap(children: [
                  Text('In case of problems found in the App, contact the developers:\n' +
                      '\n- stefanyvitoria9307@gmail.com, \n- rodrigobrochardt@gmail.com.'),
                ]),
                actions: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              );
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
              ConstantesWidgets.dialog(
                context: context,
                title: Text('Sr Manager 2.0'),
                content: Wrap(children: [
                  Text('Sr Manager is an app aimed at assisting small business CEOs.' +
                      '\nThe app offers assistance in managing sales, employees and cash inflows and outflows.' +
                      'It also offers assistance to employees in monitoring their situation in the company.'),
                ]),
                actions: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              );
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
}
