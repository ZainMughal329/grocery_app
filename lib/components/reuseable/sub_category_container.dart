import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';

Widget subCategoryWidget() {
  return Container(
    height: 100.h,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.grey,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50.h,
          width: 50.w,

          child: IconWidget(
            iconData: Icons.ac_unit_outlined,
          ),
        ),
        SizedBox(height: 10.h,),
        TextWidget(title: 'Sub Category Name' , fontSize: 10.sp,),
      ],
    ),

  );
}