import 'package:flutter/material.dart';
import 'package:wingman_machinetest/utils/colors.dart';
import 'package:wingman_machinetest/utils/dimens.dart';

class WTheme {
  static LinearGradient get primaryGradient {
    return LinearGradient(colors: [
      Color.fromARGB(255, 141, 106, 230),
      Color.fromARGB(255, 162, 136, 227),
      Color.fromARGB(255, 169, 145, 230),
      Color.fromARGB(255, 174, 153, 227),
      Color.fromARGB(255, 176, 157, 225),
    ], begin: Alignment.bottomRight, end: Alignment.topLeft);
  }

  static TextStyle get primaryHeaderStyle {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }

  static TextStyle get primaryHeaderStyle2 {
    return TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
  }


 static BoxDecoration get dialogDecoration {
    return  BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(Dimens.borderRadius_small));
  }

  
}
