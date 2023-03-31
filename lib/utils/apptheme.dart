import 'package:flutter/material.dart';
import 'package:wingman_machinetest/utils/colors.dart';

class WTheme {
  static LinearGradient get primaryGradient {
    return LinearGradient(colors: [
      WColors.primaryColor,
      Color.fromARGB(255, 162, 136, 227),
      Color.fromARGB(255, 169, 145, 230),
    ], begin: Alignment.centerLeft, end: Alignment.centerRight);
  }

  static TextStyle get primaryHeaderStyle {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }

  static TextStyle get primaryHeaderStyle2 {
    return TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
  }

  
}
