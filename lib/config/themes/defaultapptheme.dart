import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:procastiless/constants/colors.dart';

mixin ThemeGenerator {
  ThemeData get mainDefaultTheme => ThemeData(fontFamily: 'Poppins');
}

class ProcastilessTheme with ThemeGenerator {
  @override
  ThemeData get mainDefaultTheme => super.mainDefaultTheme;
}
