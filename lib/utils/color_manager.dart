import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColor = HexColor.fromHex('#010205');
  static Color secondaryColor = HexColor.fromHex('#540f11');
  static Color white = HexColor.fromHex('#ffffff');
  static Color grey = HexColor.fromHex('#989c98');
  static Color red = HexColor.fromHex('#bf0f02');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF' + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
