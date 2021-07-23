import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:procastiless/config/themes/defaultapptheme.dart';

class MainTheme implements ThemeInterface {
  @override
  ThemeColorInterface? colorThemeData;

  @override
  ThemeTextInterface? textThemeData;

  MainTheme() {
    textThemeData = MainThemeText(colorThemeData);
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
  Color? primaryColor;

  @override
  Color? secondaryColor;

  @override
  Color? tabBarColor;

  @override
  Color? tabBarItemSelectedColor;

  @override
  Color? tabVarItemColor;

  @override
  // TODO: implement getBrightness
  Brightness? get getBrightness => brightness;

  @override
  // TODO: implement getButtonColor
  Color? get getButtonColor => throw UnimplementedError();

  @override
  // TODO: implement getPrimaryColor
  Color? get getPrimaryColor => throw UnimplementedError();

  @override
  // TODO: implement getSecondaryColor
  Color? get getSecondaryColor => throw UnimplementedError();

  @override
  // TODO: implement getTabBarColor
  Color? get getTabBarColor => throw UnimplementedError();
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
    mainHeader = TextStyle();
  }

  @override
  ThemeColorInterface? colorInterface;
}
