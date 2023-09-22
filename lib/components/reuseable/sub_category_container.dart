import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/user_screens/all_products_view/index.dart';

class subCategoryWidget extends StatelessWidget {
  String title;
  String category;
  String subCategory;

  subCategoryWidget(
      {super.key,
      required this.title,
      required this.category,
      required this.subCategory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => AllProductsScreen(
            category: category,
            subCategory: subCategory,
          ),
        );
      },
      child: Container(
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
            SizedBox(
              height: 10.h,
            ),
            TextWidget(
              title: title,
              fontSize: 10.sp,
            ),
          ],
        ),
      ),
    );
  }
}
