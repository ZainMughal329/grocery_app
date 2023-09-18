import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/session_sreens/login/controller.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';

import '../../../components/colors/light_app_colors.dart';
import '../../../components/constants/app_constants.dart';
import '../../../components/reuseable/round_button.dart';
import '../../../components/reuseable/text_form_field.dart';
import '../../../components/reuseable/text_widget.dart';

class LogInView extends GetView<LogInController> {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightAppColor.bgColor,
      appBar: AppBar(
        title: TextWidget(
          title: 'LogIn',
          fontSize: 18.sp,
        ),
        backgroundColor: LightAppColor.bgColor,
        elevation: 0,
      ),
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200.h,
                width: 300.w,
                color: Colors.transparent,
              ),
              InputTextField(
                  contr: controller.state.emailController,
                  descrip: AppConstants.enterEmail,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  obsecure: false,
                  icon: Icons.email_outlined),
              SizedBox(
                height: 10.h,
              ),
              InputTextField(
                contr: controller.state.passController,
                descrip: AppConstants.enterPass,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obsecure: true,
                icon: Icons.lock_open_outlined,
                suffixIcon: Icons.visibility_off_outlined,
                onPressSufix: () {},
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {},
                    child: TextWidget(
                      title: AppConstants.forgot,
                      textColor: LightAppColor.btnColor,
                      fontSize: 13.sp,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => RoundButton(
                  title: AppConstants.login,
                  onPress: () {
                    controller.loginUser(
                      controller.state.emailController.text.trim().toString(),
                      controller.state.passController.text.trim().toString(),
                    );

                  },
                  loading: controller.state.loading.value,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(title: AppConstants.dontHaveAccount),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.signUpScreen);
                    },
                    child: TextWidget(
                      title: AppConstants.signUp,
                      fontWeight: FontWeight.bold,
                      textColor: LightAppColor.btnColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
