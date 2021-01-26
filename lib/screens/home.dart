import 'package:flutter/material.dart';
import 'package:manager_app/models/user.dart';
import 'package:manager_app/widgets/widgets_home.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    if (user == null) user = User();

    return Scaffold(
      appBar: buildAppBarHomeCEO(user),
      body: buildHomeBody(user, context),
    );
  }

  buildHomeBody(User user, BuildContext context) {
    if (user.type == "ceo") {
      return buildHomebodyCEO(context);
    }
  }
}
