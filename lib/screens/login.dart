import 'package:flutter/material.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manager_app/services/database_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  String _type;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWController = TextEditingController();
  bool _obscureText = true;
  void _showPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    _type = ModalRoute.of(context).settings.arguments; // recovery user type.

    //_emailController.text = 'nat@gmail.com';
    _emailController.text = 'stefanyvitoria9307@gmail.com';
    _passWController.text = '123456';
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        children: [
          if (Theme.of(context).brightness == Brightness.light) ...[
            ConstantesImages.sizedLogo(ConstantesImages.logo1)
          ] else
            ConstantesImages.sizedLogo(ConstantesImages.logo4),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: MediaQuery.of(context).size.height -
                    220 -
                    (AppBar().preferredSize.height),
                decoration: BoxDecoration(
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
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (txt) {
                            _emailController.text = txt;
                          },
                          controller: _emailController,
                          validator: (String value) {
                            return value.isEmpty ? 'Required field.' : null;
                          },
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
                          onSaved: (txt) {
                            _passWController.text = txt;
                          },
                          controller: _passWController,
                          validator: (String value) {
                            return value.isEmpty ? 'Required field.' : null;
                          },
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password:',
                            suffixIcon: TextButton(
                              onPressed: _showPassword,
                              child: Icon(
                                _obscureText == true
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
                              Navigator.of(context).pushNamed('forgotPassword',
                                  arguments: _type);
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
                              onPressed: () async {
                                if (!_validate()) return;

                                await DatabaseServiceAuth.login(
                                    _emailController.text,
                                    _passWController.text);
                                if (await _validatelogin(
                                    FirebaseAuth.instance.currentUser.uid)) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      'home', (Route<dynamic> route) => false,
                                      arguments: _type);
                                } else {
                                  //Login with user exchanged
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      'home', (Route<dynamic> route) => false,
                                      arguments:
                                          _type == 'ceo' ? 'employee' : 'ceo');
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                            )),
                      ),
                      if (_type == 'ceo') ...[
                        TextButton(
                          child: Text('Register.',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('register', arguments: _type);
                          },
                        ),
                      ]
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  _validate() {
    if (_formkey.currentState.validate()) {
      return true;
    }
    return false;
  }

  _validatelogin(uid) async {
    var result = await DatabaseServiceFirestore()
        .validatelogin(uid: uid, collection: _type);

    return result;
  }
}
