import 'package:flutter/material.dart';

class ConstantesImages {
  static final AssetImage logo1 = AssetImage('images/logo1.png');
  static final AssetImage logo2 = AssetImage('images/logo2.png');
  static final AssetImage logo3 = AssetImage('images/logo3.png');
  static final AssetImage logo4 = AssetImage('images/logo4.png');
  static final AssetImage logo5 = AssetImage('images/logo5.png');
  static final AssetImage logo6 = AssetImage('images/logo6.png');
  static final AssetImage pLogo = AssetImage('images/m_logo1.png');

  static Widget sizedLogo(AssetImage image) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          scale: 0.3,
        ),
      ),
    );
  }
}

class ConstantesSpaces {
  static final spaceDivider = Container(
    padding: EdgeInsets.only(top: 10, bottom: 10),
    child: Divider(),
  );
  static final spacer = Container(height: 30);
  static final spacermin = Container(height: 15);
}

class ConstantesWidgets {
  static dialog({context, Widget title, Widget content, actions}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 50,
          ),
          title: title,
          content: content,
          actions: [actions],
        );
      },
    );
  }

  static Widget loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
