import 'package:flutter/material.dart';

class ConstantesImages {
  static final AssetImage logo1 = AssetImage('images/logo1.png');
  static final AssetImage logo2 = AssetImage('images/logo2.png');
  static final AssetImage logo3 = AssetImage('images/logo3.png');
  static final AssetImage logo4 = AssetImage('images/logo4.png');
  static final AssetImage logo5 = AssetImage('images/logo5.png');
  static final AssetImage logo6 = AssetImage('images/logo6.png');
  static final AssetImage pLogo = AssetImage('images/m_logo1.png');

  static final Widget sizedLogo1 = Container(
    width: 300,
    height: 200,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: ConstantesImages.logo1,
        scale: 0.3,
      ),
    ),
  );
  static final Widget sizedLogo3 = Container(
    width: 300,
    height: 200,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: ConstantesImages.logo3,
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
  static final spacermin = Container(height: 15);
}

class ConstantesGradiente {
  static BoxDecoration gradientContainer(context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ],
      ),
    );
  }

  static gradientAppBar(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Theme.of(context).colorScheme.secondaryVariant,
            Theme.of(context).colorScheme.primaryVariant
          ],
        ),
      ),
    );
  }
}
