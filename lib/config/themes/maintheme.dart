import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:procastiless/config/themes/defaultapptheme.dart';
import 'package:procastiless/constants/colors.dart';

class MainTheme implements ThemeInterface {
  @override
  ThemeColorInterface? colorThemeData;

  @override
  ThemeTextInterface? textThemeData;

  MainTheme() {
    textThemeData = MainThemeText(colorThemeData);
    colorThemeData = MainThemeColor();
  }
}

class MainThemeColor implements ThemeColorInterface {
  @override
  Color? appBarColor;

  @override
  Brightness? brightness;

  @override
  Color? buttonColor;

  @override
  Color? primaryColor = colorNames['primary-color'];

  @override
  Color? secondaryColor;

  @override
  Color? tabBarColor = colorNames['primary-color'];

  @override
  Color? tabBarItemSelectedColor;

  @override
  Color? tabVarItemColor;

  MainThemeColor() {
    appBarColor = colorNames['primary-color'];
  }

  @override
  // TODO: implement getBrightness
  Brightness? get getBrightness => brightness;

  @override
  // TODO: implement getButtonColor
  Color? get getButtonColor => throw UnimplementedError();

  @override
  // TODO: implement getPrimaryColor
  Color? get getPrimaryColor => primaryColor;

  @override
  // TODO: implement getSecondaryColor
  Color? get getSecondaryColor => throw UnimplementedError();

  @override
  // TODO: implement getTabBarColor
  Color? get getTabBarColor => tabBarColor;
}

class MainThemeText implements ThemeTextInterface {
  double? loginButtonFontSize = 17.0;
  String? fontFamily = 'Poppins';
  @override
  TextStyle? buttonText;

  @override
  TextStyle? darkSubheading;

  @override
  TextStyle? mainHeader;

  @override
  TextStyle? paragraph;

  @override
  TextStyle? subheading;

  @override
  // TODO: implement getMainHeader
  TextStyle? get getMainHeader => mainHeader;

  MainThemeText(ThemeColorInterface? color) {
    colorInterface = color;
    buttonText = TextStyle(
        color: colorInterface?.buttonColor,
        fontSize: loginButtonFontSize,
        fontFamily: fontFamily);
    mainHeader = TextStyle(
      fontFamily: 'Poppings',
      fontSize: 30,
    );
  }

  @override
  ThemeColorInterface? colorInterface;
}
