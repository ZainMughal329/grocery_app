import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/light_app_colors.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size * 0.9;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: size.width,
      decoration: BoxDecoration(
        color: LightAppColor.bgColor,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: LightAppColor.borderColor,
        )
      ),
      child: child,
    );
  }
}

class InputTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obsecure;
  IconData icon;
  TextEditingController contr;
  String descrip;
  final IconData? suffixIcon;
  final void Function(String)? onChange;
  final VoidCallback? onPressSufix;



  InputTextField({
    super.key,
    required this.contr,
    required this.descrip,
    required this.textInputAction,
    required this.keyboardType,
    required this.obsecure,
    required this.icon,
    this.onChange,
    this.suffixIcon,
    this.onPressSufix,

    //
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: TextField(
          controller: contr,
          textInputAction: textInputAction,
          obscureText: obsecure,
          keyboardType: keyboardType,
          onChanged: onChange,
          style: GoogleFonts.poppins(fontSize: 16),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: LightAppColor.iconColor,
            ),
            border: InputBorder.none,
            hintText: descrip,
            hintStyle: GoogleFonts.poppins(fontSize: 16),
            suffixIcon: IconButton(
              onPressed: onPressSufix,
              icon: Icon(suffixIcon,color: LightAppColor.iconColor),
            )
          ),
        ),
      ),
    );
  }
}
