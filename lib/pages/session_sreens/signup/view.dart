import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/models/user_model.dart';
import 'package:grocery_app/components/routes/name.dart';
import 'package:grocery_app/pages/session_sreens/signup/controller.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

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
        automaticallyImplyLeading: false,
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
             Obx((){
               return InputTextField(
               contr: controller.state.passController,
               descrip: AppConstants.enterPass,
               textInputAction: TextInputAction.done,
               keyboardType: TextInputType.visiblePassword,
               obsecure: controller.state.obsText.value,
               icon: Icons.lock_open_outlined,
               suffixIcon: controller.state.obsText.value==true ? Icons.visibility_off_outlined : Icons.visibility,
               onPressSufix: () {
                 controller.state.obsText.value = !controller.state.obsText.value;
               },
               onChange: (value) {
                 controller.passNotifier.value =
                     PasswordStrength.calculate(text: value);
               },
               );
             }),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: PasswordStrengthChecker(
                  strength: controller.passNotifier,
                ),
              ),


              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => controller.state.loading==true ? CircularProgressIndicator(color: LightAppColor.btnColor,) :
                RoundButton(
                  title: AppConstants.signUp,
                  onPress: () async {
                    if (controller.formIsValid()) {
                      print('value is :' +
                          controller.passNotifier.value.toString());
                      UserModel userModel = UserModel(
                        userName: controller.state.userNameController.text
                            .trim()
                            .toString(),
                        phone: controller.state.phoneController.text
                            .trim()
                            .toString(),
                        email: controller.state.emailController.text
                            .trim()
                            .toString(),
                        location: '',
                        photoUrl: '',
                      );
                      controller.registerUser(
                          controller.state.emailController.text
                              .trim()
                              .toString(),
                          controller.state.passController.text
                              .trim()
                              .toString(),
                          userModel);
                    } else {
                      Get.defaultDialog(
                          title: 'Error',
                          middleText: 'All field must be filled.');
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
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
