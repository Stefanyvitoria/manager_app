import 'package:flutter/material.dart';
import 'package:manager_app/constantes.dart';
import 'package:manager_app/models/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    User user = User(); //start current user.
    user.type =
        ModalRoute.of(context).settings.arguments; // recovery user type.
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: ConstantesGradiente.gradientAppBar(context),
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Container(width: 20),
            Text('Login'),
          ],
        ),
      ),
      body: Container(
        decoration: ConstantesGradiente.gradientContainer(context),
        child: ListView(
          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
          children: [
            ConstantesImages.sizedLogo1,
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.828,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Theme.of(context).colorScheme.secondaryVariant,
                          Theme.of(context).colorScheme.primaryVariant
                        ]),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.teal,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            labelText: 'Login:',
                            focusColor: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
                        child: TextFormField(
                          obscureText: true,
                          onChanged: (text) {
                            user.password = text;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Password:',
                              suffixIcon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              'Forgot password.',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('forgotPassword', arguments: user);
                            },
                          ),
                        ],
                      ),
                      Align(
                        child: Container(
                            width: 150,
                            child: ElevatedButton(
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.teal),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'home', ModalRoute.withName('/'),
                                    arguments: user);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                            )),
                      ),
                      TextButton(
                        child: Text('Register.',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('register', arguments: user);
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
