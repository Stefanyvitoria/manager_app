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
              'Welcome!',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
              ),
            ),
            ConstantesImages.sizedLogo1,
            Column(
              children: [
                Text(
                  'Do you want to use the App as...',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  width: 125,
                  child: ElevatedButton(
                    child: Text('CEO'),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('login', arguments: 'ceo');
                    },
                  ),
                ),
                Container(
                  width: 125,
                  child: ElevatedButton(
                    child: Text('Employee'),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('login', arguments: 'employee');
                    },
                  ),
                ),
                Container(
                  width: 125,
                  child: ElevatedButton(
                    child: Text('Client'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('home');
                    },
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
