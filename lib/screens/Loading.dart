import 'package:flutter/material.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/theme.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Themebuilder(
      builder: (context, _themedata) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _themedata,
          home: Scaffold(
            appBar: AppBar(
              title: Text('Loading'),
            ),
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.teal,
              ),
            ),
          ),
        );
      },
    );
  }
}
