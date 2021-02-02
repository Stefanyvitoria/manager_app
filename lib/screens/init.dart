import 'package:flutter/material.dart';
import 'package:manager_app/constantes.dart';

class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ]),
      ),
      child: Scaffold(
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
                child: ConstantesImages.sizedLogo3,
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
                        Navigator.of(context).pushReplacementNamed('login',
                            arguments: 'employee');
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
      ),
    );
  }
}
