import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin ThemeGenerator {
  static final String themeName = "Default";
  ThemeData createDefaultTheme(ThemeInterface theme) {
    return ThemeData(
        fontFamily: 'Poppins',
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        accentColor: theme.colorThemeData?.getPrimaryColor,
        appBarTheme: AppBarTheme(
            color: theme.colorThemeData?.appBarColor,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: theme.colorThemeData?.appBarColor,
                systemNavigationBarColor: theme.colorThemeData?.appBarColor)),
        bottomAppBarColor: theme.colorThemeData?.getTabBarColor,
        textTheme: TextTheme(
            bodyText1: theme.textThemeData?.paragraph,
            bodyText2: theme.textThemeData?.paragraph,
            headline1: theme.textThemeData?.mainHeader,
            headline6: theme.textThemeData?.darkSubheading));
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
  TextStyle? mainHeader;
  TextStyle? darkSubheading;
  TextStyle? subheading;
  TextStyle? buttonText;
  TextStyle? paragraph;
  ThemeColorInterface? colorInterface;
  TextStyle? get getMainHeader;
}

abstract class ThemeColorInterface {
  Color? primaryColor;
  Color? secondaryColor;
  Color? appBarColor;
  Brightness? brightness;
  Color? tabBarColor;
  Color? tabBarItemSelectedColor;
  Color? tabVarItemColor;
  Color? buttonColor;

  Color? get getPrimaryColor;
  Color? get getSecondaryColor;
  Brightness? get getBrightness;
  Color? get getTabBarColor;
  Color? get getButtonColor;
}
