import 'package:flutter/material.dart';
import 'package:manager_app/constantes.dart';

class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Bem vindo(a)!',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
              ),
            ),
            ConstantesImages.sizedLogo,
            Column(
              children: [
                Text(
                  'Deseja Utilizar nosso App como:',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 125,
                  child: RaisedButton(
                    child: Text('CEO'),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('login');
                    },
                  ),
                ),
                Container(
                  width: 125,
                  child: RaisedButton(
                    child: Text('Funcionário(a)'),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('login');
                    },
                  ),
                ),
                Container(
                  width: 125,
                  child: RaisedButton(
                    child: Text('Cliente'),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
