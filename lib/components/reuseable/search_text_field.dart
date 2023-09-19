import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/light_app_colors.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size * 0.67.w;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      width: size.width,
      // height: 30.h,
      decoration: BoxDecoration(
          color: LightAppColor.bgColor,
          borderRadius: BorderRadius.circular(29),
          border: Border.all(
            color: LightAppColor.borderColor,
          )),
      child: child,
    );
  }
}

class SearchInputTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  IconData icon;
  TextEditingController contr;
  String descrip;
  final void Function(String)? onChange;

  SearchInputTextField({
    super.key,
    required this.contr,
    required this.descrip,
    required this.textInputAction,
    required this.keyboardType,
    required this.icon,
    this.onChange,

    //
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: TextField(
          controller: contr,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          onChanged: onChange,
          style: GoogleFonts.poppins(fontSize: 16),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: LightAppColor.textFieldIconColor,
              size: 25.sp,
            ),
            border: InputBorder.none,
            hintText: descrip,
            hintStyle: GoogleFonts.poppins(fontSize: 10.sp),
          ),
        ),
      ),
    );
  }
}
