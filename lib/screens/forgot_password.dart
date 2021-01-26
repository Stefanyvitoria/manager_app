import 'package:flutter/material.dart';
import 'package:manager_app/constantes.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailControler = TextEditingController();
    TextEditingController emailControler2 = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Recover Password'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        children: [
          Center(
            child: Text(
              'Insira seu email:',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            child: TextFormField(
              controller: emailControler,
            ),
          ),
          ConstantesSpaces.spacer,
          Center(
            child: Text(
              'Confirmar email:',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            child: TextFormField(
              controller: emailControler2,
            ),
          ),
          Align(
            child: Container(
              padding: EdgeInsets.only(top: 7),
              width: 150,
              child: RaisedButton(
                child: Text('Confirmar email'),
                onPressed: () {
                  //Validate
                  _buildPopup(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildPopup(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nova senha enviada por email.'),
          content: Text('Faça login com sua senha atualizada.'),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
