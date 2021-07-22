import 'package:flutter/material.dart';

mixin ThemeGenerator {
  static final String themeName = "Default";
  ThemeData createDefaultTheme(ThemeInterface theme) {
    return ThemeData(accentColor: theme.colorThemeData?.getPrimaryColor);
  }
}

class ThemeManager with ThemeGenerator {
  @override
  ThemeData createDefaultTheme(ThemeInterface theme) {
    return super.createDefaultTheme(theme);
  }
}

abstract class ThemeInterface {
  ThemeTextInterface? textThemeData;
  ThemeColorInterface? colorThemeData;
}

abstract class ThemeTextInterface {
  Text? mainHeader;
  Text? subheading;
  Text? paragraph;

  Text? getMain();
}

abstract class ThemeColorInterface {
  Color? primaryColor;
  Color? secondaryColor;
  Brightness? brightness;
  Color? tabBarColor;
  Color? tabBarItemSelectedColor;
  Color? tabVarItemColor;

  Color? get getPrimaryColor;
  Color? get getSecondaryColor;
  Color? get getBrightness;
  Color? get getTabBarColor;
}
