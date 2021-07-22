import 'package:flutter/material.dart';

final Map<String, Color> colorNames = {
  "primary-color": BetterColor.returnHexCode("76F3B7"),
  // "secondary-color": Color(2344).returnHexCode()
};

extension BetterColor on Color {
  static Color returnHexCode(String? hexValue) {
    StringBuffer hexColor = StringBuffer();
    hexValue = hexValue ?? "fffff";
    hexColor..write("0x")..write("ff")..write(hexValue);
    return Color(int.parse(hexColor.toString(), radix: 16));
  }
}
