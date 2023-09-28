import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/pages/session_sreens/splash/controller.dart';

class SplashView extends GetView<SplashScreenController> {
  const SplashView({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    controller.checkUserIsLogin();
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image(image: AssetImage('assets/ss.png')),
              ),
              Container(
                child: TextWidget(title: 'GroceZone',fontSize: 35.sp,fontWeight: FontWeight.bold,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
