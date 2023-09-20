import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/icon_widget.dart';
import 'package:grocery_app/components/reuseable/search_text_field.dart';
import 'package:grocery_app/components/reuseable/snackbar_widget.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/components/services/session_controller.dart';
import 'package:grocery_app/pages/session_sreens/login/controller.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';
import 'package:grocery_app/pages/user_screens/home_screen/controller.dart';

import '../../../components/colors/light_app_colors.dart';
import '../../../components/constants/app_constants.dart';
import '../../../components/reuseable/category_widget.dart';
import '../../../components/reuseable/round_button.dart';
import '../../../components/reuseable/text_form_field.dart';
import '../../../components/reuseable/text_widget.dart';
import 'index.dart';

class CategoryView extends GetView<CategoryController> {
  CategoryView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightAppColor.bgColor,

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.homeScreen);
          }, icon: IconWidget(iconData: Icons.arrow_back),),
        title: TextWidget(

        title: 'Categories',
        fontSize: 18.sp,
      ),
      backgroundColor: LightAppColor.bgColor,
      // elevation: 0,
    ),
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 15.h),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240 / 250,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(5, (index) => CategoryWidget(
            title: controller.catInfo[index]['catText'],
            image: controller.catInfo[index]['imgPath'],
            color: controller.gridColors[index],
            onPress: controller.pressButton[index],
          )),
        ),
      )
    );
  }
}
