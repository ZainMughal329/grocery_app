import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/user_model.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';

import '../../../components/colors/light_app_colors.dart';
import '../../../components/constants/app_constants.dart';
import '../../../components/reuseable/round_button.dart';
import '../../../components/reuseable/text_form_field.dart';
import '../../../components/reuseable/text_widget.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightAppColor.bgColor,
      appBar: AppBar(
        title: TextWidget(
          title: 'SignUp',
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
                contr: controller.state.userNameController,
                descrip: AppConstants.enterUserName,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obsecure: false,
                icon: Icons.person_outline_outlined,
              ),
              SizedBox(
                height: 10.h,
              ),
              InputTextField(
                contr: controller.state.phoneController,
                descrip: AppConstants.enterPhoneNo,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                obsecure: false,
                icon: Icons.phone,
              ),
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
              // SizedBox(height: 10.h),
              // Obx(
              //   () {
              //     return TextWidget(
              //       title:
              //           'Password Strength: ${controller.passwordStrengthLabel()}',
              //       textColor: controller.state.strength.value < 0.3
              //           ? Colors.orange
              //           : Colors.green,
              //     );
              //
              //   },
              // ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => RoundButton(
                  title: AppConstants.signUp,
                  onPress: () async {
                    if(controller.formIsValid()) {
                      UserModel userModel = UserModel(
                        userName: controller.state.userNameController.text
                            .trim()
                            .toString(),
                        phone: controller.state.phoneController.text
                            .trim()
                            .toString(),
                        email: controller.state.phoneController.text
                            .trim()
                            .toString(),
                        location: '',
                        photoUrl: controller.state.phoneController.text
                            .trim()
                            .toString(),
                      );
                      controller.registerUser(
                          controller.state.emailController.text.trim().toString(),
                          controller.state.passController.text.trim().toString(),
                          userModel);
                    }else {
                      Get.defaultDialog(
                        title: 'Error',
                        middleText: 'All field must be filled.'
                      );
                    }
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
                  TextWidget(title: AppConstants.alreadyHaveAccount),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.logInScreen);
                    },
                    child: TextWidget(
                      title: AppConstants.login,
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
