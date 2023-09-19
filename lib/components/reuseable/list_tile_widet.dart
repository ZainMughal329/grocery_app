import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';

class ListTileWidget extends StatelessWidget {
  final IconData iconData;
  final Color icnColor;
  final String title;
  final VoidCallback onPress;

  const ListTileWidget({
    super.key,
    required this.iconData,
    this.icnColor = LightAppColor.textFieldIconColor,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // style: ListTileStyle.list,
      // tileColor: AppColors.bgColor,
      leading: Icon(
        iconData,
        color: Colors.black54,
        size: 25.sp,
      ),
      title: TextWidget(
        title: title,
      ),
      onTap: onPress,
    );
  }
}
