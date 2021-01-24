import 'package:flutter/material.dart';
import 'package:manager_app/constantes.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 100, left: 10, right: 10, bottom: 20),
        child: Column(
          children: [
            ConstantesImages.sizedLogo,
            Text(
              'Nome de usuário ou e-mail:',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(),
            ),
            Text(
              'Senha:',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
              child: TextFormField(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  child: Text('Esqueci minha senha.'),
                  onPressed: () {},
                ),
              ],
            ),
            Container(
              width: 125,
              child: RaisedButton(
                child: Text('Entrar'),
                onPressed: () {},
              ),
            ),
            FlatButton(
              child: Text('Cadastre-se.'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ));
  }
}
