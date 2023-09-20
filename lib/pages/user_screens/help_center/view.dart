import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/colors/light_app_colors.dart';
import '../../../components/reuseable/icon_widget.dart';
import '../../../components/reuseable/text_widget.dart';
import '../../../components/routes/name.dart';
import 'controller.dart';


class HelpCenterScreen extends GetView<HelpCenterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'Help Center',
          fontSize: 18.sp,
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.homeScreen);
          },
          icon: IconWidget(
            iconData: Icons.arrow_back,
          ),
        ),
        backgroundColor: LightAppColor.bgColor,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(title:
              'Welcome to the Help Center',
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
            SizedBox(height: 16.h),
            TextWidget(title:
              'If you need assistance or have any questions, please feel free to contact us through the following methods:',
              fontSize: 16.sp,
            ),
            SizedBox(height: 16.h),
            TextWidget(title:
              'Email: support@groceryapp.com',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            TextWidget( title:
              'Phone: +123-456-7890',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 16.h),
            TextWidget( title:
              'Our support team is available during business hours and will be happy to assist you.',
              // style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}