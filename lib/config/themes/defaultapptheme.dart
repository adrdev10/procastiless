import 'package:flutter/material.dart';
import 'package:procastiless/constants/colors.dart';

mixin ThemeGenerator {
  ThemeData get mainDefaultTheme => ThemeData(
        fontFamily: 'Poppins',
        accentColor: colorNames['primary-color'],
        primaryColor: colorNames['primary-color'],
        buttonColor: colorNames['buttontext-color'],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                colorNames['buttontext-color'] ?? Colors.black),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: colorNames['buttontext-color'],
        ),
        textTheme: TextTheme(
          headline3: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 45,
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            fontSize: 15,
          ),
          bodyText2: TextStyle(
            fontSize: 11,
          ),
        ),
      );
}

class ProcastilessTheme with ThemeGenerator {
  @override
  ThemeData get mainDefaultTheme => super.mainDefaultTheme;
}
