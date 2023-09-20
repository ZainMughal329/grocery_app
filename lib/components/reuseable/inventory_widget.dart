import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';

class InventoryWidget extends StatelessWidget {
  // final String image;
   final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onPress;

   InventoryWidget(
      {super.key,
        required this.title,
        required this.icon,
        required this.color,
        required this.onPress,
      });

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: onPress,
        child: Container(
          // width: double.infinity,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(0.7),
              width: 2,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: _screenWidth * 0.3.w,
                  // width: double.infinity,
                  width: _screenWidth * 0.4.w,
                  child: Center(child: Icon(icon,size: _screenWidth * 0.15.w,)),
                ),
                TextWidget(
                  title: title,
                  textColor: Colors.black,
                  fontSize: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
