import 'package:flutter/material.dart';

class Themebuilder extends StatefulWidget {
  final Widget Function(BuildContext context, ThemeData themedata) builder;

  Themebuilder({this.builder});

  @override
  _ThemebuilderState createState() => _ThemebuilderState();

  static _ThemebuilderState of(BuildContext context) {
    return context.findAncestorStateOfType();
  }
}

class _ThemebuilderState extends State<Themebuilder> {
  ThemeData _themeData;

  @override
  void initState() {
    super.initState();
    _themeData = Themes.darkTheme; //Themes.lightTheme;
  }

  void changeTheme() {
    setState(() {
      _themeData = _themeData == Themes.lightTheme
          ? Themes.darkTheme
          : Themes.lightTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _themeData);
  }
}

class Themes {
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.black38,
      secondary: Colors.blueGrey,
      primaryVariant: Colors.teal,
      secondaryVariant: Colors.teal[900],
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        minimumSize: Size(60, 40),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: Colors.teal,
    accentColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(
          5.0,
        ),
      ),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      focusColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white),
      suffixStyle: TextStyle(color: Colors.white),
      contentPadding: EdgeInsets.all(12.0),
    ),
  );

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.grey[400],
      primaryVariant: Colors.teal,
      secondaryVariant: Colors.teal[600],
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        minimumSize: Size(60, 40),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.transparent,
    accentColor: Colors.black,
    primaryColor: Colors.teal,
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(
          5.0,
        ),
      ),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      focusColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white),
      suffixStyle: TextStyle(color: Colors.white),
      contentPadding: EdgeInsets.all(12.0),
    ),
  );
}
