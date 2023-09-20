import 'package:flutter/material.dart';
import 'package:grocery_app/components/colors/dark_app_color.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDarkTheme ? DarkAppColor.bgColor : LightAppColor.bgColor,
      primaryColor: Colors.blue,
    );
  }
}
