import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData dark = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.teal,
      minimumSize: Size(60, 40),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.blueGrey[900],
  primaryColor: Colors.teal,
  accentColor: Colors.white,
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.white),
  ),
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
ThemeData light = ThemeData(
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
  scaffoldBackgroundColor: Colors.white,
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

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  SharedPreferences _prefs;
  bool _darkTheme;
  bool get darkTheme => _darkTheme;
  ThemeNotifier() {
    _loadFromPrefs();
    if (_prefs == null) {
      _darkTheme = false;
    }
  }
  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}
