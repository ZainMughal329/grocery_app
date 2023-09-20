import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';

class InventoryInputWidget extends StatelessWidget {
  String title;
  IconData iconData;
  TextEditingController controller;
  TextInputType inputType;

  InventoryInputWidget({
    Key? key,
    required this.title,
    required this.iconData,
    required this.controller,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        style: GoogleFonts.poppins(
          decoration: TextDecoration.none,
          decorationColor: LightAppColor.decorationColor,
          color: LightAppColor.textColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          hintText: title,
          labelText: title,

          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
