import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/light_app_colors.dart';

class IconWidget extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final double fontSize;

  const IconWidget({
    super.key,
    required this.iconData,
    this.iconColor = LightAppColor.iconColor,
    this.fontSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: iconColor,
      size: fontSize,
    );
  }
}
