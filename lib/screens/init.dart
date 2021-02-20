import 'package:flutter/material.dart';
import 'package:manager_app/services/constantes.dart';

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
            Container(
              padding: EdgeInsets.only(right: 15, left: 15),
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(70),
                color: Colors.teal,
              ),
              child: ConstantesImages.sizedLogo(ConstantesImages.logo3),
            ),
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
                    child: Text(
                      'CEO',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('login', arguments: 'ceo');
                    },
                  ),
                ),
                Container(
                  width: 125,
                  child: ElevatedButton(
                    child: Text(
                      'Employee',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('login', arguments: 'employee');
                    },
                  ),
                ),
                Container(
                  width: 125,
                  child: ElevatedButton(
                    child: Text(
                      'Client',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('home', arguments: 'client');
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
