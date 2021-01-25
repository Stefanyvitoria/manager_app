import 'package:flutter/material.dart';

class ConstantesImages {
  static final AssetImage logo = AssetImage('images/logo.png');
  //static final AssetImage logoInvert = AssetImage('images/logo_invert.jpg');
  static final Widget sizedLogo = Container(
    width: 300,
    height: 200,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: ConstantesImages.logo,
        scale: 0.3,
      ),
    ),
  );
}

class ConstantesSpaces {
  static final spaceDivider = Container(
    padding: EdgeInsets.only(top: 10, bottom: 10),
    child: Divider(),
  );
  static final spacer = Container(height: 30);
}
