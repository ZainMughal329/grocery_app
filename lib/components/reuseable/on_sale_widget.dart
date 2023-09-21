import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';

Widget onSaleContainer() {
  return Container(
    height: 200.h,
    width: 220.w,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.grey,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        )
      ]
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 130.h,
              width: 100.w,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.grey),
              ),
              child: Icon(
                Icons.production_quantity_limits,
                size: 30.sp,
                color: Colors.orange,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextWidget(title: 'Item name'),
          TextWidget(title: 'Item quantity'),
          TextWidget(
            title: 'Item price',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 50.h,
          ),
          Container(
            height: 50.h,
            width: 200.w,
            color: Colors.green,
            child: Center(
              child: TextWidget(
                title: 'Add to cart',
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
