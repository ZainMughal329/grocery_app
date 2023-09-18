import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/session_sreens/login/controller.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';
import 'package:grocery_app/pages/user_screens/home_screen/controller.dart';

import '../../../components/colors/light_app_colors.dart';
import '../../../components/constants/app_constants.dart';
import '../../../components/reuseable/round_button.dart';
import '../../../components/reuseable/text_form_field.dart';
import '../../../components/reuseable/text_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightAppColor.bgColor,
      appBar: AppBar(
        title: TextWidget(
          title: 'Home Screen',
          fontSize: 18.sp,
        ),
        backgroundColor: LightAppColor.bgColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundButton(
              title: 'LogOut',
              onPress: () async {
                final auth = FirebaseAuth.instance;
                await auth.signOut().then((value) {
                  Get.snackbar('SignOut success', 'message');
                  Get.toNamed(AppRoutes.logInScreen);
                }).onError(
                  (error, stackTrace) {
                    Get.snackbar('Error', 'message');
                  },
                );
              },
            ),
          ],
        ),
      ),
      // resizeToAvoidBottomInset: false,
    );
  }
}
