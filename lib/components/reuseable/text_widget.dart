import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/light_app_colors.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDecoration decoration;
  final Color decorationColor;
  final FontStyle fontStyle;

  const TextWidget(
      {super.key,
      required this.title,
      this.textColor = LightAppColor.textColor,
      this.fontSize = 16,
      this.fontWeight = FontWeight.normal,
      this.decoration = TextDecoration.none,
      this.decorationColor = LightAppColor.decorationColor,
        this.fontStyle = FontStyle.normal,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        decoration: decoration,
        decorationColor: decorationColor,
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      ),
    );
  }
}
