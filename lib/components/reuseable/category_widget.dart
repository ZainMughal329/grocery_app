import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/pages/user_screens/category_screen/widgets/show_categories_details.dart';

class CategoryWidget extends StatelessWidget {
  final String image;
  final String title;
  final Color color;
  // final String titleToPass;


  const CategoryWidget(
      {super.key,
        required this.title,
        required this.image,
        required this.color,
        // required this.titleToPass
      });

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Get.to(() => ShowAllCategoriesProductsScreen(category: title,),);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
          children: [
            Container(
              height: _screenWidth * 0.3.w,
              width: _screenWidth * 0.3.w,
              decoration: BoxDecoration(
                image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
              ),
            ),
            TextWidget(
              title: title,
              textColor: Colors.black,
              fontSize: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
