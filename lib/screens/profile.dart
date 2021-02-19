import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/ceo.dart';
import 'package:manager_app/models/company.dart';
import 'package:manager_app/models/employee.dart';
import 'package:manager_app/screens/Loading.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/database_service.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: user.toString() == "Instance of 'Ceo'"
          ? _buildBodyProfileCEO(user)
          : _buildBodyProfileEmployee(user),
    );
  }

  List<Widget> _buildProfileUser(Ceo user) {
    return <Widget>[
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
          ConstantesWidgets.dialog(
            context: context,
            title: Text('Edit Name'),
            content: Container(
              child: TextFormField(
                initialValue: user.name,
                onChanged: (txt) {
                  user.name = txt;
                },
                decoration: const InputDecoration(
                  labelText: 'Name:',
                  labelStyle: TextStyle(fontSize: 15),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            actions: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      DatabaseServiceFirestore().setDoc(
                        collectionName: 'ceo',
                        instance: user,
                        uid: user.uid,
                      );
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          );
        },
        leading: Icon(
          Icons.account_box,
        ),
        title: Text(
          "${user.name}".substring(0, 1).toUpperCase() +
              "${user.name}".substring(1),
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
            title: Text('Email'),
            content: Container(
              child: TextFormField(
                initialValue: user.email,
                onChanged: (txt) {
                  user.email = txt;
                },
                decoration: const InputDecoration(
                  labelText: 'email:',
                  labelStyle: TextStyle(fontSize: 15),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            actions: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        DatabaseServiceAuth.changeEmail(
                          FirebaseAuth.instance.currentUser,
                          user.email,
                        );
                        DatabaseServiceFirestore().setDoc(
                          collectionName: 'ceo',
                          instance: user,
                          uid: user.uid,
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          );
        },
        leading: Icon(
          Icons.email,
        ),
        title: Text(
          '${user.email}',
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
            title: Text('Edit phone'),
            content: Container(
              child: TextFormField(
                initialValue: user.phone,
                onChanged: (txt) {
                  user.phone = txt;
                },
                decoration: const InputDecoration(
                  labelText: 'Phone:',
                  labelStyle: TextStyle(fontSize: 15),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            actions: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      DatabaseServiceFirestore().setDoc(
                        collectionName: 'ceo',
                        instance: user,
                        uid: user.uid,
                      );
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          );
        },
        leading: Icon(
          Icons.phone,
        ),
        title: Text(
          user.phone == null ? 'tap to edit / add' : user.phone,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      ConstantesSpaces.spacer,
    ];
  }

  _buildBodyProfileCEO(Ceo user) {
    //Returns the CEO body if user.type equals 'ceo'.
    if (user.company == null) {
      return ListView(
        padding: EdgeInsets.only(top: 25),
        children: _buildProfileUser(user),
      );
    } else {
      return StreamBuilder(
        stream: DatabaseServiceFirestore().getDoc(
          collectionName: 'company',
          uid: user.uid,
        ),
        builder: (context, AsyncSnapshot snapshot) {
          while (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Loading();
          }

          Company company = Company.fromSnapshot(snapshot);
          return ListView(
            padding: EdgeInsets.only(top: 25),
            children: [
              Column(
                children: _buildProfileUser(user),
              ),
              //Company profile
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
                  ConstantesWidgets.dialog(
                    context: context,
                    title: Text('Edit Company Name'),
                    content: Container(
                      child: TextFormField(
                        initialValue: company.name,
                        onChanged: (txt) {
                          company.name = txt;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Name:',
                          labelStyle: TextStyle(fontSize: 15),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    actions: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              DatabaseServiceFirestore().setDoc(
                                collectionName: 'company',
                                instance: company,
                                uid: user.uid,
                              );
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
                leading: Icon(
                  Icons.account_balance,
                ),
                title: Text(
                  '${company.name}',
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
                    title: Text('Edit Company CNPJ'),
                    content: Container(
                      child: TextFormField(
                        initialValue: company.cnpj,
                        onChanged: (txt) {
                          company.cnpj = txt;
                        },
                        decoration: const InputDecoration(
                          labelText: 'CNPJ:',
                          labelStyle: TextStyle(fontSize: 15),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    actions: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              DatabaseServiceFirestore().setDoc(
                                collectionName: 'company',
                                instance: company,
                                uid: user.uid,
                              );
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
                leading: Icon(
                  Icons.people,
                ),
                title: Text(
                  'CNPJ : ${company.cnpj}',
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
                    title: Text('Edit Company Email'),
                    content: Container(
                      child: TextFormField(
                        initialValue: company.email,
                        onChanged: (txt) {
                          company.email = txt;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email:',
                          labelStyle: TextStyle(fontSize: 15),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    actions: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              DatabaseServiceFirestore().setDoc(
                                collectionName: 'company',
                                instance: company,
                                uid: user.uid,
                              );
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
                leading: Icon(
                  Icons.email,
                ),
                title: Text(
                  '${company.email}',
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
                    title: Text('Edit Company Phone'),
                    content: Container(
                      child: TextFormField(
                        initialValue: company.phone,
                        onChanged: (txt) {
                          company.phone = txt;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Phone:',
                          labelStyle: TextStyle(fontSize: 15),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    actions: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              DatabaseServiceFirestore().setDoc(
                                collectionName: 'company',
                                instance: company,
                                uid: user.uid,
                              );
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
                leading: Icon(
                  Icons.phone,
                ),
                title: Text(
                  '${company.phone}',
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
                    title: Text('Edit Company Adress'),
                    content: Container(
                      child: TextFormField(
                        initialValue: company.adress,
                        onChanged: (txt) {
                          company.adress = txt;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Adress:',
                          labelStyle: TextStyle(fontSize: 15),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    actions: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              DatabaseServiceFirestore().setDoc(
                                collectionName: 'company',
                                instance: company,
                                uid: user.uid,
                              );
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
                leading: Icon(
                  Icons.add_location_sharp,
                ),
                title: Text(
                  '${company.adress}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  _buildBodyProfileEmployee(Employee user) {
    //Returns the staff if user.type is equal to 'employee'.
    return StreamBuilder(
      stream: DatabaseServiceFirestore().getDoc(
        collectionName: 'company',
        uid: user.company.id,
      ),
      builder: (context, AsyncSnapshot snapshot) {
        while (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Loading();
        }

        Company company = Company.fromSnapshot(snapshot);
        return ListView(
          padding: EdgeInsets.only(top: 25),
          children: [
            ListTile(
              onTap: () {
                ConstantesWidgets.dialog(
                  context: context,
                  title: Text('Edit Name'),
                  content: Container(
                    child: TextFormField(
                      initialValue: user.name,
                      onChanged: (txt) {
                        user.name = txt;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Name:',
                        labelStyle: TextStyle(fontSize: 15),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  actions: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            DatabaseServiceFirestore().setDoc(
                              collectionName: 'employee',
                              instance: user,
                              uid: user.uid,
                            );
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                );
              },
              leading: Icon(
                Icons.account_box,
              ),
              title: Text(
                '${user.name}',
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
                  title: Text('Edit Email'),
                  content: Container(
                    child: TextFormField(
                      initialValue: user.email,
                      onChanged: (txt) {
                        user.email = txt;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email:',
                        labelStyle: TextStyle(fontSize: 15),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  actions: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            DatabaseServiceAuth.changeEmail(
                              FirebaseAuth.instance.currentUser,
                              user.email,
                            );
                            DatabaseServiceFirestore().setDoc(
                              collectionName: 'employee',
                              instance: user,
                              uid: user.uid,
                            );
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                );
              },
              leading: Icon(
                Icons.email,
              ),
              title: Text(
                '${user.email}',
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
                  title: Text('Edit phone'),
                  content: Container(
                    child: TextFormField(
                      initialValue: user.phone,
                      onChanged: (txt) {
                        user.phone = txt;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Phone:',
                        labelStyle: TextStyle(fontSize: 15),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  actions: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            DatabaseServiceFirestore().setDoc(
                              collectionName: 'employee',
                              instance: user,
                              uid: user.uid,
                            );
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                );
              },
              leading: Icon(
                Icons.phone,
              ),
              title: Text(
                user.phone == null ? 'tap to edit / add' : user.phone,
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
                  title: Text('Edit adress'),
                  content: Container(
                    child: TextFormField(
                      initialValue: user.adress,
                      onChanged: (txt) {
                        user.adress = txt;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Adress:',
                        labelStyle: TextStyle(fontSize: 15),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  actions: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            DatabaseServiceFirestore().setDoc(
                              collectionName: 'employee',
                              instance: user,
                              uid: user.uid,
                            );
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                );
              },
              leading: Icon(
                Icons.add_location_sharp,
              ),
              title: Text(
                user.adress == null ? 'tap to edit / add' : user.adress,
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
                  title: Wrap(
                    children: [Text('Company name: \n${company.name}')],
                  ),
                  actions: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'),
                  ),
                );
              },
              leading: Icon(
                Icons.account_balance,
              ),
              title: Text(
                '${company.name}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
